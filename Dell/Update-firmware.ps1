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

			#Define Functions
			function Test-DellCommandInstalled {
				[CmdletBinding()]
				Param(
					[string]$Pathx64 = "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe"
					[string]$Pathx32 = "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe"
				)

					if (Test-Path -Path $Pathx64){
						Write-host "Dell Command Update 64bit is installed."
						}

				Elseif (Test-Path -Path $Pathx32){
						Write-Host "Dell Command Update 32Bit is installed."
						}	
				
				Else {
						Write-host "You need to install Dell Command Update."
						}
			}
			
			Function Install-DellCommandUpdate{
				
			}

			#Define Error log
			Write-Verbose "Error log will be $ErrorLog"
		}
		Process{

			ForEach-Object ($Computer in $Computername){
				$Continue = $True

				Try {
					Write-Verbose "Connecting to machine $Computer"
					$Session = New-PSSession -ComputerName $computer -ErrorAction 
					$Continue = $True
				}

				Catch{

				}

				Invoke-Command -session $Session -ScriptBlock {
						
						}


			}
		}
		End{}
}