CREATE TYPE recurring_frequency AS ENUM ('daily', 'weekly', 'monthly', 'yearly');
CREATE TYPE recurring_type AS ENUM ('income', 'expense');

CREATE TABLE recurring_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  wallet_id UUID NOT NULL REFERENCES wallets(id) ON DELETE CASCADE,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  type recurring_type NOT NULL,
  amount NUMERIC(18,2) NOT NULL,
  note TEXT NULL,
  frequency recurring_frequency NOT NULL,
  frequency_interval SMALLINT DEFAULT 1,
  start_date DATE NOT NULL,
  end_date DATE NULL,
  next_due_date DATE NOT NULL,
  last_executed_at TIMESTAMPTZ NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
