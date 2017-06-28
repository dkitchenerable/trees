require_relative 'red_black_node.rb'

# a red black tree implementation
# heavy influence from c implementation on https://en.wikipedia.org/wiki/Red-black_tree
# RB PROPERTIES
class RedBlackTree
  attr_accessor :root

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
    @root = insert_recursive(@root, key, value)
  end

  private

  def insert_recursive(node, key, value, parent=nil)
    # new node
    if (node == nil)
      new_node = RedBlackNode.new(key, value, true)
      new_node.parent = parent
      rebalance(new_node)
      return new_node
    # recursive cases
    elsif (key > node.key)
      node.right = insert_recursive(node.right, key, value, node)
    elsif (key < node.key)
      node.left = insert_recursive(node.left, key, value, node)
    else # keys match, so simply change value
      node.value = value
    end
    return node
  end

  # cases for rebalancing
  # case 1 - node is the root
  # case 2 - parent is black
  # case 3 - parent and uncle red
  # case 4 - node is right of left child of grandparent OR
  #          node is left of right child of grandparent
  # case 5 - node is right of right child of grandparent OR
  #          node is left of left child of grandparent
  def rebalance(node)
    # case 1
    if node.parent == nil
      # root is always black based on RB properties
      node.mark_black
    elsif node.parent.is_black? # case 2
      return
    elsif uncle(node) && uncle(node).is_red? # case 3
      node.parent.mark_black
      uncle(node).mark_black
      grandparent = grandparent(node)
      grandparent.mark_red
      rebalance(grandparent)
    else #check case 4 and 5
      g = grandparent(node)
      if g.left.right == node || g.right.left == node
        return
      else
        return
      end
      end
    end
  end

  def self.rotate_right
  end

  def self.rotate_left
  end

  def grandparent(node)
    return nil if node.nil?
    return nil if node.parent.nil?
    return node.parent.parent
  end

  def uncle(node)
    g = grandparent(node)
    return nil if g.nil?
    return node.parent == g.left ? g.right : g.left
  end
end
