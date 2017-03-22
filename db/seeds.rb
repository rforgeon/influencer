#
# 5.times do
#    User.create!(
#    user_name: Faker::GameOfThrones.character.delete(' '),
#    name: Faker::StarWars.character,
#    photo: Faker::Avatar.image,
#    email: Faker::Internet.email,
#    password: 'password',
#    twitter:Faker::Internet.url,
#    facebook:Faker::Internet.url,
#    instagram:Faker::Internet.url,
#    youtube:Faker::Internet.url,
#    customLink:Faker::Internet.url,
#    bankNum:"34567876567",
#    bankRoutting:"34567876567"
#    )
#  end
#  users = User.all
#
#
#
# 5.times do
#   mainContact = users.sample
#   brand = Brand.create!(
#   domain: Faker::Internet.domain_name,
#   photo: Faker::Company.logo,
#   companyName: Faker::Company.name,
#   mainContactName: mainContact.name,
#   mainContactEmail: mainContact.email,
#   description: Faker::Company.catch_phrase,
#   campaignURL: Faker::Internet.url,
#   giftDescription: Faker::StarWars.vehicle,
#   giftReferralThreshold: 1000,
#   sponsorSalesPercent: 5,
#   bankNum: "34567876567",
#   bankRoutting: "34567876567",
#   registered: false
#   )
#
# end
# brands = Brand.all
#
# 5.times do
#    user = users.sample
#    brand = brands.sample
#    wrapped_link= WrappedLink.create!(
#    link: "licklink.com/#{user.name}-#{brand.companyName}",
#    user_id: user.id,
#    brand_id: brand.id
#    )
#  end
#  wrapped_links = WrappedLink.all
#
#
# puts "Seed finished"
# puts "#{User.count} users created"
# puts "#{Brand.count} brands created"
# puts "#{WrappedLink.count} links created"
