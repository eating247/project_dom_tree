class Loader

  def initialize(path)
    load(path)
  end

  def load(path)
    processed = []
    File.readlines(path).each do |line|
      processed << line.strip
    end
    processed.join
  end

end