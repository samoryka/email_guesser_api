# frozen_string_literal: true

class KnownEmailsProvider
  def call
    known_emails_file_content = File.read('assets/known-emails.json')
    JSON.parse(known_emails_file_content)
  end
end
