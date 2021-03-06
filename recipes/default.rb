#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2011, ZeddWorks
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


package "postgresql" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "postgresql-8.4" },
    ["redhat"] => { "default" => "postgresql84-server" }
  )
end

package "postgresql-server-dev" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "postgresql-server-dev-8.4" },
    ["redhat"] => { "default" => "postgresql84-devel" }
  )
end

if platform? "redhat"
  execute "postgresql-initdb" do
    command "service postgresql initdb"
    not_if "test -d /var/lib/pgsql/data/base"
  end

  cookbook_file "/var/lib/pgsql/data/pg_hba.conf" do
    source "pg_hba.conf"
    mode "0600"
    owner "postgres"
    group "postgres"
  end
end

service "postgresql" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

