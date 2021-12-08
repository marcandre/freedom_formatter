defmodule FreedomFormatter.MixProject do
  use Mix.Project

  def project do
    [
      app: :freedom_formatter,
      description: "A fork of the Elixir code formatter, with added freedom",
      version: "1.2.2",
      elixir: "~> 1.13.0 or 1.13.0-rc.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: [
        docs: "docs --source-url https://github.com/gamache/freedom_formatter"
      ]
    ]
  end

  def package do
    [
      licenses: ["Apache 2.0"],
      maintainers: [
        "pete gamache <pete@gamache.org>",
        "Marc-André Lafortune <fformat@marc-andre.ca>"
      ],
      links: %{github: "https://github.com/marcandre/freedom_formatter"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
