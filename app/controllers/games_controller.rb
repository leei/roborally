class GamesController < ApplicationController
  private
  before_filter :load_game, :only => %w(show edit update destroy)
  before_filter :check_host, :only => %w(edit update destroy)

  #
  # Load a Game object (by params[:id])
  #
  def load_game
    @game = Game.find_by_id(params[:id])
    unless @game
      render( :status => :not_found, :text => "Game not found.")
      return false
    end
    return true
  end

  #
  # Ensure that the board we loaded is editable for this action.
  #
  def check_host
    unless @game.host == current_user
      render( :status => :unauthorized,
              :text => "Cannot %s a game you didn't create." % params[:action])
      return false
    end
    return true
  end

  public
  def index
    options = { :order => "games.created_at DESC" }
    if params[:host]
      options[:conditions] = { :host_id => params[:host] }
    end
    options[:page] = (params[:page] || 1).to_i
    options[:per_page] = 20

    @games = Game.paginate(:all, options)
  end

  def show
  end

  def new
    @game = current_user.new_game
    if @game
      @game.attributes = params[:game]
    else
      flash[:error] = "Can only be a player in one game at a time."
      redirect_to :back
    end
  end

  def create
    @game = current_user.new_game
    @game.attributes = params[:game]

    if @game.save
      redirect_to game_url(@game)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    @game.attributes = params[:game]

    if @game.save
      redirect_to game_url(@game)
    else
      render :action => :edit
    end
  end

  def destroy
    @game.destroy

    if @game.frozen?
      redirect_to :back
    else
      redirect_to game_url(@game)
    end
  end
end
