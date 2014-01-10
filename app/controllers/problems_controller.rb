class ProblemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @problem = Problem.new
  end
end
