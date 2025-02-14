# frozen_string_literal: true

json.claims @claims do |claim|
  json.id claim.id
  json.description claim.description
  json.amount claim.amount
  json.date claim.date
  json.status claim.status
  json.user_name claim.user.name
  json.location claim.location
  json.receipts(claim.receipts.map { |receipt| url_for(receipt) })
  json.tags(claim.tags.map { |tag| {id: tag.id, name: tag.name} })
end
