require 'spec_helper'

describe Domain::PTP::Movie do
  Given(:data){JSON.parse(File.read('spec/fixtures/ptp/jurassic_world.json'))}

  subject{described_class.new(data['Movies'][0])}

  describe "Attributes" do
    Then{expect(subject.title).to eq 'Jurassic World'}
    And{expect(subject.cover).to eq 'http://c1.ptpimg.me/view/http://img1.picload.org/image/ilolpag/74b1a876gw1erl2hp6szyj20sg1920.jpg'}
  end

  describe "#releases" do
    When(:result){subject.releases}
    Then{expect(result.count).to eq 5}
    And{expect(result.first.resolution).to eq "720x360"}
  end

  describe "#best_release" do
    When(:result){subject.best_release}

    context "with jurassic world" do
      Given(:data){JSON.parse(File.read('spec/fixtures/ptp/jurassic_world.json'))}
      Then{expect(result.id).to eq 383084}
    end

    context "with jurassic world with the best release with no seeders" do
      Given(:data){JSON.parse(File.read('spec/fixtures/ptp/jurassic_world_no_seeders.json'))}
      Then{expect(result.id).to eq 383170}
    end
  end
end
