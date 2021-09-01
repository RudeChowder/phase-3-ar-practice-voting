class Candidate < ActiveRecord::Base
  has_many :ballots
  has_many :voters, through: :ballots

  def count_votes(year)
    ballots.where(year: year).count
  end

  def most_popular_year
    votes_per_year = ballots.group(:year).count
    votes_per_year.max_by { |_k, v| v }.first
  end

  def voters_in_party_below_age(party, age)
    voters.where("party == ? AND age < ?", party, age)
  end

  def self.seats_in_party(party)
    party_candidates = all.where(party: party)
    party_candidates.pluck(:seat)
  end

  def self.most_popular_for(seat)
    candidates_for_seat = all.where(seat: seat)
    candidates_for_seat.max_by { |candidate| candidate.ballots.count }
  end
end
