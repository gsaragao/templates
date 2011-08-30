# encoding : utf-8
class <%= controller_class_name %>Controller < ApplicationController

respond_to :html

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with @<%= plural_table_name %>
  end

  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with @<%= singular_table_name %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with @<%= singular_table_name %>
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
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
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
      flash[:notice] = t('msg.update_sucess')
      redirect_to <%= plural_table_name %>_path
    else
      render :action => :edit
    end
end

  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to <%= plural_table_name %>_path
  end
end
