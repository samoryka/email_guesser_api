# frozen_string_literal: true

require 'minitest/autorun'

class EmailFormatDeriverTest < Minitest::Test

  def test_returns_default_email_format_when_domain_not_known
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'samoryka@otherDomain.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain'
      }
    )

    assert_equal(EmailFormat, EmailFormatDeriver.new(known_emails_provider).call('babbel.com'))
  end

  def test_returns_default_email_format_when_domain_unknownFormat
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(
      :call,
      {
        'Samory Ka' => 'samoryka@otherDomain.com',
        'Maya Angelou' => 'mangelou@otherOtherDomain',
        'Edouard Louis' => 'edouard.louis@babbel'
      }
    )

    assert_equal(EmailFormat, EmailFormatDeriver.new(known_emails_provider).call('babbel.com'))
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
