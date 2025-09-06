$tasks = @("FinRL_Trading_Bot", "FinRL_Model_Training")

foreach ($taskName in $tasks) {
	$settings = (Get-ScheduledTask -TaskName $taskName).Settings
	$settings.StartWhenAvailable = $true
	$settings.WakeToRun        = $true

	# Persist the changes
	Set-ScheduledTask -TaskName $taskName -Settings $settings
}

Write-Output "Updated tasks to run when missed and wake PC: $($tasks -join ', ')"
