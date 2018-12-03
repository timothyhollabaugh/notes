/*
 * C++ Program to Solve N-Queen Problem
 */
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <vector>
#define N 8
#define M 100 // Total number of solutions to allocate for
using namespace std;
 
/* print solution */
void printSolution(int board[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
            cout<<board[i][j]<<"  ";
        cout<<endl;
    }
}
 
/* check if a queen can be placed on board[row][col]*/
bool isSafe(int board[N][N], int row, int col)
{
    int i, j;
    for (i = 0; i < col; i++)
    {
        if (board[row][i])
            return false;
    }
    for (i = row, j = col; i >= 0 && j >= 0; i--, j--)
    {
        if (board[i][j])
            return false;
    }

    for (i = row, j = col; j >= 0 && i < N; i++, j--)
    {
        if (board[i][j])
            return false;
    }

    return true;
}

/*solve N Queen problem */
bool solver(int board[N][N], int col, int all_boards[M][N][N], int &num_boards)
{
    if (col >= N) {
        return true;
    }
    for (int i = 0; i < N; i++)
    {
       //*************************
       //start your code here

        // Clear the column of any previous attempts
        for (int j = 0; j < N; j++) {
            board[j][col] = 0;
        }

        // If it is safe to put a queen here, do so and solve the next column
        if (isSafe(board, i, col)) {

            board[i][col] = 1;

            // Attempt to solve the board for the rest of the columns
            if (solver(board, col+1, all_boards, num_boards)) {
                // If we found a solution, add it to the array of boards
                copy(&board[0][0], &board[0][0]+N*N, &all_boards[num_boards++][0][0]);
            }
        }

       //end your code here
       //**************************
    }

    return false;
}

/* solves the N Queen problem using Backtracking.*/
bool solveNQ()
{
    int board[N][N] = {0};
    int all_boards[M][N][N];
    int num_boards = 0;

    solver(board, 0, all_boards, num_boards);

    cout << "Found " << num_boards << " solutions" << endl;

    for (int i = 0; i < num_boards; i++) {
        cout << endl;
        cout << "Solution #" << i+1 << ": " << endl;
        printSolution(all_boards[i]);
    }

    return num_boards > 0;
}

// Main
int main()
{
    solveNQ();
    return 0;
}
