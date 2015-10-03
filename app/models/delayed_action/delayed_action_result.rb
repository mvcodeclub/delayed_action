module DelayedAction
  class DelayedActionResult < ActiveRecord::Base
    before_create do
      self.uuid = SecureRandom.uuid
    end
  end
end
