# frozen_string_literal: true
class Essay::AssociationFeatures

  def translation?
    translation_for_globalize?
  end

  # class Article < ActiveRecord::Base
  #   belongs_to :poster
  #   translates :poster_id
  # end
  #
  # Article.association_features[:poster].translation_for_globalize?       => false
  # Article.association_features[:translations].translation_for_globalize? => true
  def translation_for_globalize?
    !!model_features.with(:globalize) { |g| g.association_for_translations == this_association }
  end

  def globalize_translation
    @globalize_translation || begin
      @globalize_translation = GlobalizeTranslation.new(env) if translation_for_globalize?
    end
  end

  class GlobalizeTranslation < Base
    def top_feature
      model_features.globalize
    end

    protected :top_feature
  end

  def translates?
    translates_with_globalize?
  end

  # class Article < ActiveRecord::Base
  #   belongs_to :poster
  #   translates :poster_id
  # end
  #
  # Article.association_features[:poster].translates_with_globalize?       => true
  # Article.association_features[:translations].translates_with_globalize? => false
  def translates_with_globalize?
    !!model_features.with(:globalize) { |g| g.translated_association_names.include?(association_name) }
  end

  def globalize_translatable
    @globalize_translatable || begin
      @globalize_translatable = GlobalizeTranslatable.new(env) if translates_with_globalize?
    end
  end

  class GlobalizeTranslatable < Base
    def top_feature
      model_features.globalize
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :poster_id
    # end
    #
    # Article.association_features[:poster].translation_table => arel table for 'article_translations'
    def translation_table
      top_feature.association_for_translations.to.arel
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :poster_id
    # end
    #
    # Article.association_features[:poster].translation_table_name => 'article_translations'
    def translation_table_name
      translation_table.name.to_sym
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :poster_id
    # end
    #
    # Article.association_features[:poster].translation_from_key_name => :poster_id
    def translation_from_key_name
      this_association.reflection.foreign_key.to_sym
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :poster_id
    # end
    #
    # Article.association_features[:poster].translation_to_key_name => :id
    def translation_to_key_name
      top_feature.association_for_translations.from_key_name
    end

    serialize do
      {
        translation_table_name:     translation_table_name,
        translation_from_key_name:  translation_from_key_name,
        translation_to_key_name:    translation_to_key_name
      }
    end
  end

  serialize do
    {
      is_translation_for_globalize: translation_for_globalize?,
      translates_with_globalize:    translates_with_globalize?,
      globalize_translation:        globalize_translation.try(:to_hash),
      globalize_translatable:       globalize_translatable.try(:to_hash)
    }
  end
end
