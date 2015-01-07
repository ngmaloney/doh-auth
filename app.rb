require "sinatra"
require "oauth2"
require "json"

enable :sessions

PARAMS = [:client_id, :client_secret, :site, :auth_path, :token_path, :redirect_uri, :scope, :resource]

get "/" do
  assign_defaults
  haml :index
end

post "/auth" do
  save_params && assign_defaults
  authorize_url = client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: @scope)
  redirect authorize_url
end

get "/callback" do
  assign_defaults
  token = client.auth_code.get_token(params[:code], redirect_uri: @redirect_uri)
  resp = token.get(@resource)
  json = JSON.parse(resp.body)
  @token = token.token
  @content = JSON.pretty_generate(json)
  haml :index
end

def client
  @client ||= OAuth2::Client.new(@client_id, @client_secret, {site: @site, authorize_url: @auth_path, token_url: @token_path})
end

def save_params
  PARAMS.each do |var|
    session[var] = params[var]
  end
end

def assign_defaults
  defaults = YAML.load_file("./defaults.yaml") || {}
  @client_id = session[:client_id] || defaults[:client_id]
  @client_secret = session[:client_secret] || defaults[:client_secret]
  @site = session[:site] || defaults[:site]
  @auth_path = session[:auth_path] || defaults[:auth_path]
  @token_path = session[:token_path] || defaults[:token_path]
  @redirect_uri = session[:redirect_uri] || "http://#{request.env["HTTP_HOST"]}/callback"
  @scope = session[:scope] || defaults[:scope]
  @resource = session[:resource] || defaults[:resource]
end
