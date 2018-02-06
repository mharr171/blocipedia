class WikisController < ApplicationController
  # before_action :authenticate_user!, except: [:index]
  before_action :authenticate_user!, except: %i[index show]
  # after_action :verify_authorized

  def index
    set_wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    set_show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = 'Wiki was saved.'
      redirect_to [@wiki]
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    set_show
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = 'Wiki was updated.'
      redirect_to [@wiki]
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def set_wikis
    temp_wikis = Wiki.all
    @wikis = []
    temp_wikis.each do |wiki|
      if wiki.private == false
        @wikis << wiki
      elsif policy(User).admin?
        @wikis << wiki
      elsif wiki.user == current_user
        @wikis << wiki
      else
        wiki.collaborators.each do |collab|
          @wikis << wiki if collab.user == current_user
        end
      end
    end
  end

  def set_show
    @show = false
    if current_user
      @show = true if @wiki.user == current_user
      @show = true if @wiki.user == current_user.admin?
      @wiki.collaborators.each do |collab|
        @show = true if collab.user == current_user
      end
    end
    @show = true if current_user.nil? && (@wiki.private == false)
  end
end
