class Admin::CategoriesController < ApplicationController
  def index
  end
end


class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:admin_customer] = "更新成功"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

   private

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :kana_last_name,
                                     :kana_first_name,
                                     :phone_number,
                                     :post_cord,
                                     :address,
                                     :email,
                                     :is_active)
  end

end