## Test Cases and Tags

## The idea is NOT that you copy and paste this code
## and use it in your environment but that you alter
## it to do what YOU want

cd 'Git:\PSConfAsiaPreCon\Slides and Demos\08 - Pester'

## You can run all of the .Tests.ps1 files in a folder with
##  Invoke-Pester
##  The tag allows us to only run certain tests
## Look in the .Tests.ps1 file

Invoke-Pester -Tag Backup

Invoke-Pester -Tag DiskSpace

Invoke-Pester -tag Collation

Invoke-Pester -Tag DBCC

Invoke-Pester -Tag VLF

Invoke-Pester -Tag Latency

Invoke-Pester -Tag Memory

Invoke-Pester -Tag TempDB
Test-DbaTempDbConfiguration -SqlInstance ROb-XPS

Invoke-Pester -Tag ServerName

Invoke-Pester -Tag LinkedServer

Invoke-Pester -Tag Connection

Invoke-Pester -Tag JobOwner

Invoke-Pesters -Tag XEvents

Invoke-Pester -Tag PowerPlan

Invoke-Pester -Tag AdHoc

Invoke-Pester -Tag Compatability

Invoke-Pester -Tag Owner

Invoke-Pester -Tag Server

Invoke-Pester -Tag Instance

## Or run ALL of them
## The idea is NOT that you copy and paste this code
## and use it in your environment but that you alter
## it to do what YOU want
Invoke-Pester