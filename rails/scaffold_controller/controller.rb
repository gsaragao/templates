# encoding : utf-8
class <%= controller_class_name %>Controller < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_<%= singular_table_name %> , :only => [:show, :edit, :update, :destroy]

  def index
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    @<%= plural_table_name %> = <%= singular_table_name.capitalize %>.pesquisar(params[:<%= singular_table_name %>],params[:page])
    respond_with @<%= plural_table_name %>
  end

  def show
    respond_with @<%= singular_table_name %>
  end

  def new
    load_combos
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with @<%= singular_table_name %>
  end

  def edit
    load_combos
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    
    if @<%= orm_instance.save %>
      flash[:notice] = t('msg.create_sucess')
      redirect_to <%= plural_table_name %>_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
      flash[:notice] = t('msg.update_sucess')
      redirect_to <%= plural_table_name %>_path
    else
      load_combos
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
    @class_<%= singular_table_name %> = 'active'  
  end
  
  def load_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:<%= singular_table_name %>].nil?) 
       params[:<%= singular_table_name %>].delete_if{|k,v| v.blank?}
    end
  end
  
end
