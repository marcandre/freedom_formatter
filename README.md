# 🇺🇸🇺🇸🇺🇸 Freedom Formatter 🇺🇸🇺🇸🇺🇸

A fork of Elixir's code formatter, with added freedom.
[![Build Status](https://travis-ci.org/gamache/freedom_formatter.svg?branch=master)](https://travis-ci.org/gamache/freedom_formatter) [![Hex.pm Version](http://img.shields.io/hexpm/v/freedom_formatter.svg?style=flat)](https://hex.pm/packages/freedom_formatter)

Respects `.formatter.exs` and supports all features of the
standard code formatter.

<img src="https://gamache.github.io/images/freedom-formatter.jpg"
alt="Freedom Formatter">

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

Elixir's code formatter does not currently wish to support trailing
commas, or indeed any additional settings, until at least January 2019.

Thanks to software freedom, we can use tomorrow's formatter today.

## Added features

Freedom Formatter supports all Elixir's standard code formatting
options, as well as:

* `:trailing_comma` - if set `true`, multi-line list, map, and
  struct literals will include a trailing comma after the last item
  or pair in the data structure. Does not affect argument lists,
  tuples, or lists/maps/structs rendered on a single line.

## Authorship and License

Freedom Formatter is released under the same license as Elixir itself,
the Apache License Version 2.0, included here as the file `LICENSE`.

Freedom Formatter is based upon the Elixir code formatter, whose
implementation and tests are included in this project.
The core Elixir formatter was written by José Valim, with
contributions from Andrea Leopardi and others.

Customizations to the formatter are written by Pete Gamache.

