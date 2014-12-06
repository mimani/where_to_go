module SampleBlog
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    get "/" do
      "Hello World!"
    end

    get :about, :map => '/about_us' do
      render :haml, "%p This is a sample blog created to demonstrate how Padrino works!"
    end
  end
end
