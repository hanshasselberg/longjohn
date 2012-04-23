require "spec_helper"

describe ApplicationController do
  describe ".in_studio?" do
    let(:in_studio) { controller.in_studio? }

    context "when cookie not set" do
      before { cookies[:studio] = nil }

      context "when no admin" do
        it "returns false" do
          in_studio.should be_false
        end
      end

      context "when admin" do
        before do
          session[:user_id] = 1
          User.expects(:find).returns(User.new(admin: true))
        end

        it "returns true" do
          in_studio.should be_true
        end
      end
    end

    context "when cookie set" do
      before do
        REDIS.set("longjohn:studio", "123")
        cookies[:studio] = "123"
      end

      it "returns true" do
        in_studio.should be_true
      end
    end
  end
end
