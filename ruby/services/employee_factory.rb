require_relative '../entities/employee'

class EmployeeFactory
  DataError = Class.new(StandardError)

  def initialize(date_parser)
    @date_parser = date_parser
  end

  def build_from(data)
    employee_data = format_data data
    Employee.new(employee_data)
  end

  private

  attr_reader :date_parser

  def format_data(data)
    verify_employee_data(data)
    data = data.dup
    data[:birthdate] = parse_birthdate(data[:birthdate])
    data
  rescue DateParser::FormatError
    full_name = [data[:first_name], data[:last_name]].join(' ')
    raise DataError.new("Cannot read birthdate for #{full_name}")
  end

  def parse_birthdate(raw_date)
    date_parser.parse(raw_date)
  end

  def build_employee(data)
    Employee.new(data)
  end

  def verify_employee_data(data)
    return data unless (error = data[:error])

    raise error
  end
end
