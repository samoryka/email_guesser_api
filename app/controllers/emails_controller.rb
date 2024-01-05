class EmailsController < ApplicationController
  def derive
    first_name, last_name = get_names

    @email = EmailFormatDeriver.new.call(first_name, last_name, derive_params[:company_domain])
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
