#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "postgresql" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "postgresql" }
  )
end

package "postgresql-server-dev" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "postgresql-server-dev-9.0" }
  )
end
