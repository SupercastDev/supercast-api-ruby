# frozen_string_literal: true

module Supercast
  class Role < Resource
    extend Supercast::Operations::Create
    include Supercast::Operations::Destroy
    extend Supercast::Operations::List
    include Supercast::Operations::Save

    OBJECT_NAME = 'role'.freeze
  end
end
