# frozen_string_literal: true

module Supercast
  class Feeds < Resource
    include Supercast::Operations::Feeds
    extend Supercast::Operations::Find

    OBJECT_NAME = 'feed'
  end
end
