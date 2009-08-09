class BoardsController < ApplicationController
  # These actions refer to an existing board, load it.
  before_filter :load_board, :only => %w(show edit update delete)

  def index
    @boards = Board.find(:all)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  # Load an existing board
  def load_board
    @board = Board.find(params[:id].to_i)
  end
end
