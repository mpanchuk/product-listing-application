require "rails_helper"

describe ProductsController do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the products into @products, and create new @product object" do
      iphone4s = Product.create!(name: "iphone4s", price: 800)
      iphone5s = Product.create!(name: "iphone5s", price: 900)
      get :index

      expect(assigns(:products)).to match_array([iphone4s, iphone5s])
    end
  end

  describe "POST #create" do
    before(:each) do
      @product_params = {name: "Test product", price: 400}
    end

    it "responds successfully with an HTTP 302 status code (redirection)" do
      post :create, product: @product_params
      response.should redirect_to(products_path)
    end

    it "renders the index template if params not valid" do
      post :create, product: {name: "New product"}
      expect(response).to render_template("index")
    end

    it "should create a new product" do
      expect{
        post :create, product: @product_params
      }.to change(Product, :count).by(1)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @product = Product.create!(name: "iphone4s", price: 800)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :edit, {id: @product.id}
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do
      get :edit, {id: @product.id}
      expect(response).to render_template("edit")
    end

    it "loads product to edit into @product" do
      get :edit, {id: @product.id}

      expect(assigns(:product)).to match(@product)
    end
  end

  describe "PUT #update" do
    before(:each) do
      @product = Product.create!(name: "iphone4s", price: 800)
      @product_params = {name: "Edited Test product", price: 500}
    end

    it "responds successfully with an HTTP 302 status code (redirection)" do
      put :update, product: @product_params, id: @product.id
      response.should redirect_to(products_path)
    end

    it "renders the index template if params not valid" do
      put :update, product: {name: "New product", price: "ddd"}, id: @product.id
      expect(response).to render_template("edit")
    end

    it "should update a new product" do
      put :update, product: @product_params, id: @product.id
      expect(@product.reload.name).to match("Edited Test product")
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @product = Product.create!(name: "iphone4s", price: 800)
    end

    it "responds successfully with an HTTP 204 status code" do
      delete :destroy, id: @product.id
      response.should redirect_to(products_path)
    end

    it "should destroy a product" do
      expect{
        delete :destroy, id: @product.id
      }.to change(Product, :count).by(-1)
    end
  end
end