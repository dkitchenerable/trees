class Queue
  def initialize
    @read = 0
    @write = 0
    @container = []
  end

  def empty?
    @read == @write
  end

  def enqueue(object)
    @container[@write] = object
    @write += 1
  end

  def dequeue
    object = @container[@read]
    @read += 1
    object
  end
end
