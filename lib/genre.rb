class Genre < Base
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def songs
    @songs
  end

  def sorted_songs
    @songs.sort {|a, b| a.name <=> b.name}
  end

  def song_list
    sorted_songs.each_with_index do |song, i|
      puts "#{i + 1}. #{song.display_by_artist}"
    end
  end

  def artists
    self.songs.map(&:artist).uniq
  end

end
