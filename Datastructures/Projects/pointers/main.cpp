
#include <iostream>

using namespace std;

int main() {

    // The scope operators { } keep the variables seperate between the two runs

    {
        int i;
        int k;

        int *p1;
        int *p2;

        cout << "Enter the first number (i): ";
        cin >> i;
        cout << endl;

        cout << "Enter the second number (k): ";
        cin >> k;
        cout << endl;

        cout << "Initially:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        p1 = &i;
        p2 = &k;

        cout << "After assignment to pointers:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        p1 = p2;

        cout << "After assigning p1 to p2:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        *p1 = 3;
        *p2 = 4;

        cout << "After final assignment:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;
    }

    {
        int i;
        int k;

        int *p1;
        int *p2;

        cout << "Enter the first number (i): ";
        cin >> i;
        cout << endl;

        cout << "Enter the second number (k): ";
        cin >> k;
        cout << endl;

        cout << "Initially:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        p1 = &i;
        p2 = &k;

        cout << "After assignment to pointers:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        *p1 = *p2;

        cout << "After assigning *p1 to *p2:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;

        *p1 = 3;
        *p2 = 4;

        cout << "After final assignment:" << endl;
        cout << "i: " << i << ", k: " << k << ", p1: " << p1 << ", p2" << p2 << endl;
    }
}

