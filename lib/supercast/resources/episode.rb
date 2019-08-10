# frozen_string_literal: true

module Supercast
  class Episode < Resource
    extend Supercast::Operations::Create
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List
    include Supercast::Operations::Save

    OBJECT_NAME = 'episode'.freeze
  end
end
