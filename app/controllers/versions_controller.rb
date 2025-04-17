class VersionsController < ApplicationController
  before_action :set_version, only: %i[ show edit update destroy make_default ]

  # GET /versions or /versions.json
  def index
    @versions = Version.all
  end

  # GET /versions/1 or /versions/1.json
  def show
  end

  # GET /versions/new
  def new
    @version = Version.new
  end

  # GET /versions/1/edit
  def edit
  end

  # POST /versions or /versions.json
  def create
    @version = Version.new(version_params)

    respond_to do |format|
      if @version.save
        format.html { redirect_to version_url(@version), notice: "Version was successfully created." }
        format.json { render :show, status: :created, location: @version }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versions/1 or /versions/1.json
  def update
    # Only allow update of name, description, and link
    params.require(:version).permit(:name, :description, :link)
    respond_to do |format|
      if @version.update(version_params)
        format.html { redirect_to version_url(@version), notice: "Version was successfully updated." }
        format.json { render :show, status: :ok, location: @version }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versions/1 or /versions/1.json
  def destroy
    folder_id = @version.folder_id
    @version.destroy!

    respond_to do |format|
      format.html { redirect_to folder_url(folder_id), notice: "Version was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Make default GET /versions/:id/make_default
  def make_default
    folder_id = @version.folder_id
    @folder = Folder.find(folder_id)
    @folder.default_version = @version

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_url(folder_id), notice: "Default version was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def version_params
      params.require(:version).permit(:user_id, :folder_id, :name, :description, :link)
    end
end
