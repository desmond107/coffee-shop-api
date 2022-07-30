require 'sinatra'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/coffees' do
    coffees = Coffee.all
    coffees.to_json
  end

  post '/coffees' do
    coffee = Coffee.create(name: params[:name], price: params[:price], description: params[:description])
    if coffee
      coffee.to_json
    else
      {message: "Something went wrong! Try again"}
    end
  end

  post '/login' do
    if params[:email].empty? || params[:password].empty?
      return {message: "Please fill in all the fields"}.to_json
    else
      user = User.find_by(email: params[:email])
      if !user
        return {message: "Account does not exist"}.to_json
      end
      if user && user.password != params[:password]
        return {message: "Wrong password/email."}.to_json
      end
      user = {
      id: user.id,
      email: user.email
    }

      {user: user}.to_json
    end
  end

  post '/register' do
    if params[:email].empty? || params[:password].empty?
      return {message: "Please fill in all the fields"}.to_json
    elsif User.find_by(email: params[:email])
      return {message: "User already exists."}.to_json
    elsif params[:password].length < 5
      return {message: "Password must be atleast 5 characters."}.to_json
    end
    user = User.create(
      email: params[:email],
      password: params[:password]
    )
    user = {
      id: user.id,
      email: user.email
    }

    {user: user}.to_json
  end

  get '/users/:user_id/orders' do
    user = User.find_by(id: params[:user_id])
    if user
      user.to_json(include: :orders)
    else
      {message: "Problem fetching orders"}
    end
  end

  post '/orders' do
    order = Order.create(
      amount: params[:amount],
      user_id: params[:user_id],
      order: params[:order]
    )
    order.to_json
  end

end