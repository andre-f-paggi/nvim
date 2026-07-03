function Get-Greeting {
    param([string]$Name)
    "hello $Name"
}

Get-Greeting -Name 'world'
