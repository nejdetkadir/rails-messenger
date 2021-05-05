module ApplicationHelper

  def add_participants_list(user, room)
    data = []

    user.friends.each do |f|
      if !room.participants.where(user_id: f.id).first
        data.push(f)
      end
    end

    data
  end
end
