CREATE TYPE category_type AS ENUM ('income', 'expense', 'transfer');

CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NULL REFERENCES users(id) ON DELETE CASCADE,
  parent_id UUID NULL REFERENCES categories(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  type category_type NOT NULL,
  icon VARCHAR(50) NULL,
  color VARCHAR(7) NULL,
  is_system BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
