# frozen_string_literal: true

class EmailFormatDeriver
  @@formats = nil

  def initialize
    if @@formats.nil?

      @@formats = {}
      known_emails = JSON.parse(File.read('assets/known-emails.json'))
      known_emails.each do |full_name, email|
        username, domain = email.split('@')

        @@formats[domain] = EmailFormat
      end
    end
  end

  def call(first_name, last_name, domain)
    format = @@formats[domain]

    format.apply(first_name, last_name, domain)
  end

  private

end
