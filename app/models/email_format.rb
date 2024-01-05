# frozen_string_literal: true

class EmailFormat
  def self.apply(first_name, last_name, domain)
    "#{first_name}#{last_name}@#{domain}".downcase.strip
  end
end
