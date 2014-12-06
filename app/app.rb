module WhereToGo
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions
    set :bind, '192.168.2.38'

    get "/" do
      "Hello World!"
    end

    get :about, :map => '/about_us' do
      render :haml, "%p This is a sample blog created to demonstrate how Padrino works!"
    end
  end
end
