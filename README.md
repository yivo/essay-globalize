```ruby
  class Article < ActiveRecord::Base
    belongs_to :poster
    translates :name, :poster_id
  end

  Article.features.translates_with_globalize?                   # => true
  Article.features.globalize.translated_attribute_names         # => [:name, :poster_id]
  Article.features.globalize.model_class_for_translations       # => Article::Translation
  Article.features.globalize.association_for_translations.name  # => :translations
```

## Gemfile
```ruby
gem 'essay-globalize', github: 'yivo/essay-globalize'
```