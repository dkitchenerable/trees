require_relative '../red_black_tree.rb'
require_relative '../red_black_node.rb'

describe RedBlackTree do
  before(:each) do
    @tree = RedBlackTree.new
  end

  describe "#search" do
    context "empty tree" do
      it "should return nil" do
        expect(@tree.search(1)).to be_nil
      end
    end

    context "non-empty tree" do
      it "should return node value on match" do
      end

      it "should return nil for match" do
      end
    end
  end

  describe "#insert" do
    context "case 1: node is at root" do
      it "should set as root" do
        @tree.insert(1, "foo")
        expect(@tree.root.key).to eq(1)
        expect(@tree.root.value).to eq("foo")
      end

      it "parent is nil" do
        @tree.insert(1, "foo")
        expect(@tree.root.parent).to be_nil
      end
  
      it "root should be black" do
        @tree.insert(1, "foo")
        expect(@tree.root.is_black?).to eq(true)
      end
    end

    context "case 2: parent is black" do
      it "should place in correct order" do
        @tree.insert(2, "foo")
        @tree.insert(1, "bar")
        expect(@tree.root.left.key).to eq(1)
        expect(@tree.root.left.value).to eq("bar")
      end

      it "new node is red" do
        @tree.insert(2, "foo")
        @tree.insert(1, "bar")
        expect(@tree.root.left.is_red?).to eq(true)
      end
    end

    context "case 3: parent and uncle are red" do
      before(:each) do
        @tree.insert(2, "root")
        @tree.insert(1, "left")
        @tree.insert(3, "right")
        expect(@tree.root.left.value).to eq("left")
        expect(@tree.root.right.value).to eq("right")
      end

      it "new node is in proper spot and colored red" do
        @tree.insert(0, "new")
        expect(@tree.root.left.left.value).to eq("new")
        expect(@tree.root.left.left.is_red?).to eq(true)
      end

      it "new node's parent and uncle is black" do
        @tree.insert(0, "new")
        new_node = @tree.root.left.left
        expect(new_node.parent.is_black?).to eq(true)
        expect(new_node.parent.parent.right.is_black?).to eq(true)
      end
    end

    context "case 4: node is right of grandparent left child" do
      before(:each) do
        @tree.insert(4, "root")
        @tree.insert(1, "left child")
        @tree.insert(5, "right child")
        @tree.insert(-1, "left child left")
        @tree.insert(2, "left child right")
        expect(@tree.root.left.value).to eq("left child")
        expect(@tree.root.right.value).to eq("right child")
      end

      it "new node is in proper spot" do
        @tree.insert(0, "new")
        @tree.print
      end

    end
  end
end
