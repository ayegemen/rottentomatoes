require ('spec_helper')

describe Movie do
  describe "searching Movie for same Director" do
    it "movie object call same_director" do
      movie = create(:movie, title: "james bond", director: "tom jones")
      movie.director_movies.should eq([movie])
    end
  end
end
