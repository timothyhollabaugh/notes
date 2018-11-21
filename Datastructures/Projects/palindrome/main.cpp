#include <iostream>
#include <string>
#include <stack>
#include <queue>
#include <cassert>
#include <locale>

using namespace std;

bool is_palindrome(string str) {

    // if the string is empty, we know it is a palindrome
    if (str == "") return true;

    // create the stack and the queue
    stack<char> s;
    queue<char> q;

    // create a locale uses to check if each character is a letter
    locale l;

    // iterate through the string, and add each letter to both the queue and the stack
    for (string::iterator it = str.begin(); it != str.end(); it++) {

        // We only check letters for palindromes
        if (isalpha(*it, l)) {
            // Make everything lowercase to make it case insensitive
            s.push(tolower(*it));
            q.push(tolower(*it));
        }
    }

    // Go through the stack and queue to make sure that the top of the stack and the front of the queue match
    while (!s.empty() || !q.empty()) {
        if (s.top() != q.front()) {
            // if they do not match, there is no point in continuing
            return false;
        }

        // Remove this element from the stack and the queue, so the next one can be tested next iteration
        s.pop();
        q.pop();
    }

    // we would have returned false already if it was not a palindrome, so it must be a palindrome here.
    return true;
}

int main() {

    // run some tests
    assert(is_palindrome("racecar"));
    assert(!is_palindrome("hello"));
    assert(is_palindrome("A man, a plan, a canal: Panama"));
    assert(is_palindrome(""));

    cout << "Tests passed!\n";
}


