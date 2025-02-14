# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity
    rescue_from JWT::DecodeError, with: :handle_invalid_token
    rescue_from StandardError, with: :handle_internal_server_error
  end

  private

  def handle_not_found(exception)
    render json: {error: I18n.t("errors.not_found"), details: exception.message}, status: :not_found
  end

  def handle_unprocessable_entity(exception)
    render json: {error: I18n.t("errors.unprocessable_entity"), details: exception.message},
      status: :unprocessable_entity
  end

  def handle_invalid_token(exception)
    render json: {error: I18n.t("errors.invalid_token"), details: exception.message}, status: :unauthorized
  end

  def handle_internal_server_error(exception)
    Rails.logger.error("Erro interno: #{exception.message}")
    render json: {error: I18n.t("errors.internal_server_error"), details: exception.message},
      status: :internal_server_error
  end
end
