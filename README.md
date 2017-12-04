# Associations in the Phoenix

Associations are implemented using macro-style calls, so that you can
declaratively add features to your models.

Associations in Ecto are used when two different sources (tables) are
linked via foreign keys.

## The Types of Associations

The Phoenix supports six types associations:

* `belongs_to`
* `has_one`
* `has_many`
* `has_many :through`
* `has_one :through`
* `has_and_belongs_to_many`
