# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  private

  def authenticate_user!
    token = extract_token_from_header
    raise JWT::DecodeError, I18n.t("errors.auth.token_missing") unless token

    @current_user = decode_token(token)
    raise ActiveRecord::RecordNotFound, I18n.t("errors.auth.user_not_found") unless @current_user
  end

  def decode_token(token)
    payload, = JWT.decode(token, Rails.application.secret_key_base, true, {algorithm: "HS256"})
    User.find(payload["sub"])
  end

  def extract_token_from_header
    request.headers["Authorization"]&.split&.last
  end

  def current_user
    @current_user
  end
end
