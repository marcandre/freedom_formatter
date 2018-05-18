defmodule CodeFormatterHelpers do
  defmacro assert_same(good, opts \\ []) do
    quote bind_quoted: [good: good, opts: opts] do
      assert IO.iodata_to_binary(FreedomFormatter.format_string!(good, opts)) == String.trim(good)
    end
  end

  defmacro assert_format(bad, good, opts \\ []) do
    quote bind_quoted: [bad: bad, good: good, opts: opts] do
      result = String.trim(good)
      assert IO.iodata_to_binary(FreedomFormatter.format_string!(bad, opts)) == result
      assert IO.iodata_to_binary(FreedomFormatter.format_string!(good, opts)) == result
    end
  end
end

ExUnit.start()
