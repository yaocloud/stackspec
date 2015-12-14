describe server('web001.example.com') do
  # it { p subject.resource }

  its(:name)            { should eq 'web001.example.com' }
  its(:security_groups) { should have(8).security_groups }
  its(:key_name)        { should eq 'sample001' }

  its('flavor.id')      { should eq '123' }
end
