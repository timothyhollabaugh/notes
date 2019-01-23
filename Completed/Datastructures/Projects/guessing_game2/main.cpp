#include <iostream>
#include <string>
#include <sstream>
#include <vector>

using namespace std;

bool matches_pattern(int a, int b, int c) {
    return (a | b) == c;
}

string pattern_discription() {
    return "(a | b) == c";
}

class Guess {
    public:
        int a;
        int b;
        int c;
        bool matches() { return matches_pattern(a, b, c); }
};

void print_guesses(vector<Guess> guesses) {
    if (guesses.size() == 0) {
        cout << "You have not made any guesses yet!" << endl;
    } else {
        cout << "Here are your guesses:" << endl;

        for (int i = 0; i < guesses.size(); i++) {
            Guess guess = guesses[i];

            cout << guess.a << ", " << guess.b << ", and " << guess.c << ": ";

            if (guess.matches()) {
                cout << "Yes";
            } else {
                cout << "No";
            }

            cout << endl;
        }
    }
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

    vector<Guess> guesses;

    while (1) {
        cout << "Enter 3 numbers, seperated by whitespace." << endl;
        cout << "To quit, type \"quit\". ";
        cout << "To see the pattern, type \"pattern\". ";
        cout << "To see your guesses, type \"guesses\". " << endl;

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

        if (input == "guesses") {
            print_guesses(guesses);
            cout << endl;
            continue;
        }

        Guess guess;

        input.append(" ");

        stringstream number_stream = stringstream(input);

        number_stream >> guess.a;

        if (!number_stream.good()) {
            cout << "Invalid first number, please try again" << endl;
            cout << endl;
            continue;
        }

        number_stream >> guess.b;

        if (!number_stream.good()) {
            cout << "Invalid second number, please try again" << endl;
            cout << endl;
            continue;
        }

        number_stream >> guess.c;

        if (!number_stream.good()) {
            cout << "Invalid third number, please try again" << endl;
            cout << endl;
            continue;
        }

        cout << "You entered: " << guess.a << ", " << guess.b << ", and " << guess.c << endl;

        guesses.push_back(guess);

        if (guess.matches()) {
            cout << "You won!" << endl;
            cout << endl;
            print_guesses(guesses);
            cout << endl;
            cout << "The pattern was: " << pattern_discription() << endl;
            exit(0);
        } else {
            cout << "Nope!" << endl;
            cout << endl;
        }
    }
}

