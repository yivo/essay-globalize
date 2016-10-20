```ruby
  class Article < ActiveRecord::Base
    belongs_to :poster
    translates :name, :poster_id
  end

  Article.features.translates_with_globalize?                   # => true

  Article.features.globalize.translated_attribute_names         # => [:name, :poster_id]
  Article.features.globalize.model_class_for_translations       # => Article::Translation
  Article.features.globalize.association_for_translations.name  # => :translations

  Article.attribute_features[:name].translates_with_globalize?           # => true
  Article.association_features[:poster].translates_with_globalize?       # => true
  Article.association_features[:translations].translates_with_globalize? # => false
  Article.association_features[:translations].translation_for_globalize? # => true
```

## Gemfile
```ruby
gem 'essay-globalize', '~> 1.0'
```
