# frozen_string_literal: true

class FirstNameInitialLastNameEmailFormat
  def self.matches?(first_name, last_name, username)
    "#{first_name[0]}#{last_name}".downcase.strip == username
  end

  def self.apply(first_name, last_name, domain)
    "#{first_name[0]}#{last_name}@#{domain}".downcase.strip
  end
end
