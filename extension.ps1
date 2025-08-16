# PowerShell script to download and extract files


# Create the folder if it doesn't exist
$folderPath = "$env:USERPROFILE\Downloads"

# Downloading the first file
curl -o "$folderPath\1.zip" "https://drive.usercontent.google.com/download?id=16v8fXTl_g3u9PbA3MlIUCMCjevUrwgyy&export=download"

# Downloading the second file
curl -o "$folderPath\2.zip" "https://drive.usercontent.google.com/u/0/uc?id=19tqerOt_5WZVvSWZ9xjj-HAVAm6AbPfi&export=download"



# Extract the first file
Expand-Archive -Path "$folderPath\1.zip" -DestinationPath "$folderPath"

# Extract the second file
Expand-Archive -Path "$folderPath\2.zip" -DestinationPath "$folderPath"


