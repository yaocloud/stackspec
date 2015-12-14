describe server('web001.example.com') do
  # it { p subject.resource }

  its(:name)            { should eq 'stackspec.example.com' }
  its(:key_name)        { should eq 'sample001' }

  its(:security_groups) { should have(4).security_groups }
  it { should have_security_group(name: "https") }

  its('flavor.id')      { should eq '8' }

end
