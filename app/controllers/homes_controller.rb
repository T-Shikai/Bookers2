class HomesController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}


  def top
  end

  def about
  end
end
