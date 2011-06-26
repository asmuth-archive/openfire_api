require 'rubygems'
require 'rspec'
require 'fakeweb'

FakeWeb.allow_net_connect = false
 
$: << ::File.expand_path('../../lib', __FILE__)
require 'openfire_api'

