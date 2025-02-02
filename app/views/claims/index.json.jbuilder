json.claims @claims do |claim|
  json.id claim.id
  json.description claim.description
  json.amount claim.amount
  json.date claim.date
  json.status claim.status
  json.user_id claim.user_id
  json.location claim.location
  json.created_at claim.created_at
  json.updated_at claim.updated_at
  json.receipts claim.receipts.map(&:url)
end
