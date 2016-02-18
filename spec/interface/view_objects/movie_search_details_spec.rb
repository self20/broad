require 'spec_helper'

describe ViewObjects::MovieSearchDetails do
  subject{described_class.new(imdb_id)}

  Given(:imdb_id){'tt1431045'}

  Given do
    stub_request(:get, "https://api-v2launch.trakt.tv/search?id=#{imdb_id}&id_type=imdb").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
  end

  Then{expect(subject.title).to eq 'Deadpool'}

end
