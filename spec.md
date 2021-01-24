# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes) -> there are multiple has many relations

- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User) -> multiple of these
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients) -> Likes, comments, notes, MixContent!
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients) -> Mixes, content, notes, comments

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity) -> comments/notes
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) -> There are many for users and mixes
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) -> there are many for mixes and users
- [x] Include signup (how e.g. Devise) -> yes
- [x] Include login (how e.g. Devise) -> yes
- [x] Include logout (how e.g. Devise) -> yes
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) -> yes
- [x] Include nested resource show or index (URL e.g. users/2/recipes) -> users:mixes
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)users:mixes and mixes:content
- [x] Include form display of validation errors (form URL e.g. /recipes/new) -> yes!

Confirm:
- [x] The application is pretty DRY 
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate