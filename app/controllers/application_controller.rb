class ApplicationController < Sinatra::Base
  configure {set :public_folder, 'public'; set :views, 'app/views'}

  get('/recipes') {@recipes = Recipe.all; erb :index}
  get('/recipes/new') {erb :new}
  get('/recipes/:id') {@recipe = Recipe.find_by_id(params[:id]); erb :show}
  get('/recipes/:id/edit') {@recipe = Recipe.find_by_id(params[:id]); erb :edit}
  post('/recipes') {@recipe = Recipe.create(params); redirect to "/recipes/#{@recipe.id}"}
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
