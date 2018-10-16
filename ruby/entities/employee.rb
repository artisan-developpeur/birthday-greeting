class Employee < Struct.new(:email, :first_name, :last_name, :birthdate)
  def initialize(email:, first_name:, last_name:, birthdate:)
    super(email, first_name, last_name, birthdate)
  end

  def full_name
    [first_name, last_name].reject(&:empty?).join(' ')
  end
end
