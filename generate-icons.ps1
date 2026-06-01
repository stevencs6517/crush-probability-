Add-Type -AssemblyName System.Drawing

function New-Icon([int]$S, [string]$Path) {
  $bmp = New-Object System.Drawing.Bitmap($S, $S)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

  # Full-bleed diagonal gradient background (matches app accent).
  $rect = New-Object System.Drawing.Rectangle(0, 0, $S, $S)
  $c1 = [System.Drawing.Color]::FromArgb(255, 77, 166, 255)   # #4DA6FF
  $c2 = [System.Drawing.Color]::FromArgb(255, 111, 211, 255)  # #6FD3FF
  $bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $c1, $c2, 45)
  $g.FillRectangle($bg, $rect)

  # White heart (two humps + triangle to the tip), within the maskable safe zone.
  $r = [double]($S * 0.20)
  $humpY = [double]($S * 0.40)
  $cx = [double]($S * 0.5)
  $xL = $cx - ($r * 0.95)
  $xR = $cx + ($r * 0.95)
  $white = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)

  $g.FillEllipse($white, [single]($xL - $r), [single]($humpY - $r), [single]($r * 2), [single]($r * 2))
  $g.FillEllipse($white, [single]($xR - $r), [single]($humpY - $r), [single]($r * 2), [single]($r * 2))

  $p1 = New-Object System.Drawing.PointF([single]($xL - $r), [single]$humpY)
  $p2 = New-Object System.Drawing.PointF([single]($xR + $r), [single]$humpY)
  $p3 = New-Object System.Drawing.PointF([single]$cx, [single]($S * 0.82))
  $g.FillPolygon($white, @($p1, $p2, $p3))

  $g.Dispose()
  $bmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Host "wrote $Path ($S x $S)"
}

$dir = Join-Path $PSScriptRoot "tools"
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
New-Icon 512 (Join-Path $dir "icon-512.png")
New-Icon 192 (Join-Path $dir "icon-192.png")
New-Icon 180 (Join-Path $dir "apple-touch-icon.png")
