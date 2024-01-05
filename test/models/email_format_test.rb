# frozen_string_literal: true

require 'minitest/autorun'

class EmailFormatTest < Minitest::Test
  def test_apply_raises_error
    assert_raises(NotImplementedError) { EmailFormat.apply('samory', 'ka', 'babbel.com') }
  end

  def test_matches_raises_error
    assert_raises(NotImplementedError) { EmailFormat.matches?('samory', 'ka', 'babbel.com') }
  end
end
