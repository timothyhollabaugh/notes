#include <iostream>
#include "sequence.h"

using namespace std;
using namespace sequence;

void print_sequence(const Sequence &s) {
    cout << "Sequence" << endl;
    for (int i = 0; i < s.size(); i += 1) {
        cout << s[i];
        cout << " ";
    }
    cout << endl;

    cout << "size " << s.size() << " | ";
    cout << "current item " << s.current() << " | ";
    cout << "valid item " << s.is_item() << endl;

    cout << endl;
}

int main() {
    cout << "Testing sequence class" << endl;

    cout << "Creating sequence" << endl;
    Sequence s;
    print_sequence(s);

    cout << "Inserting elements into sequence" << endl;
    s.insert(1);
    print_sequence(s);
    s.insert(2);
    print_sequence(s);
    s.insert(3);
    print_sequence(s);

    cout << "Attaching elements to sequence" << endl;
    s.attach(10);
    print_sequence(s);
    s.attach(11);
    print_sequence(s);

    cout << "Removing elements" << endl;
    s.remove_current();
    print_sequence(s);

    cout << "Reseting to start" << endl;
    s.start();
    print_sequence(s);

    cout << "Advancing sequence" << endl;
    while (s.is_item()) {
        s.advance();
        print_sequence(s);
    }

}

