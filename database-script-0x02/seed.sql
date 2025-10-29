-- Insert Users (mix of guests, hosts, and admin)
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
(UUID(), 'John', 'Doe', 'john.doe@email.com', 'hashed_password_1', '+1234567890', 'host'),
(UUID(), 'Jane', 'Smith', 'jane.smith@email.com', 'hashed_password_2', '+1234567891', 'guest'),
(UUID(), 'Admin', 'User', 'admin@system.com', 'hashed_password_3', '+1234567892', 'admin'),
(UUID(), 'Mary', 'Johnson', 'mary.j@email.com', 'hashed_password_4', '+1234567893', 'host'),
(UUID(), 'Robert', 'Wilson', 'rob.wilson@email.com', 'hashed_password_5', '+1234567894', 'guest');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
(UUID(), (SELECT user_id FROM User WHERE email = 'john.doe@email.com'), 
'Beachfront Villa', 'Luxury villa with ocean view', 'Miami, FL', 299.99),
(UUID(), (SELECT user_id FROM User WHERE email = 'mary.j@email.com'),
'Mountain Cabin', 'Cozy cabin in the woods', 'Aspen, CO', 199.99),
(UUID(), (SELECT user_id FROM User WHERE email = 'john.doe@email.com'),
'City Apartment', 'Modern downtown loft', 'New York, NY', 150.00);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
(UUID(), 
(SELECT property_id FROM Property WHERE name = 'Beachfront Villa'),
(SELECT user_id FROM User WHERE email = 'jane.smith@email.com'),
'2024-01-10', '2024-01-15', 1499.95, 'confirmed'),
(UUID(),
(SELECT property_id FROM Property WHERE name = 'Mountain Cabin'),
(SELECT user_id FROM User WHERE email = 'rob.wilson@email.com'),
'2024-02-01', '2024-02-05', 799.96, 'pending');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
(UUID(),
(SELECT booking_id FROM Booking WHERE user_id = (SELECT user_id FROM User WHERE email = 'jane.smith@email.com')),
1499.95, 'credit_card');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
(UUID(),
(SELECT property_id FROM Property WHERE name = 'Beachfront Villa'),
(SELECT user_id FROM User WHERE email = 'jane.smith@email.com'),
5, 'Amazing property with stunning views!');

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
(UUID(),
(SELECT user_id FROM User WHERE email = 'jane.smith@email.com'),
(SELECT user_id FROM User WHERE email = 'john.doe@email.com'),
'Is the beach villa available next month?');
