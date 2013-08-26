require 'spec_helper_system'

describe 'testing module installation:' do

  pp = <<-EOS
    class { 'redis': enable_epel => true, }
  EOS

  # Using puppet_apply as a subject
  context puppet_apply(pp) do
    its(:stderr)    { should be_empty }
    its(:exit_code) { should_not == 1 }
  end

end

describe 'testing redis itself:' do

  context shell 'redis-cli ping' do
    its(:stdout)    { should =~ /PONG/ }
    its(:stderr)    { should be_empty  }
    its(:exit_code) { should be_zero   }
  end

  context shell 'redis-cli set abc "Hello World"' do
    its(:stderr)    { should be_empty }
    its(:exit_code) { should be_zero  }
  end

  context shell 'redis-cli get abc' do
    its(:stdout)    { should =~ /Hello World/ }
    its(:stderr)    { should be_empty         }
    its(:exit_code) { should be_zero          }
  end

  context shell 'redis-cli del abc' do
    its(:stderr)    { should be_empty }
    its(:exit_code) { should be_zero  }
  end
end