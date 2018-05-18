defmodule FreedomFormatter do
  @moduledoc ~S"""
  Freedom Formatter is a fork of Elixir's code formatter,
  with added freedom.  It respects `.formatter.exs` and
  supports all features of the standard code formatter.

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

  ## Thanks

  Thanks to José Valim for hacking together a code formatter and
  getting it almost perfect. :)
  """

  @doc ~S"""
  Formats the given code `string`.

  The formatter receives a string representing Elixir code and
  returns iodata representing the formatted code according to
  pre-defined rules.

  ## Options

    * `:file` - the file which contains the string, used for error
      reporting

    * `:line` - the line the string starts, used for error reporting

    * `:line_length` - the line length to aim for when formatting
      the document. Defaults to 98.

    * `:locals_without_parens` - a keyword list of name and arity
      pairs that should be kept without parens whenever possible.
      The arity may be the atom `:*`, which implies all arities of
      that name. The formatter already includes a list of functions
      and this option augments this list.

    * `:rename_deprecated_at` - rename all known deprecated functions
      at the given version to their non-deprecated equivalent. It
      expects a valid `Version` which is usually the minimum Elixir
      version supported by the project.

  ## Design principles

  The formatter was designed under three principles.

  First, the formatter never changes the semantics of the code by
  default. This means the input AST and the output AST are equivalent.
  Optional behaviour, such as `:rename_deprecated_at`, is allowed to
  break this guarantee.

  The second principle is to provide as little configuration as possible.
  This eases the formatter adoption by removing contention points while
  making sure a single style is followed consistently by the community as
  a whole.

  The formatter does not hard code names. The formatter will not behave
  specially because a function is named `defmodule`, `def`, etc. This
  principle mirrors Elixir's goal of being an extensible language where
  developers can extend the language with new constructs as if they were
  part of the language. When it is absolutely necessary to change behaviour
  based on the name, this behaviour should be configurable, such as the
  `:locals_without_parens` option.

  ## Running the formatter

  While the formatter attempts to fit the most it can on a single line,
  in many situations such may not be possible, often causing line breaks
  to be introduced in the code.

  In some cases, this may lead to undesired formatting and it is often best
  to adjust the formatted output. To put it in other words: some code generated
  by the formatter may not be aesthetically pleasing and they require explicit
  intervention from the developer. That's why we do not recommend to run the
  formatter blindly in an existing codebase. Instead you should format and
  sanity check each formatted file.

  Let's see some examples. The code below:

      "this is a very long string ... #{inspect(some_value)}"

  may be formatted as:

      "this is a very long string ... #{
        inspect(some_value)
      }"

  This happens because the only place the formatter can introduce a
  new line without changing the code semantics is in the interpolation.
  In those scenarios, we recommend developers to directly adjust the
  code. Here we can use the binary concatenation operator `<>/2`:

      "this is a very long string " <>
        "... #{inspect(some_value)}"

  The string concatenation makes the code fit on a single line and also
  gives more options to the formatter.

  A similar example is when the formatter breaks a function definition
  over multiple clauses:

      def my_function(
        %User{name: name, age: age, ...},
        arg1,
        arg2
      ) do
        ...
      end

  While the code above is completely valid, you may prefer to match on
  the struct variables inside the function body in order to keep the
  definition on a single line:

      def my_function(%User{} = user, arg1, arg2) do
        %{name: name, age: age, ...} = user
        ...
      end

  In some situations, you can use the fact the formatter does not generate
  elegant code as a hint for refactoring. Take this code:

      def board?(board_id, %User{} = user, available_permissions, required_permissions) do
        Tracker.OrganizationMembers.user_in_organization?(user.id, board.organization_id) and
          required_permissions == Enum.to_list(MapSet.intersection(MapSet.new(required_permissions), MapSet.new(available_permissions)))
      end

  The code above has very long lines and running the formatter is not going
  to address this issue. In fact, the formatter may make it more obvious that
  you have complex expressions:

      def board?(board_id, %User{} = user, available_permissions, required_permissions) do
        Tracker.OrganizationMembers.user_in_organization?(user.id, board.organization_id) and
          required_permissions ==
            Enum.to_list(
              MapSet.intersection(
                MapSet.new(required_permissions),
                MapSet.new(available_permissions)
              )
            )
      end

  Take such cases as a suggestion that your code should be refactored:

      def board?(board_id, %User{} = user, available_permissions, required_permissions) do
        Tracker.OrganizationMembers.user_in_organization?(user.id, board.organization_id) and
          matching_permissions?(required_permissions, available_permissions)
      end

      defp matching_permissions?(required_permissions, available_permissions) do
        intersection =
          required_permissions
          |> MapSet.new()
          |> MapSet.intersection(MapSet.new(available_permissions))
          |> Enum.to_list()

        required_permissions == intersection
      end

  To sum it up: since the formatter cannot change the semantics of your
  code, sometimes it is necessary to tweak or refactor the code to get
  optimal formatting. To help better understand how to control the formatter,
  we describe in the next sections the cases where the formatter keeps the
  user encoding and how to control multiline expressions.

  ## Keeping user's formatting

  The formatter respects the input format in some cases. Those are
  listed below:

    * Insignificant digits in numbers are kept as is. The formatter
      however always inserts underscores for decimal numbers with more
      than 5 digits and converts hexadecimal digits to uppercase

    * Strings, charlists, atoms and sigils are kept as is. No character
      is automatically escaped or unescaped. The choice of delimiter is
      also respected from the input

    * Newlines inside blocks are kept as in the input except for:
      1) expressions that take multiple lines will always have an empty
      line before and after and 2) empty lines are always squeezed
      together into a single empty line

    * The choice between `:do` keyword and `do/end` blocks is left
      to the user

    * Lists, tuples, bitstrings, maps, structs and function calls will be
      broken into multiple lines if they are followed by a newline in the
      opening bracket and preceded by a new line in the closing bracket

    * Pipeline operators, like `|>` and others with the same precedence,
      will span multiple lines if they spanned multiple lines in the input

  The behaviours above are not guaranteed. We may remove or add new
  rules in the future. The goal of documenting them is to provide better
  understanding on what to expect from the formatter.

  ### Multi-line lists, maps, tuples, etc

  You can force lists, tuples, bitstrings, maps, structs and function
  calls to have one entry per line by adding a newline after the opening
  bracket and a new line before the closing bracket lines. For example:

      [
        foo,
        bar
      ]

  If there are no newlines around the brackets, then the formatter will
  try to fit everything on a single line, such that the snippet below

      [foo,
       bar]

  will be formatted as

      [foo, bar]

  You can also force function calls and keywords to be rendered on multiple
  lines by having each entry on its own line:

      defstruct name: nil,
                age: 0

  The code above will be kept with one keyword entry per line by the
  formatter. To avoid that, just squash everything into a single line.

  ### Parens and no parens in function calls

  Elixir has two syntaxes for function calls. With parens and no parens.
  By default, Elixir will add parens to all calls except for:

    1. calls that have do/end blocks
    2. local calls without parens where the name and arity of the local
       call is also listed under `:locals_without_parens` (except for
       calls with arity 0, where the compiler always require parens)

  The choice of parens and no parens also affects indentation. When a
  function call with parens doesn't fit on the same line, the formatter
  introduces a newline around parens and indents the arguments with two
  spaces:

      some_call(
        arg1,
        arg2,
        arg3
      )

  On the other hand, function calls without parens are always indented
  by the function call length itself, like this:

      some_call arg1,
                arg2,
                arg3

  If the last argument is a data structure, such as maps and lists, and
  the beginning of the data structure fits on the same line as the function
  call, then no indentation happens, this allows code like this:

      Enum.reduce(some_collection, initial_value, fn element, acc ->
        # code
      end)

      some_funtion_without_parens %{
        foo: :bar,
        baz: :bat
      }

  ## Code comments

  The formatter also handles code comments in a way to guarantee a space
  is always added between the beginning of the comment (#) and the next
  character.

  The formatter also extracts all trailing comments to their previous line.
  For example, the code below

      hello #world

  will be rewritten to

      # world
      hello

  Because code comments are handled apart from the code representation (AST),
  there are some situations where code comments are seen as ambiguous by the
  code formatter. For example, the comment in the anonymous function below

      fn
        arg1 ->
          body1
          # comment

        arg2 ->
          body2
      end

  and in this one

      fn
        arg1 ->
          body1

        # comment
        arg2 ->
          body2
      end

  are considered equivalent (the nesting is discarded alongside most of
  user formatting). In such cases, the code formatter will always format to
  the latter.
  """
  @since "1.6.0"
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
  @since "1.6.0"
  @spec format_file!(binary, keyword) :: iodata
  def format_file!(file, opts \\ []) when is_binary(file) and is_list(opts) do
    string = File.read!(file)
    formatted = format_string!(string, [file: file, line: 1] ++ opts)
    [formatted, ?\n]
  end
end
