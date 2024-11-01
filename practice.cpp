#include <bits/stdc++.h>
using namespace std;

// INITIALIZING AN LINKED LIST
struct Node
{
public:
    int data;
    Node *next;

public:
    Node(int data1)
    {
        data = data1;
        next = nullptr;
    }

public:
    Node(int data1, Node *next1)
    {
        data = data1;
        next = next1;
    }
};

// CREATING A LL FROM ARRAY
Node *ArrToLL(vector<int> &arr)
{
    Node *head = new Node(arr[0]);
    Node *mover = head;

    for (int i = 1; i < arr.size(); i++)
    {
        Node *temp = new Node(arr[i]);
        mover->next = temp;
        mover = temp;
    }

    return head;
}

// RETURN THE TAIL OF LINKED LIST
Node* Tail(Node* head) {
    if (head == NULL) return NULL;  

    Node* temp = head;
    while (temp->next != NULL) {
        temp = temp->next;
    }

    return temp;  
}


int main()
{
    vector<int> nums = {1, 2, 3, 4, 5};
    Node *head = ArrToLL(nums);

    Node *tail = Tail(head);
    cout << tail->data;

    // TRAVERSING THROUGH THE LINKED LIST.
    // Node *newtemp = head;
    // while (newtemp)
    // {
    //     cout << newtemp->data << " ";
    //     newtemp = newtemp->next;
    // }
    // cout << endl;

    return 0;
}