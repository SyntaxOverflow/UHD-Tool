### Functions ###
function f_ping {
    if ([string]::IsNullOrWhiteSpace($cInput.Text)) {
        $cOutput.Text = "Invalid input"
        return
    }
    $cHostname = $cInput.Text.Trim()
    $cOutput.Text = "Pinging $cHostname"
    ping $cHostname | Where-Object { $cOutput.AppendText($_ + "`r`n"); $window.Dispatcher.Invoke([action] { }, "Render") }
}

function f_msra {
    if ([string]::IsNullOrWhiteSpace($cInput.Text)) {
        $cOutput.Text = "Invalid input"
        return
    }
    $cHostname = $cInput.Text.Trim()
    msra.exe /offerra $cHostname
    if($cInput.Items.Count -eq 0 -OR $cHostname -ne $cInput.Items.item(0)){$cInput.Items.Insert(0,$cHostname)}
    $cInput.Text = ""
}

function f_mstsc {
    if ([string]::IsNullOrWhiteSpace($cInput.Text)) {
        $cOutput.Text = "Invalid input"
        return
    }
    $cHostname = $cInput.Text.Trim()
    mstsc.exe /v:$cHostname
    if($cInput.Items.Count -eq 0 -OR $cHostname -ne $cInput.Items.item(0)){$cInput.Items.Insert(0,$cHostname)}
    $cInput.Text = ""
}

function f_info {
    if ([string]::IsNullOrWhiteSpace($cInput.Text)) {
        $cOutput.Text = "Invalid input"
        return
    }
    $cHostname = $cInput.Text.Trim()
    if($cInput.Items.Count -eq 0 -OR $cHostname -ne $cInput.Items.item(0)){$cInput.Items.Insert(0,$cHostname)}
    $cInput.Text = ""
}

function f_user {
    if ([string]::IsNullOrWhiteSpace($uInput.Text)) {
        $uOutput.Text = "Invalid input"
        return
    }
    $uSamAccountName = $uInput.Text.Trim()
    $UserData = Get-ADUser $uSamAccountName
    #Needs testing!
    #$uOutput.Text = $UserData.ToString()
    #$UserData | Where-Object { $uOutput.AppendText($_ + "`r`n")}
}

### GUI ###
#Add WPF
Add-Type -AssemblyName PresentationFramework

#Get GUI xaml
[xml]$xaml = (Get-Content "$PSScriptRoot\gui.xml") -replace "x:Name=", "Name="
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
#Create a Variable foreach xaml element with a name
$xaml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name ($_.Name) -Value $window.FindName($_.Name) }

#Give Buttons a purpose
$cPing.Add_Click({ f_ping })
$cMSRA.Add_Click({ f_msra })
$cMSTSC.Add_Click({ f_mstsc })
$cInfo.Add_Click({ f_info })
$uSearch.Add_Click({ f_user })

#Show-Gui
[void]$window.ShowDialog()