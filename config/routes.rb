Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "search/bands",
    to: "searchers#bands",
    as: "search_bands"

  get "songs/list",
    to: "songs#list",
    as: "list_songs"

end
