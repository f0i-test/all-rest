class Thing < ActiveRecord::Base
  attr_accessible :content, :thing, :tid

  def object
    JSON.parse self.content
  end

  def object= hash
    self.content = hash.to_json
  end
end
