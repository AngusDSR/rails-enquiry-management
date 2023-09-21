puts "Destroying all enquiries..."
Enquiry.destroy_all

10.times do
  puts "Creating enquiry..."
  current_record = Enquiry.create(
    first_name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    email: Faker::Internet.email(name: :first_name),
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    instagram_handle: "@#{Faker::Adjective.positive}_#{Faker::Movies::StarWars.specie.downcase.tr(' ', '_',).gsub(/[^a-z]/, '')}",
    preferred_contact_method: %w[email text whatsapp instagram].sample,
    description: "#{[Faker::Movies::StarWars.character, Faker::Ancient.god].sample} a #{[Faker::Creature::Animal.name, Faker::Vehicle.make, Faker::Games::DnD.ranged_weapon].sample} #{['surrounded by','made up of', 'coming out of a'].sample} #{[Faker::Games::ElderScrolls.creature, Faker::Games::Zelda.item].sample}",
    placement: "#{['upper','lower','inner','outer','middle of'].sample} #{['thigh', 'arm', 'wrist', 'face', 'arse'].sample}",
    notes: [Faker::TvShows::BojackHorseman.tongue_twister, Faker::Movies::StarWars.quote, nil].sample
  )
  puts current_record.errors.full_messages
  puts "#{current_record.title} created!"
  puts "---------------------------------"

end

puts "Created #{Enquiry.count} enquiries."
