class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    
    
    if !params[:pet][:owner_id]
      @owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.create(name: params[:pet][:name], owner: @owner)
    else
      @pet = Pet.create(name: params[:pet][:name], owner: Owner.find(params[:pet][:owner_id]))
    end
    redirect to "pets/#{@pet.id}"
  end
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if params[:owner][:name] == ""
      @pet.update(params[:pet])
    else
      
      params[:pet][:owner_id] = Owner.create(name: params[:owner][:name]).id
      
      @pet.update(params[:pet])
    end
    redirect to "pets/#{@pet.id}"
  end
end