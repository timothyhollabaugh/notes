
#include <iostream>

using namespace std;

int main() {

    int n;

    cout << "How many values? ";
    cin >> n;

    int *a = new int[n];

    int m;
    int *p;

    for (int i = 0; i < n; i++) {

        int v;

        cout << "Enter value #" << i << ": ";
        cin >> v;

        a[i] = v;

        cout << "The pointer to value #" << i << " is " << &a[i] << endl;

        if (i == 0 || a[i] > m) {
            m = a[i];
            p = &a[i];
        }
    }

    cout << "The pointer to the largest value is " << p << endl;
}

