require 'pry'

class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(attribute, value)
    matches = []
    queue = [@tree.root]
    until queue.empty?
      curr_node = queue[0]
      tag = curr_node.children.first
      if match?(tag, attribute, value)
        matches << curr_node
      end
      children = curr_node.children.select {|child| child.class == Node}
      queue += children
      queue.shift
    end
    #returns nodes matching value for specified attribute
    matches
  end

  def match?(tag, attribute, value)
    return false if tag.attributes[attribute].nil?
    tag.attributes[attribute].include?(value)
  end

  def search_descendants(node, attribute, value)
    matches = []
    queue = [node]
    until queue.empty?
      curr_node = queue[0]
      tag = curr_node.children.first
      if match?(tag, attribute, value)
        matches << curr_node
      end
      children = curr_node.children.select {|child| child.class == Node}
      queue += children
      queue.shift
    end
    #returns nodes matching value for specified attribute
    matches
  end

  def search_ancestors(node, attribute, value)
    matches = []
    queue = [node]
    loop do
      curr_node = queue[0].parent
      break if curr_node.nil?
      tag = curr_node.children.first
      if match?(tag, attribute, value)
        matches << curr_node
      end
      queue << curr_node
      queue.shift
    end
    matches
  end

end


=begin

load 'searcher.rb'
b = TreeSearcher.new(a.tree)
b.search_by("class", "super-header")
node = b.search_by("class", "super-header").first
b.search_descendants(node, "class", "emphasized")
node = b.search_descendants(node, "class", "emphasized").first
b.search_ancestors(node, "class", "super-header").size


=end