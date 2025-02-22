OmniAuth.config.allowed_request_methods = [ :post ]
OmniAuth.config.silence_get_warning = true

OmniAuth.config.before_request_phase do |env|
  request = Rack::Request.new(env)
  env["omniauth.origin"] = request.params["origin"] || request.referer if request.referer && request.referer.start_with?("http")
end
