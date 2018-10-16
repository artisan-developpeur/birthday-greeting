require_relative 'services/file_reader'
require_relative 'services/date_parser'
require_relative 'services/employee_factory'
require_relative 'services/email_factory'
require_relative 'services/email_sender'
require 'date'

class App
  EMPLOYEES_LIST_FILENAME = "../employees.txt"
  EMPLOYEE_FILE_FIELDS = %i[first_name last_name birthdate email].freeze

  def initialize(email_sender:, email_factory:, employee_factory:)
    @email_sender = email_sender
    @email_factory = email_factory
    @employee_factory = employee_factory
  end

  def run
    employees_data = file_reader.read(EMPLOYEES_LIST_FILENAME)
    employees_data.each do |employee_data|
      begin
        employee = employee_factory.build_from(employee_data)
        next unless birthday_today?(employee)

        send_greeting_email_to(employee)
      rescue FileReader::DataError, EmployeeFactory::DataError => e
        puts e.message
        next
      end
    end
  end

  private

  attr_reader :email_sender, :email_factory, :employee_factory

  def birthday_today?(employee)
    employee.birthdate.yday == Date.today.yday
  end

  def send_greeting_email_to(employee)
    email = email_factory.build_greeting_email(employee)
    email_sender.send(email)
  end

  def file_reader
    FileReader.new(EMPLOYEE_FILE_FIELDS)
  end
end

date_parser      = DateParser.new
employee_factory = EmployeeFactory.new(date_parser)
email_factory    = EmailFactory.new
email_sender     = EmailSender.new

app = App.new(
  employee_factory: employee_factory,
  email_factory: email_factory,
  email_sender: email_sender
)
app.run
