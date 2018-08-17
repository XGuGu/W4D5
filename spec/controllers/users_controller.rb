require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "renders the users index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "should create a new user" do
      allow(subject).to receive(:logged_in?).and_return(true)
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post :create, params: { user: { username: "pikachu", password: "" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: { username: "pikachu", password: "short" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
     it "redirects user to sign-in page on success" do
       post :create, params: { user: { username: "pikachu", password: "pokemon" } }
       expect(response).to redirect_to(users_url)
     end
   end

  end

   # describe "DELETE" do
   #   let!(:user) {create :user}
   #   before :each do
   #     delete :destroy, params: {id: user.id}
   #   end
   #   it "destroy the user" do
   #     expect(User.exists?(user.id)).to be(false)
   #   end
   #   it "redirect to users_url" do
   #     expect(response).to have_http_status(302)
   #     expect(response).to redirect_to (users_url)
   #   end
   # end


end
