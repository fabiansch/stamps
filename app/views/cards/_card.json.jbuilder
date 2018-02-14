json.extract! card, :id, :stamps_count, :name, :description, :exploited, :company_id, :created_at, :updated_at
json.url card_url(card, format: :json)
