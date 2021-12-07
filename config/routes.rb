Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # api

  root "courses#index"
  
  namespace :api do
    namespace :v1 do
      resources :courses, only: [] do
        member do
          # /api/v1/courses/2/like
          post :like
        end
      end
    end
  end

  #課程和 review 評論
  resources :courses do
    member do
      get :buy
    end
    resources :reviews, only: [:create] # 建出 course_reviews_path, /courses/:course_id/reviews(.:format)
    resources :orders, only: [:create]  # POST /courses/2/orders
  end
  resources :reviews, only: [:destroy] # 建出 review_path, courses#destroy, /reviews/:id(.:format)

  # 首頁轉到課程首頁
  get "/", to: "courses#index"
  # root "pages#index"
  # 開一個新的 about
  get "/about", to: "pages#about"

  # hahow 網頁製作
  get "/sign_up", to: "users#sign_up"
  get "/sign_in", to: "users#sign_in"
  post "/account_verify", to: "users#account_verify"
  post "/sign_in/check", to: "users#check"
  delete "/sign_out", to: "users#sign_out"
end
