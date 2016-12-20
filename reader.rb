require_relative 'loader.rb'
require_relative 'tree.rb'

class DOMReader
  attr_accessor :string

  def initialize
    @string = load_file
    #@tree = build_tree
    #@renderer = NodeRenderer.new(@tree)
    #@searcher = TreeSearcher.new(@tree)
  end

  def load_file(path="test.html")
    loader = Loader.new
    loader.load(path)
  end

  def build_tree
    DOMTree.new(@string)
  end

end

=begin

load 'reader.rb'
a = DOMReader.new

=end