
#include <cassert>
#include "sorted_sequence.h"

namespace sorted_sequence {

    SortedSequence::SortedSequence() {
        this->used = 0;
        this->current_index = 0;
    }

    void SortedSequence::start() {
        this->current_index = 0;
    }

    void SortedSequence::advance() {
        this->current_index += 1;
        assert(current_index < this->CAPACITY);
    }

    void SortedSequence::insert(const value_type &entry) {

        size_type insert_index = 0;

        if (this->used > 0) {

            insert_index = this->used;

            for (size_type i = 0; i < this->used; i += 1) {
                if (this->data[i] > entry) {
                    insert_index = i;
                    break;
                }
            }

            // move each entry past and including the current index down one spot
            for (size_type i = this->used; i > insert_index; i -= 1) {
                if (i+1 < this->CAPACITY) {
                    this->data[i] = this->data[i-1];
                }
            }
        }

        this->used += 1;
        assert(this->used < this->CAPACITY);

        this->data[insert_index] = entry;
    }

    void SortedSequence::remove_current() {
        if (this->used > 0) {
            // move each entry past the current index forwad one spot
            for (size_type i = this->current_index; i < this->used; i+= 1){
                if (i+1 < this->CAPACITY) {
                    this->data[i] = this->data[i+1];
                }
            }

            used -= 1;
        }
    }

    SortedSequence::size_type SortedSequence::size() const {
        return this->used;
    }

    bool SortedSequence::is_item() const {
        return this->current_index < this->used;
    }

    SortedSequence::value_type SortedSequence::current() const {
        return this->data[this->current_index];
    }

    SortedSequence::value_type SortedSequence::operator[](SortedSequence::size_type index) const {
        if (index <= this->used) {
            return this->data[index];
        } else {
            return this->data[this->used];
        }
    }
}

