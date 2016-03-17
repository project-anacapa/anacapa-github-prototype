Rails.application.routes.draw do

  resources :students do
    member do
      # POST /students/:id/courses
      post 'courses', :to => "students#add_course", :as => :add_course_to
    end
  end
 resources :courses do
    member do
      get 'roster', :to => "courses#edit_roster", :as => :edit_roster
      post 'roster', :to => "courses#add_student", :as => :add_student
      delete 'roster', :to => "courses#remove_student", :as => :remove_student
      post 'import_students', :to => "courses#csv_course_roster", :as => :import_students
      get 'export_roster', :to => "courses#export_course_roster_csv", :as => :export_roster
    end
  end
  resources :admin_panel do
    member do
      # POST /admin_panel/toggle_admin/:id
      post 'toggle_admin', :to => 'admin_panel#toggle_admin', :as => :toggle_admin
      post 'toggle_instructor', :to => 'admin_panel#toggle_instructor', :as => :toggle_instructor
    end
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
