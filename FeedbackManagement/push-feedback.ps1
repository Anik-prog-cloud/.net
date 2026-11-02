# Safe push script for FeedbackManagement repository
# Usage: Open PowerShell (prefer Developer PowerShell), then run:
#   powershell -ExecutionPolicy Bypass -File .\push-feedback.ps1

$repoPath = 'E:\vscc\FeedbackManagement'

# Project subfolder inside the solution
$projectFolder = 'FeedbackManagement'

$remoteUrl = 'https://github.com/Anik-prog-cloud/.net.git'

function ExitWithMessage($msg) {
	Write-Host $msg -ForegroundColor Yellow
	exit 1
}

# Check git
try {
	$gitVersion = git --version 2>$null
} catch {
	ExitWithMessage "Git is not available in this environment. Install Git and ensure it's on PATH."
}

# Change to repo
if (-not (Test-Path $repoPath)) {
	ExitWithMessage "Repository path '$repoPath' not found. Update the script with correct path."
}
Set-Location $repoPath

# Ensure inside a git repo
$inside = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0) {
	Write-Host "Not a git repository. Initializing repository at $repoPath..."
	git init
	if ($LASTEXITCODE -ne 0) { ExitWithMessage "Failed to initialize git repository." }
}

# Commit any outstanding changes
$status = git status --porcelain
if ($status) {
	Write-Host "Local working tree has changes. Will stage intended files only (not everything)."

	# Determine intended paths to add
	$pathsToAdd = @()
	if (Test-Path "$repoPath\FeedbackManagement.slnx") { $pathsToAdd += 'FeedbackManagement.slnx' }
	if (Test-Path "$repoPath\$projectFolder\$projectFolder.csproj") { $pathsToAdd += "$projectFolder/$projectFolder.csproj" }
	if (Test-Path "$repoPath\$projectFolder") {
		$pathsToAdd += "$projectFolder/Controllers"
		$pathsToAdd += "$projectFolder/Models"
		$pathsToAdd += "$projectFolder/Views"
		$pathsToAdd += "$projectFolder/App_Start"
		$pathsToAdd += "$projectFolder/Content"
		$pathsToAdd += "$projectFolder/Scripts"
		$pathsToAdd += "$projectFolder/Global.asax"
		$pathsToAdd += "$projectFolder/Web.config"
		$pathsToAdd += "$projectFolder/Properties"
	}

	if ($pathsToAdd.Count -eq 0) {
		Write-Host "No expected project files found to add. Skipping staging." -ForegroundColor Yellow
	} else {
		Write-Host "Staging these paths:`n$($pathsToAdd -join "`n")"
		foreach ($p in $pathsToAdd) { git add -- "$p" }

		git commit -m "Update: FeedbackManagement project changes"
		if ($LASTEXITCODE -ne 0) { Write-Host "No changes to commit or commit failed." }
	}
} else {
	Write-Host "Working tree clean."
}

# Add or update origin remote
$remotes = git remote
if ($remotes -match '^origin$') {
	Write-Host "Remote 'origin' exists. Setting URL to $remoteUrl"
	git remote set-url origin $remoteUrl
	if ($LASTEXITCODE -ne 0) { ExitWithMessage "Failed to set origin URL." }
} else {
	Write-Host "Adding remote 'origin' -> $remoteUrl"
	git remote add origin $remoteUrl
	if ($LASTEXITCODE -ne 0) { ExitWithMessage "Failed to add remote origin." }
}

# Fetch remote
Write-Host "Fetching origin..."
git fetch origin
if ($LASTEXITCODE -ne 0) { Write-Host "Fetch failed (remote may require authentication or be empty); continuing..." -ForegroundColor Yellow }

# Determine if remote has branches
$remoteHeads = git ls-remote --heads origin
if (-not $remoteHeads) {
	Write-Host "Remote appears empty. Pushing current branch and setting upstream..."
	# Stage only selected files/folders
	$pathsToAdd = @()
	if (Test-Path "$repoPath\FeedbackManagement.slnx") { $pathsToAdd += 'FeedbackManagement.slnx' }
	if (Test-Path "$repoPath\$projectFolder\$projectFolder.csproj") { $pathsToAdd += "$projectFolder/$projectFolder.csproj" }
	if (Test-Path "$repoPath\$projectFolder") {
		$pathsToAdd += "$projectFolder/Controllers"
		$pathsToAdd += "$projectFolder/Models"
		$pathsToAdd += "$projectFolder/Views"
		$pathsToAdd += "$projectFolder/App_Start"
		$pathsToAdd += "$projectFolder/Content"
		$pathsToAdd += "$projectFolder/Scripts"
		$pathsToAdd += "$projectFolder/Global.asax"
		$pathsToAdd += "$projectFolder/Web.config"
		$pathsToAdd += "$projectFolder/Properties"
	}

	if ($pathsToAdd.Count -eq 0) { ExitWithMessage "No expected project files found to add. Check path settings." }

	Write-Host "Staging these paths:`n$($pathsToAdd -join "`n")"
	foreach ($p in $pathsToAdd) { git add -- "$p" }

	git commit -m "Initial add: FeedbackManagement project"
	if ($LASTEXITCODE -ne 0) { Write-Host "No changes to commit or commit failed." -ForegroundColor Yellow }

	git push -u origin HEAD
	if ($LASTEXITCODE -ne 0) { ExitWithMessage "Push failed. Check authentication." }
	Write-Host "Push completed."; exit 0
}

# Determine remote default branch from remote show
$defaultBranch = ''
# Try to detect remote default branch
$symref = git ls-remote --symref origin HEAD 2>$null
if ($symref -match 'ref: refs/heads/(\S+)\s+HEAD') { $defaultBranch = $matches[1] }
if (-not $defaultBranch) {
	# fallback to common names
	$tryBranches = @('main','master')
	foreach ($b in $tryBranches) {
		$exists = git ls-remote --heads origin $b 2>$null
		if ($exists) { $defaultBranch = $b; break }
	}
}
if (-not $defaultBranch) { $defaultBranch = 'main' }

# If local does not have default branch name, try master as fallback
$localBranch = git rev-parse --abbrev-ref HEAD
if (-not $localBranch) { ExitWithMessage "Could not determine local branch." }

Write-Host "Remote default branch: $defaultBranch"
Write-Host "Local branch: $localBranch"

# Integrate remote changes safely
Write-Host "Attempting to rebase local changes onto origin/$defaultBranch (if it exists)..."
git rev-parse --verify origin/$defaultBranch > $null 2>&1
if ($LASTEXITCODE -eq 0) {
	$pullResult = git pull --rebase origin $defaultBranch
	if ($LASTEXITCODE -ne 0) {
		Write-Host "Rebase/pull reported non-zero exit. You may need to resolve conflicts manually." -ForegroundColor Yellow
		Write-Host "Run 'git status' and fix conflicts, then commit and run this script again."
		exit 1
	}
} else {
	Write-Host "origin/$defaultBranch does not exist; will push local branch to remote $defaultBranch after committing.";
}

# Push local HEAD to remote default branch without force
Write-Host "Pushing local branch to origin/$defaultBranch..."
git push origin HEAD:$defaultBranch
if ($LASTEXITCODE -ne 0) { ExitWithMessage "Push failed. Check authentication and remote history divergence." }

Write-Host "Push succeeded. Repository is up-to-date on origin/$defaultBranch." -ForegroundColor Green

# End of script
