class FileReader
  DataError = Class.new(StandardError)

  def initialize(file_fields)
    @file_fields = file_fields
  end

  def read(filename)
    File.open(filename) do |file|
      puts 'Reading file...'
      read_lines(file)
    end
  end

  private

  attr_reader :file_fields

  def read_lines(file)
    data = []
    file.each_line.with_index do |line, i|
      header = i.zero?
      next if header

      data << read_line(line, i)
    end
    data
  end

  def read_line(line, line_index)
    columns = line.split(',').map(&:strip)
    raise DataError.new("Invalid data format at line #{line_index}") unless columns.size == 4

    data = Hash[file_fields.map.with_index{ |field, i| [field, columns[i]] }]
    data
  rescue DataError => e
    { error: e }
  end
end
