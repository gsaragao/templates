# encoding : utf-8
class <%= controller_class_name %>Controller < ApplicationController

  respond_to :html
  layout "application", :except  => [:show]
  before_filter :setar_classe_menu
  before_filter :carrega_<%= singular_table_name %>, :only  => [:show, :edit, :update, :destroy]

  def index
     @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
     @<%= plural_table_name %> = <%= controller_class_name %>.pesquisa(@<%= singular_table_name %>.descricao)
    respond_with @<%= plural_table_name %>
  end 

  def show
    respond_with @<%= singular_table_name %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with @<%= singular_table_name %>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    
    if @<%= orm_instance.save %>
      flash[:notice] = t('msg.create_sucess')
      redirect_to <%= plural_table_name %>_path
    else
      render :action => :new 
    end
  end

  def update
    if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
      flash[:notice] = t('msg.update_sucess')
      redirect_to <%= plural_table_name %>_path
    else
      render :action => :edit
    end
 end

  def destroy
    @<%= orm_instance.destroy %>
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to <%= plural_table_name %>_path
  end
  
  private

  def setar_classe_menu
    @class_<%= singular_table_name %> = 'selected'  
  end
  
  def carrega_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= controller_class_name %>.find(params[:id])
  end
  
end
