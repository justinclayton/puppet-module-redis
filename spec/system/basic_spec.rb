require 'spec_helper_system'

describe 'basic tests:' do

  pp = <<-EOS
    class { 'redis': enable_epel => true, }
  EOS

  # Using puppet_apply as a subject
  context puppet_apply(pp) do
    its(:stderr) { should be_empty }
    its(:exit_code) { should_not == 1 }
  end
end