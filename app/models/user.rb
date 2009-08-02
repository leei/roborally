class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # optional configuration
    #c.add_acts_as_authentic_module :password
    #c.add_acts_as_authentic_module :email
  end
end
