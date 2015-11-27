defmodule Resume.CLI.Application do
  alias Resume.CLI.ArgumentParser
  alias Resume.CLI.ResumeDataFetcher

  def start(argv) do
    try do
      body = ArgumentParser.parse(argv)
      |> ResumeDataFetcher.fetch
      IO.puts Base.decode64!(body[:title])
    catch
      { :halt, num } -> System.halt(num)
    end
  end
end
