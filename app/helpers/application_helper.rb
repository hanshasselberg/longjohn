module ApplicationHelper
  def classify str
    str.gsub(/\W/, '_').underscore
  end
end
