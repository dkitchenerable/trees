class RedBlackNode
  attr_accessor :parent, :left, :right, :key, :value

  def initialize(k, v=nil, red=true)
    @key = k
    @value = v
    @parent = nil
    @left = nil
    @right = nil
    @red = red
  end

  def is_red?
    @red
  end

  def is_black?
    !@red
  end

  def set_black
    @red = false
  end

  def set_red
    @red = true
  end

end
