class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    #puts "INCOMING PARAMS HERE: #{params}"


    @user = User.find_by(email: params[:return-path])
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]     

    if @user.nil?
      user = User.new(
        name:     params[:return-path], 
        email:    params[:return-path],
        password: 'helloworld'
      )
      user.skip_confirmation!
      user.save!     
    end

    if @topic.nil?
      topic = Topic.new(
        title:    params[:subject],
        user:     user  
      )
      topic.save!
    end

    @bookmark = Bookmark.find_by(url: @url)
    if @bookmark.nil?
      bookmark = Bookmark.new(
        topic:    topic,
        url:      @url
      )
      bookmark.save!
    end


    head 200
  end
end