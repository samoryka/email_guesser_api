# frozen_string_literal: true

require 'minitest/autorun'

class EmailFormatDeriverTest < Minitest::Test

  def test_raises_error_when_domain_unknown
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'samoryka@otherDomain.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain'
      }
    )

    assert_raises(UnknownDomainError, 'email format unkown for babbel.com') do
      EmailFormatDeriver.new(known_emails_provider).call('babbel.com')
    end
  end

  def test_raises_error_when_format_not_recognizable
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'samoryka@otherDomain.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain',
        'Edouard Louis' => 'edouard.louis@babbel.com'
      }
    )

    assert_raises(UnknownFormatError, "format not known turning 'Edouard Louis' into edouard.louis") do
      assert_equal(EmailFormat, EmailFormatDeriver.new(known_emails_provider).call('babbel.com'))
    end
  end

  def test_returns_first_name_last_name_format_when_domain_known
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'samoryka@babbel.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain'
      }
    )

    assert_equal(FirstNameLastNameEmailFormat, EmailFormatDeriver.new(known_emails_provider).call('babbel.com'))
  end

  def test_returns_first_name_initial_last_name_format_when_domain_known
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'ska@babbel.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain'
      }
    )

    assert_equal(FirstNameInitialLastNameEmailFormat, EmailFormatDeriver.new(known_emails_provider).call('babbel.com'))
  end
end
