# Build a real multi-size .ico with embedded PNGs (Vista+ format).
$dst   = "C:\Users\mtaut\OneDrive\Desktop\Website"
$logos = "$dst\assets\logos"
$parts = @("$logos\favicon-16.png", "$logos\favicon-32.png", "$logos\favicon-48.png")

$blobs = @()
foreach ($p in $parts) { $blobs += ,([System.IO.File]::ReadAllBytes($p)) }

$ms = New-Object System.IO.MemoryStream
$bw = New-Object System.IO.BinaryWriter($ms)

$bw.Write([uint16]0)              # reserved
$bw.Write([uint16]1)              # type: icon
$bw.Write([uint16]$blobs.Count)   # image count

$offset = 6 + (16 * $blobs.Count)
$sizes  = @(16, 32, 48)
for ($i = 0; $i -lt $blobs.Count; $i++) {
  $s = $sizes[$i]
  $bw.Write([byte]$s)             # width  (0 would mean 256)
  $bw.Write([byte]$s)             # height
  $bw.Write([byte]0)              # palette count
  $bw.Write([byte]0)              # reserved
  $bw.Write([uint16]1)            # colour planes
  $bw.Write([uint16]32)           # bits per pixel
  $bw.Write([uint32]$blobs[$i].Length)
  $bw.Write([uint32]$offset)
  $offset += $blobs[$i].Length
}
foreach ($b in $blobs) { $bw.Write($b) }

$bw.Flush()
[System.IO.File]::WriteAllBytes("$dst\favicon.ico", $ms.ToArray())
$bw.Dispose(); $ms.Dispose()

$f = Get-Item "$dst\favicon.ico"
Write-Host ("favicon.ico  {0} sizes (16/32/48)  {1} bytes" -f $blobs.Count, $f.Length)

# sanity check: re-read the header
$raw = [System.IO.File]::ReadAllBytes($f.FullName)
Write-Host ("header  reserved={0} type={1} count={2}" -f [BitConverter]::ToUInt16($raw,0), [BitConverter]::ToUInt16($raw,2), [BitConverter]::ToUInt16($raw,4))
