Tag = Struct.new(:type, :attributes, :classes, :id, :name)

def parse_tag(string)

  type = string.scan(/^<(\w+).*>$/)
  attributes = string.scan(/^<\w+(.*[=]".*")>$/)
  classes = string.scan(/^<.*[class][=]"(.*)">$/)
  id = string.scan(/^<.*[id][=](".*")>$/)
  name = string.scan(/^<.*[name][=](".*")>$/)
  parsed = Tag.new(type, attributes, classes, id, name)

end

=begin


parse_tag(%Q(<div class="top-div">))

%Q(<div class="top-div">)
=end