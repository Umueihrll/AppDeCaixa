CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role VARCHAR(20) NOT NULL -- 'cashier', 'manager'
);

CREATE TABLE registers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  location VARCHAR(100)
);

CREATE TABLE shifts (
  id SERIAL PRIMARY KEY,
  register_id INTEGER REFERENCES registers(id),
  user_id INTEGER REFERENCES users(id),
  open_time TIMESTAMPTZ NOT NULL,
  close_time TIMESTAMPTZ,
  initial_balance NUMERIC(10,2) NOT NULL,
  final_balance NUMERIC(10,2)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  shift_id INTEGER REFERENCES shifts(id) NOT NULL,
  type VARCHAR(10) CHECK (type IN ('entry', 'outtake', 'tip')) NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  note TEXT
);