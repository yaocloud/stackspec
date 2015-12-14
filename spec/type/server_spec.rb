describe server("stackspec.example.jp") do
  let(:servers) do
    [
      double(
        "name"            => "stackspec.example.jp",
        "status"          => 'ACTIVE',
        "security_groups" => security_groups,
        "flavor"          => flavor
      )
    ]
  end

  let(:flavor) { double("id" => '123') }

  let(:security_groups) do
    [
      double("name" => "http"),
      double("name" => "https"),
      double("name" => "fluentd"),
    ]
  end

  before do
    allow(Yao::Server).to receive(:list_detail).with(name: 'stackspec.example.jp') { servers }
  end

  after do
    subject.instance_eval{ @resource = nil }
  end

  it { should be_an_instance_of Stackspec::Type::Server }
  its(:resource) { should respond_to :status }

  its(:name) { should eq "stackspec.example.jp" }
  its(:status) { should eq "ACTIVE" }
  it { should have(3).security_groups }
  its('flavor.id') { should eq '123' }

  context "when no server found" do
    let(:servers) { [] }
    it do
      expect { subject.resource }.to \
        raise_error(Stackspec::ResourceNotFound, /No server found for name: "stackspec.example.jp"/)
    end
  end

  context "when security groups are duplicating" do
    let(:security_groups) do
      [
        double("name" => "http"),
        double("name" => "https"),
        double("name" => "fluentd"),
        double("name" => "http"),
        double("name" => "https"),
        double("name" => "fluentd"),
      ]
    end

    it { should have(3).security_groups }
  end
end
