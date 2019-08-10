# frozen_string_literal: true

require File.expand_path('../../lib/supercast.rb', __dir__)

RSpec.describe Supercast do
  it 'should allow api_key to be configured' do
    Supercast.api_key = '123abc'

    Supercast.api_key.should eq('123abc')
  end

  it 'should allow ca_bundle_path to be configured' do
    Supercast.ca_bundle_path = '/path/to/bundle'

    Supercast.ca_bundle_path.should eq('/path/to/bundle')
  end

  it 'should allow log_level to be configured' do
    Supercast.log_level = Supercast::LEVEL_DEBUG

    Supercast.log_level.should eq(Supercast::LEVEL_DEBUG)
  end

  it 'should raise error on invalid log_level configuration' do
    expect { Supercast.log_level = 'bad' }.to raise_error(ArgumentError)
  end

  it 'should allow logger to be configured' do
    Supercast.logger = 1

    Supercast.logger.should eq(1)
  end

  it 'should allow max_network_retries to be configured' do
    Supercast.max_network_retries = 1

    Supercast.max_network_retries.should eq(1)
  end
end
