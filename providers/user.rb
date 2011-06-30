action :create do
  user = new_resource.user
  password = new_resource.password
  if password.nil?
    execute "create-postgres-user-#{user}" do
      user "postgres"
      command "psql -c \"CREATE USER #{user};\""
      not_if "sudo -u postgres bash -c \"psql -c '\\du'\" | grep #{user}"
    end
  else
    execute "create-postgres-user-#{user}" do
      user "postgres"
      command "psql -c \"CREATE USER #{user} WITH PASSWORD '#{password}';\""
      not_if "sudo -u postgres bash -c \"psql -c '\\du'\" | grep #{user}"
    end
  end
end

action :drop do
  user = new_resource.user
  execute "drop-postgres-user-#{user}" do
    user "postgres"
    command "psql -c \"DROP USER #{user};\""
    only_if "sudo -u postgres bash -c \"psql -c '\\du'\" | grep #{user}"
  end
end
