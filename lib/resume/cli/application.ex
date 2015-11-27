defmodule Resume.CLI.Application do
  alias Resume.CLI.ArgumentParser
  alias Resume.CLI.ResumeDataFetcher

  def start(argv) do
    try do
      ArgumentParser.parse(argv)
      |> ResumeDataFetcher.fetch
    catch
      :halt ->
        System.halt(0)
    end
  end
end
