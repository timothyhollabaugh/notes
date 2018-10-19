module Dataflow(enable, reset_time, reset_best_time, display_time, display_best_time, update_best_time, show, compare, clock);

    input enable, reset_time, reset_best_time, display_time, display_best_time, update_best_time, clock;
    output compare;
    output [15:0] show;

    wire [15:0] t;
    wire [15:0] best_time;

    assign best_time = reset_best_time ? 16'b1001100110011001 : (update_best_time ? t : best_time);

    assign compare = (t < best_time) ? 1'b1 : 1'b0;

    assign show = display_time ? t : (display_best_time ? best_time : show);

    wire enable1, enable2, enable3;

   BCD_4bit counter0 (
       .clock(clock),
       .enable(enable),
       .reset(reset_time),
       .t(t[3:0])
   );

   assign enable1 = enable & t[0] & t[3];

   BCD_4bit counter1 (
       .clock(clock),
       .enable(enable1),
       .reset(reset_time),
       .t(t[7:4])
   );

   assign enable2 = enable1 & t[4] & t[7];

   BCD_4bit counter2 (
       .clock(clock),
       .enable(enable2),
       .reset(reset_time),
       .t(t[11:8])
   );

   assign enable3 = enable2 & t[8] & t[11];

   BCD_4bit counter3 (
       .clock(clock),
       .enable(enable3),
       .reset(reset_time),
       .t(t[15:12])
   );

   endmodule
