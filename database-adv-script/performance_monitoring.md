# Monitor and Refine Database Performance

## Step 1: Baseline Query & Performance Plan

```sql
    EXPLAIN ANALYZE
    SELECT b.booking_id, b.status, p.name AS property_name, py.amount, u.name AS user_name
    FROM bookings_partitioned b
    JOIN users u ON b.user_id = u.user_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN payments py ON b.booking_id = py.booking_id
    WHERE b.start_date BETWEEN '2025-07-01' AND '2025-07-31' AND b.status = 'confirmed';
```

### Observed Plan

- Sequential scan on bookings_partitioned
- Hash joins instead of index scans
- High cost: 110.62
- Row width: large (many columns fetched)


```sql
    -- For filter conditions
    CREATE INDEX idx_bookings_start_status ON bookings_partitioned (start_date, status);

    -- For join columns
    CREATE INDEX idx_bookings_user_id ON bookings_partitioned (user_id);
    CREATE INDEX idx_bookings_property_id ON bookings_partitioned (property_id);
    CREATE INDEX idx_bookings_booking_id ON bookings_partitioned (booking_id);

    -- On foreign tables
    CREATE INDEX idx_users_user_id ON users (user_id);
    CREATE INDEX idx_properties_property_id ON properties (property_id);
    CREATE INDEX idx_payments_booking_id ON payments (booking_id);

    -- Refresh statistics
    ANALYZE bookings_partitioned, users, properties, payments;
```

## Retesting

```sql
    EXPLAIN ANALYZE
    SELECT b.booking_id, b.status, p.name AS property_name, py.amount, u.name AS user_name
    FROM bookings_partitioned b
    JOIN users u ON b.user_id = u.user_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN payments py ON b.booking_id = py.booking_id
    WHERE b.start_date BETWEEN '2025-07-01' AND '2025-07-31' AND b.status = 'confirmed';
```

## Expected Improvements:

- Partition pruning activates: only July partition scanned ✅
- Index scan replaces seq scan ✅
- Nested loop joins or bitmap index scan ✅
- Execution time reduced from ~110ms → ~25ms

