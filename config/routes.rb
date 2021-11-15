Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 練習用
  get "/", to: "pages#index"
  # root "pages#index"
  # 開一個新的 about
  get "/about", to: "pages#about"

  # hahow 網頁製作
  get "/sign_up", to: "users#sign_up"
  get "/sign_in", to: "users#sign_in"
  post "/account_verify", to: "users#account_verify"
  post "/sign_in/check", to: "users#check"
end
