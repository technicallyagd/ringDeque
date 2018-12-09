import lists
type
  RingDeque*[T] = object
    data: DoublyLinkedRing[T]
    length: int

proc `$`*[T](dq: RingDeque[T]): string =
  ## turns a list into its string representation.
  $dq.data

proc newDeque*[T](): RingDeque[T] =
  result

proc newDeque*[T](initialData: openArray[T]): RingDeque[T] =
  for d in initialData:
    result.data.append(d)
    result.length += 1

proc append*[T](dq: var RingDeque[T]; v: T) =
  dq.data.append(v)
  dq.length += 1

proc prepend*[T](dq: var RingDeque[T]; v: T) =
  dq.data.prepend(v)
  dq.length += 1

proc len*(dq: RingDeque): int =
  dq.length

proc `[]`*[T](dq: RingDeque[T]; i: int): T =
  var n = dq.data.head
  let moves = i mod dq.length
  for _ in 0..<moves:
    n = n.next
  n.value

proc `[]`*[T](dq: var RingDeque[T]; i: int): T =
  var n = dq.data.head
  let moves = i mod dq.length
  for _ in 0..<moves:
    n = n.next
  n.value

proc `[]=`*[T](dq: var RingDeque[T]; i: int; v: T) =
  var n = dq.data.head
  let moves = i mod dq.length
  for _ in 0..<moves:
    n = n.next
  n.value = v

proc `[]`*[T](dq: RingDeque[T]; i: BackwardsIndex): T =
  var n = dq.data.head
  let moves = i.int mod dq.length
  for _ in 0..<moves:
    n = n.prev
  n.value

proc `[]`*[T](dq: var RingDeque[T]; i: BackwardsIndex): T =
  var n = dq.data.head
  let moves = i.int mod dq.length
  for _ in 0..<moves:
    n = n.prev
  n.value

proc `[]=`*[T](dq: var RingDeque[T]; i: BackwardsIndex; v: T) =
  var n = dq.data.head
  let moves = i.int mod dq.length
  for _ in 0..<moves:
    n = n.prev
  n.value = v

proc rotate*[T](dq: var RingDeque[T]; r = 1) =
  ## Positive = right rotation = counter clock-wise
  ## Negative = left rotation = clock-wise
  var n = dq.data.head
  var rot = r mod dq.length
  if r > 0:
    for _ in 0..<rot:
      n = n.prev
  else:
    for _ in 0..<(-rot):
      n = n.next
  dq.data.head = n

proc reverse*[T](dq: var RingDeque[T]) =
  ## Reverses the RingDeque in-place
  for n in dq.data.nodes:
    swap(n.prev, n.next)
  dq.data.head = dq.data.head.next

proc reversed*[T](dq: RingDeque[T]): RingDeque[T] =
  ## Returns a reversed copy of the RingDeque
  var n = dq.data.head
  for _ in 0..<dq.length:
    result.prepend(n.value)
    n = n.next

proc remove*[T](dq: var RingDeque[T]; n: DoublyLinkedNode[T]) =
  ## Removes the given node
  dq.length += -1
  dq.data.remove(n)

# TODO handle cases where deque is empty
proc pop*[T](dq: var RingDeque[T]): T =
  ## Removes the rightmost node in the list and returns its value
  var n = dq.data.head.prev
  result = n.value
  dq.remove(n)

proc popLeft*[T](dq: var RingDeque[T]): T =
  ## Removes the leftmost node in the list and returns its value
  var n = dq.data.head
  result = n.value
  dq.data.head = n.next
  dq.remove(n)

proc clear*[T](dq: var RingDeque[T]) =
  ## Removes the entire deque
  for _ in 0..<dq.length:
    dq.data.remove(dq.data.head)
  dq.length = 0

proc count*[T](dq: RingDeque[T]; v: T): int =
  for n in dq.data.nodes:
    if n.value == v: result += 1
