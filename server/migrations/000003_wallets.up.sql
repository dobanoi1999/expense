CREATE TYPE wallet_type AS ENUM ('cash', 'bank', 'credit', 'investment', 'shared');
CREATE TYPE wallet_role AS ENUM ('owner', 'editor', 'viewer');

CREATE TABLE wallets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  type wallet_type NOT NULL,
  currency VARCHAR(10) DEFAULT 'VND',
  initial_balance NUMERIC(18,2) DEFAULT 0,
  current_balance NUMERIC(18,2) DEFAULT 0,
  color VARCHAR(7) NULL,
  icon VARCHAR(50) NULL,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE wallet_members (
  wallet_id UUID NOT NULL REFERENCES wallets(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role wallet_role NOT NULL,
  invited_at TIMESTAMPTZ DEFAULT NOW(),
  accepted_at TIMESTAMPTZ NULL,
  PRIMARY KEY (wallet_id, user_id)
);
