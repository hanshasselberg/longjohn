require 'spec_helper'

describe EquipmentReservation do
  describe ".in" do
    context "when providing no date" do
      let(:reservations) { EquipmentReservation.in(nil, nil) }

      it "works" do
        reservations.should be
      end
    end

    context "when providing from" do
      pending
    end

    context "when providing to" do
      pending
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
end
