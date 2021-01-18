Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "search/bands-fast",
    to: "searchers#bands_fast",
    as: "search_bands_fast"

  get "search/bands",
    to: "searchers#bands_all",
    as: "search_bands_all"

  get "songs/list",
    to: "songs#list",
    as: "list_songs"

  get "band/:slug",
    to: "bands#show",
    as: "show_band"

end
