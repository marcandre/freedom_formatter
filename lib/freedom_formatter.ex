defmodule FreedomFormatter do
  @moduledoc ~S"""
  Freedom Formatter is a fork of Elixir's code formatter,
  with added freedom. See the README for more information.
  """

  @doc ~S"""
  See Code.format_string!/2
  """
  @doc since: "1.6.0"
  @spec format_string!(binary, keyword) :: iodata
  def format_string!(string, opts \\ []) when is_binary(string) and is_list(opts) do
    line_length = Keyword.get(opts, :line_length, 98)

    to_quoted_opts =
      [
        unescape: false,
        warn_on_unnecessary_quotes: false,
        literal_encoder: &{:ok, {:__block__, &2, [&1]}},
        token_metadata: true
      ] ++ opts

    {forms, comments} = Code.string_to_quoted_with_comments!(string, to_quoted_opts)

    to_algebra_opts =
      [
        comments: comments
      ] ++ opts

    doc = FreedomFormatter.Formatter.to_algebra(forms, to_algebra_opts)

    Inspect.Algebra.format(doc, line_length)
  end

  @doc """
  Formats a file.

  See `format_string!/2` for more information on code formatting and
  available options.
  """
  @doc since: "1.6.0"
  @spec format_file!(binary, keyword) :: iodata
  def format_file!(file, opts \\ []) when is_binary(file) and is_list(opts) do
    string = File.read!(file)
    formatted = format_string!(string, [file: file, line: 1] ++ opts)
    [formatted, ?\n]
  end

  #### Formatter plugin ####

  @behaviour Mix.Tasks.Format

  def features(_opts) do
    [extensions: ~w[.ex .exs]]
  end

  def format(content, formatter_opts) do
    IO.iodata_to_binary([format_string!(content, formatter_opts), ?\n])
  end
end
