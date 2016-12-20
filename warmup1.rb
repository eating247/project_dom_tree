TagNode = Struct.new(:type, :attributes, :nested)

def parse_tag(string)
  type = string.scan(/^<(\w+).*>$/)
  attributes = string.scan(/^<\s*\w+\s+(\w+\s*[=]\s*".*")\s*>$/)
  parsed = Tag.new(type, attributes, classes, id, name)
end

def parser_script(string)
  type = string.scan(/^\s*?<(\w+).*?>.*?<(\/\w+)>$/)
  attributes = string.scan(/^<\s*\w+\s+(\w+\s*[=]\s*".*")\s*>$/)
  nested = string.scan(/^.*?<.*?>(.*)<\/.*?>$/)
  parsed = TagNode.new(type, attributes, nested)
end

=begin


%Q(<div class="top-div">)

parse_tag(%Q(<div class="top-div">))



html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

parser_script(html_string)


=end