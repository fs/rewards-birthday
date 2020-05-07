require "rewards-birthday/base"
require "rewards-birthday/user"

module RewardsBirthday
  module_function

  def create_birthday_bonuses
    Base.new.create_birthday_bonuses
  end

  def create_birthday_bonuses_for(emails)
    Base.new.create_birthday_bonuses_for(emails)
  end
end
