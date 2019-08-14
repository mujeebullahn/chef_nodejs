# InSpec test for recipe node::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

#this test is runnung on ubuntu machine
#? returns boolean
unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end


# This is an example test, replace it with your own test.
describe port(80) do  #get rid of the skip part so its listening
  it { should be_listening }
end

describe service "nginx" do  #get rid of the skip part so its listening
  it { should be_running }
  it { should be_enabled }
end

#compare if we get bad gateway (502)
#testing if its broken
#command kitchen test
describe http('http://localhost',enable_remote_worker: true) do
  its('status'){ should cmp 502 }
end


end
