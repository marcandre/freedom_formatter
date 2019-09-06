Code.require_file("../test_helper.exs", __DIR__)

defmodule Code.Formatter.SingleClauseOnDoTest do
  use ExUnit.Case, async: true

  import CodeFormatterHelpers

  @single_clause_on_do [single_clause_on_do: true]

  describe "lists" do
    test "case with single clause" do
      ExUnit.CaptureIO.capture_io(:stderr, fn ->
        assert_format """
                      def hello(world) do
                        case world do
                          :world -> IO.inspect world
                        end
                      end
                      """,
                      """
                      def hello(world) do
                        case world do :world ->
                          IO.inspect(world)
                        end
                      end
                      """,
                      @single_clause_on_do
      end)
    end
  end
end
