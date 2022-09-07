Code.require_file("../test_helper.exs", __DIR__)

defmodule Code.Formatter.LocalPipeWithParensTest do
  use ExUnit.Case, async: true

  import CodeFormatterHelpers

  @local_pipe_with_parens [local_pipe_with_parens: true]

  describe "pipe" do
    test "to local functions" do
      assert_format "foo |> bar",
                    "foo |> bar()",
                    @local_pipe_with_parens

      assert_format "foo |> bar |> baz >>> qux |> fin",
                    "foo |> bar() |> baz() >>> qux |> fin()",
                    @local_pipe_with_parens

      assert_format "foo |> bar", "foo |> bar()", [
        [:locals_without_parens, [bar: :*]] | @local_pipe_with_parens
      ]
    end
  end
end
