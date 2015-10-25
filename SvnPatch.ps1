$SvnRevisionOneLine = (git svn log --oneline -1) | Out-String
$pos = $SvnRevisionOneLine.IndexOf(" | ")
$SvnRevision = $SvnRevisionOneLine.Substring(1, $pos-1)
git diff | Where { $_ -notmatch "^diff[ ]--git[ ]a/" } | Where { $_ -notmatch "^index[ ]\w{7}[.]{2}\w{7}[ ]\d{5}" } | %{if($_ -match [regex]::escape("--- a/")){$_ += "	(revision $SvnRevision)"}; $_} | ForEach-Object { $_ -replace [regex]::escape("--- a/"), "--- " } | %{if($_ -match [regex]::escape("+++ b/")){$_ += "	(working copy)"}; $_} | ForEach-Object { $_ -replace [regex]::escape("+++ b/"), "+++ " } | Set-Content ("patchSvn.diff")
