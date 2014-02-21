class TwittersController < ApplicationController

	def index

	end

	def create
		redirect_to request_token.authorize_url
	end

	def auth
		# the `request_token` method is defined in `app/helpers/oauth.rb`
	  
	  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
	  
	  # puts @access_token.inspect
	  # our request token is only valid until we use it to get an access token, so let's delete it from our session
	  session.delete(:request_token)


	  # at this point in the code is where you'll need to create your user account and store the access token
  	user = User.create(username: @access_token.params[:screen_name], access_token: @access_token.token, access_secret: @access_token.secret)
  	Session[:user_id] = user.id

  	# redirect to landing page
  	#redirect_to user_challenges_path

	end

end
