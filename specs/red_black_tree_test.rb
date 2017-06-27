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
end

