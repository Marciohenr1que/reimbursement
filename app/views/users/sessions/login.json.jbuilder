# frozen_string_literal: true

json.message I18n.t("users.sessions.login_success")
json.user do
  json.id resource.id
  json.email resource.email
  json.created_at resource.created_at
  json.updated_at resource.updated_at
  json.role resource.role
  json.name resource.name
end
json.token request.env["warden-jwt_auth.token"]
