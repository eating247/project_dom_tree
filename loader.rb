class Loader

  def load(path)
    processed = []
    File.readlines(path).each do |line|
      processed << line.strip
    end
    processed.join
  end

end