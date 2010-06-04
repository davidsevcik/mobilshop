# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mobilshop_session',
  :secret      => '0d6863c67b4015565224f42174187c9857570d7cca5bd4e7cf9e61344257c71110a6d35868224f1f44f4db1a8a7d50a1fad476a1d6fe24fed954616178de061c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store