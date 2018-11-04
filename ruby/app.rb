require 'date'
class App
  FILENAME = "../employees.txt"

  def run
    File.open(FILENAME) do |file|
      puts 'Reading file...'
      first_line = true
      file.each_line.with_index do |line, i|
        begin
          if first_line
            first_line = false
            next
          end
          columns = line.split(',')
          raise "Invalid data format at line #{i}" unless columns.size == 4
          first_name = columns[0].strip
          last_name = columns[1].strip
          names = [first_name, last_name].join(' ')
          date = columns[2].strip
          email_adress = columns[3].strip
          raise "Cannot read birthdate for #{names}" unless date.split('/').size == 3
          date = Date.parse(date)
          next unless date.yday == Date.today.yday # Comment this line to test output
          title = "Joyeux Anniversaire !"
          body = "Bonjour #{first_name},\nJoyeux Anniversaire !\nA bientôt,"
          send_email(email_adress, title, body)
        rescue => e
          puts e
          next
        end
      end
    end
  end

  def send_email(email_adress, title, body)
    puts "Sending email to #{email_adress}"
    puts "Title: #{title}"
    puts "Body:\n#{body}"
    puts "--------------"
  end
end

App.new.run
