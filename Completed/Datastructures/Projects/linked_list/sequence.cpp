#include <cstdlib>
#include <cassert>
#include "node.h"
#include "sequence.h"

using namespace std;

namespace linked_list {


    sequence::sequence() {
        //fill your code here

        // Initialize fields for an empty sequence
        head_ptr = NULL;
        tail_ptr = NULL;
        cursor = NULL;
        precursor = NULL;
        many_nodes = 0;
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
            cursor = NULL;
            precursor = NULL;
        }

        // cursor equals to the head pointer
        else if(source.cursor == source.head_ptr)
        {
            //fill your code here
            cursor = head_ptr;
            precursor = NULL;
        }

        else
        {
            //fill your code here
            //hint: use list_locate() function to find the precursor

            // Get the index of the node the source cursor is pointing to by iterating through the source
            // nodes untill the current node is the same as the cursor node.
            size_t cursor_index = 0;

            for (
                const node *current_node = source.head_ptr;
                current_node != NULL;
                current_node = current_node->link()
            ) {
                if (current_node == source.cursor) break;
                cursor_index++;
            }

            // Find the node in the copied list that corresponds to the cursor in the source list
            cursor = list_locate(head_ptr, cursor_index);

            // Find the node for the precursor
            precursor = list_locate(head_ptr, cursor_index-1);
        }
        //fill your code here
        // update the many_nodes variable

        // Get the number of nodes in the list
        many_nodes = list_length(head_ptr);

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

            // put the new node at the head of the list, and update the cursor and precursor
            list_head_insert(head_ptr, entry);
            cursor = head_ptr;
            precursor = NULL;
        }

        else
        {
            //fill your code here
            // all other cases
            //hint: list_insert()

            // Insert the new node after the precursor, and update the cursor
            list_insert(precursor, entry);
            cursor = precursor->link();
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
            // The two lists are the same list, no need to do anything
            return;
        }

        // Copy the source list to this list
        list_copy(source.head_ptr, head_ptr, tail_ptr);

        // There is no cursor in the source list
        if(source.cursor == NULL)
        {
            cursor = NULL;
            precursor = NULL;
        }

        // cursor equals to the head pointer
        else if(source.cursor == source.head_ptr)
        {
            cursor = head_ptr;
            precursor = NULL;
        }

        else
        {
            // Get the index of the node the source cursor is pointing to by iterating through the source
            // nodes untill the current node is the same as the cursor node.
            size_t cursor_index = 0;

            for (
                const node *current_node = source.head_ptr;
                current_node != NULL;
                current_node = current_node->link()
            ) {
                if (current_node == source.cursor) break;
                cursor_index++;
            }

            // Find the node in the copied list that corresponds to the cursor in the source list
            cursor = list_locate(head_ptr, cursor_index);

            // Find the node for the precursor
            precursor = list_locate(head_ptr, cursor_index-1);
        }
        // Get the number of nodes in the list
        many_nodes = list_length(head_ptr);

        return;
    }

    sequence::value_type sequence::current() const {

        return cursor->data();

    }
}
