pseudocode this bitch

Node = Struct.new(:tag, :children, :parent)
Tag = Struct.new(:type, :attributes, :nested)


class DOMReader
  #passes string to Tree to be parsed and stored
  #manages operations of other classes
end

#subject of Warmup2
class DOMTree
  #builds tree from string
  #should be able to output same HTML string from tree
    # find opening tag, create node with relevant info from tag
    # find closing tag matching opening tag
    #parse nested text until no more tags/nodes to be built
end

class NodeRenderer
  #passed tree upon instantiation
  #render(node) outputs info about nodes and subtree
    #How many total nodes there are in the sub-tree below this node
      #use treesearcher
    #A count of each node type in the sub-tree below this node
      #use treesearcher
    #All of the node's data attributes
  #rebuild html file from tree
end

class TreeSearcher
  #passed tree upon instantiation
  #traverse trees looking for particular characteristics (BFS)
  #search only descendants of a particular node (DFS)
    #bfs
  #search ancestors (search parents of given node)
    #dfs
  #method_missing
end

class Loader
  #loads file as stripped string
end