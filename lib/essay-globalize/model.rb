class Essay::ModelFeatures
  def translates_with_globalize?
    defined?(Globalize) && model_class.included_modules.include?(Globalize::ActiveRecord::InstanceMethods)
  end

  def globalize
    @globalize || begin
      @globalize = TranslatesWithGlobalize.new(env) if translates_with_globalize?
    end
  end

  def to_hash
    super.merge!(
      translates_with_globalize: translates_with_globalize?,
      globalize:                 globalize.try(:to_hash)
    )
  end

  class TranslatesWithGlobalize < Base
    def translated_attributes
      model_class.translated_attribute_names.map { |el| model_associations[el] }
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :name, :poster_id
    # end
    #
    # Article.features.globalize.translated_attribute_names => [:name, :poster_id]
    def translated_attribute_names
      model_class.translated_attribute_names.map { |el| el.kind_of?(Symbol) ? el : el.to_sym }
    end

    def translated_associations
      tr_attrs = translated_attribute_names
      model_associations.select do |assoc|
        assoc.belongs_to? && tr_attrs.include?(assoc.reflection.foreign_key.to_sym)
      end
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :name, :poster_id
    # end
    #
    # Article.features.globalize.translated_association_names => [:poster]
    def translated_association_names
      translated_associations.map(&:name)
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :name, :poster_id
    # end
    #
    # Article.features.globalize.model_class_for_translations => Article::Translation
    def model_class_for_translations
      model_class.translation_class
    end

    # class Article < ActiveRecord::Base
    #   belongs_to :poster
    #   translates :name, :poster_id
    # end
    #
    # Article.features.globalize.association_for_translations => traits for association named 'translations'
    def association_for_translations
      globalize_base = Globalize::ActiveRecord::Translation
      model_associations.find do |assoc|
        to_class = assoc.to_class
        to_class && to_class.ancestors.include?(globalize_base)
      end
    end
  end
end