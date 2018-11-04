require_relative '../entities/email'

class EmailFactory
  def build_greeting_email(employee)
    title = "Joyeux Anniversaire !"
    body = "Bonjour #{employee.first_name},\nJoyeux Anniversaire !\nA bientôt,"
    build_email(title: title, mail_to: employee.email, body: body)
  end

  private

  def build_email(title:, body:, mail_to:, header: nil, footer: nil)
    header ||= "Sending email to #{mail_to}"
    title = "Title: #{title}"
    body = "Body:\n#{body}"
    footer ||= "--------------"
    Email.new(header: header, mail_to: mail_to, title: title, body: body, footer: footer)
  end
end
