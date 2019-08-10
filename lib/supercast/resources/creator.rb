# frozen_string_literal: true

module Supercast
  class Creator < Resource
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List
    include Supercast::Operations::Save

    OBJECT_NAME = 'creator'
  end
end
