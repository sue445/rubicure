describe Rubicure::Movie do
  let(:movie_names) do
    [
      :dx1,
      :dx2,
      :dx3,
      :ns1,
      :ns2,
      :ns3,
      :sc,
    ]
  end

  describe "#names" do
    subject { Rubicure::Movie.names }

    it { should include(*movie_names) }
  end

  describe "#uniq_names" do
    subject { Rubicure::Movie.uniq_names }

    it { should include(*movie_names) }
    its(:count) { should == movie_names.count }
  end

  describe "#find" do
    subject { Rubicure::Movie.find(movie_name) }

    context "when exists" do
      let(:movie_name) { :dx }

      its(:title) { should == "映画 プリキュアオールスターズDX みんなともだちっ☆奇跡の全員大集合!" }
    end

    context "when not exists" do
      let(:movie_name) { :ashita_no_nadja  }

      it { expect{ subject }.to raise_error }
    end
  end

end
