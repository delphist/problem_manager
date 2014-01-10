# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
    :email => "xdelphist@gmail.com",
    :password => '12345678'
)
User.create!(
    :email => "5002307@gmail.com",
    :password => '12345678'
)

Subject.create(
    :title => "Воровство денег с банковских карт",
)
Subject.create(
    :title => "Нарушения коллекторами прав граждан",
)
Subject.create(
    :title => "Некачественные слуги банков и иных кредитных организаций",
)

Status.create(
    :title => "В работе",
    :map_color => "00ff00",
)
Status.create(
    :title => "Ищем контакты",
    :map_color => "ff0000",
)