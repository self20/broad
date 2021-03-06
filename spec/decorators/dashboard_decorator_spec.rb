require 'spec_helper'

describe DashboardDecorator, :nodb do
  subject{described_class.new(dashboard)}

  Given(:movies_waitlist){[build_stubbed(:movie, waitlist: true)]}
  Given(:episodes_today){[build_stubbed(:episode)]}
  Given(:episodes_week){[build_stubbed(:episode)]}

  Given(:dashboard){OpenStruct.new(movies_waitlist: movies_waitlist, episodes_today: episodes_today, episodes_week: episodes_week)}

  describe "#movies_waitlist" do
    When(:result){subject.movies_waitlist}
    Then{expect(result.first).to be_decorated_with(MovieDecorator)}
  end

  describe "#movies_waitlist_more?" do
    When(:result){subject.movies_waitlist_more?}

    context "with more than 10 movies" do
      Given(:movies_waitlist){build_list(:movie, 11)}
      Then{expect(result).to be_truthy}
    end

    context "with less than 10 movies" do
      Given(:movies_waitlist){build_list(:movie, 5)}
      Then{expect(result).to be_falsy}
    end
  end

  describe "#movies_waitlist_nbr" do
    When(:result){subject.movies_waitlist_more_nbr}

    context "with more than 10 movies" do
      Given(:movies_waitlist){build_list(:movie, 11)}
      Then{expect(result).to eq 1}
    end

    context "with less than 10 movies" do
      Given(:movies_waitlist){build_list(:movie, 5)}
      Then{expect(result).to eq 0}
    end
  end

  describe "#movies_waitlist_limit" do
    Then{expect(subject.movies_waitlist_limit).to eq described_class::MOVIES_WAITLIST_LIMIT}
  end

  describe "#episodes_today" do
    Then{expect(subject.episodes_today.first).to be_decorated_with(EpisodeDecorator)}
  end

  describe "#episodes_today" do
    Then{expect(subject.episodes_week.first).to be_decorated_with(EpisodeDecorator)}
  end

end
