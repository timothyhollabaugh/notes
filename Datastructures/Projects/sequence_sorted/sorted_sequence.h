#ifndef SEQUENCE_H
#define SEQUENCE_H
#include <cstdlib>

namespace sorted_sequence {
    class SortedSequence {

        public:
            typedef double value_type;
            typedef std::size_t size_type;

            static const size_type CAPACITY = 30;

            SortedSequence();

            void start();
            void advance();
            void insert(const value_type &entry);
            void remove_current();

            size_type size() const;
            bool is_item() const;
            value_type current() const;
            value_type operator[](size_type index) const;

        private:
            value_type data[CAPACITY];
            size_type used;
            size_type current_index;
    };
}

#endif
