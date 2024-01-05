defmodule ElixirGreating do
  def main do
    file_name = "../employees.txt"

    try do
      if File.exists?(file_name) do
        {:ok, content} = File.read(file_name)
        lines = String.split(content, "\n")

        IO.puts("Reading file...")
        fl = true

        Enum.each(lines, fn line ->
          if fl do
            fl = false
          else
            t = String.split(line, ",")
            t = Enum.map(t, &String.trim/1)

            if Enum.count(t) == 4 do
              d = String.split(Enum.at(t, 2), "/")
              if Enum.count(d) == 3 do
                n = Date.utc_today()
                if n.day == String.to_integer(Enum.at(d, 0)) && n.month == String.to_integer(Enum.at(d, 1)) do
                  send_email(
                    Enum.at(t, 3),
                    "Joyeux Anniversaire !",
                    "Bonjour " <> Enum.at(t, 0) <> ",\nJoyeux Anniversaire !\nA bientôt,"
                  )
                end
              else
                IO.puts("Cannot read birthdate for " <> Enum.at(t, 0) <> " " <> Enum.at(t, 1))
              end
            else
              IO.puts("Invalid file format")
            end
          end
        end)

        IO.puts("Batch job done.")
      else
        IO.puts("Unable to open file '" <> file_name <> "'")
      end
    rescue
      exception -> IO.puts("Error reading file '" <> file_name <> "'")
    end
  end

  defp send_email(to, title, body) do
    IO.puts("Sending email to : " <> to)
    IO.puts("Title: " <> title)
    IO.puts("Body: Body\n" <> body)
    IO.puts("-------------------------")
  end
end

ElixirGreating.main()
