require_relative 'red_black_node.rb'

# a red black tree implementation
# heavy influence from c implementation on https://en.wikipedia.org/wiki/Red-black_tree
# RB PROPERTIES
class RedBlackTree
  def initialize
    @root = nil
  end

  def search(key)
    node = @root
    while node != nil
      return node.value if node.key == key
      node = key < node.key ? node.left : node.right
    end
    return nil
  end

  def delete(key, value)
  end

  def insert(key, value)
    node = @root
    insert_recursive(node, key, value)
  end

  private

  def insert_recursive(node, key, value)
    # new node 
    if (node == nil)
      new_node = RedBlackNode.new(key, value, true)
      rebalance(node)
    # recursive cases
    elsif (key > node.key)
      insert_recursive(node.right, key, value)
    elsif (key < node.key)
      insert_recursive(node.left, key, value)
    else # keys match, so simply change value
      node.value = value
    end
  end

  # cases for rebalancing
  # case 1 - node is the root
  # case 2 - parent is black
  # case 3 - parent and uncle red
  def self.rebalance(node)
    # case 1
    if node.parent == nil
      # root is always black based on RB properties
      node.set_black
    elsif node.parent.is_black? # case 2
      return
    elsif node.parent.is_red? && node.uncle.try(:is_red) # case 3
    else
    end
        
        
  end

  def self.rotate_right
  end

  def self.rotate_left
  end

  def self.grandparent(node)
  end

  def self.uncle(node)
  end
end
