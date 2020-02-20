# frozen_string_literal: true

module Supercast
  module DataTypes
    def self.object_names_to_classes
      {
        # data structures
        DataList::OBJECT_NAME => DataList,

        # business objects
        Channel::OBJECT_NAME => Channel,
        Creator::OBJECT_NAME => Creator,
        Episode::OBJECT_NAME => Episode,
        Invite::OBJECT_NAME => Invite,
        Role::OBJECT_NAME => Role,
        Subscriber::OBJECT_NAME => Subscriber,
        UsageAlert::OBJECT_NAME => UsageAlert,
        Feeds::OBJECT_NAME => Feeds
      }
    end
  end
end
