User.create(email: 'admin@example.com', password: 'testtest', password_confirmation: 'testtest', username: 'adminpogi', user_type: 'admin')
User.create(email: 'broker@example.com', password: 'testtest', password_confirmation: 'testtest', username: 'brokerpogi', user_type: 'broker')
User.create(email: 'buyer@example.com', password: 'testtest', password_confirmation: 'testtest', username: 'buyerpogi', user_type: 'buyer')

Stock.create(name: 'Aerotyne International', unit_price: 5.12, shares: 100000, user_id: 2)
Stock.create(name: 'Investor Center', unit_price: 10.79, shares: 50000, user_id: 2)
Stock.create(name: 'Stratton Oakmont', unit_price: 53.23, shares: 20000, user_id: 2)

Order.create(name: 'Aerotyne International', unit_price: 5.12, shares: 10, stock_id: 1, user_id: 3)
Order.create(name: 'Investor Center', unit_price: 10.79, shares: 20, stock_id: 2, user_id: 3)
Order.create(name: 'Stratton Oakmont', unit_price: 53.23, shares: 50, stock_id: 3, user_id: 3)