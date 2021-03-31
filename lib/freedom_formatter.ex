defmodule FreedomFormatter do
  @moduledoc ~S"""
  Freedom Formatter is a fork of Elixir's code formatter,
  with added freedom.

  It respects `.formatter.exs` and supports all features of
  the standard code formatter, as well as additional features
  unlikely to arrive soon in core Elixir.

  ## Usage

  Install:

  ```elixir
  {:freedom_formatter, "~> 1.0", only: :dev}
  ```

  Run:

  ```bash
  mix fformat
  ```

  ## Why

  Elixir's code formatter does not intend to support trailing commas,
  or indeed any additional settings, until at least January 2019.
  See Elixir issues [#7689](https://github.com/elixir-lang/elixir/pull/7689)
  and [#6646](https://github.com/elixir-lang/elixir/issues/6646) for more
  information.

  Thanks to software freedom, we can use tomorrow's formatter today.

  ## Project Goals

  * To provide a compatible alternative to the Elixir formatter,
    available separately from the core Elixir distribution
  * To allow developers and teams to benefit from standardized code
    formatting while retaining a style they find more productive
  * To be a testbed for new formatting features and options,
    maintaining the easiest possible path to possible inclusion in
    core Elixir.

  ## Added features

  Freedom Formatter supports all Elixir's standard code formatting
  options, as well as:

  * `:trailing_comma` - if set `true`, multi-line list, map, and
    struct literals will include a trailing comma after the last item
    or pair in the data structure. Does not affect argument lists,
    tuples, or lists/maps/structs rendered on a single line.

  ## Thanks

  Thanks to José Valim for hacking together a code formatter and
  getting it almost perfect. :)
  """

  @doc ~S"""
  See Code.format_string!/2
  """
  @doc since: "1.6.0"
  @spec format_string!(binary, keyword) :: iodata
  def format_string!(string, opts \\ []) when is_binary(string) and is_list(opts) do
    line_length = Keyword.get(opts, :line_length, 98)
    algebra = FreedomFormatter.Formatter.to_algebra!(string, opts)
    Inspect.Algebra.format(algebra, line_length)
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
end
