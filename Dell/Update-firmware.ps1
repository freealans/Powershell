Update-DellFirmware {
	<#
	.SYNOPSIS
	Will query and install Dell updates using Dell command Update.
	.DESCRIPTION
	This commnad will check to see that Dell command is installed on the system(s), then query and install udpates.
	.PARAMETER Computername
	One or more computernames or IP addresses to query.
	.PARAMETER LogErrors
	Specify this switch to create a text log file of computers that can't be queried.
	.PARAMETER ErrorLog
	When used with -LogErrors, specifies the file path and the name to which failed computer names will be writen.  Defaults to %userprofile%\Desktop\DellFirmwareUpgrade.txt.
	.EXAMPLE
	Update-DellFirmware -computername localhost
	#>
		[CmdletBinding()]
		param(
			[Parameter (Mandatory=$True, ValueFromPipeline=$True, HelpMessage="Computername or IP address")]
			[Alias('Hostname')]
			[string[]]$Computername,

			[string]$ErrorLog = '%userprofile%\Desktop\DellFirmwareUpgrade.txt',

			[switch]$LogErrors
		)
		Begin{
			Write-Verbose "Error log will be $ErrorLog"
		}
		Process{

			ForEach-Object ($Computer in $Computername){
				$Continue = $True
				Try {
					Write-Verbose "Connecting to machine $Computer"
					Invoke-Command -ComputerName $Computer -ScriptBlock {
						if (Test-Path -Path "%systemdrive%\Program Files\Dell\CommandUpdate\dcu-cli.exe")
						}
				}

				Catch{

				}
			}
		}
		End{}
}