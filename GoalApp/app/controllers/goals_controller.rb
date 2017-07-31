class GoalsController < ApplicationController
  def index
    @users = User.all
  end
end
