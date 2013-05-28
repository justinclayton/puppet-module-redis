require 'spec_helper'

describe 'redis', :type => :class do
  context 'on a centos system' do
    let(:facts) do
      {
        :osfamily => 'RedHat'
      }
    end

    it 'should install epel' do
      should include_class('epel')
    end

    it 'should setup redis' do
      should contain_package('redis').with_name('redis')
      should contain_file('redis.conf').with_path('/etc/redis.conf')
      should contain_service('redis').with_name('redis')
    end
  end

  context 'on an ubuntu system' do
    let(:facts) do
      {
        :osfamily => 'Debian'
      }
    end

    it 'should not install epel' do
      should_not include_class('epel')
    end

    it 'should setup redis' do
      should contain_package('redis').with_name('redis-server')
      should contain_file('redis.conf').with_path('/etc/redis/redis.conf')
      should contain_service('redis').with_name('redis-server')
    end
  end
end