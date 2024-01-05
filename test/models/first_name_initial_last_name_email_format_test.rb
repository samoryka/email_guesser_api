# frozen_string_literal: true

require 'minitest/autorun'

class FirstNameInitialLastNameEmailFormatTest < Minitest::Test
  def test_matches_first_name_initial_last_name
    assert_equal(true, FirstNameInitialLastNameEmailFormat.matches?('Samory', 'Ka', 'ska'))
  end

  def test_does_not_match_other_formats
    assert_equal(false, FirstNameInitialLastNameEmailFormat.matches?('Samory', 'Ka', 'samoryka'))
    assert_equal(false, FirstNameInitialLastNameEmailFormat.matches?('Samory', 'Ka', 'samory.ka'))
    assert_equal(false, FirstNameInitialLastNameEmailFormat.matches?('Samory', 'Ka', 'S4M0RY'))
  end

  def test_formats_email
    assert_equal("ska@babbel.com", FirstNameInitialLastNameEmailFormat.apply('Samory', 'Ka', 'babbel.com'))
  end
end
