#include <iostream>
#include <string>
#include <sstream>

using namespace std;

bool matches_pattern(int a, int b, int c) {
    return (a | b) == c;
}

string pattern_discription() {
    return "(a | b) == c";
}

int main() {

    cout << "Welcome to the guessing game!" << endl;
    cout << "You need to guess a pattern that describes how 3 numbers relate to each other" << endl;
    cout << "You will need to enter 3 numbers at a time," << endl;
    cout << "and you will be told if your numbers match the pattern" << endl;

    cout << endl;

    cout << "Shall we begin? (y/n)" << endl;

    string begin;

    getline(cin, begin);

    if (begin != "y") {
        cout << endl;
        cout << "Bye!" << endl;
        exit(1);
    }

    cout << endl;

    while (1) {
        cout << "Enter 3 numbers, seperated by whitespace." << endl;
        cout << "To quit, type \"quit\". To see the pattern, type \"pattern\"" << endl;

        string input;

        getline(cin, input);

        cout << endl;

        if (input == "quit") {
            cout << "Bye!" << endl;
            exit(1);
        }

        if (input == "pattern") {
            cout << "The pattern is: " << pattern_discription() << endl;
            cout << endl;
            continue;
        }

        int a, b, c;

        input.append(" ");

        stringstream number_stream = stringstream(input);

        number_stream >> a;

        if (!number_stream.good()) {
            cout << "Invalid first number, please try again" << endl;
            cout << endl;
            continue;
        }

        number_stream >> b;

        if (!number_stream.good()) {
            cout << "Invalid second number, please try again" << endl;
            cout << endl;
            continue;
        }

        number_stream >> c;

        if (!number_stream.good()) {
            cout << "Invalid third number, please try again" << endl;
            cout << endl;
            continue;
        }

        cout << "You entered: " << a << ", " << b << ", and " << c << endl;

        if (matches_pattern(a, b, c)) {
            cout << "You won!" << endl;
            cout << "The pattern was: " << pattern_discription() << endl;
            exit(0);
        } else {
            cout << "Nope!" << endl;
            cout << endl;
        }
    }
}

