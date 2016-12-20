require 'pry'

Node = Struct.new(:children, :parent)
Tag = Struct.new(:function, :type, :attributes)

class DOMTree

  attr_accessor :root, :string, :stack

  def initialize(string)
    @string = string
    build_tree
  end

  def outputter(node=@root)
    node.children.each do |child|
      if child.class == Node
        outputter(child)
      else
        print_child_node(child)
      end
    end
    return
  end

  def print_child_node(child)
    if child.function == :open
      puts "<#{child.type}>"
    elsif child.function == :content
      puts "#{child.attributes[:text]}"
    elsif child.function == :close
      puts "<#{child.type}>"
    end
  end


  def build_tree
    add_root(@string)
    @stack = [@root]
    add_nodes(@stack)
  end

  def add_nodes(stack)
    node = stack.pop
    loop do
      tag = find_tag(@string)
      if tag.function == :open
        child_node = Node.new([tag], node)
        node.children << child_node
        @stack << child_node
        add_nodes(@stack)    
      elsif tag.function == :content
        node.children << tag
      elsif tag.function == :close
        node.children << tag
        break
      end
    end
  end

  def add_root(string)
    tag = find_tag(string)
    @root = Node.new([tag], nil)
  end

  def find_tag(string)
    tag = nil
    if segment = opening_tag?(string)
      tag = Tag.new(:open, nil, nil)
      parse_tag(tag, segment)
    elsif segment = closing_tag?(string)
      tag = Tag.new(:close, nil, nil)
      parse_tag(tag, segment)
    elsif segment = text_tag?(string)
      tag = Tag.new(:content, nil, {text: segment})
    end
    return tag
  end

  def opening_tag?(string)
    return false unless captures = string.match(/^(<\w+.*?>)/)
    @string = captures.post_match
    return captures.to_s
  end

  def closing_tag?(string)
    return false unless captures = string.match(/^(<\/\w+>)/)
    @string = captures.post_match
    return captures.to_s
  end

  def text_tag?(string)
    return false unless captures = string.match(/^([^<]+)/)
    @string = captures.post_match
    return captures.to_s
  end

  def parse_tag(tag, segment)
    case tag.function
    when :open
      tag.type = segment.match(/^<(\w+)(.*)>$/).captures.first
      attributes = segment.match(/^<(\w+)(.*)>$/).captures[1]
      tag.attributes = process_attribute_hash(attributes)
    when :close
      tag.type = segment.match(/^<(\/\w+).*>$/).captures.first
      tag.attributes = nil
    end
    tag
  end

  def process_attribute_hash(segment)
    attributes = segment.scan(/\s(.*?)\s*=\s*['|"](.*?)['|"]/)
    Hash[ attributes.to_h.map { |k,v| [k, v.split(" ")] } ]
  end

end

=begin
load 'warmup2.rb'
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

a = DOMTree.new(html_string)

=end