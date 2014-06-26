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

    it "loads all of the products into @products" do
      iphone4s = Product.create!(name: "iphone4s", price: 800)
      iphone5s = Product.create!(name: "iphone5s", price: 900)
      get :index

      expect(assigns(:products)).to match_array([iphone4s, iphone5s])
    end
  end
end