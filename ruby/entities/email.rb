class Email < Struct.new(:mail_to, :title, :body, :header, :footer)

  def initialize(mail_to:, title:, body:, header:, footer:)
    super(mail_to, title, body, header, footer)
  end

  def print
    [header, title, body, footer].each{ |section| puts section }
    true
  end
end
