require 'spec_helper'

describe Equipment::ReturnsController do
  describe "#all_equipment_reservations" do
    it "returns all equipment reservations" do
      EquipmentReservation.expects(:all)
      controller.all_equipment_reservations
    end
  end
end
