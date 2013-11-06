module SingletonMethodSupport

  module SingletonMethods
    include Core
  end
  
  def self.included(base)
    base.extend SingletonMethods
  end

end
