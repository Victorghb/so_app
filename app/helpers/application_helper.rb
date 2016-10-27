module ApplicationHelper

	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "SO"
    if page_title.empty?
      "#{base_title} App"
    else
      "#{base_title} | #{page_title}"
    end
  end
end
