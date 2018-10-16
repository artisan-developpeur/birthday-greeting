class DateParser
  FormatError = Class.new(StandardError)

  def parse(raw_date)
    raise FormatError.new unless raw_date.split('/').size == 3
    Date.parse(raw_date)
  end
end
