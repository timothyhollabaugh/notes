/*
 * C++ Program to Solve N-Queen Problem
 */
#include <iostream>
#include <cstdio>
#include <cstdlib>
#define N 8
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
bool solver(int board[N][N], int col)
{
    if (col >= N) {
        cout << "Solved" << endl;
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

            cout << i << ", " << col << endl;
            printSolution(board);

            // Attempt to solve the board for the rest of the columns. If that worked, we are done.
            if (solver(board, col+1)) return true;
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
    if (solver(board, 0) == false)
    {
        cout<<"Solution does not exist"<<endl;
        return false;
    }
    printSolution(board);
    return true;
}
 
// Main
int main()
{
    solveNQ();
    return 0;
}
