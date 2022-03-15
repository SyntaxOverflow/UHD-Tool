### Functions ###

function test {
    if ([string]::IsNullOrWhiteSpace($Eingabefeld.Text)) {
        $Ausgabefeld.Text = "Keine Eingabe!"
        return
    }
    
    $Eingabe = $Eingabefeld.Text.Trim()
    
    $Ausgabefeld.Text = "Deine Eingabe war: $Eingabe"

    $Eingabefeld.Items.Insert(0, $Eingabe)
}

### GUI ###

#Add WPF
Add-Type -AssemblyName PresentationFramework

#Get GUI xaml
[xml]$xaml = Get-Content "$PSScriptRoot\gui.xml"
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

#Get GUI Elements
$Eingabefeld = $window.FindName("Eingabefeld")
$Knopf1 = $window.FindName("Knopf1")
$Knopf2 = $window.FindName("Knopf2")
$Knopf3 = $window.FindName("Knopf3")
$Knopf4 = $window.FindName("Knopf4")
$Knopf5 = $window.FindName("Knopf5")
$Knopf6 = $window.FindName("Knopf6")
$Ausgabefeld = $window.FindName("Ausgabefeld")

#Give buttons a purpose
$Knopf1.Add_Click{ (test) }
$Knopf2.Add_Click{ (test) }
$Knopf3.Add_Click{ (test) }
$Knopf4.Add_Click{ (test) }
$Knopf5.Add_Click{ (test) }
$Knopf6.Add_Click{ (test) }

#Show-Gui
[void]$window.ShowDialog()