This problem requires making a couple of observations and small conceptual jumps:

* The reordering involves interleaving two "streams" of nodes, one going in the direction of the original linked list and one going in the opposite direction. 
* This seems like it would be fairly easy if we had a second copy of the linked list, but in reverse order. Can we make one? Well, we can use a stack to reverse a linked list — we can traverse through the linked list, adding each element to the stack, and we can pop items off the stack; they'll come off in reverse order. 
* The problem asks us to modify the linked list in-place, but modifying in-place can sometimes be messy while you're in the middle of it. Sometimes it's easier to imagine building a new data structure from scratch, and figuring out how to make that work in-place. So how would we build a new, reordered linked list? We could alternate between the two lists, getting the `head` of the linked list and `pop`ping the top item of the stack, and adding them to our new linked list one at a time. 

In this case, it was important to notice the specific pattern in the reordered list — the pattern isn't arbitrary, and its design informs the solution. You also need to know (or figure out) that a linked list can only be traversed in one direction, and a items `pop`ped off a stack come off in the opposite order that they were added in; combining these facts means that a stack can be used to reverse a linked list. Finally, you'll have to combine these pieces into the actual solution.

There are two remaining questions:

How do we adapt the solution to modify the original list in-place? Well, we want to keep the first `head` in place, but we want to insert a node between that `head` and the `head.next` node. So, we can stash `head.next` in a temporary variable, `pop` the node we want to insert-in-between from the stack, set `head.next` to that node, and set _its_ `next` to the temporary variable. Then we repeat, with `head` now referring to the node in the temporary variable. 

Finally, how do we know when we're done? If we manually run that solution over the examples, we see that we have to run those steps N/2 steps, where N is the number of items in the linked list. What happens if N is odd? In Example 2, N is 5, and it turns out that running these steps 2 times is also enough. Thus, N/2 (rounded down, which is what integer division does by default) is the number of times we need to run these steps.

```ruby
@cat 1-stack.rb
```

This solution iterates through all the nodes of the linked list once to build the stack — this is O(N). We'll assume `push`ing and `pop`ing to a stack is constant time, so we can ignore this factor. Then, we run a bunch of constant-time updates within a loop which repeats N/2 times — this is O(N/2). Thus, the total runtime is O(N) + O(N/2), which simplifies to O(N).