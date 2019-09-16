class ListNode
  attr_accessor :val, :next

  def initialize(val)
    @val = val
    @next = nil
  end
end

def reorder_list(head)
  # Create stack from given linked list
  stack = []
  node = head
  node_count = 0
  while node
    # Also count the number of nodes
    # since we're going through all of them anyway
    node_count += 1
    stack.push(node)
    node = node.next
  end

  # Nothing to do if the given list is empty
  return nil if node_count == 0

  # Starting from `head`, replace the `next` bit of the list
  # by building a new one
  node_from_beginning = head
  (node_count / 2).times do
    subsequent_node = node_from_beginning.next
    node_from_end = stack.pop
    node_from_end.next = subsequent_node
    node_from_beginning.next = node_from_end
    node_from_beginning = subsequent_node
  end
  node_from_beginning.next = nil
end
