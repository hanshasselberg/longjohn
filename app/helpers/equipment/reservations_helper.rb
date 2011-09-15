module Equipment::ReservationsHelper
  def classify str
    str.gsub(/\W/, '_').underscore
  end
end
