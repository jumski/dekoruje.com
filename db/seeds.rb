# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


SpreeCore::Engine.load_seed if defined?(SpreeCore)
SpreeAuth::Engine.load_seed if defined?(SpreeAuth)

Spree::Config.set(:allow_ssl_in_production => false,
                  :default_locale => :pl)
