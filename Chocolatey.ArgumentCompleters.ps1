<#
 # Argument Completion for Chocolatey
 # WORK IN PROGRESS!!!
 #>

function Get-ChocolateyCommands {
   [PSCustomObject]@{Argument='list'; ToolTip='lists remote or local packages'; Enabled=$True}
   [PSCustomObject]@{Argument='search'; ToolTip='searches remote or local packages (alias for list)'; Enabled=$True}
   [PSCustomObject]@{Argument='info'; ToolTip='retrieves package information. Shorthand for choco search pkgname --exact --verbose'; Enabled=$True}
   [PSCustomObject]@{Argument='install'; ToolTip='installs packages from various sources'; Enabled=$True}
   [PSCustomObject]@{Argument='pin'; ToolTip='suppress upgrades for a package'; Enabled=$True}
   [PSCustomObject]@{Argument='outdated'; ToolTip='retrieves packages that are outdated. Similar to upgrade all --noop'; Enabled=$True}
   [PSCustomObject]@{Argument='upgrade'; ToolTip='upgrades packages from various sources'; Enabled=$True}
   [PSCustomObject]@{Argument='uninstall'; ToolTip='uninstalls a package'; Enabled=$True}
   [PSCustomObject]@{Argument='pack'; ToolTip='packages up a nuspec to a compiled nupkg'; Enabled=$True}
   [PSCustomObject]@{Argument='push'; ToolTip='pushes a compiled nupkg'; Enabled=$True}
   [PSCustomObject]@{Argument='new'; ToolTip='generates files necessary for a chocolatey package from a template'; Enabled=$True}
   [PSCustomObject]@{Argument='sources'; ToolTip='view and configure default sources (alias for source)'; Enabled=$True}
   [PSCustomObject]@{Argument='source'; ToolTip='view and configure default sources'; Enabled=$True}
   [PSCustomObject]@{Argument='config'; ToolTip='Retrieve and configure config file settings'; Enabled=$True}
   [PSCustomObject]@{Argument='features'; ToolTip='view and configure choco features (alias for feature)'; Enabled=$True}
   [PSCustomObject]@{Argument='feature'; ToolTip='view and configure choco features'; Enabled=$True}
   [PSCustomObject]@{Argument='setapikey'; ToolTip='retrieves or saves an apikey for a particular source (alias for apikey)'; Enabled=$True}
   [PSCustomObject]@{Argument='apikey'; ToolTip='retrieves or saves an apikey for a particular source'; Enabled=$True}
   [PSCustomObject]@{Argument='unpackself'; ToolTip='have chocolatey set it self up'; Enabled=$True}
   [PSCustomObject]@{Argument='version'; ToolTip='[DEPRECATED] will be removed in v1'; ToolTip='use choco outdated or cup <pkg|all> -whatif instead'; Enabled=$False}
   [PSCustomObject]@{Argument='update'; ToolTip='[DEPRECATED] RESERVED for future use (you are looking for upgrade, these are not the droids you are looking for)'; Enabled=$False}
   [PSCustomObject]@{Argument='download'; ToolTip='downloads packages'; ToolTip='optionally downloading and internalizing all remote resources (recompiling)'; Enabled=$True}
}

#function Chocolatey_CommandCompletion {
#   param($wordToComplete, $commandAst)  
#}

# cuninst
function Chocolatey_UninstallArgumentCompletion 
{
    param($wordToComplete, $commandAst)

    $packages = clist -lo
    
    $packages |
        Where-Object { $_ -notlike '*packages installed.' -and $_ -like "$wordToComplete*" } |
        ForEach-Object {
            $ToolTip = "{0}" -f $_
            New-CompletionResult -CompletionText $_.split(" ")[0] -ToolTip $ToolTip
        }
}

Register-ArgumentCompleter `
   -Command ('cuninst', 'choco uninstall') `
   -Native `
   -ScriptBlock $function:Chocolatey_UninstallArgumentCompletion `
   -Description 'cuninst package_name'
