defmodule Resume.CLI.Application do
  alias Resume.CLI.ArgumentParser
  alias Resume.CLI.ResumeDataFetcher

  def start(argv) do
    try do
      body = ArgumentParser.parse(argv)
      |> ResumeDataFetcher.fetch
      # TODO: Equivalent of JSON.recurse_proc for the returned `body`
      # TODO: Find out if there is a way to ensure that Ruby and Prawn are
      # installed on the system.
      IO.puts Base.decode64!(body[:title])
    catch
      { :halt, num } -> System.halt(num)
    end
  end
end
