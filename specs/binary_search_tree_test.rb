require_relative '../binary_search_tree.rb'

describe BinarySearchTree do
  before(:each) do
    @tree = BinarySearchTree.new
    @tree.put(2, "bar")
    @tree.put(1, "foo")
    @tree.put(3, "foo-bar")
  end

  context "#delete" do
    it "an empty tree remains unchanged" do
      tree = BinarySearchTree.new
      tree.delete(1)
      expect(tree.root).to be_nil
    end

    it "no match leaves tree unchanged" do
      tree = BinarySearchTree.new
      tree.put(2, "root")
      tree.delete(1)
      expect(tree.root.key).to eq(2)
      expect(tree.root.value).to eq("root")
    end

    it "a match with no child" do
      tree = BinarySearchTree.new
      tree.put(2, "root")
      tree.delete(2)
      expect(tree.root).to be_nil
    end

    it "a match with one left child" do
      tree = BinarySearchTree.new
      tree.put(2, "root")
      tree.put(1, "left-child")
      tree.delete(2)
      expect(tree.root.key).to eq(1)
      expect(tree.root.value).to eq("left-child")
      expect(tree.root.left).to be_nil
      expect(tree.root.right).to be_nil
    end

    it "a match with one right child" do
      tree = BinarySearchTree.new
      tree.put(2, "root")
      tree.put(3, "right-child")
      tree.delete(2)
      expect(tree.root.key).to eq(3)
      expect(tree.root.value).to eq("right-child")
      expect(tree.root.left).to be_nil
      expect(tree.root.right).to be_nil
    end

    it "a match with two children" do
      @tree.delete(2)
      expect(@tree.root.key).to eq(3)
      expect(@tree.root.left.key).to eq(1)
    end

    it "a match with two children and height greater than 2" do
      tree = BinarySearchTree.new
      tree.put(4, "n1")
      tree.put(1, "n2")
      tree.put(2, "n3")
      tree.put(3, "n4")
      tree.put(6, "n6")
      tree.put(5, "n5")
      tree.put(7, "n7")
      tree.delete(4)
      expect(tree.root.key).to eq(5)
      expect(tree.root.left.key).to eq(1)
    end
  end

  context "#put" do
    it "place at root for empty tree" do
      tree = BinarySearchTree.new
      expect(tree.root).to be_nil
      tree.put(1,"new")
      expect(tree.root.key).to eq(1)
      expect(tree.root.value).to eq("new")
    end

    it "place in correct order of non-empty tree" do
      tree = BinarySearchTree.new
      tree.put(2,"root")
      expect(tree.root.key).to eq(2)
      expect(tree.root.value).to eq("root")
      tree.put(1,"new")
      # root stays the same
      expect(tree.root.key).to eq(2)
      expect(tree.root.value).to eq("root")
      # smaller key placed to left of root
      expect(tree.root.left.key).to eq(1)
      expect(tree.root.left.value).to eq("new")
    end
  end
  
  context "#get" do
    it "should return nil for empty tree" do
      expect(BinarySearchTree.new.get(4)).to eq(nil)
    end

    it "should return nil for no match" do
      expect(@tree.get(4)).to eq(nil)
    end

    it "should return value match" do
      expect(@tree.get(1)).to eq("foo")
    end

    it "should return value match" do
      expect(@tree.get(2)).to eq("bar")
    end

    it "should return value match" do
      expect(@tree.get(3)).to eq("foo-bar")
    end
  end
end
