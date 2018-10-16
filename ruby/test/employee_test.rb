require 'minitest/autorun'
require_relative '../entities/employee.rb'
class EmployeeTest < Minitest::Test

  def test_can_be_created_with_minimal_required_attributes
    assert_raises ArgumentError do
      Employee.new(email: 'jet.julien@gmail.com', first_name: 'Julien', birthdate: '02/08/1990')
    end
  end

  def test_cannot_be_created_without_email
    assert_raises ArgumentError do
      Employee.new(first_name: 'Julien', birthdate: '02/08/1990')
    end
  end

  def test_cannot_be_created_without_first_name
    assert_raises ArgumentError do
      Employee.new(email: 'jet.julien@gmail.com', birthdate: '02/08/1990')
    end
  end

  def test_cannot_be_created_without_birthdate
    assert_raises ArgumentError do
      Employee.new(email: 'jet.julien@gmail.com', first_name: 'Julien')
    end
  end

  def setup
    @employee = Employee.new(email: 'jet.julien@gmail.com', first_name: 'Julien', last_name: 'Jet', birthdate: '02/08/1990')
  end

  def test_attributes
    assert_equal @employee.email, 'jet.julien@gmail.com'
    assert_equal @employee.first_name, 'Julien'
    assert_equal @employee.last_name, 'Jet'
    assert_equal @employee.birthdate, '02/08/1990'
  end

  def test_full_name
    assert_equal @employee.full_name, 'Julien Jet'
  end
end
