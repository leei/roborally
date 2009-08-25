module BoardsHelper
  def board_links
    links = [link_to "All", boards_url()]
    links << link_to("Mine", boards_url(:creator => current_user.id))
    links.join(", ")
  end

  def board_operations(board, user)
    if board.can_edit?(user)
      [link_to( "Edit", edit_board_url(board)),
       link_to( "Delete", board_url(board),
                :method => :delete,
                :confirm => ("Are you sure you want to delete board '%s'?" % board.name) )].join(", ")
    end
  end
end
