class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get('/recipes/new') do
    erb(:new)
  end

  get('/recipes') do
    @recipes = Recipe.all
    erb(:index)
  end

  get('/recipes/:id') do
    @recipe = Recipe.find_by_id(params[:id])
    erb(:show)
  end

  get('/recipes/:id/edit') do
    @recipe = Recipe.find_by_id(params[:id])
    erb(:edit)
  end

  patch('/recipes/:id') do
    # tests didn't like my code
    # @temp = Recipe.find_by_id(@recipe.id)
    # @temp.update(name: params[:recipe_name], ingredients: params[:ingredients], cooking_time: params[:cooking_time])
    # redirect_to "/recipes/#{@temp.id}"
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect_to "/recipes/#{@recipe.id}"
  end

  post('/recipes') do
    @recipe = Recipe.create(params)
    redirect_to "/recipes/#{@recipe.id}"
  end

  delete('/recipes/:id') do
    Recipe.destroy(@recipe.id)
    redirect_to "/index.erb"
  end

end
