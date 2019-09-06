# These parameters should not deviate from the Elixir .formatter.exs,
# so that merges are easy
[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    # Formatter tests
    assert_format: 2,
    assert_format: 3,
    assert_same: 1,
    assert_same: 2
  ],
  plugins: [
    FreedomFormatter,
  ]
  # trailing_comma: true (or false)
  # single_clause_on_do: true (or false)
]
