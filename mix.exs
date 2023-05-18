defmodule BMP3XX.MixProject do
  use Mix.Project

  @version "0.1.6"
  @description "Use Bosch environment sensors in Elixir"
  @source_url "https://github.com/mnishiguchi/bmp3xx"

  def project do
    [
      app: :bmp3xx,
      version: @version,
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(Mix.env()),
      docs: docs(),
      package: package(),
      description: @description,
      dialyzer: [
        flags: [:missing_return, :extra_return, :unmatched_returns, :error_handling, :underspecs]
      ],
      preferred_cli_env: %{
        docs: :docs,
        "hex.publish": :docs,
        "hex.build": :docs
      },
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps(env) when env in [:test, :dev] do
    [
      {:circuits_i2c, github: "elixir-circuits/circuits_i2c", branch: "v2.0", override: true},
      {:circuits_sim, github: "elixir-circuits/circuits_sim"},
      {:credo, "~> 1.7", runtime: false},
      {:dialyxir, "~> 1.3", runtime: false}
    ]
  end

  defp deps(_env) do
    [
      {:circuits_i2c, "~> 2.0 or ~> 1.0 or ~> 0.3"},
      {:ex_doc, "~> 0.29", only: :docs, runtime: false}
    ]
  end

  defp elixirc_paths(env) when env in [:test, :dev], do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp package do
    %{
      files: [
        "lib",
        "test",
        "mix.exs",
        "README.md",
        "LICENSE",
        "CHANGELOG.md"
      ],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @source_url,
        "BMP180 data sheet" => "https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf",
        "BMP280 data_sheet" => "https://cdn-shop.adafruit.com/datasheets/BST-BMP280-DS001-11.pdf",
        "BMP388 data_sheet" =>
          "https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf",
        "BME280 data_sheet" =>
          "https://cdn-learn.adafruit.com/assets/assets/000/115/588/original/bst-bme280-ds002.pdf",
        "BME680 data_sheet" => "https://cdn-shop.adafruit.com/product-files/3660/BME680.pdf"
      }
    }
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp aliases do
    [
      lint: ["format", "deps.unlock --unused", "hex.outdated", "credo", "dialyzer"]
    ]
  end
end
