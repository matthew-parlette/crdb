class CustomersController < ApplicationController
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
    find_customer
  end
  
  def update
    find_customer
    
    respond_to do |format|
      if @customer.update(filtered_params)
        flash[:notice] = 'Customer was successfully updated.'
        format.html { render 'show' }
      else
        flash[:alert] = 'Customer could not be updated.'
        format.html { render 'edit' }
      end
    end
  end
  
  def destroy
    find_customer
    
    respond_to do |format|
      if @customer.destroy
        flash[:notice] = "Successfully deleted customer."
        format.html { redirect_to(customers_path) }
        format.js   {}
        format.json { render json: @customer, status: :deleted }
      else
        flash[:alert] = "Customer could not be deleted."
        format.html { render json: @customer.errors, status: :unprocessable_entity }
        format.js   {}
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def filtered_params
      params.require(:customer).permit(:title,:name,:description,:links,:importance,:active)
    end
    
    def find_customer
      @customer = Customer.find(params[:id])
    end
end
