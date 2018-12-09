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
