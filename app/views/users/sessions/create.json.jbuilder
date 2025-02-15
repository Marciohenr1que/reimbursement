# frozen_string_literal: true

json.message I18n.t("users.sessions.login_success")
json.user do
  json.id @user.id
  json.email @user.email
  json.created_at @user.created_at
  json.updated_at @user.updated_at
  json.role @user.role
  json.name @user.name
end
json.token @token
