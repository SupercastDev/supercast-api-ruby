# frozen_string_literal: true

module Supercast
  class Subscriber < Resource
    extend Supercast::Operations::Create
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List
    include Supercast::Operations::Save

    OBJECT_NAME = 'subscriber'
  end
end
