# Deque implemented with DoublyLinkedRing

This package is trying to mimic some functionalities of Python's `deque` from [collections](https://docs.python.org/2/library/collections.html#collections.deque). Since there's already a [deques](https://nim-lang.org/docs/deques.html) implemented with `seq`, I had to call this `RingDeque`.

## Example Usage

```nim
import ringDeque

var dq = newDeque("ghi")

echo dq                       # ['g', 'h', 'i']

dq.append('j')
dq.prepend('f')

echo dq.len                   # 5
echo dq                       # ['f', 'g', 'h', 'i', 'j']

echo dq.pop()                 # j
echo dq.popLeft()             # f

echo dq                       # ['g', 'h', 'i']

var n = dq.headNode # Gets the head node (of type DoublyLinkedNode) of the deque
echo n.value                  # g
echo n.next.value             # h
echo n.prev.value             # i

echo dq[0]                    # g
echo dq.head                  # g
echo dq[^1]                   # i
echo dq.tail                  # i

dq[1] = 'z'
echo dq                       # ['g', 'z', 'i']
dq[1] = 'h'

# dq[x] justs goes down the headNode.next chain x mod dq.len times
# Access the two ends will be fast.
# Access the middle of a long deque will be really slow.

# However, we only go at most dq.len steps
# These are the same as doing dq[0]
echo dq[9]                    # g
echo dq[^9]                   # g

let rdq = reversed(dq)        # Makes a reversed copy of dq
echo rdq                      # ['i', 'h', 'g']

echo 'h' in dq                # true
echo '@' in dq                # false

dq.extend("jkl")
echo dq                       # ['g', 'h', 'i', 'j', 'k', 'l']

dq.rotate(1)
echo dq                       # ['l', 'g', 'h', 'i', 'j', 'k']

dq.rotate(-1)
echo dq                       # ['g', 'h', 'i', 'j', 'k', 'l']

dq.reverse()                  # reverses dq in-place
echo dq                       # ['l', 'k', 'j', 'i', 'h', 'g']

dq.clear()                    # Empty the deque
try:
  discard dq.pop()
except ValueError:
  echo "raises ValueError if popping empty deque"

dq.extendLeft("abc")          # extendLeft() reverses the input order
echo dq                       # ['c', 'b', 'a']

```

Please take a look at [theTest.nim](tests/theTest.nim) for more supported usages.
