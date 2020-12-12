class Song < ActiveRecord::Base
    validates :title, presence: true
    validates :artist_name, presence: true
    validate :release_year_errors
    validate :copycat

    def release_year_errors
        if released == true && release_year == nil
            errors.add(:release_year, "must have a release year")
        elsif released == true && release_year > Time.now.year
            errors.add(:release_year, "release year cannot be in the future")
        end
    end

    def copycat
        new_artist = self.artist_name
        new_title = self.title
        new_year = self.release_year
        Song.all.each do |song|
            if song.artist_name == new_artist && song.title == new_title && song.release_year == new_year
                errors.add(:title, "cannot be released by the same artist in the same year")
            end
        end
    end
end