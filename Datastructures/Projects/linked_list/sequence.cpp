#include <cstdlib>
#include <cassert>
#include "node.h"
#include "sequence.h"

using namespace std;

namespace linked_list {


    sequence::sequence() {
        //fill your code here
    }

    sequence::sequence(const sequence& source)
    {

        //hint: copy nodes from the source sequence
        list_copy(source.head_ptr, head_ptr, tail_ptr);

        //hint: update the cursor and precursor
        //no current item
        if(source.cursor == NULL)
        {
            //fill your code here

        }

        // cursor equals to the head pointer
        else if(source.cursor == source.head_ptr)
        {
            //fill your code here

        }

        else
        {
            //fill your code here
            //hint: use list_locate() function to find the precursor


        }
        //fill your code here
        // update the many_nodes variable


        return;

    }


    sequence::~sequence() {
        list_clear(head_ptr);
        many_nodes=0;

    }

    void sequence::start() {
        cursor = head_ptr;
        precursor = NULL;

    }

    void sequence::advance()
    {
        // reach the end of the sequence
        if(!is_item())
        {
            return;
        }
        // no current item
        if(cursor->link() == NULL )
        {
            precursor = NULL;
            cursor = NULL;
        }
        else
        {
            precursor = cursor;
            cursor = cursor->link();
        }
        return;
    }

    void sequence::insert(const value_type& entry)
    {
        // insert at the head or no current
        if(cursor == head_ptr || cursor == NULL)
        {
            //hint: list_head_insert()

        }

        else
        {
            //fill your code here
            // all other cases
            //hint: list_insert()

        }
        //update the variables
        many_nodes = many_nodes + 1;
        tail_ptr = list_locate(head_ptr, many_nodes);
        return;
    }


    void sequence::attach(const value_type& entry)
    {

        if(head_ptr == NULL)
        {
            list_head_insert(head_ptr, entry);
            cursor = head_ptr;
        }
        else if(cursor == NULL || cursor == tail_ptr)
        {
            list_insert(tail_ptr, entry);
            precursor = tail_ptr;
            cursor = precursor->link();
            tail_ptr = cursor;
        }
        else
        {
            list_insert(cursor, entry);
            precursor = cursor;
            cursor = cursor->link();
        }
        many_nodes = many_nodes + 1;
        return;
    }

    void sequence::remove_current ()
    {
        if(!is_item())
            return;

        if(cursor == head_ptr && cursor->link() != NULL)
        {
            list_head_remove(head_ptr);
            cursor = head_ptr;
            precursor = NULL;
        }
        else if(cursor == head_ptr && cursor->link() == NULL)
        {
            list_clear(head_ptr);
            cursor = NULL;
            precursor = NULL;
        }
        else if(cursor->link() == NULL)
        {
            list_remove(precursor);
            cursor = NULL;
            precursor = NULL;
        }
        else
        {
            list_remove(precursor);
            cursor = precursor->link();
        }
        many_nodes = list_length(head_ptr);
        return;
    }

    void sequence::operator =(const sequence& source)
    {
        if(this == &source){
            //fill your code here
        }


        //fill your code here
        // copy the linked list
        //hint: use list_copy() function

        if(source.cursor ==  NULL)
        {
            //fill your code here

        }


        //copy the cursor and precursor
        else if(source.cursor == source.head_ptr)
        {

            //fill your code here
        }

        else
        {
             //fill your code here
            //hint: use list_locate() function to find the precursor
        }

        many_nodes = list_length(head_ptr);
        return ;
    }

    sequence::value_type sequence::current() const {

        return cursor->data();

    }
}
