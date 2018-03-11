class Api::PagesController < Api::ApplicationController
  def home
      cards = []
      current_user.cards.each do |card|
        cards.insert(-1, {card: card, current_stamps: card.stamps.where(user: current_user).count})
      end
      respond_with cards
  end
end
