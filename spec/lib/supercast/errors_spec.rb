# frozen_string_literal: true

require File.expand_path('../../../lib/supercast.rb', __dir__)

RSpec.describe Supercast::SupercastError do
  describe 'self.initialize' do
    it 'correctly initializes' do
      message = "Something went wrong"

      allow_any_instance_of(Supercast::SupercastError).to receive(:initialize).with(message)

      error = Supercast::SupercastError.new(message)
      expect(error).to be_a(StandardError)
    end
  end
end
