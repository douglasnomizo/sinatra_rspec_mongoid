require 'sinatra'
require 'mongoid'

Mongoid.load!('mongoid.yml')

class User
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :pass, type: String
end

get '/' do 
  @users = User.all
  erb :index
end

post '/login' do
  User.create!(name: params[:name], pass: params[:password])
  redirect '/'
end