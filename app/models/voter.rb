class Voter < ActiveRecord::Base
  has_many :ballots
  has_many :candidates, through: :ballots

  def vote(candidate, year)
    Ballot.create(voter: self, candidate: candidate, year: year)
  end

  def votes_across_party_lines
    candidates.where("party != ?", self.party)
  end

  def self.voted_in(year)
    all_ballots = all.map { |voter| voter.ballots }.flatten
    ballots_from_year = all_ballots.filter{ |ballot| ballot.year == year}
    ballots_from_year.map { |ballot| ballot.voter }.uniq
  end

  def self.in_party_above_age(party, age)
    all.where("party = ? AND age > ?", party, age)
  end

  def self.voted_for(candidate)
    all.filter { |voter| voter.candidates.include? candidate }
  end
end
