# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_RoboRally_session',
  :secret      => '652ae759099eb8183c043b58a995041cd70c7020bc51e2288b6933661e042f4bc85263255c2772f0d0ce5d8073d64126ad861c12477ce82f7c39a9bd0e239e7d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
