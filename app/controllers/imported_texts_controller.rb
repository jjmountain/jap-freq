class ImportedTextsController < ApplicationController
  before_action :set_imported_text, only: [:show, :edit, :update, :destroy]

  # GET /imported_texts
  # GET /imported_texts.json
  def index
    @imported_texts = ImportedText.all
  end

  # GET /imported_texts/1
  # GET /imported_texts/1.json
  def show
  end

  # GET /imported_texts/new
  def new
    @imported_text = ImportedText.new
  end

  # GET /imported_texts/1/edit
  def edit
  end

  # POST /imported_texts
  # POST /imported_texts.json
  def create
    @imported_text = ImportedText.new(imported_text_params)

    respond_to do |format|
      if @imported_text.save
        format.html { redirect_to @imported_text, notice: 'Imported text was successfully created.' }
        format.json { render :show, status: :created, location: @imported_text }
      else
        format.html { render :new }
        format.json { render json: @imported_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imported_texts/1
  # PATCH/PUT /imported_texts/1.json
  def update
    respond_to do |format|
      if @imported_text.update(imported_text_params)
        format.html { redirect_to @imported_text, notice: 'Imported text was successfully updated.' }
        format.json { render :show, status: :ok, location: @imported_text }
      else
        format.html { render :edit }
        format.json { render json: @imported_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imported_texts/1
  # DELETE /imported_texts/1.json
  def destroy
    @imported_text.destroy
    respond_to do |format|
      format.html { redirect_to imported_texts_url, notice: 'Imported text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imported_text
      @imported_text = ImportedText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imported_text_params
      params.require(:imported_text).permit(:title, :content)
    end
end
