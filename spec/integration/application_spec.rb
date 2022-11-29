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
    it "should return info about album " do 
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Surfer Rosa </h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end
  

  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('Surfer Rosa')
      expect(response.body).to include('1988')
      expect(response.body).to include('Waterloo')
      expect(response.body).to include('1974')
      expect(response.body).to include('Super Trouper')
      expect(response.body).to include('1980')
      expect(response.body).to include('Bossanova')
      expect(response.body).to include('1990')
      expect(response.body).to include('Lover')
      expect(response.body).to include('2019')
      expect(response.body).to include('Folklore')
      expect(response.body).to include('2020')
      expect(response.body).to include('I Put a Spell on You')
      expect(response.body).to include('1965')
      expect(response.body).to include('Baltimore')
      expect(response.body).to include('1978')
      expect(response.body).to include('Here Comes the Sun')
      expect(response.body).to include('1971')
      expect(response.body).to include('Fodder on My Wings')
      expect(response.body).to include('1982')
      expect(response.body).to include('Ring Ring')
      expect(response.body).to include('1973')
    end  
  end  



  context "POST/ albums" do
    it 'should validate album 
    parameters' do 
      response = post(
        '/albums',
      invalid_artist_title: 'SillyTitle',
      another_invalid_thing:123
      )
      expect(response.status).to eq(400)
    end 


    it "should create a new album" do
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
      expect(response.body).to include('<h1>Artists</h1>')
      expect(response.body).to include('Name: Pixies')
      expect(response.body).to include('Genre: Rock')
      expect(response.body).to include('Name: ABBA')
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include('Name: Taylor Swift')
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include('Name: Nina Simone')
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include("Kiasmos")
      expect(response.body).to include('Experimental')
      
    end
  end

  context 'GET/albums/new' do 
    it 'should return the form to add a new album' do 
      response = get('/albums/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Insert a new album into Music Library </h1>')
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include('<label> Album title </label>')
      expect(response.body).to include('<label> Album release year </label>')
      expect(response.body).to include(' <label> Album artist ID </label>')
      expect(response.body).to include('<input type="submit"/>')
    end
  end



  context "GET/artists/:id" do 
    it "should return info about artist " do 
      response = get('/artists/3')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1> Taylor Swift </h1>')
      expect(response.body).to include('Genre: Pop')
  
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

