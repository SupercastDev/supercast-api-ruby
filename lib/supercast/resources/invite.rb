# frozen_string_literal: true

module Supercast
  class Invite < Resource
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List

    OBJECT_NAME = 'invite'
  end
end
