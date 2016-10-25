json.extract! user, :id, :slug, :email, :created_at, :updated_at
json.url user_url(user, format: :json)