CREATE TYPE social_provider AS ENUM ('google', 'facebook', 'apple');

CREATE TABLE social_accounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  provider social_provider NOT NULL,
  provider_user_id VARCHAR(255) NOT NULL,
  access_token TEXT NULL,
  refresh_token TEXT NULL,
  token_expires_at TIMESTAMPTZ NULL,
  profile_data JSONB NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (provider, provider_user_id)
);

CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  refresh_token_hash VARCHAR(255) UNIQUE NOT NULL,
  device_info JSONB NULL,
  ip_address INET NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
