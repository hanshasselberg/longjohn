require 'spec_helper'

describe Model do
  describe ".new" do
    let(:model) { Model.new }

    it "creates a new instance" do
      model.should be_a(Model)
    end
  end

  describe "#equal_to_reservation" do
    let(:model) { Model.new('A', 'B', 'C') }

    context "when nil is given" do
      it "should return false" do
        model.equal_to_reservation(nil).should_not be
      end
    end

    context "when a reservation is given" do
      context "when model, company or kind are not the same" do
        let(:reservation) { { model: 'X', company: 'X', kind: 'X' } }

        it "should return false" do
          model.equal_to_reservation(reservation).should_not be
        end
      end

      context "when model, company and kind are the same" do
        let(:reservation) { { 'model' => 'A', 'company' => 'B', 'kind' => 'C' } }

        it "should return true" do
          model.equal_to_reservation(reservation).should be
        end
      end
    end
  end

  describe ".from_devices" do
    context "when there are no devices" do
      let(:devices) { Device.all }
      let(:models) { Model.from_devices(devices) }

      it "should return an empty array" do
        models.should be_empty
      end
    end

    context "when there are three devices, two of them different" do
      let!(:device_one) { Device.create(model: 'A', company: '1', kind: 'H')}
      let!(:device_two) { Device.create(model: 'B', company: '1', kind: 'H')}
      let!(:device_three) { Device.create(model: 'B', company: '1', kind: 'H')}
      let(:devices) { Device.all }
      let(:models) { Model.from_devices(devices) }

      it "should include device_one's model" do
        models.should include(device_one.cast_to_model)
      end

      it "should include device_two's model" do
        models.should include(device_two.cast_to_model)
      end

      it "should include 2 models" do
        models.should have(2).items
      end

      it "should include a model with 2 total devices" do
        models.find{ |m| m.total_devices == 2}.should be
      end
    end
  end

  describe ".in" do
    context "when given two dates" do
      context "when there are no reservations" do
        let(:models) { Model.in(Date.today, Date.today) }

        it "should return all models" do
          models.should == Model.all
        end

        it "should set available_devices equals total_devices" do
          models.all?{ |model| model.available_devices == model.total_devices }.should be
        end
      end

      context "when there is a reservation" do
        let!(:device)  { Device.create(model: 'A', company: '1', kind: 'H') }
        let!(:reservation) do
          EquipmentReservation.create(
            from: Time.now-1.day,
            to: Time.now,
            reservations: [{model: device.model, company: device.company, kind: device.kind, count: 1}]
          )
        end
        let(:models) { Model.in(Time.now-2.days, Time.now) }

        it "should return a model with available_devices smaller then total_devices" do
          models.any?{ |model| model.available_devices < model.total_devices }.should be
        end
      end
    end
  end

  describe "#==" do
    let(:model) { Model.new }

    context "when other is nil" do
      it "should return false" do
        (model == nil).should_not be
      end
    end

    context "when other is from another class" do
      it "should return false" do
        (model == Device.new).should_not be
      end
    end

    context "when other is from the same class" do
      context "when other model has same model, kind and company" do
        it "should return true" do
          (model == Model.new).should be
        end
      end

      context "when other model has a different model, kind or company" do
        it "should return false" do
          (model == Model.new('different')).should_not be
        end
      end
    end
  end
end
