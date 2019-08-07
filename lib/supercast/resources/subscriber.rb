# frozen_string_literal: true

module Supercast
  class Subscriber < Resource
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List

    OBJECT_NAME = 'subscriber'
  end
end
