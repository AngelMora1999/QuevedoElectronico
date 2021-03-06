class AdsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :premiun, :top, :sell]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all.ultimos
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad.update_visit_count
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
    if current_user == @ad.user || current_user.is_admin?
    else
      redirect_to premiun_path, notice: "Usted no es el dueño de la publicación"
    end
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = current_user.ads.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Mis metodos
  def premiuns
    @ads = Ad.all.ultimos.premiuns
  end

  def tops
    @ads = Ad.all.ultimos.tops
  end

  def populares
    @ads = Ad.all.populares.ultimos.activo
  end

  def nuevos
    @ads = Ad.all.ultimos.nuevos.activo
  end

  def usados
    @ads = Ad.all.ultimos.usados.activo
  end

  def economicos
    @ads = Ad.all.economicos.ultimos.activo
  end

  def caros
    @ads = Ad.all.caros.ultimos.activo
  end

  def vendidos
    @ads = Ad.all.selled.ultimos
  end

  #Publicidad
  def publicidad
  end

  #Metodos para AASM
  def premiun
    @ad.premiun!
    redirect_to @ad
  end

  def top
    @ad.top!
    redirect_to @ad
  end
  
  def sell
    @ad.sell!
    redirect_to @ad
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:title, :description, :brand, :price, :state, :visit_count, :region, :city, :cellphone, :phone, :adress, :status, :cover)
    end
end
