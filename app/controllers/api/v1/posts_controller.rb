class Api::V1::PostsController < ApplicationController
  before_action :check_jwt, only: %i[ create update destroy ]
  before_action :set_post, only: %i[ show update destroy ]
  before_action :set_cors_headers, except: :options

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts?label=idea
  def index_by_label
    @posts = Post.where(label: params[:label])

    render json: @posts
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])

    render json: @post
  end

  # GET /posts?date=2021-01-01
  def show_by_date
    date = Date.parse(params[:date])
    date_range = date.beginning_of_day..date.end_of_day
    @post = Post.find_by(created_at: date_range)

    render json: @post
  end


  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: api_v1_post_path(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :label, :created_at)
    end

    def set_cors_headers
      origin = Rails.env.production? ? 'https://journal-frontend-smoky.vercel.app' : 'http://localhost:4000'


      response.headers['Access-Control-Allow-Origin'] = origin
      response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
      response.headers['Access-Control-Allow-Credentials'] = 'true'
    end

    def check_jwt
      auth_header = request.headers['Authorization']
      token = auth_header&.split(' ')&.last

      if token
        begin
          decoded_token = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'], true, algorithm: 'HS256')
          payload = decoded_token.first
          user_id = payload['user_id']

          @current_user = User.find(user_id)
        rescue JWT::DecodeError
          render json: { error: 'Invalid token' }, status: :unauthorized
        end
      else
        render json: { error: 'Token missing' }, status: :unauthorized
      end
    end
end
