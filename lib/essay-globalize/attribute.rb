class Essay::AttributeRoles
  def translates_with_globalize?
    feature = model_features.globalize
    feature && feature.translated_attribute_names.include?(attribute_name)
  end
end