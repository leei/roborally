module GamesHelper
  def game_links
    links = [link_to "All", games_path()]
    links << link_to("Mine", games_path(:host => current_user.id))
    links.join(", ")
  end
end
