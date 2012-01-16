require 'spec_helper'

describe Device do
  describe ".entries_of" do
    context "when asked for company" do
      let(:companies) { Device.entries_of(:company, condition) }

      context "when no condition given" do
        let(:condition) { nil }

        context "when there are no devices" do
          it "returns an empty list" do
            companies.should be_empty
          end
        end

        context "when there are devices with different companies" do
          let!(:devices) { [Device.create(company: 'A'), Device.create(company: 'B')] }

          it "returns a list of their companies" do
            companies.should == devices.map(&:company)
          end
        end

        context "when there are devices with same companies" do
          let!(:devices) { [Device.create(company: 'A'), Device.create(company: 'A')] }

          it "returns a uniq list of their companies" do
            companies.should == devices.map(&:company).uniq
          end
        end
      end

      context "when condition kind: 'A' given" do
        let(:condition) { {kind: 'A'} }

        context "when there are no devices" do
          it "returns an empty list" do
            companies.should be_empty
          end
        end

        context "when there are devices matching the condition" do
          let!(:device_one) { Device.create(kind: 'A', company: 'A') }
          let!(:device_two) { Device.create(kind: 'B') }
          let!(:devices) { [device_one, device_two] }

          it "retuns list of companies of matching devices" do
            companies.should == [device_one.company]
          end
        end
      end
    end
  end
end
