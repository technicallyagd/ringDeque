# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import ringDeque



suite "newDeque":
  test "should create new empty RingDeque while no argument passed":
    let q = newDeque[bool]()
    check q.len == 0

  test "should create new RingDeque filled with supplied array-like data":
    let q = newDeque([1, 2, 3])
    check q.len == 3
    check $q == "[1, 2, 3]"

  test "should create new RingDeque[char] filled with supplied string":
    let q = newDeque("ghi")
    check q.len == 3
    check $q == "['g', 'h', 'i']"

  test "should create new RingDeque[string] filled with supplied seq[string]":
    let q = newDeque(@["ghi", "jkl", "mno"])
    check q.len == 3
    check $q == "[\"ghi\", \"jkl\", \"mno\"]"

suite "`$`":
  test "should return the string representation of the deque":
    let q = newDeque([1, 2, 3])
    check $q == "[1, 2, 3]"

suite "len":
  test "should return the length of the deque":
    let q = newDeque([1, 2, 3])
    check q.len == 3

suite "head and tail":
  setup:
    let q = newDeque([1, 2, 3])
  test "head should return the value of the first node":
    check q.head == 1
  test "tail should return the value of the last node":
    check q.tail == 3
  test "headNode should return the first DoublyLinkedNode in the deque":
    let n = q.headNode
    check n.value == 1
    check n.prev.value == 3
    check n.next.value == 2
  test "tailNode should return the last DoublyLinkedNode in the deque":
    let n = q.tailNode
    check n.value == 3
    check n.prev.value == 2
    check n.next.value == 1

suite "append":
  test "should add to the right of the deque":
    var q = newDeque([1, 2, 3])
    check q.len == 3

    q.append(4)
    check q.len == 4
    check $q == "[1, 2, 3, 4]"

suite "prepend":
  test "should add to the left of the deque":
    var q = newDeque([1, 2, 3])
    q.prepend(4)
    check $q == "[4, 1, 2, 3]"

suite "extend and extendLeft":
  setup:
    var q = newDeque([1, 2])
  test "extend should append provided values to the tail":
    check q.len == 2
    q.extend([3, 4, 5])
    check q.len == 5
    check $q == "[1, 2, 3, 4, 5]"
  test "extendLeft should prepend provided values to the head":
    check q.len == 2
    q.extendLeft([3, 4, 5])
    check q.len == 5
    check $q == "[5, 4, 3, 1, 2]"

suite "find":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])
  test "should return the first node with given value":
    let n = q.find(4)
    check n.value == 4
    q.removeNode(n)
    check q.len == 4
    check $q == "[1, 2, 3, 5]"
  test "should return nil if value not found":
    let n = q.find(999)
    check n.isNil

suite "rotate":
  test "rotate by positive number should shift deque counter clock-wise":
    var q = newDeque([1, 2, 3, 4, 5])
    q.rotate(1)
    check $q == "[5, 1, 2, 3, 4]"
    q.rotate(9)
    check $q == "[1, 2, 3, 4, 5]"

  test "rotate by positive number should shift deque counter clock-wise":
    var q = newDeque([1, 2, 3, 4, 5])
    q.rotate(-1)
    check $q == "[2, 3, 4, 5, 1]"
    q.rotate(-9)
    check $q == "[1, 2, 3, 4, 5]"

  test "rotate input defaults to +1":
    var q = newDeque([1, 2, 3, 4, 5])
    q.rotate()
    check $q == "[5, 1, 2, 3, 4]"

suite "Indexing operator":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])

  test "should fetch the value directly":
    check q[3] == 4

  test "should support BackwardsIndex":
    check q[^1] == 5

  test "should be able to reassign new value":
    q[3] = 122
    check q[3] == 122
    q[^4] = 21
    check $q == "[1, 21, 3, 122, 5]"

suite "reverse and reversed":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])

  test "reverse should reverse the deque in-place":
    q.reverse()
    check $q == "[5, 4, 3, 2, 1]"

  test "reversed should returned a reversed copy of the RingDeque":
    let r = q.reversed()
    check $r == "[5, 4, 3, 2, 1]"
    check $q == "[1, 2, 3, 4, 5]"

suite "remove and removeNode":
  setup:
    var q = newDeque([1, 2, 3, 4, 5, 2, 4, 0])

  test "remove should remove the first value it finds":
    q.remove(2)
    check $q == "[1, 3, 4, 5, 2, 4, 0]"

  test "remove should raise ValueError if the value is not found":
    expect ValueError:
      q.remove(10)

  test "removeNode should remove the node provided":
    q.removeNode(q.headNode.next)
    check $q == "[1, 3, 4, 5, 2, 4, 0]"

  test "removeNode should make next node the head if head is removed":
    q.removeNode(q.headNode)
    check $q == "[2, 3, 4, 5, 2, 4, 0]"

suite "pop and popLeft":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])

  test "pop should remove rightmost node and return its value":
    let v = q.pop()
    check $q == "[1, 2, 3, 4]"
    check q.len == 4
    check v == 5

  test "popLeft should remove leftmost node and return its value":
    let v = q.popLeft()
    check $q == "[2, 3, 4, 5]"
    check q.len == 4
    check v == 1

suite "clear":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])
  test "should empty the deque":
    check $q == "[1, 2, 3, 4, 5]"
    q.clear()
    check $q == "[]"

suite "count":
  setup:
    var q = newDeque([1, 2, 3, 4, 5, 2, 4, 2])
  test "should count number of elements ":
    check q.count(2) == 3
    check q.count(4) == 2
    check q.count(99) == 0

suite "step for DoublyLinkedNode":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])

  test "should move forward n times for n > 0":
    var node = q.headNode
    check node.value == 1
    node.step(2)
    check node.value == 3
    node.step(4)
    check node.value == 2

  test "should move backward n times for n < 0":
    var node = q.headNode
    check node.value == 1
    node.step(-2)
    check node.value == 4
    node.step(-4)
    check node.value == 5

  test "should not affect the original deque":
    var node = q.headNode
    check node.value == 1
    node.step(2)
    check node.value == 3
    check $q == "[1, 2, 3, 4, 5]"
    check q.head == 1
