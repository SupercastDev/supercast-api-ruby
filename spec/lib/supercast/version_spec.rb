# frozen_string_literal: true

require File.expand_path('../../../lib/supercast.rb', __dir__)

RSpec.describe Supercast::VERSION do
  it 'should be defined' do
    defined?(Supercast::VERSION).should be_truthy
  end
end
