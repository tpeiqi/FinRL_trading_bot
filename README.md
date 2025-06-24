# FinRL_trading_bot (Testing Phase)

> **Warning:**  
> This project is **in testing phase**. Use at your own risk.  
> No financial advice or guarantees.  
> Test thoroughly with paper trading before any real deployment.

## Overview

This repository contains a SMART live trading bot for multi-stock, multi-agent reinforcement learning (FinRL) with Tiger Brokers API integration.  
Key features include:

- **Multi-agent support:** Uses PPO, A2C, and SAC models (trained with [FinRL](https://github.com/AI4Finance-Foundation/FinRL)).
- **Live trading:** Connects to Tiger Brokers for real-time execution.
- **Daily stop-loss:** Prevents excessive losses by comparing account value to previous day.
- **Rolling Sharpe selection:** Dynamically picks the best-performing model.
- **Capital-aware execution:** Trades are limited by available cash and position sizes.
- **Comprehensive logging:** Logs trades, errors, and account status to `smart_trading_bot.log` and `smart_trading_bot_error.log`.
- **Transaction history:** Saves daily transaction summaries in `transaction_actions/`.

## Project Structure

```
a2c_account_value.csv
FinRL_models.ipynb
FinRL_trading_bot.ipynb
ppo_account_value.csv
sac_account_value.csv
smart_trading_bot_error.log
smart_trading_bot.log
data/
    account_value_yesterday.txt
    trade_data.csv
    train_data.csv
results/
    a2c/
    ppo/
    sac/
trained_models/
    agent_a2c.zip
    agent_ppo.zip
    agent_sac.zip
transaction_actions/
    transaction_YYYY-MM-DD.txt
```

## Requirements

- Python 3.8+
- [TigerOpen SDK](https://github.com/tigerfintech/openapi-python-sdk)
- [FinRL](https://github.com/AI4Finance-Foundation/FinRL)
- Other dependencies: `pandas`, `numpy`, `yfinance`, `stable-baselines3`, etc.

Install dependencies:
```sh
pip install -r requirements.txt
```
or, for TigerOpen:
```sh
pip install tigeropen
```

## Usage

1. **Configure Tiger Brokers API:**  
   Set your `TIGER_ID` and `TIGER_PAPER_ACCOUNT` as environment variables.  
   Place your private key at the specified path.

2. **Train or load RL models:**  
   Place trained model files in `trained_models/`.

3. **Run the bot:**  
   Execute the notebook [`FinRL_trading_bot.ipynb`](FinRL_trading_bot.ipynb) in Jupyter or VSCode.

4. **Check logs:**  
   - Info: `smart_trading_bot.log`
   - Errors: `smart_trading_bot_error.log`
   - Daily transactions: `transaction_actions/transaction_YYYY-MM-DD.txt`

## Disclaimer

- This bot is **experimental** and for research/testing only.
- No warranty or liability for financial loss.
- Always use paper trading for testing.

---

**Author:**  
PQ
24 Jun 2025
