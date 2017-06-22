require_relative 'tree_node.rb'
require_relative 'queue.rb'

PRINT_ORDERS = ["PRE", "POST", "IN"]

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end
  
  def delete(key)
    @root = del_recursive(root, key)
  end

  def get(key)
    node = @root
    while node
      return node.value if node.key == key
      if key < node.key
        node = node.left
      else
        node = node.right
      end
    end
    return nil
  end

  def put(key, value)
    node = @root
    @root = put_recursive(node, key, value)
  end

  def print(order="IN")
    raise "order must be in order #{PRINT_ORDERS.split(',')}" unless PRINT_ORDERS.include?(order)
    queue = Queue.new
    enqueue_nodes(@root, queue, order)
    print_queue(queue)
  end

  private

  def enqueue_nodes(node, queue, order)
    return if node == nil
    queue.enqueue(node) if order == "PRE"
    enqueue_nodes(node.left, queue, order)
    queue.enqueue(node) if order == "IN"
    enqueue_nodes(node.right, queue, order)
    queue.enqueue(node) if order == "POST"
  end

  def print_queue(queue)
    while !queue.empty?
      p queue.dequeue.key
    end
  end

  def put_recursive(node, key, value)
    if node == nil
      return TreeNode.new(key, value)
    end
    if key < node.key
      node.left = put_recursive(node.left, key, value)
    elsif key > node.key
      node.right = put_recursive(node.right, key, value)
    else
      node.value = value
    end
    return node
  end

  def del_recursive(node, key)
    # no match
    return nil if node.nil?
    # recursive cases
    if key < node.key
      node.left = del_recursive(node.left, key)
    elsif key > node.key
      node.right = del_recursive(node.right, key)
    else # match
      # no children
      if node.left.nil? && node.right.nil?
        return nil
      # one child
      elsif node.left && node.right.nil?
        return node.left
      elsif node.right && node.left.nil?
        return node.right
      else # two children
        # basic premise:
        # find the minimum on the right tree, set to node
        # set right tree to the right tree minus the minimum
        copy = node.dup
        min = find_min(copy.right)
        node = min
        node.right = del_min(copy.right)
        node.left = copy.left
      end
    end
    return node
  end

  # return min given node
  def find_min(node)
    return node if node.left.nil?
    find_min(node.left)
  end

  # return tree with node deleted
  def del_min(node)
    return node.right if node.left.nil?
    node.left = deleteMin(node.left)
    return node
  end
end
