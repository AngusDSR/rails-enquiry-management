class EnquiriesController < ApplicationController
  def index
    @enquiry = Enquiry.all
  end

  def new
    @enquiry = Enquiry.new
  end

end
