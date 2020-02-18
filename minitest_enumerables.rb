require 'minitest/autorun'
require './enumerable'

class EnumerableTest < MiniTest::Test
  def setup
    @data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    @enum = Object.new
    @enum.extend(Enumerable)
  end

  def test_my_each
    result = @enum.my_each
    #identity = ->(i) { i }
    assert_equal(@data, result)
  end
end
