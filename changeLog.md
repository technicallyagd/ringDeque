# Change Log

## v0.3.0

- Adds utility routine, `proc step(node: var DoublyLinkedNode; n = 1)` that helps with manipulating multiple cursors from a single deque.

## v0.2.0

- `remove` now remove the first node it finds that matches the given value. `removeNode` removes the provided node.

- Adds `head`, `tail`, `headNode`, `tailNode`, `find`, `contains`, `extend`, and `extendLeft`.

- Raises `ValueError` when popping empty deque.

## v0.1.0

- Implements most methods specified in the Python version of `deque` with the exception of `extend` and `extendLeft`
