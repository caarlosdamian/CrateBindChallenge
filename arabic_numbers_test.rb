require 'minitest/autorun'
require './arabic_numbers'

class ArabicNumbersTest < Minitest::Test
  def setup
    @arabic_numbers_test = ArabicNumbers.new
  end

  def test_return_not_null
    assert !@arabic_numbers_test.english_number(1890).nil?
  end

  def test_numbers
    assert_equal 'seven ', @arabic_numbers_test.english_number(7)
    assert_equal 'fourty-two ', @arabic_numbers_test.english_number(42)
  end

  def test_hundred
    assert_equal 'one-hundred fourty', @arabic_numbers_test.english_number(140)
  end

  def test_thousand
    assert_equal 'one thousand four-hundred fourty', @arabic_numbers_test.english_number(1440)
  end
end
