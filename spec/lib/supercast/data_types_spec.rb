# frozen_string_literal: true

require File.expand_path('../../../lib/supercast.rb', __dir__)

RSpec.describe Supercast::DataTypes do
  describe 'self.object_names_to_classes' do
    it 'correctly identify all available classes' do
      list = Supercast::DataTypes.object_names_to_classes

      expect(list['list']).to eq(Supercast::DataList)
      expect(list['channel']).to eq(Supercast::Channel)
      expect(list['creator']).to eq(Supercast::Creator)
      expect(list['episode']).to eq(Supercast::Episode)
      expect(list['invite']).to eq(Supercast::Invite)
      expect(list['role']).to eq(Supercast::Role)
      expect(list['subscriber']).to eq(Supercast::Subscriber)
      expect(list['usage_alert']).to eq(Supercast::UsageAlert)
    end
  end
end
