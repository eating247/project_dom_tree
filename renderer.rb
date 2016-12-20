require 'pry'

class NodeRenderer

  def initialize(tree)
    @tree = tree
  end

  def render(node=@tree.root)
    # render subtree node count 
    find_subtree(node)
    @descendants.size
    print_subtree_count
    # render subtree node types
    find_subtree_types
    print_subtree_types
    print_subtree_count
    # render node's attributes
    render_attributes(node)
  end

  def find_subtree(node)
    @descendants = []
    queue = [node]
    until queue.empty?
      node = queue.shift
      children = node.children.select {|child| child.class == Node}
      queue += children
      @descendants += children
    end
    @descendants
  end

  def print_subtree_count
    puts "SUBTREE COUNT: #{@descendants.size}"
    puts
  end

  def find_subtree_types
    @descendant_types = {}
    @descendants.each do |node|
      tag = node.children.first
      @descendant_types[tag.type] ||= 0
      @descendant_types[tag.type] += 1
    end
  end

  def print_subtree_types
    puts "SUBTREE NODE TYPES:"
    @descendant_types.each do |type, count|
      puts "#{type} : #{count}"
    end
    puts
  end

  def render_attributes(node)
    puts "NODE ATTRIBUTES"
    attributes = node.children.first.attributes
    attributes.each do |attribute, value|
      puts "#{attribute} : #{value.join(' ')}"
    end
    return
  end

  #how many total nodes there are in the sub tree below this node
    # go through children, count nodes

end

=begin

load 'renderer.rb'
a = NodeRenderer.new(tree)

=end