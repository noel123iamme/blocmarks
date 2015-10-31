class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
  end

  def new
    @topic = Topic.new
    @topic.user = current_user
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to topics_path
    else
      flash[:error] = "Error saving topic, please try again."
      redirect_to topics_path 
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated successfully."
      redirect_to topics_path
    else
      flash[:error] = "Topic was not updated. Please try again."
      redirect_to topics_path
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    title = @topic.title
    if @topic.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic. Please try again."
      render :show
    end
  end
  
  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
