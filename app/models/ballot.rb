class Ballot < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :voter

  def print_details
    puts "#{voter.name} voted for #{candidate.name} in #{year}"
  end

  def self.most_popular_year
    votes_per_year = all.group(:year).count
    votes_per_year.max_by { |_k, v| v }.first
  end
end
