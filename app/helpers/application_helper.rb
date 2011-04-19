module ApplicationHelper

  def logo
    @logo = image_tag("logo.png", :alt => "The Revbrolution", :id => "logo", :size => "320x240")
  end
  
end
