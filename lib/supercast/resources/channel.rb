# frozen_string_literal: true

module Supercast
  class Channel < Singleton
    include Supercast::Operations::Save

    OBJECT_NAME = 'channel'
  end
end
