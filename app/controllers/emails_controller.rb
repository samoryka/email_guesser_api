class EmailsController < ApplicationController
  module ErrorTypes
    UNKNOWN_DOMAIN = 'unknownDomain'
    INCORRECT_FULL_NAME = 'incorrectFullName'
  end

  def derive
    begin
      domain = derive_params[:company_domain]
      format = EmailFormatDeriver.new.call(domain)

      first_name, last_name = get_names
      @email = format.apply(first_name, last_name, domain)
      @error = nil
      render
    rescue UnknownDomainError
      @email = nil
      @error = ErrorTypes::UNKNOWN_DOMAIN
      render :status => :bad_request
    rescue IncorrectFullNameError
      @email = nil
      @error = ErrorTypes::INCORRECT_FULL_NAME
      render :status => :bad_request
    end
  end

  private

  def get_names
    names = derive_params[:full_name].split

    raise IncorrectFullNameError.new if names.length < 2

    [names.first, names.last]
  end

  def derive_params
    params.permit(:full_name, :company_domain)
  end
end
