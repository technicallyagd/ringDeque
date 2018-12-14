import lists

## Utility proc for moving DoublyLinkedNode itself
func step*(node: var DoublyLinkedNode; nSteps = 1) =
  if nSteps > 0:
    for _ in 1..nSteps:
      node = node.next
  else:
    for _ in 1..(-nSteps):
      node = node.prev

type
  RingDeque*[T] = object
    data: DoublyLinkedRing[T]
    length: int


proc newDeque*[T](): RingDeque[T] =
  result

proc newDeque*[T](initialData: openArray[T]): RingDeque[T] =
  for d in initialData:
    result.data.append(d)
    result.length += 1

proc `$`*[T](dq: RingDeque[T]): string =
  ## turns a list into its string representation.
  $dq.data

proc len*(dq: RingDeque): int =
  dq.length

proc headNode*[T](dq: RingDeque[T]): DoublyLinkedNode[T] =
  ## Returns the current head of the deque.
  dq.data.head

proc tailNode*[T](dq: RingDeque[T]): DoublyLinkedNode[T] =
  ## Returns the current tail of the deque.
  dq.data.head.prev

proc head*[T](dq: RingDeque[T]): T =
  ## Returns the current value of the head of the deque.
  dq.data.head.value

proc tail*[T](dq: RingDeque[T]): T =
  ## Returns the current value of the tail of the deque.
  dq.data.head.prev.value

proc append*[T](dq: var RingDeque[T]; v: T) =
  dq.data.append(v)
  dq.length += 1

proc prepend*[T](dq: var RingDeque[T]; v: T) =
  dq.data.prepend(v)
  dq.length += 1


proc removeNode*[T](dq: var RingDeque[T]; n: DoublyLinkedNode[T]) =
  ## Removes the given node, and make the next node head.
  dq.length += -1
  if n == dq.data.head:
    dq.data.head = n.next
  dq.data.remove(n)

proc clear*[T](dq: var RingDeque[T]) =
  ## Removes the entire deque
  for _ in 0..<dq.length:
    dq.data.remove(dq.data.head)
  dq.length = 0

proc contains*[T](dq: RingDeque[T]; v: T): bool =
  dq.data.contains(v)

proc count*[T](dq: RingDeque[T]; v: T): int =
  for n in dq.data.nodes:
    if n.value == v: result += 1

proc extend*[T](dq: var RingDeque[T]; vs: openArray[T]) =
  ## Appends the values provided
  for v in vs:
    dq.append(v)

proc extendLeft*[T](dq: var RingDeque[T]; vs: openArray[T]) =
  ## Prepends the values provided. Reverses the input order
  for v in vs:
    dq.prepend(v)

proc find*[T](dq: RingDeque[T]; v: T): DoublyLinkedNode[T] =
  ## Returns first node that equals the given value.
  ## Returns nil if none found.
  dq.data.find(v)

proc pop*[T](dq: var RingDeque[T]): T =
  ## Removes the rightmost node in the list and returns its value
  if dq.length > 0:
    var n = dq.data.head.prev
    result = n.value
    dq.removeNode(n)
  else: raise newException(ValueError, "The deque is empty.")

proc popLeft*[T](dq: var RingDeque[T]): T =
  ## Removes the leftmost node in the list and returns its value
  if dq.length > 0:
    var n = dq.data.head
    result = n.value
    dq.removeNode(n)
  else: raise newException(ValueError, "The deque is empty.")

proc remove*[T](dq: var RingDeque[T]; v: T) =
  ## Removes the first value it finds by scanning from head to the right.
  ## Raises ValueError if it does not exist
  var n = dq.data.find(v)
  if n.isNil: raise newException(ValueError,
      "value `" & "` not found in the deque.")
  else: dq.removeNode(n)

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

##! WARNING Index access middle of the deque is very slow, use with caution
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
