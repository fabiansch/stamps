class Api::PagesController < Api::ApplicationController
  def home
      cards = []
      current_user.cards.each do |card|
        stamps = card.stamps.where(user: current_user)
        cards.insert(-1, {card: card,
                          current_stamps: stamps.count,
                          newest_stamp: stamps.order(:created_at).last.created_at})

      end
      cards = cards.sort_by{|c| c[:newest_stamp]}
      cards.reverse!

      respond_with cards
  end
end
