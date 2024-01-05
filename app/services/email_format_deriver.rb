# frozen_string_literal: true

class EmailFormatDeriver
  @@formats = nil

  def initialize(known_emails_provider = KnownEmailsProvider.new)
    if @@formats.nil?

      @@formats = {}
      known_emails = known_emails_provider.call
      known_emails.each do |full_name, email|
        username, domain = email.split('@')

        @@formats[domain] = EmailFormat
      end
    end
  end

  def call(first_name, last_name, domain)
    @@formats[domain] || EmailFormat
  end
end
