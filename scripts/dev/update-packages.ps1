$regex = [regex] 'PackageReference Include="([^"]*)" Version="([^"]*)"'
ForEach ($file in Get-ChildItem $PWD\..\..\src -Recurse | Where-Object { $_.extension -like "*proj" })
{
  $proj = $file.fullname
  $content = Get-Content $proj
  $match = $regex.Match($content)
  if ($match.Success) {
    $name = $match.Groups[1].Value
    $version = $match.Groups[2].Value
    if ($version -notin "-") {
      Invoke-Expression "dotnet add $proj package $name"
    }
  }
}