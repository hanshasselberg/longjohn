class Device
  include Mongoid::Document
  field :barcode, :type => String
  field :model, :type => String
  field :company, :type => String
  field :kind, :type => String

  def self.entries_of(name, condition = nil)
    Device.all.where(condition).distinct(name).sort
  end

  def cast_to_model
    Model.new(model, company, kind)
  end
end
