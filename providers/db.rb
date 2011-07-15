action :create do
  database = new_resource.database
  owner = new_resource.owner
  if owner.nil?
    execute "create-postgres-db-#{database}" do
      user "postgres"
      command "psql -c \"CREATE DATABASE #{database} ENCODING 'utf8';\""
      not_if "sudo -u postgres bash -c \"psql -c '\\l'\" | grep #{database}"
    end
  else
    execute "create-postgres-db-#{database}" do
      user "postgres"
      command "psql -c \"CREATE DATABASE #{database} OWNER #{owner} ENCODING 'utf8';\""
      not_if "sudo -u postgres bash -c \"psql -c '\\l'\" | grep #{database}"
    end
  end
end
action :drop do
  database = new_resource.database
  owner = new_resource.owner
  execute "drop-postgres-db-#{database}" do
    user "postgres"
    command "psql -c \"DROP DATABASE #{database};\""
    only_if "sudo -u postgres bash -c \"psql -c '\\l'\" | grep #{database}"
  end
end
