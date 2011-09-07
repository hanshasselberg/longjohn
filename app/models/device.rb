class Device
  include Mongoid::Document
  field :barcode, :type => String
  field :model, :type => String
  field :company, :type => String
  field :kind, :type => String
end
