@echo off
REM === Activate Anaconda base and run the trading bot notebook ===
CALL C:\Users\%USERNAME%\anaconda3\Scripts\activate.bat
CALL conda activate tradingbot310

jupyter nbconvert ^
  --to notebook ^
  --execute "C:/Users/tpeiq/Desktop/investment/FinRL/final/FinRL_trading_bot.ipynb" ^
  --ExecutePreprocessor.kernel_name=trading-bot


jupyter nbconvert ^
  --to notebook ^
  --execute "C:/Users/tpeiq/Desktop/investment/FinRL/final/FinRL_trading_bot_demo.ipynb" ^
  --ExecutePreprocessor.kernel_name=trading-bot

EXIT