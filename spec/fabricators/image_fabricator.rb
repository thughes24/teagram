Fabricator(:image) do
  caption { Faker::Lorem.words(5).join(" ") }
end