require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context "GET/albums/:id" do 
    it "should return info about album 1" do 
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Surfer Rosa </h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end
  

  context "GET/ albums" do
    it "should return the list of albums" do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Albums </h1>')
      expect(response.body).to include('<div>\n    \n    \n  Title: Surfer Rosa Released: 1988')
      expect(response.body).to include('Title: Waterloo Released: 1974')
      expect(response.body).to include('Title: Super Trouper Released: 1980')
      expect(response.body).to include('Title: Bossanova Released: 1990')
      expect(response.body).to include('Title: Lover Released: 2019')
    end
  end

  context "POST/ albums" do
    it "returns 200 OK with the right content" do
      response = post(
        "/albums",
        title: "Voyage",
        release_year: "2022",
        artist_id: "2"
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Voyage')
    end
  end

  context "GET/ artists" do
    it "returns 200 OK with the right content" do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")
    end
  end


  context "POST/ artists" do
    it "returns 200 OK with the right content" do
      response = post(
        "/artists",
        name: "Wild nothing",
        genre: "Indie"
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get("/artists")

      expect(response.status).to eq(200)
      expect(response.body).to include('Wild nothing')
    end
  end


end

