# claude-switch

Switch Claude Code between saved endpoint/token profiles (e.g. several Snowflake Cortex accounts, or direct Anthropic), with per-profile spend vs budget bars for Snowflake accounts.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/neonxsl/claude-switch/main/install.sh | sh
```

Installs to `~/.local/bin/claude-switch` (set `PREFIX=/other/dir` to change). Requires `python3` (stdlib only).

## Usage

```
claude-switch              list profiles with total spend (* = active)
claude-switch <n|name>     activate a profile
claude-switch add          add a profile (prompts; token input hidden)
claude-switch rm <n|name>  remove a profile
claude-switch budget <n|name> <usd>   set a profile's budget
claude-switch test [n|name]   send one real request; shows OK or the exact API error
claude-switch --version
```

Activating a profile sets `env.ANTHROPIC_BASE_URL` and `apiKeyHelper` in `~/.claude/settings.json` (a timestamped backup is written first). For Snowflake endpoints it also appends `/api/v2/cortex` to the base URL if missing and sets `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` (Cortex rejects Claude Code's beta headers otherwise). Restart Claude Code to apply.

## Storage

- Profiles: `~/.claude/profiles.json` (chmod 600)
- Tokens: `~/.claude/tokens/<name>` (chmod 600), or any file via `@/path/to/file` when adding

No tokens are stored in this repo.

## Spend

For `*.snowflakecomputing.com` endpoints, total spend is read from `snowflake.organization_usage.usage_in_currency_daily` using the profile's PAT. The role needs access to `SNOWFLAKE.ORGANIZATION_USAGE`; otherwise the list shows `no billing access`. Default budget is $400.
