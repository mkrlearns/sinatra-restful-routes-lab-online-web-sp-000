class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get('/recipes') {@recipes = Recipe.all; erb :index}
  get('/recipes/new') {erb :new}
  get('/recipes/:id') {@recipes = Recipe.find_by_id(params[:id]); erb :show}
  get('/recipes/:id/edit') {@recipes = Recipe.find_by_id(params[:id]); erb :edit}
  post('/recipes') {@recipes = Recipe.create(params); redirect to "/recipes/#{@recipe.id}"}
  delete('/recipes/:id') {Recipe.find_by_id(params[:id]).delete; redirect to "/recipes"}

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

end
