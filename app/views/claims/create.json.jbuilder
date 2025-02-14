# frozen_string_literal: true

json.message I18n.t("claims.create.success")
json.claim do
  json.id @claim.id
  json.amount @claim.amount
  json.description @claim.description
  json.status @claim.status
  json.date @claim.date
  json.location @claim.location
end
