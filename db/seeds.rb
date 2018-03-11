
user_1 = User.create(email: 'user_1@example.de', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
user_2 = User.create(email: 'user_2@example.de', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
user_3 = User.create(email: 'user_3@example.de', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)

dat_backhus = Company.create(name: 'Dat Backhus')
miss_doener = Company.create(name: 'Miss Döner')

address_1 = Address.create( street: 'Lange Reihe',
                            number: 29,
                            postal_code: 20099,
                            state: 'Hamburg',
                            city: 'Hamburg',
                            company: dat_backhus)

address_2 = Address.create( street: 'Mönkebergstraße',
                            number: 3,
                            postal_code: 20095,
                            state: 'Hamburg',
                            city: 'Hamburg',
                            company: dat_backhus)

address_3 = Address.create( street: 'Carl von Ossietzky Platz',
                            number: 1,
                            postal_code: 20099,
                            state: 'Hamburg',
                            city:'Hamburg',
                            company: miss_doener)

bonus_card_1 = Card.create( name: 'Bonuskarte Brot',
                            description: 'Das elfte Brot gibt\'s um sonst.',
                            stamps_count: 10,
                            exploited: false,
                            company: dat_backhus)

bonus_card_2 = Card.create( name: 'Bonuskarte Kaffee',
                            description: 'Den zehnten Café gibt\s frei Haus.',
                            stamps_count: 9,
                            exploited: false,
                            company: dat_backhus)

bonus_card_3 = Card.create( name: 'Bonuskarte Döner',
                            description: 'Den elften Döner gibt\s frei Haus.',
                            stamps_count: 10,
                            exploited: false,
                            company: miss_doener)

vendor_1 = Vendor.create( user: user_1,
                          company: dat_backhus)

vendor_2 = Vendor.create( user: user_2,
                          company: miss_doener)


