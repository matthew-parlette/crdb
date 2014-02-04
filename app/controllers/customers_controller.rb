class CustomersController < ApplicationController
  before_filter :get_customers
  
  def index
    @customers = Customer.all
    respond_to do |format|
      format.html {}
      format.json { render json: @customers }
    end
  end
  
  def show
    find_customer
    respond_to do |format|
      format.html {}
      format.json { render json: @customer }
    end
  end
  
  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(filtered_params)
    
    respond_to do |format|
      if @customer.save
        flash[:notice] = 'Customer was successfully created.'
        format.html { redirect_to @customer }
        format.json { render json: @customer, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def get_customers
    end
    
    def filtered_params
      params.require(:customer).permit(:title,:name,:description)
    end
    
    def find_customer
      @customer = Customer.find(params[:id])
    end
end
