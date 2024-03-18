# frozen_string_literal: true

require_relative "../test_helper"

module SyntaxTree
  class HashShorthandTest < Minitest::Test
    def test_hash_shorthand_in_hash_literal
      assert_format("{ foo: }\n", "{ foo: foo }\n")
    end

    def test_hash_shorthand_in_arguments
      assert_format("foo(bar:)\n", "foo(bar: bar)\n")
    end

    private

    def assert_format(expected, source = expected)
      options = Formatter::Options.new(hash_shorthand: true)
      formatter = Formatter.new(source, [], options: options)
      SyntaxTree.parse(source).format(formatter)

      formatter.flush
      assert_equal(expected, formatter.output.join)
    end
  end
end
