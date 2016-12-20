Node = Struct.new(:children, :parent)
Tag = Struct.new(:function, :type, :attributes)

class DOMTree

  attr_accessor :root, :string

  def initialize(string)
    @string = string
    build_tree
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

  def outputter(node=@root)
    node.children.each do |child|
      if child.class == Node
        outputter(child)
      else
        print_tag(child)
      end
    end
    return
  end

  def print_tag(child)
    if child.function == :open
      puts "<#{child.type}>"
    elsif child.function == :content
      puts "#{child.attributes[:text]}"
    elsif child.function == :close
      puts "<#{child.type}>"
    end
  end

end



=begin
load 'tree.rb'
a = DOMTree.new(string)





string=
  "<html><head><title>This is a test page</title></head><body><div class=\"top-div\">I'm an outer div!!!<div class=\"inner-div\">I'm an inner div!!! I might just <em>emphasize</em> some text.</div>I am EVEN MORE TEXT for the SAME div!!!</div><main id=\"main-area\"><header class=\"super-header\"><h1 class=\"emphasized\">Welcome to the test doc!</h1><h2>This document contains data</h2></header><ul>Here is the data:<li>Four list items</li><li class=\"bold funky important\">One unordered list</li><li>One h1</li><li>One h2</li><li>One header</li><li>One main</li><li>One body</li><li>One html</li><li>One title</li><li>One head</li><li>One doctype</li><li>Two divs</li><li>And infinite fun!</li></ul></main></body></html>"


=end