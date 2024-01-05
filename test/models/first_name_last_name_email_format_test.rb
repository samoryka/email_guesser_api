# frozen_string_literal: true

require 'minitest/autorun'

class FirstNameLastNameEmailFormatTest < Minitest::Test
  def test_matches_first_name_last_name
    assert_equal(true, FirstNameLastNameEmailFormat.matches?('Samory', 'Ka', 'samoryka'))
  end

  def test_does_not_match_other_formats
    assert_equal(false, FirstNameLastNameEmailFormat.matches?('Samory', 'Ka', 'ska'))
    assert_equal(false, FirstNameLastNameEmailFormat.matches?('Samory', 'Ka', 'samory.ka'))
    assert_equal(false, FirstNameLastNameEmailFormat.matches?('Samory', 'Ka', 'S4M0RY'))
  end

  def test_formats_email
    assert_equal('samoryka@babbel.com', FirstNameLastNameEmailFormat.apply('Samory', 'Ka', 'babbel.com'))
  end
end
