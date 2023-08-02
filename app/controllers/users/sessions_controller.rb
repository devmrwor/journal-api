# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      if request.format.json?
        render json: {
          user: user,
          token: JWT.encode({
            user_id: user.id,
            username: user.username,
          }, ENV['DEVISE_JWT_SECRET_KEY'], 'HS256')
        } and return
      end
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    if request.format.json?
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

end
