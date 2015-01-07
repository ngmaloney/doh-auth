# Doh! Auth2
# Oauth2 API Explorer

Doh! Auth2 is a simple Sinatra app useful for debugging OAUTH2 API's. The form
can be pre-populated via a defaults.yaml.

## To Run:

    ruby app.rb

## defaults.yml
    :client_id: OAUTH2_CLIENT_ID
    :client_secret: OAUTH2_CLIENT_SECRET
    :site: OAUTH2_SITE_URL
    :auth_path: OAUTH2_AUTH_PATH
    :token_path: OAUTH2_TOKEN_PATH
    :scope: OAUTH2_SCOPE
    :resource: API_RESOURCE_PATH


