# frozen_string_literal: true

class EmailFormat
  def self.matches?(first_name, last_name, username)
    raise NotImplementedError.new
  end

  def self.apply(first_name, last_name, domain)
    raise NotImplementedError.new
  end
end
