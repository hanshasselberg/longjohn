require 'spec_helper'

describe Admin::MiscController do
  describe "POST create_studio_cookie" do
    before do
      controller.expects(:requires_admin).returns(true)
      cookies[:studio] = nil
      post :create_studio_cookie
    end

    it "sets cookie with rand" do
      cookies[:studio].should be
    end
  end

  describe ".rand" do
    it "contains number" do
      controller.rand.should be
    end
  end
end
