# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_trombi_session',
  :secret      => '67d748553e0926ce34d8357d3a5e384ab3676eda924d77fc4ccece504754d8c7b9484942dc7b05db7765f1136b0d35485eb3fe538de467d9a751d92cf00e0b67'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
