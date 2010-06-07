# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_restart_session',
  :secret      => '06addcc33aaefa3365cef5533682a05de0b9156c1b4dea05429d97620ffa989be6fe4d41a3120246936538df832490fda7b235afeb19aa73ccd68bf014c0c340'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store