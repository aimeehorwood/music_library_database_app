# POST/albums Route Design Recipe

# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)



1. Design the Route Signature
You'll need to include:

* the HTTP method
* the path
* any query parameters (passed in the URL)
* or body parameters (passed in the request body)

Method: POST
Path: /albums
Body Parameters:
title=Voyage
release_year=2022
artist_id=2

2. Design the Response

# Create a new album
Request: POST /albums
  With body parameters: "title=Voyage, release_year=2022, artist_id=2"
Response: None (just creates the resource on the server)


3. Write Examples
Replace these with your own design.


# Request:

POST /albums

# Expected response:

Response for 200 OK
# Request:

GET /albums

# Expected response:

Response for 200 OK

4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET/ albums" do
    it "should return the list of albums" do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring")

    end
  end

  context "POST/ albums" do
    it "should create a new album" do
      response = post(
        "/albums",
        title: "Voyage",
        release_year: "2022",
        artist_id: "2"
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('')

      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Voyage')
    end
  end
end


5. Implement the Route
Write the route and web server code to implement the route behaviour.
