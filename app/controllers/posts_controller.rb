class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :saved]
    before_action :authenticate_user!, only: [:new, :edit, :upvote, :downvote, :saved]

    def index
        @posts = Post.all.order('created_at DESC')
                     .paginate(page: params[:page], per_page: 3)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id

        if @post.save
            flash[:success] = 'Post created successfully!'
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def edit
    end

    def show
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    def update
        if @post.update(post_params)
            redirect_to posts_path
        else
            render 'edit'
        end
    end

    def upvote
        @post.upvote_by current_user
        redirect_back(fallback_location: root_path)
    end

    def downvote
        @post.downvote_by current_user
        redirect_back(fallback_location: root_path)
    end

    def saved
        @post.upsaved_by current_user
        redirect_to post_path(@post)
    end

    private

    def post_params
        params.require(:post).permit(:title, :content, :image)
    end

    def find_post
        @post = Post.find(params[:id])
    end
end
