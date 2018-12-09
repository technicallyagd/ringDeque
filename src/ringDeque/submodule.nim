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

proc rotate*[T](dq: var RingDeque[T]; r: int) =
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
