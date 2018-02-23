json.extract! transaction, :id, :count, :card_id, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
