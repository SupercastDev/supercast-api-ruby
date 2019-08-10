# frozen_string_literal: true

require File.expand_path('../../../lib/supercast.rb', __dir__)

RSpec.describe Supercast::Singleton do
  describe 'self.resource_url' do
    it 'should raise error with abstract class' do
      expect { Supercast::Singleton.resource_url }.to raise_error(NotImplementedError)
    end
  end
end
