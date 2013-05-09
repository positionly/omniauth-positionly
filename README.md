# OmniAuth Positionly

This gem contains the Positionly strategy for OmniAuth.

## How To Use It

Usage is as per any other OmniAuth 1.0 strategy. So let's say you're using Rails, you need to add the strategy to your `Gemfile`:

    gem 'omniauth-positionly', git: "git@github.com:positionly/omniauth-positionly.git", require: false

Once these are in, you need to add the following to your `config/initializers/omniauth.rb`:

	require "omniauth-positionly"
	Rails.application.config.middleware.use  OmniAuth::Strategies::Positionly, "IDENTIFIER", "SECRET"

You will obviously have to put in your identifier and secret, which you get when you register new client app with Positionly
