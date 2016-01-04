class Essay::AttributeFeatures
  def translates?
    translates_with_globalize?
  end

  def translates_with_globalize?
    !!model_features.with(:globalize) { |g| g.translated_attribute_names.include?(attribute_name) }
  end
end