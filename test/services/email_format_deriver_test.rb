# frozen_string_literal: true

require 'minitest/autorun'

class EmailFormatDeriverTest < Minitest::Test

  def test_returns_default_email_format_when_no_matching_domain
    known_emails_provider = Minitest::Mock.new
    known_emails_provider.expect(:call, { "otherDomain.com" => EmailFormat })

    assert_equal(EmailFormat, EmailFormatDeriver.new.call('Samory', 'Ka', 'babbel.com'))
  end
end
