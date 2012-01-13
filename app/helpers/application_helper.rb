module ApplicationHelper
  def classify str
    str.gsub(/\W/, '_').underscore
  end

  def models_to_hashes(models)
    # models = models.values
    # fubar = {}
    # kinds = models.uniq{|e| e[:kind]}.map{|e| e[:kind]}.sort
    # kinds.each do |kind|
    #   fubar[kind] = {}
    #   companies = models.select{ |e| e[:kind] == kind }
    #     .uniq{|e| e[:company]}.map{|e| e[:company]}.sort
    #   companies.each do |company|
    #     fubar[kind][company] = models
    #       .select{ |e| e[:kind] == kind && e[:company] == company }
    #   end
    # end
    # fubar
    result = {}
    make_list(models, :kind).each do |kind|
      result[kind] ||= {}
    end
  end

  private

  def make_list(models, meth, other = nil)
    models
      .reject{ |model| other.present? && model.send(meth) != other }
      .uniq{ |model| model.send(meth) }
      .map{ |model| model.send(meth) }
      .sort
  end
end
