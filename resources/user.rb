def initialize(*args)
  super
  @action = :create
end

actions :create
actions :drop

attribute :user, :kind_of => String, :required => true, :name_attribute => true
attribute :password, :kind_of => String
