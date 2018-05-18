Code.require_file("../test_helper.exs", __DIR__)

defmodule Code.Formatter.TrailingCommaTest do
  use ExUnit.Case, async: true

  import CodeFormatterHelpers

  @short_length [line_length: 10]
  @medium_length [line_length: 20]
  @trailing_comma [trailing_comma: true]

  describe "lists" do
    test "ignores `trailing_comma: true` for single-line lists" do
      one_line = "[1, 2, 3]"

      assert_same one_line, @trailing_comma

      one_line_with_cons = "[1, 2, 3 | 4]"

      assert_same one_line_with_cons, @trailing_comma
    end

    test "respects `trailing_comma: true` for multi-line lists" do
      multi_line = """
      [
        1,
        2,
        3,
      ]
      """

      assert_same multi_line, @trailing_comma

      multi_line_with_cons = """
      [
        1,
        2,
        3 | 4
      ]
      """

      assert_same multi_line_with_cons, @trailing_comma
    end
  end

  describe "maps" do
    test "ignores `trailing_comma: true` on single-line maps" do
      good_keyword = "%{a: 1, b: 2}"

      assert_same good_keyword, @trailing_comma

      good_assoc = "%{a => 1, b => 2}"

      assert_same good_assoc, @trailing_comma
    end

    test "respects `trailing_comma: true` on multi-line maps" do
      good_keyword = """
      %{
        first: 1,
        second: 2,
      }
      """

      assert_same good_keyword, @trailing_comma

      good_assoc = """
      %{
        key1 => value1,
        key2 => value2,
      }
      """

      assert_same good_assoc, @trailing_comma

      good_keyword_with_newlines = """
      %{
        first:
          expression1(),
        second:
          expression2(),
      }
      """

      assert_same good_keyword_with_newlines, @trailing_comma ++ @medium_length

      good_assoc_with_newlines = """
      %{
        key1 =>
          expression1(),
        key2 =>
          expression2(),
      }
      """

      assert_same good_assoc_with_newlines, @trailing_comma ++ @medium_length
    end
  end

  describe "maps with update" do
    test "ignores `trailing_comma: true` on single-line maps" do
      good_keyword = "%{foo | a: 1, b: 2}"

      assert_same good_keyword, @trailing_comma

      good_assoc = "%{foo | a => 1, b => 2}"

      assert_same good_assoc, @trailing_comma
    end

    test "respects `trailing_comma: true` on multi-line maps" do
      good_keyword = """
      %{
        foo
        | first: 1,
          second: 2,
          third: 3,
          fourth: 4,
      }
      """

      assert_same good_keyword, @trailing_comma ++ @medium_length

      good_assoc = """
      %{
        foo
        | key1 => value1,
          key2 => value2,
      }
      """

      assert_same good_assoc, @trailing_comma ++ @medium_length

      good_keyword_with_newlines = """
      %{
        foo
        | first:
            expression1(),
          second:
            expression2(),
      }
      """

      assert_same good_keyword_with_newlines, @trailing_comma ++ @medium_length

      good_assoc_with_newlines = """
      %{
        foo
        | key1 =>
            expression1(),
          key2 =>
            expression2(),
      }
      """

      assert_same good_assoc_with_newlines, @trailing_comma ++ @medium_length
    end
  end

  describe "structs" do
    test "ignores `trailing_comma: true` on single-line structs" do
      good_keyword = "%Foo{a: 1, b: 2}"

      assert_same good_keyword, @trailing_comma

      good_assoc = "%Foo{:a => 1, :b => 2}"

      assert_same good_assoc, @trailing_comma
    end

    test "respects `trailing_comma: true` on multi-line structs" do
      good_keyword = """
      %Foo{
        first: 1,
        second: 2,
        third: 3,
        fourth: 4,
      }
      """

      assert_same good_keyword, @trailing_comma ++ @medium_length

      good_assoc = """
      %Foo{
        :key1 => value1,
        :key2 => value2,
      }
      """

      assert_same good_assoc, @trailing_comma ++ @medium_length

      good_keyword_with_newlines = """
      %Foo{
        first:
          expression1(),
        second:
          expression2(),
      }
      """

      assert_same good_keyword_with_newlines, @trailing_comma ++ @medium_length

      good_assoc_with_newlines = """
      %Foo{
        :key1 =>
          expression1(),
        :key2 =>
          expression2(),
      }
      """

      assert_same good_assoc_with_newlines, @trailing_comma ++ @medium_length
    end
  end

  describe "struct with update" do
    test "ignores `trailing_comma: true` on single-line structs" do
      good_keyword = "%Foo{foo | a: 1, b: 2}"

      assert_same good_keyword, @trailing_comma

      good_assoc = "%Foo{foo | :a => 1, :b => 2}"

      assert_same good_assoc, @trailing_comma
    end

    test "respects `trailing_comma: true` on multi-line structs" do
      good_keyword = """
      %Foo{
        foo
        | first: 1,
          second: 2,
          third: 3,
          fourth: 4,
      }
      """

      assert_same good_keyword, @trailing_comma ++ @medium_length

      good_assoc = """
      %Foo{
        foo
        | :key1 => value1,
          :key2 => value2,
      }
      """

      assert_same good_assoc, @trailing_comma ++ @medium_length

      good_keyword_with_newlines = """
      %Foo{
        foo
        | first:
            expression1(),
          second:
            expression2(),
      }
      """

      assert_same good_keyword_with_newlines, @trailing_comma ++ @medium_length

      good_assoc_with_newlines = """
      %Foo{
        foo
        | :key1 =>
            expression1(),
          :key2 =>
            expression2(),
      }
      """

      assert_same good_assoc_with_newlines, @trailing_comma ++ @medium_length
    end
  end
end
