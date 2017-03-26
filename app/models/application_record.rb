class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options={})
    # exclude nil values
    # TODO: Would also like to exclude default values (e.g. false, uninitialised dates etc)
    super(options).reject { |k, v| v.nil? }
  end
end
