$cfgFile = "\\truenas.syrentec.net\public\GitHub\VizioTVPowershell\Integrations_Config.json"
$tvInfo = Get-Content $cfgFile -Raw | ConvertFrom-Json
$tvInfo

$tvInfo.VizioAPI
$tvInfo.'Xavier TV'
$tvInfo.'Gabriel TV'
$tvInfo.'Amanda TV'


$tgtDevice = $($tvInfo.'Xavier TV')
$tgtDevice.Name

[string]$deviceName = $($tgtDevice.Name)
[int]$deviceId = 1
[string]$IPAddress = $($tgtDevice.IPAddress)
pathping $IPAddress

	$payload = @{
		DEVICE_ID=$deviceId;
		DEVICE_NAME=$deviceName
	} | ConvertTo-Json

	$response = Send-Command -path '/pairing/start' -Method 'PUT' -data $payload -ip $IPAddress

	$tvPin = Read-Host -Prompt 'Input the Pin displayed on the screen: '
	$tvPin = $tvPin

	$payload = @{
		DEVICE_ID=$deviceId;
		CHALLENGE_TYPE=$response.ITEM.CHALLENGE_TYPE;
		RESPONSE_VALUE=$tvPin;
		PAIRING_REQ_TOKEN=$response.ITEM.PAIRING_REQ_TOKEN
	} | ConvertTo-Json

	$response = Send-Command -path '/pairing/pair' -Method PUT -data $payload -ip $IPAddress
return

@concat(dataset().RunType,'/sites/',formatDateTime(string(dataset().StartTime), 'yyyy'),'/', formatDateTime(string(dataset().StartTime), 'MM'),'/',formatDateTime(string(dataset().StartTime), 'dd'),'/',string(dataset().Runid))
@concat(dataset().RunType,'/siteswithownerresolved','/',formatDateTime(string(dataset().StartTime), 'yyyy'),'/', formatDateTime(string(dataset().StartTime), 'MM'),'/',formatDateTime(string(dataset().StartTime), 'dd'),'/',string(dataset().Runid))
7035542652