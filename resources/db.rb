def initialize(*args)
  super
  @action = :create
end

actions :create
actions :drop

attribute :database, :kind_of => String, :required => true, :name_attribute => true
attribute :owner, :kind_of => String
