
#include <cassert>
#include "sequence.h"

namespace sequence {

    Sequence::Sequence() {
        this->used = 0;
        this->current_index = 0;
    }

    void Sequence::start() {
        this->current_index = 0;
    }

    void Sequence::advance() {
        this->current_index += 1;
        assert(current_index < this->CAPACITY);
    }

    void Sequence::insert(const value_type &entry) {
        if (this->used > 0) {
            // move each entry past and including the current index down one spot
            for (size_type i = this->used; i > this->current_index; i -= 1) {
                if (i+1 < this->CAPACITY) {
                    this->data[i] = this->data[i-1];
                }
            }
        }

        this->used += 1;
        assert(this->used < this->CAPACITY);

        this->data[this->current_index] = entry;
    }

    void Sequence::attach(const value_type &entry) {
        this->advance();
        this->insert(entry);
    }

    void Sequence::remove_current() {
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

    Sequence::size_type Sequence::size() const {
        return this->used;
    }

    bool Sequence::is_item() const {
        return this->current_index < this->used;
    }

    Sequence::value_type Sequence::current() const {
        return this->data[this->current_index];
    }

    Sequence::value_type Sequence::operator[](Sequence::size_type index) const {
        if (index <= this->used) {
            return this->data[index];
        } else {
            return this->data[this->used];
        }
    }
}

