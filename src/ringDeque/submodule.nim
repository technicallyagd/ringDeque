import lists
type
  RingDeque*[T] = object
    data: DoublyLinkedRing[T]
    length: int
    cursor: DoublyLinkedNode[T]


proc newDeque*[T](): RingDeque[T] =
  result.cursor = result.data.head


proc newDeque*[T](initialData: openArray[T]): RingDeque[T] =
  for d in initialData:
    result.data.append(d)
    result.length += 1
  result.cursor = result.data.head

proc append*[T](dq: var RingDeque[T]; v: T) =
  var newNode = newDoublyLinkedNode(v)
  var tail = dq.cursor.prev
  newNode.prev = tail
  newNode.next = dq.cursor
  dq.cursor.prev = newNode
  tail.next = newNode

proc len*(dq: RingDeque): int =
  dq.length

proc `[]`*[T](dq: RingDeque[T]; i: int): T =
  var n = dq.cursor
  let moves = i mod dq.length
  for _ in 0..<moves:
    n = n.next
  n.value

proc rotate*[T](dq: var RingDeque[T]; r: int) =
  var n = dq.cursor
  if r > 0:
    for _ in 0..<rot:
      n = n.next
  else:
    for _ in 0..<(-rot):
      n = n.prev
  dq.cursor = n
