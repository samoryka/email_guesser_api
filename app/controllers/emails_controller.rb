class EmailsController < ApplicationController
  module ErrorTypes
    UNKNOWN_DOMAIN = 'unknownDomain'
  end

  def derive
    first_name, last_name = get_names
    domain = derive_params[:company_domain]

    begin
      format = EmailFormatDeriver.new.call(domain)

      @email = format.apply(first_name, last_name, domain)
      @error = nil
      render
    rescue UnknownDomainError
      @email = nil
      @error = ErrorTypes::UNKNOWN_DOMAIN
      render :status => :bad_request
    end
  end

  private

  def get_names
    names = derive_params[:full_name].split

    [names.first, names.last]
  end

  def derive_params
    params.permit(:full_name, :company_domain)
  end
end
