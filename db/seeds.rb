admin = User.create(email: 'admin@example.com',
                    password: 'testtest',
                    password_confirmation: 'testtest',
                    username: 'adminpogi',
                    user_type: 'Admin')

broker = User.create(email: 'broker@example.com',
                     password: 'testtest',
                     password_confirmation: 'testtest',
                     username: 'brokerpogi',
                     user_type: 'Broker')

buyer = User.create(email: 'buyer@example.com',
                    password: 'testtest',
                    password_confirmation: 'testtest',
                    username: 'buyerpogi',
                    user_type: 'Buyer')

stock1 = Stock.create(name: 'Aerotyne International',
                      unit_price: 5.12,
                      shares: 100000,
                      user_id: broker.id)

stock2 = Stock.create(name: 'Investor Center',
                      unit_price: 10.79,
                      shares: 50000,
                      user_id: broker.id)

stock3 = Stock.create(name: 'Stratton Oakmont',
                      unit_price: 53.23,
                      shares: 20000,
                      user_id: broker.id)

Order.create(name: 'Aerotyne International',
             unit_price: 5.12,
             shares: 10,
             stock_id: stock1.id,
             user_id: buyer.id)

Order.create(name: 'Investor Center',
             unit_price: 10.79,
             shares: 20,
             stock_id: stock2.id,
             user_id: buyer.id)

Order.create(name: 'Stratton Oakmont',
             unit_price: 53.23,
             shares: 50,
             stock_id: stock3.id,
             user_id: buyer.id)