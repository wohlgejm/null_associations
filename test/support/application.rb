module Rails
  def self.application
    Application.new
  end

  class Application
    def config
      self
    end

    def active_record
      self
    end

    def belongs_to_required_by_default
      false
    end
  end
end
