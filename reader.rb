require_relative 'loader.rb'

class DOMReader

  def initialize
    @string = load_file
    #@tree = DOMTree.new(@string)
    #@renderer = NodeRenderer.new(@tree)
    #@searcher = TreeSearcher.new(@tree)
  end

  def load_file
    loader = Loader.new("test.html")
  end

end

=begin

load 'reader.rb'
a = DOMReader.new

=end