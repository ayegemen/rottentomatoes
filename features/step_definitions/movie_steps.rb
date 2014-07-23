Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

#When /^(?:|I )go to (.+) for "(.*)"$/ do |page, movie|
#  step "I go to #{page}"
#  m = Movie.find_by_title(movie) 
#  visit edit_movie_path(m.id)
#end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie, director|
  pending
end


