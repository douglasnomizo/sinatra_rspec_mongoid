ENV['RACK_ENV'] = 'test'

require './app'  # <-- your sinatra app
require 'rspec'
require 'rack/test'
require 'ostruct'

describe 'The App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  user_1 = OpenStruct.new(name: 'Brownie', email: 'brown@mail.com', pass: '123')
  user_2 = OpenStruct.new(name: 'Mary', email: 'mary@mail.com', pass: '321')

  describe "Index Page" do
    before(:each) do
      allow(User).to receive(:all).and_return([user_1, user_2])
    end

    it "should show the login form" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Name:', 'Password:'
    end

    it "should list added users" do
      get '/'
      expect(last_response.body).to include 'Brownie', 'Mary'
    end
  end

  describe "Users" do
    before(:each) do
      @user = User.new 
    end

    it "should have name" do
      @user.should respond_to :name
    end

    it "should have email" do
      @user.should respond_to :email
    end

    it "should have pass" do
      @user.should respond_to :pass
    end

  end

  describe "Login" do
    it "should redirect to index" do
      pending 'to be done'
    end
  end

end