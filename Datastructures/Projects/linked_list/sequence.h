#ifndef SEQUENCE_H
#define SEQUENCE_H
#include <cstdlib>
#include "node.h"

namespace linked_list {

    class sequence {

        public:
            typedef double value_type;
            typedef std::size_t size_type;

            sequence();
            sequence(const sequence& soruce);
            ~sequence();

            void start();
            void advance();
            void insert(const value_type &entry);
            void attach(const value_type &entry);
            void operator = (const sequence& source);
            void remove_current();

            size_type size() const {
                return many_nodes;
            }

            bool is_item() const {
                return many_nodes;
            }

            value_type current() const;

        private:
            node *head_ptr;
            node *tail_ptr;
            node *cursor;
            node *precursor;
            size_type many_nodes;
    };
}

