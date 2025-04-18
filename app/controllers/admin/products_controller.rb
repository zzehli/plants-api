class Admin::ProductsController < AdminController
  before_action :set_admin_product, only: %i[ show edit update destroy ]
  # GET /admin/products or /admin/products.json
  def index
    @admin_products = Product.all
    render json: @admin_products
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
    render json: @admin_product
  end

  # GET /admin/products/new
  def new
    @admin_product = Product.new
    render json: @admin_product
  end

  # GET /admin/products/1/edit
  def edit
    render json: @admin_product
  end

  # POST /admin/products or /admin/products.json
  def create
    @admin_product = Product.new(admin_product_params)
    @admin_product.quantity = 0

    respond_to do |format|
      if @admin_product.save
        format.json { render json: @admin_product, status: :created, location: @admin_product }
      else
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    respond_to do |format|
      if @admin_product.update(admin_product_params)
        format.json { render :show, status: :ok, location: @admin_product }
      else
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @admin_product.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_product_params
      # image param is necessary here to attach images
      params.require(:product).permit(:name, :description, :price, :active, :image, :category)
    end
end
