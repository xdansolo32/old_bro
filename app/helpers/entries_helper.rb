module EntriesHelper
  # Return a title on a per-page basis.
  def title
    base_title = "The Encybropedia"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
