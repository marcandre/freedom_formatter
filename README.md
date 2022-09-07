# 🇺🇸🇺🇸🇺🇸 Freedom Formatter 🇺🇸🇺🇸🇺🇸

A fork of Elixir's code formatter, with added freedom.
[![Build Status](https://travis-ci.org/gamache/freedom_formatter.svg?branch=master)](https://travis-ci.org/gamache/freedom_formatter) [![Hex.pm Version](http://img.shields.io/hexpm/v/freedom_formatter.svg?style=flat)](https://hex.pm/packages/freedom_formatter)

Freedom Formatter is a formatter plugin for Elixir files (`.ex` and `.exs`).
It supports all features of the standard code formatter (forked from Elixir 1.14.0),
as well as additional features.

## Added Features

- `:trailing_comma` - if set `true`, multi-line list, map, and
  struct literals will include a trailing comma after the last item
  or pair in the data structure. Does not affect argument lists nor
  tuples. Does not affect lists/maps/structs rendered on a single line either.

```elixir
# trailing_comma: false
example = %{
  foo: 42,
  bar: 44
}
# trailing_comma: true
example = %{
  foo: 42,
  bar: 44,
}
```

- `:local_pipe_with_parens` - if set to `true`, will force pipes to local functions and no argument to have parenthesis. Default elixir formatter will accept pipes both with and without parenthesis:

```elixir
# local_pipe_with_parens: false
[:only, :an, :example]
|> hd()
|> to_string

# local_pipe_with_parens: true
[:only, :an, :example]
|> hd()
|> to_string()
```

Note that this option results in code that technically is not identical (it has a different AST).
While Elixir will interpret `a |> b` and `a |> b()` the same way, it is theoretically possible to write a macro that would handle `a |> b` differently from `a |> b()`. We know of no library that does that.
This option will also prevent writing your own `defmacro foo |> bar do`; we know of no library that does this either (except Elixir itself).
If you know of any such examples, please open an issue to let us know.

- `:single_clause_on_do` - if set to `true`, will format `case` with single pattern with the pattern inline, like:

```elixir
# single_clause_on_do: false
case expr do
  pattern -> body
end

# single_clause_on_do: true
case expr do pattern ->
  body
end
```

## Usage

Install by adding the package to your `mix.exs`

```elixir
{:freedom_formatter, ">= 2.0.0", only: :dev}
```

Specify this package as a plugin for the formatter in `.formatter.exs`:

```elixir
# .formatter.exs
[
  inputs: [
    # ...
  ],
  plugins: [
    # ...
    # Add this:
    FreedomFormatter,
  ],

  # Additional options are now supported:
  trailing_comma: true,
  local_pipe_with_parens: true,
]
```

## Why

Elixir's code formatter does not intend to support trailing commas,
or indeed any additional settings.
See Elixir issues [#7689](https://github.com/elixir-lang/elixir/pull/7689)
and [#6646](https://github.com/elixir-lang/elixir/issues/6646) for more
information.

## Project Goals

- To provide a compatible alternative to the Elixir formatter,
  available separately from the core Elixir distribution
- To allow developers and teams to benefit from standardized code
  formatting while retaining a style they find more productive
- To be a testbed for new formatting features and options,
  maintaining the easiest possible path to possible inclusion in
  core Elixir.

## Authorship and License

Freedom Formatter is released under the same license as Elixir itself,
the Apache License Version 2.0, included here as the file `LICENSE`.

Freedom Formatter is based upon the Elixir code formatter, whose
implementation and tests are included in this project.
The core Elixir formatter was written by José Valim, with
contributions from Andrea Leopardi and others.

Authored by Pete Gamache.
Maintance by Marc-André Lafortune.

### Notes

- This project uses semantic versioning.
- This project gets a new branch for each new minor version of elixir (unless no change was made to the formatter).
- Each new branch has its history completely rewritten.

### Changelog

v2.1.0: Adds `local_pipe_with_parens` option. Requires Elixir 1.14.0+

v2.0.0: Now a formatter plugin; as such it requires Elixir 1.13.2+
