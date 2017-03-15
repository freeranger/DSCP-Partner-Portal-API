Contact.create!(first_name: "Tony",
                last_name: "Stark",
                email: "tony@starkindustries.com",
                phone: 8005556969,
                phone_alt: 8004446969,
                business_name: "Stark Industries",
                street_address: "429 Stark Blvd.",
                city: "Mailbu",
                state: "CA",
                zip: 90263,
                website: "starkindustries.com",
                facebook: "",
                instagram: "",
                partner: true )

596.times do |n|
  first_name     = Faker::Name.first_name
  last_name      = Faker::Name.last_name
  email          = "example-#{n+1}@example.com"
  phone          = 9876543211
  phone_alt      = 1234567890
  business_name  = Faker::HarryPotter.location
  street_address = Faker::Address.street_address
  city           = "St. Charles"
  state          = "IL"
  zip            = 60175
  website        = "http://example.com"
  facebook       = "http://facebook.com/DowntownStCharlesPartnership"
  instagram      = "http://instagram.com/STC_CitySide"
  partner        = false

  rand_num = rand(2)
  rand_num == 1 ? partner = true : partner = false

  Contact.create!(first_name: first_name,
                  last_name: last_name,
                  email: email,
                  phone: phone,
                  phone_alt: phone_alt,
                  business_name: business_name,
                  street_address: street_address,
                  city: city,
                  state: state,
                  zip: zip,
                  website: website,
                  facebook: facebook,
                  instagram: instagram,
                  partner: partner )
end
