# encoding: utf-8
# frozen_string_literal: true

class Essay::AttributeFeatures
  def translates?
    translates_with_globalize?
  end

  def translates_with_globalize?
    !!model_features.with(:globalize) { |g| g.translated_attribute_names.include?(attribute_name) }
  end

  serialize do
    { translates_with_globalize: translates_with_globalize? }
  end
end
