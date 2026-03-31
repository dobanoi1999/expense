CREATE TYPE transaction_type AS ENUM ('income', 'expense', 'transfer');

CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  wallet_id UUID NOT NULL REFERENCES wallets(id) ON DELETE CASCADE,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  type transaction_type NOT NULL,
  amount NUMERIC(18,2) NOT NULL CHECK (amount > 0),
  currency VARCHAR(10) DEFAULT 'VND',
  exchange_rate NUMERIC(18,6) DEFAULT 1,
  note TEXT NULL,
  transaction_date DATE NOT NULL,
  transaction_time TIME NULL,
  to_wallet_id UUID NULL REFERENCES wallets(id) ON DELETE CASCADE,
  transfer_amount NUMERIC(18,2) NULL,
  recurring_id UUID NULL REFERENCES recurring_transactions(id) ON DELETE SET NULL,
  is_excluded BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_transactions_wallet_date ON transactions(wallet_id, transaction_date DESC);
CREATE INDEX idx_transactions_user_date ON transactions(user_id, transaction_date DESC);
CREATE INDEX idx_transactions_category_id ON transactions(category_id);

CREATE TABLE transaction_tags (
  transaction_id UUID NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
  tag VARCHAR(50) NOT NULL,
  PRIMARY KEY (transaction_id, tag)
);

CREATE TABLE attachments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  transaction_id UUID NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
  file_url TEXT NOT NULL,
  file_name VARCHAR(255),
  file_size INTEGER,
  mime_type VARCHAR(100),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
