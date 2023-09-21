class Enquiry < ApplicationRecord
  before_validation do
    self.title = "#{first_name}-#{description.split.first}-#{placement.split.last}-#{Date.today.strftime('%b').upcase}"
  end
end
