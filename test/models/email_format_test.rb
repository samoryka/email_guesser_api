# frozen_string_literal: true

require 'minitest/autorun'

class EmailFormatTest < Minitest::Test
  def test_formats_email
    assert_equal('samoryka@babbel.com', EmailFormat.apply('samory', 'ka', 'babbel.com'))
  end
end
