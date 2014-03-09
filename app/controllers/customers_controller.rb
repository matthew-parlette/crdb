include ApplicationHelper

class CustomersController < ApplicationController
  after_filter :format_flash
  
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
        flash[:notice] = "Customer '#{@customer.title}' was successfully created."
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
        flash[:notice] = "'#{@customer.title}' was successfully updated."
        format.html { render 'show' }
      else
        @alert = ["'#{@customer.title}' could not be updated."]
        @errors = @customer.errors
        format.html { render 'edit' }
      end
    end
  end
  
  def destroy
    find_customer
    
    respond_to do |format|
      if @customer.destroy
        flash[:notice] = "Successfully deleted '#{@customer.title}'."
        format.html { redirect_to(customers_path) }
        format.js   {}
        format.json { render json: @customer, status: :deleted }
      else
        @alert = ["'#{@customer.title}' could not be deleted."]
        @errors = @customer.errors
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
