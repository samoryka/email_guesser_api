# frozen_string_literal: true

class EmailFormatDeriver

  def initialize(known_emails_provider = KnownEmailsProvider.new)
    @known_emails_provider = known_emails_provider
  end

  def call(domain)
    known_formats = load_known_formats
    format = known_formats[domain]

    raise UnknownDomainError.new("email format unkown for #{domain}") if format.nil?

    format
  end

  private

  def load_known_formats
    Rails.cache.fetch('email_known_formats', expires_in: 30.minutes) do
      known_emails = @known_emails_provider.call

      formats = known_emails.map do |full_name, email|
        username, domain = email.split('@')
        format = derive_format(full_name, username)

        [domain, format]
      end

      formats.to_h
    end
  end

  def derive_format(full_name, username)
    names = full_name.split
    first_name = names.first
    last_name = names.last

    if FirstNameLastNameEmailFormat.matches?(first_name, last_name, username)
      return FirstNameLastNameEmailFormat
    end

    if FirstNameInitialLastNameEmailFormat.matches?(first_name, last_name, username)
      return FirstNameInitialLastNameEmailFormat
    end

    raise UnknownFormatError.new("format not known turning #{full_name} into #{username}")
  end
end
