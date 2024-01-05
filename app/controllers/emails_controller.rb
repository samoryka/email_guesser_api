class EmailsController < ApplicationController
  def derive
    first_name, last_name = get_names
    domain = derive_params[:company_domain]
    format = EmailFormatDeriver.new.call(domain)

    @email = format.apply(first_name, last_name, domain)
    render
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
