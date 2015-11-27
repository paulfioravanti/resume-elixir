defmodule Resume.CLI.ResumeDataFetcher do
  require Poison

  @user_agent [ {"User-agent", "Elixir paulfioravanti"} ]
  @remote_repo "https://raw.githubusercontent.com/paulfioravanti/resume/master/"

  def fetch(locale) do
    HTTPoison.get(
      "#{@remote_repo}/resources/resume.#{locale}.json", @user_agent
    )
    |> handle_response
  end

  defp handle_response({ :ok, %{ status_code: 200, body: body } }) do
    Poison.Parser.parse!(body, keys: :atoms)
  end
  defp handle_response({ :error, %{ status_code: _status, body: body } }) do
    IO.puts IO.ANSI.format([:red, Poison.decode!(body)], true)
    throw { :halt, 2 }
  end
end
