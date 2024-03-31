class Queue<T>{
  private var elements = [T]()

  var isEmpty: Bool{
    return elements.isEmpty
  }

  var count: Int{ // Counting the size
    return elements.count
  }

  func enqueue(_ element: T){
    elements.append(element)
  }

  func dequeue() -> T?{
    guard !isEmpty else { return nil }
    return elements.removeFirst()
  }

  func peek() -> T?{
    return elements.first
  }
}