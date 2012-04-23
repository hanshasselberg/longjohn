class Admin::MiscController < ApplicationController
  before_filter :requires_admin

  expose(:rand) { SecureRandom.hex }

  def create_studio_cookie
    cookies[:studio] = rand
    REDIS.set("longjohn:studio", rand)
    redirect_to admin_misc_index_path
  end
end
