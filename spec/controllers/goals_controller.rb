require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "GET #index" do
    it "renders the goals index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "should only allow the account owner to create new goal" do
      allow(subject).to receive(:current_user_goal).and_return(true)
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "with invalid params" do
      it "validates the presence of the user's id and title" do
        post :create, params: { goal: { user_id: 3, title: "" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the title is at least 6 characters long" do
        post :create, params: { goal: { user_id: 2, title: "short" } }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
     it "redirects user to sign-in page on success" do
       post :create, params: { goal: { user_id: 2, title: "EAT ALL THE CAKE" } }
       expect(response).to redirect_to(goal_url(goal))
     end
   end

  end

   describe "DELETE" do

     let!(:goal) {create :goal}
     
     before :each do
       delete :destroy, params: {id: goal.id}
     end
     it "destroy the goal" do
       expect(Goal.exists?(goal.id)).to be(false)
     end
     it "redirect to goals_url" do
       expect(response).to have_http_status(302)
       expect(response).to redirect_to (goals_url)
     end
   end


end
