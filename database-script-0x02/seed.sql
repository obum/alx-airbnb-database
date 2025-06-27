-- 🎭 User Roles
INSERT INTO user_roles (role_id, role_name, description) VALUES
  (1, 'guest', 'User who can book properties'),
  (2, 'host', 'User who can list properties'),
  (3, 'admin', 'User with platform privileges');

-- 💳 Payment Methods
INSERT INTO payment_methods (method_id, name, description) VALUES
  (1, 'credit_card', 'Visa, MasterCard, AMEX'),
  (2, 'paypal', 'PayPal digital payments'),
  (3, 'stripe', 'Stripe-based checkout');

-- 👥 Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Ada', 'Obi', 'ada@example.com', 'hash1', '08031234567', 2),
  ('22222222-2222-2222-2222-222222222222', 'Uche', 'Balogun', 'uche@example.com', 'hash2', '08099887766', 1),
  ('33333333-3333-3333-3333-333333333333', 'Zainab', 'Okoro', 'zainab@example.com', 'hash3', '08123456789', 3);

-- 🏡 Properties
INSERT INTO properties (property_id, host_id, name, description, country, state, city, address_line, latitude, longitude, pricepernight) VALUES
  ('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Lagos Island Loft', 'Cozy 2-bedroom apartment with ocean view.', 'Nigeria', 'Lagos', 'Lagos Island', '12 Ocean Drive', 6.5244, 3.3792, 450.00);

-- 🧾 Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
  ('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', '2025-07-01', '2025-07-05', 1800.00, 'confirmed');
  ('ccccccc2-cccc-cccc-cccc-cccccccccccc', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', '2025-08-01', '2025-08-05', 1800.00, 'confirmed');

-- 💸 Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
  ('ccccccc1-cccc-cccc-cccc-cccccccccccc', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 1800.00, 1);
  ('cccccc11-cccc-cccc-cccc-cccccccccccc', 'ccccccc2-cccc-cccc-cccc-cccccccccccc', 2000.00, 2);
 

-- 📝 Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
  ('ddddddd1-dddd-dddd-dddd-dddddddddddd', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 5, 'Beautiful place — loved the view!');

-- ✉️ Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
  ('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeeee', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi Ada, is the apartment available next weekend?');

-- 👥 Role Assignments (multi-role support)
INSERT INTO user_role_assignments (assignment_id, user_id, role_id, assigned_at, is_active) VALUES
  ('fffffff1-ffff-ffff-ffff-ffffffffffff', '22222222-2222-2222-2222-222222222222', 1, CURRENT_TIMESTAMP, true),
  ('fffffff2-ffff-ffff-ffff-fffffffffff1', '11111111-1111-1111-1111-111111111111', 2, CURRENT_TIMESTAMP, true);
