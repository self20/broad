require 'spec_helper'

describe FetchTvShowDetailsTraktJob do
  subject{described_class.new}

  When{subject.perform(tv_show)}

  context "with an existing show" do
    Given(:tv_show){create :tv_show, name: 'Better Call Saul'}
    Then{expect(tv_show.trakt_details[:year]).to eq 2015}
    And{expect(tv_show.imdb_id).to eq "tt3032476"}
  end

  context "with a missing show" do
    Given(:tv_show){create :tv_show, name: 'nofound'}
    Then{expect(tv_show.trakt_details).to_not be_present}
  end
end
