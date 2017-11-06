class BitmapEditor

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      prase_line(line.chomp)
    end
  end

  private

  attr_accessor :image, :rows, :columns

  def prase_line(line)
    case line
    when /^I/
      create_image(line)
    when 'S'
      print_image
    else
      puts 'unrecognised command :('
    end
  end

  def create_image(line)
    _command, columns, rows = line.split(' ')
    self.columns = columns.to_i
    self.rows = rows.to_i
    # intialise to all white
    self.image = Array.new(columns.to_i) { Array.new(rows.to_i, 'O') }
  end

  def print_image
    return puts 'There is no image' unless image

    output = ''
    rows.times do |y|
      columns.times do |x|
        output << image[x][y]
      end
      output << "\n"
    end
    puts output
  end
end
