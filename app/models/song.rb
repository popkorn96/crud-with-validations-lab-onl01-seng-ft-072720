class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "Cannot release the same song twice in a year."}
    validates :released, inclusion: { in: [true, false] }
    validate :release_year_presence
    validates :artist_name, presence: true
    
    
    def release_year_presence
        if self.released
          unless self.release_year
            errors.add(:release_year, "Released Song must have a released year.")
          else
            now = Time.new
            if now.year < self.release_year
              errors.add(:release_year, "Release year is in the future.")
            end
        end
        end
    end
end
# title, a string
# Must not be blank
# Cannot be repeated by the same artist in the same year
# released, a boolean describing whether the song was ever officially released
# Must be true or false
# release_year, an integer
# Optional if released is false
# Must not be blank if released is true
# Must be less than or equal to the current year
# artist_name, a string
# Must not be blank
# genre, a string