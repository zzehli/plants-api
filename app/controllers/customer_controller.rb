class CustomerController < ApplicationController
  before_action :authenticate_customer!
  def index
  end
end
