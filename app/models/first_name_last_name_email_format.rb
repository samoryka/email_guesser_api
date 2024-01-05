# frozen_string_literal: true

class FirstNameLastNameEmailFormat < EmailFormat
  def self.matches?(first_name, last_name, username)
    "#{first_name}#{last_name}".downcase.strip == username
  end

  def self.apply(first_name, last_name, domain)
    "#{first_name}#{last_name}@#{domain}".downcase.strip
  end
end
