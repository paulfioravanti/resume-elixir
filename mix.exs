defmodule Resume.Mixfile do
  use Mix.Project

  def project do
    [app: :resume,
     version: "0.0.1",
     elixir: "~> 1.1",
     escript: escript,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:httpoison, :gettext, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :poison, "~> 1.5" },
      { :httpoison, "~> 0.7.2" },
      { :gettext, "~> 0.7"}
    ]
  end

  defp escript do
    [main_module: Resume]
  end
end
