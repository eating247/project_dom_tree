require_relative 'loader'
require_relative 'tree'
require_relative 'renderer'
require_relative 'searcher'

class DOMReader
  attr_accessor :string, :tree, :searcher

  def initialize
    @string = load_file
    @tree = DOMTree.new(@string)
    @renderer = NodeRenderer.new(@tree)
    @searcher = TreeSearcher.new(@tree)
  end

  def load_file(path="test.html")
    loader = Loader.new
    loader.load(path)
  end

  def render
    renderer.render(@tree.root)
  end

  def rebuild
    @tree.outputter
  end

end

=begin

load 'reader.rb'
a = DOMReader.new

=end