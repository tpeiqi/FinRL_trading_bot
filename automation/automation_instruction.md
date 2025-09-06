# Automated Jupyter Notebook Execution (Windows + Task Scheduler)

This project includes automation scripts to **execute Jupyter notebooks
automatically** using a `.bat` file and Windows Task Scheduler.

------------------------------------------------------------------------

## ⚙️ Prerequisites

1.  **Install Anaconda / Miniconda**\
    Download and install from:
    <https://docs.conda.io/en/latest/miniconda.html>

2.  **Install nbconvert and Jupyter dependencies**

    ``` bash
    conda create -n tradingbot310 python=3.10
    conda activate tradingbot310
    pip install jupyter nbconvert jupyter_client ipykernel
    python -m ipykernel install --user --name tradingbot310 --display-name "Python (tradingbot310)"
    ```

    -   Replace `tradingbot310` with your own kernel/env name if needed.

    -   Verify your kernel exists:

        ``` bash
        jupyter kernelspec list
        ```

------------------------------------------------------------------------

## 📝 Example `.bat` File

Save the following as `run_trading_bot.bat`:

``` bat
@echo off
REM === Activate Anaconda base and run the notebook ===
CALL %USERPROFILE%\anaconda3\Scripts\activate.bat
CALL conda activate tradingbot310

jupyter nbconvert ^
  --to notebook ^
  --execute "C:\Users\tpeiq\Desktop\investment\FinRL\final\FinRL_models.ipynb" ^
  --ExecutePreprocessor.kernel_name=tradingbot310

EXIT
```

### Things to edit:

-   Replace `tradingbot310` with your kernel name.\
-   Replace the notebook path
    (`C:\Users\tpeiq\Desktop\investment\FinRL\final\FinRL_models.ipynb`)
    with the full path to your `.ipynb`.

------------------------------------------------------------------------

## ⏰ Automating with Task Scheduler

1.  Open **Task Scheduler** → **Create Task**.\
2.  **General Tab**:
    -   Name: `FinRL_Model_Training`\
    -   Run with highest privileges.\
3.  **Triggers Tab**:
    -   Add schedule (daily, weekly, or at logon).\
4.  **Actions Tab**:
    -   Action: **Start a program**\
    -   Program/script: Full path to your `.bat` file.\
5.  **Conditions Tab**:
    -   Check **Wake the computer to run this task** if needed.\
6.  **Settings Tab**:
    -   Enable **Run task as soon as possible after a scheduled start is
        missed**.

------------------------------------------------------------------------

## ⏰ Create Task Scheduler using Powershell (Example)

``` powershell
$Action   = New-ScheduledTaskAction -Execute "C:\Users\tpeiq\Desktop\investment\FinRL\final\automation\FinRL_model_train.bat"
$Trigger  = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At 4:00pm
$Settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -WakeToRun

Register-ScheduledTask -TaskName "FinRL_Model_Training" `
                       -Action $Action `
                       -Trigger $Trigger `
                       -Settings $Settings `
                       -RunLevel Highest `
                       -Description "Run model training notebook automation"

```

------------------------------------------------------------------------

## ⏰ Modify Task Scheduler using Powershell (Example)

``` powershell
$tasks = @("FinRL_Trading_Bot", "FinRL_Model_Training")

foreach ($taskName in $tasks) {
	$settings = (Get-ScheduledTask -TaskName $taskName).Settings
	$settings.StartWhenAvailable = $true
	$settings.WakeToRun        = $true

	# Persist the changes
	Set-ScheduledTask -TaskName $taskName -Settings $settings
}

Write-Output "Updated tasks to run when missed and wake PC: $($tasks -join ', ')"
```

------------------------------------------------------------------------

## ✅ Test Run

-   Double-click your `.bat` file → it should run the notebook and
    generate an executed `.ipynb`.\
-   From Task Scheduler, right-click the task → **Run**.

------------------------------------------------------------------------

## 📂 Output

By default, the notebook will overwrite itself with executed outputs.\
If you want separate timestamped outputs, modify your `.bat` like this:

``` bat
jupyter nbconvert ^
  --to notebook ^
  --execute "C:\path\to\notebook.ipynb" ^
  --ExecutePreprocessor.kernel_name=tradingbot310 ^
  --output "outputs\notebook_out.ipynb"
```

------------------------------------------------------------------------

## 🔧 Troubleshooting

-   **Conda not found** → Adjust the path to `activate.bat` (`anaconda3`
    vs `miniconda3`).\

-   **Kernel not found** → Check your kernel name with
    `jupyter kernelspec list`.\

-   **Notebook times out** → Add `--ExecutePreprocessor.timeout=3600`
    for 1-hour timeout.\

-   **Check logs** → Redirect output in `.bat`:

    ``` bat
    jupyter nbconvert ... 1>> run.log 2>&1
    ```

------------------------------------------------------------------------

Repeat the same process for `trading_bot_automation.bat` by changing the
notebook path and task name.
