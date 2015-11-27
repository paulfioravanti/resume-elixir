defmodule Resume.CLI.ArgumentParser do
  @version "0.1"
  @available_locales ["en", "it", "ja"]

  def parse(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(argv) do
    parse = OptionParser.parse(
      argv,
      switches: [help: :boolean, version: :boolean, locale: :string],
      aliases: [h: :help, v: :version, l: :locale]
    )

    case parse do
      { [help: true], _argv, _options } ->
        :help
      { [version: true], _argv, _options } ->
        :version
      { [locale: locale], _argv, _options }
        when locale in @available_locales ->
          { :locale, locale }
      { [], [], [] } -> # no options passed
        { :locale, "en" }
      { [locale: locale], _argv, _options } ->
        { :error, "Locale #{locale} is not supported" }
      { _parsed, _argv, [{ flag, nil }]  }
        when flag in ["-l", "--locale"] ->
          { :error, "You're missing the locale argument" }
      { _parsed, _argv, [{ flag, nil }]  } ->
        { :error, "Invalid Option: #{flag}" }
      _anything_else ->
        :help
    end
  end

  defp process({ :locale, locale }), do: locale
  defp process(:version) do
    IO.puts @version
    throw { :halt, 0 }
  end
  defp process({ :error, message }) do
    IO.puts IO.ANSI.format([:red, message], true)
    process(:help)
  end
  defp process(:help) do
    IO.puts """
      Usage: ./resume [options]

      Specific options:
          -l, --locale LOCALE\tSelect the locale of the resume (en, it, ja)

      Common options:
          -h, --help\t\tShow this message
          -v, --version\t\tShow version
    """
    throw { :halt, 0 }
  end
end
