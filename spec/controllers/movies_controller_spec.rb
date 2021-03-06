require 'spec_helper'

describe MoviesController do
  #render_views
  let(:movie) { FactoryGirl.create(:movie) }
  let(:movie_list){[movie, FactoryGirl.build(:movie,title: "yes man")]}
  let(:wrongmovie){ FactoryGirl.create(:movie, director: nil)}
  
  describe "GET :samedirector" do
    #before :each do
    #movie.stub(:id).and_return('1')
    #Movie.stub(:find).and_return(movie)
    #get :samedirector, id: "1"
    #end

    it "responds successfully with an HTTP 200 status code" do
      get :samedirector, id: movie.id
      expect(response).to be_success
      expect(response.response_code).to eq(200)
    end
    
    it "sends the correct params to controller" do
      #controller.stub(:params).and_return({"id"=>"1", "controller"=>"movies", 
      #"action"=>"samedirector"})
      get :samedirector, id: movie.id
      expect(controller.params["id"]).to eq("1")
    end

    it "sets @movie to given param[:id]" do
      #movie = build(:movie, director: "james")
      #movie.stub(:id).and_return(1)
      #Movie.stub(:find).and_return(movie)
      #get :samedirector, id: "1"
      #debugger
      Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
      get :samedirector, id: movie.id
      
      expect(assigns(:movie)).to eq(movie)
    end
    
  
    context "movie.director field is valid" do
      #before :each do
      #  
      #end
      
      it "checks that director field is set" do
        get :samedirector, id: movie.id
        expect(movie.director).to_not be_blank
      end
        
        
      it "calls the director_movies method of movie" do
        #Movie.stub(:find_all_by_director).with(movie.director).and_return(movie_list)
        #Movie.should_receive(:find_all_by_director).with(movie.director).and_return(movie_list)
        #get :samedirector, id: movie.id
       
        #movie.stub(:director_movies).and_return(movie_list)
        #movie.director_movies.should eq(movie_list)
        Movie.any_instance.should_receive(:director_movies)
        get :samedirector, id: movie.id
        #expect(assigns(:simmov)).to eq(movie_list)
        #expect(Movie).to receive(:find_all_by_director).with(movie.director).and_return(movie_list)
        #  Movie.stub(:find_all_by_director).with(movie.director).and_return(movie_list)
      end

      it "new @dirmov contains the list of filtered movies" do
        Movie.any_instance.stub(:director_movies).and_return(movie_list)
        get :samedirector, id: movie.id
        expect(assigns(:dirmov)).to eq(movie_list)
      end
      
      it "renders the samedirector template" do
        get :samedirector, id: movie.id
        expect(response).to render_template(:samedirector)
      end
    end
    context "movie.director is not valid" do
      
      it "check movie.director not valid" do
        get :samedirector, id: wrongmovie.id
        expect(wrongmovie.director).to be_blank
      end

      it "redirects to index page" do
        get :samedirector, id: wrongmovie.id
        response.should redirect_to(movies_path)
      end
      
    end
  end
  
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('hardware').and_return(movie_list)
      post :search_tmdb, {:search_terms => 'hardware'}
    end
    describe 'after valid search' do
      it 'should select the Search Results template for rendering' do
        Movie.stub(:find_in_tmdb).and_return(movie_list)
        post :search_tmdb, {:search_terms => 'hardware'}
        response.should render_template('search_tmdb')
      end
      it 'should make the TMDb search results available to that template' do
        Movie.stub(:find_in_tmdb).and_return(movie_list)
        post :search_tmdb, {:search_terms => 'hardware'}
        debugger
        expect(assigns(:movies)).to eq(movie_list)
      end
    end
  end
end
