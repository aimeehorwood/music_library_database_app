# file: app.rb
require "sinatra"
require "sinatra/reloader"
require_relative "lib/database_connection"
require_relative "lib/album_repository"
require_relative "lib/artist_repository"

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/album_repository"
    also_reload "lib/artist_repository"
  end

  get "/" do 
    return "Welcome"
  end 

  get "/albums/new" do
    return erb(:new_album)
  end

  get "/albums" do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:all_albums)
  end

  get "/albums/:id" do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album_id)
  end

  post "/albums" do
    if album_invalid_request_parameters?
      status 400
      return ""
    end

    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)
    erb(:album_created)
  end

  def album_invalid_request_parameters?
    return (params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil)
  end

  get "/artists/new" do
    return erb(:new_artist)
  end

  get "/artists" do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:all_artists)
  end

  get "/artists/:id" do
    repo = ArtistRepository.new
    album_repo = AlbumRepository.new
    @artist = repo.find(params[:id])
    @album = album_repo.find(@artist.id)

    return erb(:artist_id)
  end

  post "/artists" do
    if artist_invalid_request_parameters?
      status 400
      return ""
    end

    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)
    erb(:artist_created)
  end

  def artist_invalid_request_parameters?
    return (params[:name] == nil || params[:genre] == nil)
  end
end
