pragma solidity ^0.4.24;

contract queue
{
    uint extent = 101;  //控制队列长度,目前队列仅存100人
    
    struct Queue {
        uint[] data;
        uint front;
        uint back;
        uint number;
    }
    /// @dev the number of elements stored in the queue.
    function length(Queue storage q) view internal returns (uint) {
        return q.number;
    }
    /// @dev push a new element to the back of the queue
    function push(Queue storage q, uint data) internal
    {
        if ((q.back + 1) % extent == q.front)
            return; // throw;
        q.data[q.back] = data;
        q.number += 1;
        q.back = (q.back + 1) % extent;
    }
    /// @dev remove and return the element at the front of the queue
    function pop(Queue storage q) internal returns (uint r)
    {
        if (q.back == q.front)
            return; // throw;
        r = q.data[q.front];
        delete q.data[q.front];
        q.number -= 1;
        q.front = (q.front + 1) % extent;
    }
    
}

/*
contract QueueUserMayBeDeliveryDroneControl is queue {
    Queue requests;
    
    constructor() public {
        requests.data.length = 200;
    }
    function addRequest(string d) public {
        push(requests, d);
    }
    function popRequest() public returns (string) {
        return pop(requests);
    }
    function queueLength() view public returns (uint) {
        return length(requests);
    }
}*/