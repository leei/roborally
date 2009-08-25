class BoardsController < ApplicationController
  # These actions refer to an existing board, load it.
  before_filter :load_board, :only => %w(show edit update destroy)

  before_filter :check_editable, :only => %w(edit update destroy)

  before_filter :require_user, :only => %w(new)

  def index
    conds = { }
    conds[:creator_id] = params[:creator] if params[:creator]
    @boards = Board.find(:all, :conditions => conds )
  end

  def show
  end

  def new
    @board = Board.new(:max_players => 4)
  end

  def create
    # Grab the size parameters and remove them from attributes list.
    rows = (params[:board].delete(:rows) || 12).to_i
    cols = (params[:board].delete(:columns) || 12).to_i

    @board = Board.new(params[:board])

    @board.clear_layout(cols, rows)
    @board.creator = current_user

    if @board.save
      redirect_to edit_board_url(@board)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    @board.attributes = params[:board]
    if @board.save
      redirect_to board_url(@board)
    else
      render :action => :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_url()
  end

  private
  # Load an existing board
  def load_board
    @board = Board.find(params[:id].to_i)
    if !@board
      render( :status => :not_found, :text => "Board not found.")
      return false
    end
    return true
  end

  #
  # Ensure that the board we loaded is editable for this action.
  #
  def check_editable
    if !@board.can_edit?(current_user)
      render( :status => :unauthorized,
              :text => "Cannot %s a board you didn't create." % params[:action])
      return false
    end
    return true
  end
end
