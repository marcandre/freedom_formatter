# 🇺🇸🇺🇸🇺🇸 Freedom Formatter 🇺🇸🇺🇸🇺🇸

A fork of Elixir's code formatter, with added freedom.
[![Build Status](https://travis-ci.org/gamache/freedom_formatter.svg?branch=master)](https://travis-ci.org/gamache/freedom_formatter) [![Hex.pm Version](http://img.shields.io/hexpm/v/freedom_formatter.svg?style=flat)](https://hex.pm/packages/freedom_formatter)

Freedom Formatter is a formatter plugin for Elixir files (`.ex` and `.exs`).
It supports all features of the standard code formatter (forked from Elixir 1.14.0),
as well as additional features.

## Added Features

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
]
```

An elixir bug ([fixed but not released yet](https://github.com/elixir-lang/elixir/issues/11915)) currently requires the app `FreedomFormatter` to be compiled first before attempting to format.

```
# Do this:
mix deps.get
mix compile
# Before you do that:
mix format
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
