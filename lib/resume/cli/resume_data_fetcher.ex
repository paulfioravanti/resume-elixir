defmodule Resume.CLI.ResumeDataFetcher do
  require Logger
  require Poison

  @user_agent [ {"User-agent", "Elixir paulfioravanti"} ]
  @remote_repo "https://raw.githubusercontent.com/paulfioravanti/resume/master/"

  def fetch(locale) do
    body = HTTPoison.get(
      "#{@remote_repo}/resources/resume.#{locale}.json", @user_agent
    )
    |> handle_response
    |> decode_response
    # |> Dict.take(["title"])
    IO.puts Base.decode64!(body[:title])
  end

  defp handle_response({ :ok, %{ status_code: 200, body: body } }) do
    Logger.info "Successful response"
    # Logger.debug fn -> inspect(body) end
    # { :ok, Poison.decode!(body) }
    { :ok, Poison.Parser.parse!(body, keys: :atoms) }
  end
  defp handle_response({ :error, %{ status_code: status, body: body } }) do
    Logger.error "Error #{status} returned"
    { :error, Poison.decode!(body) }
  end

  defp decode_response({ :ok, body }), do: body
  defp decode_response({ :error, error }) do
    { _key, message } = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end
end
