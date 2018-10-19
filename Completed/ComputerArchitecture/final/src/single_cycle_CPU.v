// Comp Arch Take Home Final Exam
//
// Build a Simple Single-Cycle Computer (Figure 1)
//
// 1. Implement the instruction decoder in 4 in STRUCTURAL Verilog
//    20% (10% for a working design, 10% for proper structural Verilog implementation)
// 2. Implement the Single-Cycle Computer in Figure 1 in Verilog
//    All of the blocks (modules) needed are implemented in this file.
//    60% (30% for instantiating the proper modules and making connections, 30% for functionality)
// 3. Add the following instruction sequence to program memory (ROM).
//
//          SUB R3, R4, R5
//          SUB R6, R7, R0
//          ADD R0, R0, R3
//          SUB R0, R0, R6
//          ST  R7, R0
//          LD  R7, R6
//          ADI R0, R6, 2
//          ADI R3, R6, 3
//
//    20% (2.5% per correct instruction word)
//
// A testbench for the single cycle processor is provided in single_cycle_CPU_tb.v
// You are not required to submit any testbench results; however, you are STRONGLY
// encouraged to run the testbench to verify the functionality of your processor

// 1. Implement the instruction decoder in Figure 9-16 in STRUCTURAL Verilog
module instruction_decoder(IR, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
    // inputs
    input [15:0] IR;

    // outputs
    output [7:0] DA, AA, BA;
    output MB, MD, RW, MW, PL, JB, BC;
    output [3:0] FS;

    // wires

    wire [6:0] op;
    wire [2:0] dr, sa, sb;
    wire op6n;
    wire pln;

    // assignments and structural Verilog
    assign {op, dr, sa, sb} = IR;

    assign DA = dr;
    assign AA = sa;
    assign BA = sb;

    assign MB = op[6];

    not pl_not(pln, PL);
    and fs0_and(FS[0], op[0], pln);
    assign FS[3:1] = op[3:1];

    assign MD = op[4];

    not rw_not(RW, op[5]);

    not op6_not(op6n, op[6]);
    and mw_and(MW, op[5], op6n);

    and pl_and(PL, op[5], op[6]);

    assign JB = op[4];
    assign BC = op[0];

endmodule

// 2. Implement the Single-Cycle Computer in Figure 9-15 in Verilog
// All of the blocks (modules) needed are implemented in this file.
module single_cycle_CPU(clock, reset);
    // inputs
    input clock, reset;

    // wires

    wire [3:0] da;
    wire [3:0] ba;
    wire [3:0] aa;
    wire [3:0] fs;
    wire mb, md, rw, mw, pl, jb, bc;

    wire [7:0] a_bus;
    wire [7:0] b_bus;
    wire [7:0] d_bus;

    wire [7:0] reg_b_out;
    wire [7:0] reg_a_out;

    wire [7:0] alu_out;
    wire [7:0] mem_out;

    wire v, c, n, z;

    wire [7:0] constant;

    wire [3:0] branch_offset;
    wire [7:0] pc_out;

    wire [15:0] rom_out;

    wire [1:0] pc_fs;

    // instantiation of control unit components

    instruction_memory rom(
        .address(pc_out),
        .IR(rom_out)
    );

    instruction_decoder decoder(
        .IR(rom_out),
        .DA(da),
        .AA(aa),
        .BA(ba),
        .MB(mb),
        .FS(fs),
        .MD(md),
        .RW(rw),
        .MW(mw),
        .PL(pl),
        .JB(jb),
        .BC(bc)
    );

    program_counter pc(
        .clock(clock),
        .reset(reset),
        .ProgramCounterFunctionSelect(pc_fs),
        .JumpInput(d_bus),
        .BranchInput(branch_offset),
        .PC(pc_out)
    );

    branch_control branch(
        .V(v),
        .C(c),
        .N(n),
        .Z(z),
        .PL(pl),
        .JB(jb),
        .BC(bc),
        .ProgramCounterFunctionSelect(pc_fs)
    );

    sign_extend_branch extend(
        .IR_8_down_6(rom_out[8:6]),
        .IR_2_down_0(rom_out[2:0]),
        .BranchOffset(branch_offset)
    );

    // instantiation of datapath components
    // note: name the register file instance "reg_file0"
    // note: name the data memory instance "ram_inst"

    zero_fill_contstant zero_fill(
        .IR_2_down_0(rom_out[2:0]),
        .constant(constant)
    );

    register_file8x8 reg_file0(
        .clock(clock),
        .reset(reset),
        .RW(rw),
        .DA(da),
        .AA(aa),
        .BA(ba),
        .D(d_bus),
        .A(reg_a_out),
        .B(reg_b_out)
    );

    mux_2_to_1 b_mux(
        .S(mb),
        .A(reg_b_out),
        .B(constant),
        .F(b_bus)
    );

    assign a_bus = reg_a_out;

    function_unit alu(
        .FS(fs),
        .A(a_bus),
        .B(b_bus),
        .F(alu_out),
        .V(v),
        .C(c),
        .N(n),
        .Z(z)
    );

    data_memory ram_inst(
        .clock(clock),
        .MW(mw),
        .address(a_bus),
        .data_in(b_bus),
        .data_out(mem_out)
    );

    mux_2_to_1 d_mux(
        .S(md),
        .A(alu_out),
        .B(mem_out),
        .F(d_bus)
    );

endmodule

// 3. Add the address and binary value for the assembly instructions
//    listed below
module instruction_memory(address, IR);
    input [7:0]address;
    output reg [15:0]IR;

    always @(address) begin
        case(address)
            8'h00: IR <= 16'b1001100000000000; // LDI R0, 0
            8'h01: IR <= 16'b1001100001000001; // LDI R1, 1
            8'h02: IR <= 16'b1001100010000010; // LDI R2, 2
            8'h03: IR <= 16'b1001100011000011; // LDI R3, 3
            8'h04: IR <= 16'b1001100100000100; // LDI R4, 4
            8'h05: IR <= 16'b1001100101000101; // LDI R5, 5
            8'h06: IR <= 16'b1001100110000110; // LDI R6, 6
            8'h07: IR <= 16'b1001100111000111; // LDI R7, 7
            8'h08: IR <= 16'b0100000000100101; // ST  R4, R5 (M[R4] <= R5)
            8'h09: IR <= 16'b0000010000001010; // ADD R0, R1, R2
            // add the following instructions
            8'h0a: IR <= 16'b0000101011100101; // SUB R3, R4, R5
            8'h0b: IR <= 16'b0000101110111000; // SUB R6, R7, R0
            8'h0c: IR <= 16'b0000010000000011; // ADD R0, R0, R3
            8'h0d: IR <= 16'b0000101000000110; // SUB R0, R0, R6
            8'h0e: IR <= 16'b0100000000111000; // ST  R7, R0
            8'h0f: IR <= 16'b0010000111110000; // LD  R7, R6
            8'h10: IR <= 16'b1000010000110010; // ADI R0, R6, 2
            8'h11: IR <= 16'b1000010011110011; // ADI R3, R6, 3
            default: IR <= 16'b000000000000;
        endcase
    end
endmodule

// 8 x 8-bit register file implemented with behavioral Verilog
module register_file8x8(clock,reset,RW,DA,AA,BA,D,A,B);
    input clock, reset;
    input [7:0]D;
    output [7:0]A, B;
    input RW;
    input [2:0]DA,AA,BA;

    reg [7:0]reg_file [0:7];

    always @(posedge clock) begin
        if(reset) begin
            reg_file[0] <= 8'h00;
            reg_file[1] <= 8'h00;
            reg_file[2] <= 8'h00;
            reg_file[3] <= 8'h00;
            reg_file[4] <= 8'h00;
            reg_file[5] <= 8'h00;
            reg_file[6] <= 8'h00;
            reg_file[7] <= 8'h00;
        end
        else if(RW) begin
            reg_file[DA] <= D;
        end
    end

    // implement A and B bus selection with dataflow style multiplexers
    assign A = AA[2] ? (AA[1]?(AA[0]?reg_file[7]:reg_file[6]):(AA[0]?reg_file[5]:reg_file[4])) : (AA[1]?(AA[0]?reg_file[3]:reg_file[2]):(AA[0]?reg_file[1]:reg_file[0]));
    assign B = BA[2] ? (BA[1]?(BA[0]?reg_file[7]:reg_file[6]):(BA[0]?reg_file[5]:reg_file[4])) : (BA[1]?(BA[0]?reg_file[3]:reg_file[2]):(BA[0]?reg_file[1]:reg_file[0]));
endmodule

// 2:1 Multiplexor implemented with dataflow Verilog
module mux_2_to_1(S, A, B, F);
    parameter N = 8;
    input S;
    input [N-1:0]A, B;
    output [N-1:0]F;

    assign F = S ? B : A;
endmodule

// Function unit described in Table 9-4 implemented in behavioral Verilog
module function_unit(FS, A, B, F, V, C, N, Z);
    input [3:0]FS;
    input [7:0]A, B;
    output reg [7:0] F;
    output V, N, Z;
    output reg C;

    always @(A or B or FS) begin
        case(FS)
            4'b0000: {C, F} <= A;
            4'b0001: {C, F} <= A + 8'h01;
            4'b0010: {C, F} <= A + B;
            4'b0011: {C, F} <= A + B + 8'h01;
            4'b0100: {C, F} <= A + (~B);
            4'b0101: {C, F} <= A + (~B) + 8'h01;
            4'b0110: {C, F} <= A + 8'hFF;
            4'b0111: {C, F} <= A;
            4'b1000: {C, F} <= A & B;
            4'b1001: {C, F} <= A | B;
            4'b1010: {C, F} <= A ^ B;
            4'b1011: {C, F} <= ~A;
            4'b1100: {C, F} <= B;
            4'b1101: {C, F} <= B >> 1;
            4'b1110: {C, F} <= B << 1;
            4'b1111: {C, F} <= A;
        endcase
    end

    assign Z = (F == 4'b0000) ? 1'b1 : 1'b0;
    assign N = F[7];
    assign V = ( (A[7] == B[7]) & (A[7] != F[7]) ) ? 1'b1 : 1'b0;
endmodule

// Branch control logic described in section 9-8 implemented in dataflow Verilog
module branch_control(V, C, N, Z, PL, JB, BC, ProgramCounterFunctionSelect);
    input V, C, N, Z, PL, JB, BC;
    output [1:0] ProgramCounterFunctionSelect;
    wire JUMP, BRANCH;

    assign JUMP = PL & JB;
    assign BRANCH = (PL & ~JB & ~BC & Z) | (PL & ~JB & BC & N);

    assign ProgramCounterFunctionSelect = {JUMP, BRANCH};
endmodule

// Program counter described in section 9-8 implemented in behavioral Verilog
module program_counter(clock, reset, ProgramCounterFunctionSelect, JumpInput, BranchInput, PC);
    input clock, reset;
    input [1:0] ProgramCounterFunctionSelect;
    input [7:0] JumpInput;
    input [7:0] BranchInput;
    output reg [7:0]PC;

    always @(posedge clock) begin
        if(reset) PC <= 8'h00;
        else if(ProgramCounterFunctionSelect[1]) PC <= JumpInput;
        else if(ProgramCounterFunctionSelect[0]) PC <= PC + BranchInput;
        else PC <= PC + 4'b0001;
    end
endmodule

// sign extend described in section 9-8
module sign_extend_branch(IR_8_down_6, IR_2_down_0, BranchOffset);
    input [2:0]IR_8_down_6;
    input [2:0]IR_2_down_0;
    output [7:0]BranchOffset;

    assign BranchOffset = {IR_8_down_6[2], IR_8_down_6[2], IR_8_down_6, IR_2_down_0};
endmodule

// zero fill described in section 9-8
module zero_fill_contstant(IR_2_down_0, constant);
    input [2:0]IR_2_down_0;
    output [7:0]constant;

    assign constant = {5'b00000, IR_2_down_0};
endmodule

// 256x8 synchronous memory, negedge triggered for use with a posedge datapath
// (i.e. no need for you to invert the clock)
module data_memory(clock, MW, address, data_in, data_out);
    input MW;
    input clock;
    input [7:0]address;
    input [7:0]data_in;
    output reg [7:0]data_out;

    reg [7:0]mem [0:255];
    always @(negedge clock)
        data_out <= mem[address];

    always @(negedge clock) begin
        if(MW) mem[address] = data_in;
    end
endmodule



