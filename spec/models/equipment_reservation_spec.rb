require 'spec_helper'

describe EquipmentReservation do
  describe ".in" do
    context "when providing no date" do
      let!(:reservation_one) { EquipmentReservation.create }
      let!(:reservation_two) { EquipmentReservation.create }
      let(:reservations) { EquipmentReservation.in(nil, nil) }

      it "returns everything" do
        reservations.should == EquipmentReservation.all
      end
    end

    context "when providing from" do
      let(:from) { Time.now-5.days }
      let!(:reservation_one) { EquipmentReservation.create from: from }
      let!(:reservation_two) { EquipmentReservation.create from: from-2.days }
      let(:reservations) { EquipmentReservation.in(from, nil) }

      it "returns reservation one" do
        reservations.should == [reservation_one]
      end
    end

    context "when providing to" do
      let(:to) { Time.now-5.days }
      let!(:reservation_one) { EquipmentReservation.create to: to-1 }
      let!(:reservation_two) { EquipmentReservation.create to: to+2.days }
      let(:reservations) { EquipmentReservation.in(nil, to) }

      it "returns reservation one" do
        reservations.should == [reservation_one]
      end
    end

    context "when providing from and to" do
      context "when there are no reservations" do
        let(:reservations) { EquipmentReservation.in(Time.now-10.days, Time.now).entries }
        it "returns an empty array" do
          reservations.should be_empty
        end
      end

      context "when there is a reservation touching the start" do
        let!(:reservation_one) { EquipmentReservation.create(from: Time.now-5.hours, to: Time.now-1.hour)}
        let(:reservations) { EquipmentReservation.in(Time.now-1.day, Time.now).entries }

        it "includes the reservation" do
          reservations.should include(reservation_one)
        end
      end

      context "when there are two reserverations, one touching, the other not" do
        let!(:reservation_one) { EquipmentReservation.create(from: Time.now-5.hours, to: Time.now-1.hour)}
        let!(:reservation_two) { EquipmentReservation.create(from: Time.now-3.days, to: Time.now-3.days)}
        let(:reservations) { EquipmentReservation.in(Time.now-1.day, Time.now).entries }

        it "includes the correct reservation" do
          reservations.should include(reservation_one)
        end
        it "shouldn't include the other reservation" do
          reservations.should_not include(reservation_two)
        end
      end

      context "when there are multiple reservations" do
        let!(:reservation_one) { EquipmentReservation.create(from: Time.now-5.hours, to: Time.now-1.hour)}
        let(:reservations) { EquipmentReservation.in(Time.now-1.day, Time.now).entries }

        it "returns every reservation only once" do
          reservations.should == reservations.uniq
        end
      end
    end
  end

  describe "#reservation_entries" do
    let(:reservation_entry_one) { { count: 1, model: 'A', company: 'B', kind: 'C' } }
    let(:reservation_entry_two) { { count: nil, model: 'A', company: 'B', kind: 'C' } }
    let(:reservation_entries) { [reservation_entry_one, reservation_entry_two] }
    let(:reservation) { EquipmentReservation.new }

    context "when providing an array of reservations" do
      before do
        reservation.reservation_entries = reservation_entries
      end

      it "creates one reservation" do
        reservation.reservations.should have(1).items
      end
    end
  end

  describe "#pickups" do
    let!(:device) { Device.create(kind: 'A', company: 'B', model: 'C', barcode: '$barcode$') }
    let(:reservation_entry) { { count: 1, 'model' => device.model, 'company' => device.company, 'kind' => device.kind } }
    let(:reservation) { EquipmentReservation.new(reservations: [reservation_entry]) }
    let!(:old_reservations) { reservation.reservations }

    context "when providing nil" do
      before do
        reservation.pickups = nil
      end

      it "doesn't change" do
        reservation.reservations.should eq(old_reservations)
      end
    end

    context "when providing an empty array" do
      before do
        reservation.pickups = []
      end

      it "doesn't change" do
        reservation.reservations.should eq(old_reservations)
      end
    end

    context "when providing an array with an invalid barcode" do
      before do
        reservation.pickups = ['INVALID BARCODE']
      end

      it "doesn't change" do
        reservation.reservations.should eq(old_reservations)
      end
    end

    context "when providing an array with a valid barcode" do
      before do
        reservation.pickups = [device.barcode]
      end

      it "adds the barcode to the correct reservation" do
        reservation.reservations.should include(reservation_entry.merge('pickups' => [device.barcode]))
      end
    end

    context "when providing duplicate barcodes" do
      before do
        reservation.pickups = [device.barcode, device.barcode]
      end

      it "adds only one barcode" do
        reservation.reservations.should include(reservation_entry.merge('pickups' => [device.barcode]))
      end
    end
  end
end
