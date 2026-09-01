Add-Type -AssemblyName System.Drawing

$src = "G:\Shared drives\5 Marketing and Branding\Logos\Prox Search Capital Logo Suite\PROX Brandmark-1.png"
$dst = "C:\Users\mtaut\OneDrive\Desktop\Website\assets\logos"

$img = [System.Drawing.Bitmap]::new($src)
$W = $img.Width; $H = $img.Height

# opaque bounding box + modal colour of the mark
$minX = $W; $minY = $H; $maxX = -1; $maxY = -1
$rs = 0.0; $gs = 0.0; $bs = 0.0; $n = 0
for ($y = 0; $y -lt $H; $y++) {
  for ($x = 0; $x -lt $W; $x++) {
    $p = $img.GetPixel($x, $y)
    if ($p.A -gt 128) {
      if ($x -lt $minX) { $minX = $x }; if ($x -gt $maxX) { $maxX = $x }
      if ($y -lt $minY) { $minY = $y }; if ($y -gt $maxY) { $maxY = $y }
      $rs += $p.R; $gs += $p.G; $bs += $p.B; $n++
    }
  }
}
$bw = $maxX - $minX + 1; $bh = $maxY - $minY + 1
Write-Host ("source      {0}x{1}" -f $W, $H)
Write-Host ("opaque bbox x {0}..{1}  y {2}..{3}   ({4}x{5})" -f $minX, $maxX, $minY, $maxY, $bw, $bh)
Write-Host ("mean mark colour  #{0:X2}{1:X2}{2:X2}   coverage {3}%" -f [int]($rs/$n), [int]($gs/$n), [int]($bs/$n), [int](100*$n/($W*$H)))

# Render the trimmed mark into a square canvas at `size`, with `padPct` breathing room.
function Icon($size, $padPct, $bg, $out) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  if ($bg) { $g.Clear($bg) } else { $g.Clear([System.Drawing.Color]::Transparent) }

  $inner = $size * (1.0 - 2.0 * $padPct)
  $scale = $inner / [double][Math]::Max($bw, $bh)
  $dw = $bw * $scale; $dh = $bh * $scale
  $dx = ($size - $dw) / 2.0; $dy = ($size - $dh) / 2.0
  $g.DrawImage($img, (New-Object System.Drawing.RectangleF $dx, $dy, $dw, $dh),
                     (New-Object System.Drawing.RectangleF $minX, $minY, $bw, $bh),
                     [System.Drawing.GraphicsUnit]::Pixel)
  $g.Dispose()
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Host ("{0}  {1}x{1}  {2}KB" -f (Split-Path $out -Leaf), $size, [int]((Get-Item $out).Length/1KB))
}

$white = [System.Drawing.Color]::FromArgb(255,255,255,255)

Icon 16  0.02 $null "$dst\favicon-16.png"
Icon 32  0.03 $null "$dst\favicon-32.png"
Icon 48  0.03 $null "$dst\favicon-48.png"
# Apple composites transparency onto black, so this one gets a white ground.
Icon 180 0.14 $white "$dst\apple-touch-icon.png"

# keep the untouched source in the repo too
Copy-Item $src "$dst\prox-brandmark-1.png" -Force
$img.Dispose()
Write-Host "prox-brandmark-1.png copied"
