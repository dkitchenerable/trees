require_relative 'red_black_node.rb'

# a red black tree implementation
# heavy influence from c implementation on https://en.wikipedia.org/wiki/Red-black_tree
# RB PROPERTIES
# 1. node is either red or black
# 2. root is black
# 3. all leaves are black
# 4. all red children are black
# 5. every path from a given node to leave, contains the 
# same number of black nodes
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

  # simple std out print function with colors
  def print(order="IN")
    print_recursive(@root, order)
  end

  private

  def print_recursive(node, order)
    return if node == nil
    p "key:#{node.key} color:#{node.color} parent key:#{node.parent ? node.parent.key : node.parent}" if order == "PRE"
    print_recursive(node.left, order)
    p "key:#{node.key} color:#{node.color} parent key:#{node.parent ? node.parent.key : node.parent}" if order == "IN"
    print_recursive(node.right, order)
    p "key:#{node.key} color:#{node.color} parent key:#{node.parent ? node.parent.key : node.parent}" if order == "POST"
  end

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
      rebalance_case_3(node)
    else #check case 4
      g = grandparent(node)
      if node == node.parent.right && node.parent == g.left
        p "gots to be in here"
        rotate_left(node.parent)
        n = n.left
      elsif node == node.parent.left && node.parent == g.right
        rotate_right(node.parent)
        n = n.right
      end
      rebalance_case_5(node)
    end
  end

  def rebalance_case_3(node)
    node.parent.mark_black
    uncle(node).mark_black
    grandparent = grandparent(node)
    grandparent.mark_red
    rebalance(grandparent)
  end

  def rebalance_case_5(node)
    g = grandparent(node)
    node.parent.mark_black
    g.mark_red
    if (node == node.parent.left)
      rotate_right(g)
    else
      rotate_left(g)
    end
  end

  def rotate_right(node)
    g = grandparent(node)
    saved_parent = g.right
    saved_right = node.right
    g.right = node
    node.right = saved_parent
    saved_parent.left = saved_right
  end

  def rotate_left(node)
    g = grandparent(node)
    saved_parent = g.left
    saved_left = n.left
    g.left = node
    node.left = saved_p
    saved_p.right = saved_left
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
