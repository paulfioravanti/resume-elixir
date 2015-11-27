defmodule Resume.CLI.Application do
  def start(argv) do
    try do
      locale = Resume.CLI.ArgumentParser.parse(argv)
      IO.puts("Locale is: #{locale}")
    catch
      :halt ->
        System.halt(0)
    end
  end
end
