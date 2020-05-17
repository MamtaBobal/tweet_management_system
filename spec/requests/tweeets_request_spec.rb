RSpec.describe "Api::V1::Uiw::Tweeets", type: :request do

  let!(:organization) { create(:organization) }
  let!(:organization1) { create(:organization) }

  let!(:user1) { create(:user, organization: organization) }
  let!(:user2) { create(:user, is_admin: true, organization: organization) }
  let!(:user3) { create(:user, organization: organization1)}
  let!(:tweeet1) { create(:tweeet, user: user1) }
  let!(:tweeet2) { create(:tweeet, user: user3) }

  let!(:valid_headers) { { "Authorization" => user2.generate_jwt } }
  
  describe 'GET index' do
    it 'returns 200' do
      get tweeets_path, :params => "", :headers => valid_headers
      expect(response.status).to eq(200)
    end

    it 'returns a list of tweeets of users of same organization' do
      get tweeets_path, :params => "", :headers => valid_headers
      expect(json.length).to eq(1)
    end
  end

  describe 'POST create' do
    let(:params) { { 
                      tweet: "New Tweet" 
                 } }
    it 'returns 200' do
      post tweeets_path, :params => params, :headers => valid_headers
      expect(response.status).to eq(200)
    end

    it 'returns a tweeet' do
      post tweeets_path, :params => params, :headers => valid_headers
      expect(json["tweet"]).to eq("New Tweet")
    end
  end

  describe 'PUT update' do
    let!(:valid_headers) { { "Authorization" => user3.generate_jwt } }
    let!(:admin_valid_headers) { { "Authorization" => user2.generate_jwt } }

    describe 'with valid parameters' do
      let(:valid_params) { { 
                      tweet: "Updated Tweet"
                 } }

      it 'return 200' do
        put tweeet_path(tweeet2.id), :params => valid_params, :headers => valid_headers
        expect(response.status).to eq(200)
      end

      it "updates a tweeet if current user is admin" do
        put tweeet_path(tweeet1.id), :params => valid_params, :headers => admin_valid_headers
        expect(json["tweet"]).to eq("Updated Tweet")
      end

      it "updates a tweeet if current user is owner of tweeet" do
        put tweeet_path(tweeet2.id), :params => valid_params, :headers => valid_headers
        expect(json["tweet"]).to eq("Updated Tweet")
      end

      it "doesn't updates a tweeet if current user is neither owner of tweet nor admin" do
        put tweeet_path(tweeet1.id), :params => valid_params, :headers => valid_headers
        expect(response.status).to eq(401)
      end
    end

    describe 'with invalid parameters' do
      let(:invalid_params) { { 
                             tweet: ""
                         } }
      it "doesn't update a tweeet if text is blank" do
        tweet = tweeet2.tweet
        put tweeet_path(tweeet2.id), :params => invalid_params, :headers => valid_headers
        expect(tweeet2.tweet).to eq(tweet)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:valid_headers) { { "Authorization" => user3.generate_jwt } }
    let!(:admin_valid_headers) { { "Authorization" => user2.generate_jwt } }

    it 'return 200' do
      delete tweeet_path(tweeet2.id), :params => "", :headers => valid_headers
      expect(response.status).to eq(200)
    end

    it "deletes a tweeet if current user is admin" do
      delete tweeet_path(tweeet1.id), :params => "", :headers => admin_valid_headers
      expect(response.status).to eq(200)
    end

    it "deletes a tweeet if current user is owner of tweeet" do
      delete tweeet_path(tweeet2.id), :params => "", :headers => valid_headers
      expect(response.status).to eq(200)
    end

    it "doesn't updates a tweeet if current user is neither owner of tweet nor admin" do
      delete tweeet_path(tweeet1.id), :params => "", :headers => valid_headers
      expect(response.status).to eq(401)
    end
  end

end
