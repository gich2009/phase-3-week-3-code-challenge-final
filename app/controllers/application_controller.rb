class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  #--------------------User Method routes--------------------------------#
  # Display all reviews from a user
  get '/users/:id/reviews' do
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @reviews.to_json
  end

  # Display all products reviewed by a user
  get '/users/:id/products' do
    @user = User.find(params[:id])
    @products = @user.products
    @products.to_json
  end


  # Show a user's favorite product
  get '/users/:id/favorite_product' do
    @user = User.find(params[:id])
    @product = @user.favorite_product
    @product.to_json
  end
  

  # Remove a user's reviews for a specific product
  delete '/users/:user_id/reviews/:product_id' do
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @user.remove_reviews(@product)
    @user.to_json
  end
  




  #------------------------Product Method routes--------------------------------#
  # Display all reviews for a product
  get '/products/:id/reviews' do
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @reviews.to_json
  end


  # Display all users who reviewed a specific product
  get '/products/:id/users' do
    @product = Product.find(params[:id])
    @users = @product.users
    @users.to_json
  end


  # Leave a review for a product
  post '/products/:product_id/reviews' do
    @product = Product.find(params[:product_id])
    @user = User.find(params[:user_id])  # This should be current_user in a real scenario
    @product.leave_review(@user, params[:star_rating], params[:comment])
    @product.to_json
  end
  

  # Display all reviews for a product
  get '/products/:id/reviews' do
    @product = Product.find(params[:id])
    @reviews = @product.reviews.map(&:print_review)
    @reviews.to_json
  end
  

  # Display the average rating for a product
  get '/products/:id/average_rating' do
    @product = Product.find(params[:id])
    @average_rating = @product.average_rating
    @average_rating.to_json
  end

  


  #------------------------Review Method routes--------------------------------#
  # Display the user who made a specific review
  get '/reviews/:id/user' do
    @review = Review.find(params[:id])
    @user = @review.user
    @user.to_json
  end


  # Display the product that a specific review refers to
  get '/reviews/:id/product' do
    @review = Review.find(params[:id])
    @product = @review.product
    @product.to_json
  end


  #Print a single review.
  get '/reviews/:id' do
    @review = Review.find(params[:id])
    @print_review = @review.print_review
    @print_review.to_json
  end

end
