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

suite "append":
  test "should add to the right of the deque":
    var q = newDeque([1, 2, 3])
    q.append(4)
    check $q == "[1, 2, 3, 4]"

suite "prepend":
  test "should add to the left of the deque":
    var q = newDeque([1, 2, 3])
    q.prepend(4)
    check $q == "[4, 1, 2, 3]"

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

suite "Indexing operator":
  setup:
    var q = newDeque([1, 2, 3, 4, 5])

  test "should fetch the value directly":
    check q[3] == 4

  test "should be able to reassign new value":
    q[3] = 122
    check q[3] == 122
