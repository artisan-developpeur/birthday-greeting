require 'pry'
require 'minitest/autorun'
require_relative '../services/email_factory.rb'
require_relative '../entities/employee.rb'

class EmailFactoryTest < Minitest::Test
  def setup
    @factory = EmailFactory.new
    @employee = Employee.new(email: 'jet.julien@gmail.com', first_name: 'Julien', last_name: 'Jet', birthdate: '02/08/1990')
  end

  def test_build_greeting_email
    email = @factory.build_greeting_email(@employee)
    assert_equal email.header, "Sending email to #{@employee.email}"
    assert_equal email.title, "Title: Joyeux Anniversaire !"
    assert_equal email.body, "Body:\nBonjour #{@employee.first_name},\nJoyeux Anniversaire !\nA bientôt,"
    assert_equal email.footer, "--------------"
  end
end
