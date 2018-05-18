# Freedom Formatter

A fork of Elixir's code formatter, with added freedom.

<img src="https://gamache.github.io/images/freedom-formatter.jpg"
alt="Freedom Formatter">

## Usage

Install:

```elixir
{:freedom_formatter, "~> 0.1.0", only: :dev}
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

The Elixir code formatter and tests are pulled straight from the Elixir
project.  The majority of this code was written by José Valim, with
contributions from Andrea Leopardi and others.

Customizations to the Elixir formatter are written by Pete Gamache.

