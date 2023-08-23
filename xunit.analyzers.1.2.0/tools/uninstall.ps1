param($installPath, $toolsPath, $package, $project)

if($project.Object.SupportsPackageDependencyResolution)
{
    if($project.Object.SupportsPackageDependencyResolution())
    {
        # Do not uninstall analyzers via uninstall.ps1, instead let the project system handle it.
        return
    }
}

$analyzersPaths = Join-Path (Join-Path (Split-Path -Path $toolsPath -Parent) "analyzers") * -Resolve

foreach($analyzersPath in $analyzersPaths)
{
    # Uninstall the language agnostic analyzers.
    if (Test-Path $analyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem -Path "$analyzersPath\*.dll" -Exclude *.resources.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Remove($analyzerFilePath.FullName)
            }
        }
    }
}

# $project.Type gives the language name like (C# or VB.NET)
$languageFolder = ""
if($project.Type -eq "C#")
{
    $languageFolder = "cs"
}
if($project.Type -eq "VB.NET")
{
    $languageFolder = "vb"
}
if($languageFolder -eq "")
{
    return
}

foreach($analyzersPath in $analyzersPaths)
{
    # Uninstall language specific analyzers.
    $languageAnalyzersPath = join-path $analyzersPath $languageFolder
    if (Test-Path $languageAnalyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem -Path "$languageAnalyzersPath\*.dll" -Exclude *.resources.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                try
                {
                    $project.Object.AnalyzerReferences.Remove($analyzerFilePath.FullName)
                }
                catch
                {

                }
            }
        }
    }
}
# SIG # Begin signature block
# MIIqUgYJKoZIhvcNAQcCoIIqQzCCKj8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDC68wb97fg0QGL
# yXrxJhYfmibzcOh8caqC0uZprfczDaCCDvQwggPFMIICraADAgECAhACrFwmagtA
# m48LefKuRiV3MA0GCSqGSIb3DQEBBQUAMGwxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKzApBgNV
# BAMTIkRpZ2lDZXJ0IEhpZ2ggQXNzdXJhbmNlIEVWIFJvb3QgQ0EwHhcNMDYxMTEw
# MDAwMDAwWhcNMzExMTEwMDAwMDAwWjBsMQswCQYDVQQGEwJVUzEVMBMGA1UEChMM
# RGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSswKQYDVQQD
# EyJEaWdpQ2VydCBIaWdoIEFzc3VyYW5jZSBFViBSb290IENBMIIBIjANBgkqhkiG
# 9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxszlc+b71LvlLS0ypt/lgT/JzSVJtnEqw9WU
# NGeiChywX2mmQLHEt7KP0JikqUFZOtPclNY823Q4pErMTSWC90qlUxI47vNJbXGR
# fmO2q6Zfw6SE+E9iUb74xezbOJLjBuUIkQzEKEFV+8taiRV+ceg1v01yCT2+OjhQ
# W3cxG42zxyRFmqesbQAUWgS3uhPrUQqYQUEiTmVhh4FBUKZ5XIneGUpX1S7mXRxT
# LH6YzRoGFqRoc9A0BBNcoXHTWnxV215k4TeHMFYE5RG0KYAS8Xk5iKICEXwnZreI
# t3jyygqoOKsKZMK/Zl2VhMGhJR6HXRpQCyASzEG7bgtROLhLywIDAQABo2MwYTAO
# BgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUsT7DaQP4
# v0cB1JgmGggC72NkK8MwHwYDVR0jBBgwFoAUsT7DaQP4v0cB1JgmGggC72NkK8Mw
# DQYJKoZIhvcNAQEFBQADggEBABwaBpfc15yfPIhmBghXIdshR/gqZ6q/GDJ2QBBX
# wYrzetkRZY41+p78RbWe2UwxS7iR6EMsjrN4ztvjU3lx1uUhlAHaVYeaJGT2imbM
# 3pw3zag0sWmbI8ieeCIrcEPjVUcxYRnvWMWFL04w9qAxFiPI5+JlFjPLvxoboD34
# yl6LMYtgCIktDAZcUrfE+QqY0RVfnxK+fDZjOL1EpH/kJisKxJdpDemM4sAQV7jI
# dhKRVfJIadi8KgJbD0TUIDHb9LpwJl2QYJ68SxcJL7TLHkNoyQcnwdJc9+ohuWgS
# nDycv578gFybY83sR6olJ2egN/MAgn1U16n46S4To3foH0owggSRMIIDeaADAgEC
# AhAHsEGNpR4UjDMbvN63E4MjMA0GCSqGSIb3DQEBCwUAMGwxCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xKzApBgNVBAMTIkRpZ2lDZXJ0IEhpZ2ggQXNzdXJhbmNlIEVWIFJvb3QgQ0Ew
# HhcNMTgwNDI3MTI0MTU5WhcNMjgwNDI3MTI0MTU5WjBaMQswCQYDVQQGEwJVUzEY
# MBYGA1UEChMPLk5FVCBGb3VuZGF0aW9uMTEwLwYDVQQDEyguTkVUIEZvdW5kYXRp
# b24gUHJvamVjdHMgQ29kZSBTaWduaW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOC
# AQ8AMIIBCgKCAQEAwQqv4aI0CI20XeYqTTZmyoxsSQgcCBGQnXnufbuDLhAB6GoT
# NB7HuEhNSS8ftV+6yq8GztBzYAJ0lALdBjWypMfL451/84AO5ZiZB3V7MB2uxgWo
# cV1ekDduU9bm1Q48jmR4SVkLItC+oQO/FIA2SBudVZUvYKeCJS5Ri9ibV7La4oo7
# BJChFiP8uR+v3OU33dgm5BBhWmth4oTyq22zCfP3NO6gBWEIPFR5S+KcefUTYmn2
# o7IvhvxzJsMCrNH1bxhwOyMl+DQcdWiVPuJBKDOO/hAKIxBG4i6ryQYBaKdhDgaA
# NSCik0UgZasz8Qgl8n0A73+dISPumD8L/4mdywIDAQABo4IBPzCCATswHQYDVR0O
# BBYEFMtck66Im/5Db1ZQUgJtePys4bFaMB8GA1UdIwQYMBaAFLE+w2kD+L9HAdSY
# JhoIAu9jZCvDMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDAzAS
# BgNVHRMBAf8ECDAGAQH/AgEAMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYY
# aHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEsGA1UdHwREMEIwQKA+oDyGOmh0dHA6
# Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEhpZ2hBc3N1cmFuY2VFVlJvb3RD
# QS5jcmwwPQYDVR0gBDYwNDAyBgRVHSAAMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8v
# d3d3LmRpZ2ljZXJ0LmNvbS9DUFMwDQYJKoZIhvcNAQELBQADggEBALNGxKTz6gq6
# clMF01GjC3RmJ/ZAoK1V7rwkqOkY3JDl++v1F4KrFWEzS8MbZsI/p4W31Eketazo
# Nxy23RT0zDsvJrwEC3R+/MRdkB7aTecsYmMeMHgtUrl3xEO3FubnQ0kKEU/HBCTd
# hR14GsQEccQQE6grFVlglrew+FzehWUu3SUQEp9t+iWpX/KfviDWx0H1azilMX15
# lzJUxK7kCzmflrk5jCOCjKqhOdGJoQqstmwP+07qXO18bcCzEC908P+TYkh0z9gV
# rlj7tyW9K9zPVPJZsLRaBp/QjMcH65o9Y1hD1uWtFQYmbEYkT1K9tuXHtQYx1Rpf
# /dC8Nbl4iukwggaSMIIFeqADAgECAhALZYHUD3H36++YNL7DL2PeMA0GCSqGSIb3
# DQEBCwUAMFoxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw8uTkVUIEZvdW5kYXRpb24x
# MTAvBgNVBAMTKC5ORVQgRm91bmRhdGlvbiBQcm9qZWN0cyBDb2RlIFNpZ25pbmcg
# Q0EwHhcNMjEwMzA1MDAwMDAwWhcNMjQwNjAxMjM1OTU5WjCBjjEUMBIGA1UEBRML
# NjAzIDM4OSAwNjgxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJXQTEQMA4GA1UEBxMH
# UmVkbW9uZDEkMCIGA1UEChMbeFVuaXQubmV0ICguTkVUIEZvdW5kYXRpb24pMSQw
# IgYDVQQDExt4VW5pdC5uZXQgKC5ORVQgRm91bmRhdGlvbikwggIiMA0GCSqGSIb3
# DQEBAQUAA4ICDwAwggIKAoICAQC7Zs6Ng5KXq1e1R/ZpLG5l1xt6sUmY4GqfL7nB
# gQBpHpe6p7om04J6z5FaBLQRscDOo90StsUtolHAVuIhPBxxbBusJRiB6hHtHyaS
# e5rRsoKVzTQqDOxzrw5HIiq1/SFqJfT5vKTmfNDsFBVNfTbeNF8W0CScuG07rQeu
# gEc3vmmKQjBXl8RwuIlQUkhgmkh5g1A71ipibSvb5XsiZY+nz3lksL/69meWjvOI
# LZbD4TcI1MlAZbZliNfrGJpRAJk2KHN+E5+Lz8rsZMnOvl14TeiWh7tX5CUHB17A
# WWZMoRCGuSpvZ0nwELjYRO+huZTRrTGM/1iTK/xJ08TIK0ouuyihHTOMuzuprpXu
# JEKJapgQ0oAIDM5wGuxJIgcrlgLdjeg9qR7Qgpk80OFDFCt22fMxPKWYUrvaN9CP
# 1qUvzU0csEaMGbqaXvDxW4Jh5qMq6stiD9u1ZlbQXLd7cGgdLFZkG2SHYGRlsLSJ
# CCiA+xhFpyq6paLwByVyiRomN2RoKziR2yIFy04hHt1dxdCxstLU7IYepMPD2hq8
# LrQsJKtLs3oukf9hGm9mg/Ob6hfjYKO9WeFBoArZJJsAy+3yhOOvXakAeZyAaZKL
# 2W+ytTIBkEwOvpVxZoV1M0acQ1B9NlaVO29RJ6EQlWdcsN9+HA2tcJ3fSGAai+bf
# I4TJiQIDAQABo4ICHTCCAhkwHwYDVR0jBBgwFoAUy1yTroib/kNvVlBSAm14/Kzh
# sVowHQYDVR0OBBYEFE1FuBWTKAW2LOHLbCt+NrwdAW09MDQGA1UdEQQtMCugKQYI
# KwYBBQUHCAOgHTAbDBlVUy1XQVNISU5HVE9OLTYwMyAzODkgMDY4MA4GA1UdDwEB
# /wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzCBmQYDVR0fBIGRMIGOMEWgQ6BB
# hj9odHRwOi8vY3JsMy5kaWdpY2VydC5jb20vTkVURm91bmRhdGlvblByb2plY3Rz
# Q29kZVNpZ25pbmdDQS5jcmwwRaBDoEGGP2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
# bS9ORVRGb3VuZGF0aW9uUHJvamVjdHNDb2RlU2lnbmluZ0NBLmNybDBLBgNVHSAE
# RDBCMDYGCWCGSAGG/WwDATApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LmRpZ2lj
# ZXJ0LmNvbS9DUFMwCAYGZ4EMAQQBMIGEBggrBgEFBQcBAQR4MHYwJAYIKwYBBQUH
# MAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBOBggrBgEFBQcwAoZCaHR0cDov
# L2NhY2VydHMuZGlnaWNlcnQuY29tL05FVEZvdW5kYXRpb25Qcm9qZWN0c0NvZGVT
# aWduaW5nQ0EuY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggEBAI1A
# ruHc8L6TuwQC561WdwZ67LcwTmL26+W6d4m8WEXmM1RCms1Ipi0XuGL4ts9+dQbO
# yM+zB+OcTEuZpD4XuAkvthV1A5GpUJZa2hnbMgf7FeknluJF4KOpGT9ABn10tAUP
# LYEqGZONKZnJB5yjVXEIbfNrOp6WRJCQOvZSKE2Oj9CfJ6KZmaJd/gXfQzPR6oPT
# +qL/vxPvl+iyM7Cnj8e7v4GeYhKvlbnA2q5/FiBKLCNMq2B7VqNDr69wCfYgV0gi
# A19U/37d88Sz8dfJwXpAiNzrYfgrdBWlZpq8PHkKjqlCRxOr71ESnWUv7Q6Qneae
# BznvWh02DlXUPGIWMCQxghq0MIIasAIBATBuMFoxCzAJBgNVBAYTAlVTMRgwFgYD
# VQQKEw8uTkVUIEZvdW5kYXRpb24xMTAvBgNVBAMTKC5ORVQgRm91bmRhdGlvbiBQ
# cm9qZWN0cyBDb2RlIFNpZ25pbmcgQ0ECEAtlgdQPcffr75g0vsMvY94wDQYJYIZI
# AWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGC
# NwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIBdcqRcs5QL71hlQ
# nl3M636V5iTZvb6co3MHeMuIr36qMEIGCisGAQQBgjcCAQwxNDAyoBSAEgB4AFUA
# bgBpAHQALgBuAGUAdKEagBhodHRwczovL2dpdGh1Yi5jb20veHVuaXQwDQYJKoZI
# hvcNAQEBBQAEggIALkAExlpeZSdbLOkGGFHaJTGIDaPxQ67mXkCHg+5rKHicAjdX
# d+Y9A7MRuqqvSyhRXTTy+uIu2XI58wbg4KYTc6FiV3jE0WSj01Chi6cpHnvWc4vl
# bXJxUIQA+iSD9Xt1EsK4XIlqVMQGxzH71cIVDKccieJiqGOW8lEiVyVE2rwtnMwX
# BGol7NmAASEihu0cOO2zzLG9DWI5JgFhnSJAisM3OZR+R9GEhW4v6V2Bh9iAAJQ6
# P2bvpUSN3JUANRL9sPXxj8lpMx9yPC5EeVs5K0umq7CCfGaA3SL/uXUaCVUgp32Z
# 8QJCgsMIEc+ckMEPIxHhajt8dbBk5ok7NaR6gaOHb4tQ0/swC8em/HfwACM1sc0t
# dVGBT9089wC+UQisqmQWMEEY2f2aST3Jq4omAajzjZ4liaElpg3rfBqxWLyYGIDu
# GjfkFGfjkoxuUfstPWsVNQQL8VHpYrwzkOzNUXbW1UHggpHV3LhesAFzvkDRNN1M
# 0zt90uxfWbIKj0JUpdYNqK9XozN367VGrEnpJrCTZyz77NjD3cxCHWNyrOUris0z
# jrCHg+vHcA/cVphFecjGrfDa369KvIut36WCtLGkFAmoqOgwWsgwJW10joLFhz+e
# NHsJA/ixCB1ldbgU75bk3n1kB6CAl7UHLhoTLzQK2TpRIWLUPAguvBlefk6hghdm
# MIIXYgYKKwYBBAGCNwMDATGCF1IwghdOBgkqhkiG9w0BBwKgghc/MIIXOwIBAzEP
# MA0GCWCGSAFlAwQCAQUAMIIBYQYLKoZIhvcNAQkQAQSgggFQBIIBTDCCAUgCAQEG
# CisGAQQBhFkKAwEwMTANBglghkgBZQMEAgEFAAQgbLhT372WJXnbt7jc5+ECzTbb
# ohd9fI0UPg8rpPYgX6QCBmSQRH8O8xgTMjAyMzA3MDYyMTE4MDcuMjg3WjAEgAIB
# 9KCB4KSB3TCB2jELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEl
# MCMGA1UECxMcTWljcm9zb2Z0IEFtZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMd
# VGhhbGVzIFRTUyBFU046M0RBNS05NjNCLUUxRjQxNTAzBgNVBAMTLE1pY3Jvc29m
# dCBQdWJsaWMgUlNBIFRpbWUgU3RhbXBpbmcgQXV0aG9yaXR5oIIR5jCCB4IwggVq
# oAMCAQICEzMAAAAF5c8P/2YuyYcAAAAAAAUwDQYJKoZIhvcNAQEMBQAwdzELMAkG
# A1UEBhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjFIMEYGA1UE
# AxM/TWljcm9zb2Z0IElkZW50aXR5IFZlcmlmaWNhdGlvbiBSb290IENlcnRpZmlj
# YXRlIEF1dGhvcml0eSAyMDIwMB4XDTIwMTExOTIwMzIzMVoXDTM1MTExOTIwNDIz
# MVowYTELMAkGA1UEBhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFB1YmxpYyBSU0EgVGltZXN0YW1waW5nIENB
# IDIwMjAwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCefOdSY/3gxZ8F
# fWO1BiKjHB7X55cz0RMFvWVGR3eRwV1wb3+yq0OXDEqhUhxqoNv6iYWKjkMcLhEF
# xvJAeNcLAyT+XdM5i2CgGPGcb95WJLiw7HzLiBKrxmDj1EQB/mG5eEiRBEp7dDGz
# xKCnTYocDOcRr9KxqHydajmEkzXHOeRGwU+7qt8Md5l4bVZrXAhK+WSk5CihNQsW
# bzT1nRliVDwunuLkX1hyIWXIArCfrKM3+RHh+Sq5RZ8aYyik2r8HxT+l2hmRllBv
# E2Wok6IEaAJanHr24qoqFM9WLeBUSudz+qL51HwDYyIDPSQ3SeHtKog0ZubDk4hE
# LQSxnfVYXdTGncaBnB60QrEuazvcob9n4yR65pUNBCF5qeA4QwYnilBkfnmeAjRN
# 3LVuLr0g0FXkqfYdUmj1fFFhH8k8YBozrEaXnsSL3kdTD01X+4LfIWOuFzTzuosl
# BrBILfHNj8RfOxPgjuwNvE6YzauXi4orp4Sm6tF245DaFOSYbWFK5ZgG6cUY2/bU
# q3g3bQAqZt65KcaewEJ3ZyNEobv35Nf6xN6FrA6jF9447+NHvCjeWLCQZ3M8lgeC
# cnnhTFtyQX3XgCoc6IRXvFOcPVrr3D9RPHCMS6Ckg8wggTrtIVnY8yjbvGOUsAdZ
# beXUIQAWMs0d3cRDv09SvwVRd61evQIDAQABo4ICGzCCAhcwDgYDVR0PAQH/BAQD
# AgGGMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRraSg6NS9IY0DPe9ivSek+
# 2T3bITBUBgNVHSAETTBLMEkGBFUdIAAwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1Ud
# JQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMA8GA1Ud
# EwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUyH7SaoUqG8oZmAQHJ89QEE9oqKIwgYQG
# A1UdHwR9MHsweaB3oHWGc2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMv
# Y3JsL01pY3Jvc29mdCUyMElkZW50aXR5JTIwVmVyaWZpY2F0aW9uJTIwUm9vdCUy
# MENlcnRpZmljYXRlJTIwQXV0aG9yaXR5JTIwMjAyMC5jcmwwgZQGCCsGAQUFBwEB
# BIGHMIGEMIGBBggrBgEFBQcwAoZ1aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Br
# aW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBJZGVudGl0eSUyMFZlcmlmaWNhdGlvbiUy
# MFJvb3QlMjBDZXJ0aWZpY2F0ZSUyMEF1dGhvcml0eSUyMDIwMjAuY3J0MA0GCSqG
# SIb3DQEBDAUAA4ICAQBfiHbHfm21WhV150x4aPpO4dhEmSUVpbixNDmv6TvuIHv1
# xIs174bNGO/ilWMm+Jx5boAXrJxagRhHQtiFprSjMktTliL4sKZyt2i+SXncM23g
# RezzsoOiBhv14YSd1Klnlkzvgs29XNjT+c8hIfPRe9rvVCMPiH7zPZcw5nNjthDQ
# +zD563I1nUJ6y59TbXWsuyUsqw7wXZoGzZwijWT5oc6GvD3HDokJY401uhnj3ubB
# hbkR83RbfMvmzdp3he2bvIUztSOuFzRqrLfEvsPkVHYnvH1wtYyrt5vShiKheGpX
# a2AWpsod4OJyT4/y0dggWi8g/tgbhmQlZqDUf3UqUQsZaLdIu/XSjgoZqDjamzCP
# JtOLi2hBwL+KsCh0Nbwc21f5xvPSwym0Ukr4o5sCcMUcSy6TEP7uMV8RX0eH/4JL
# EpGyae6Ki8JYg5v4fsNGif1OXHJ2IWG+7zyjTDfkmQ1snFOTgyEX8qBpefQbF0fx
# 6URrYiarjmBprwP6ZObwtZXJ23jK3Fg/9uqM3j0P01nzVygTppBabzxPAh/hHhhl
# s6kwo3QLJ6No803jUsZcd4JQxiYHHc+Q/wAMcPUnYKv/q2O444LO1+n6j01z5mgg
# CSlRwD9faBIySAcA9S8h22hIAcRQqIGEjolCK9F6nK9ZyX4lhthsGHumaABdWzCC
# B5YwggV+oAMCAQICEzMAAAAqJL/lSUkRtusAAAAAACowDQYJKoZIhvcNAQEMBQAw
# YTELMAkGA1UEBhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEy
# MDAGA1UEAxMpTWljcm9zb2Z0IFB1YmxpYyBSU0EgVGltZXN0YW1waW5nIENBIDIw
# MjAwHhcNMjMwNTE4MTkzODQ2WhcNMjQwNTE2MTkzODQ2WjCB2jELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjElMCMGA1UECxMcTWljcm9zb2Z0IEFt
# ZXJpY2EgT3BlcmF0aW9uczEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046M0RBNS05
# NjNCLUUxRjQxNTAzBgNVBAMTLE1pY3Jvc29mdCBQdWJsaWMgUlNBIFRpbWUgU3Rh
# bXBpbmcgQXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# skkI99kQdoPgLSlP9iu5QmiCnrZvqHuDZ77iFUDk/oev+ok/wxbCQtztR/7mr+Vt
# zOFHTblaaEM5ofiw2be8zbpvfZ2c1ofUUjpvYAHI7kxo0rdVAVSFVI8dN7dFahtQ
# J8ozNMd6chAZ/00usrjxqWOy3HRyGXVJXJgcOWKgH/OXeszzFNyI/inDNTqMJnXD
# YA9sTsGHNzGa03VV/187lq9bnEyssMRBn4jhCuW7mam89laVxXDvngpirnWcQ+oa
# YMnpilKPPH/5CHsTAhtXC+KnkNDMrFHMQJN5Pwfp349ZdVqeLPjaYZTvJaMP2gWL
# 0TupXjDz8vsy7nPADHVcS+oPjVc96h0H5vLVH/IK9XoAcZ+CNipRI/P5tO4QCFHt
# vl+qgvVdPZPvs2CD51N/GJFhiWU7sFnC6ylbUYVwmIzO2Ozc2RUCN50TFv5Ba3xc
# SAFijmCptCpjmPO2njbSFLtiJGgDPJU+s/Ak10Vj1d6GLh5RxuhgjJTfieS3Npkb
# Pk2+YW4dMX1d8y9q9ryKXRxXiPzypghNeCPwIwvIK6wbj/Lz2sV5Z6UwffM4n362
# IOcwsZfyCaP7BJgDfIxQt0l+7g+EXk7r/YuVLYudmrbaDqfySqCFNZ1EVHPKMslp
# 4L7/FinF8F+B7Q/coGRB19q/OXWEtO3BiVK2PyoHS8sCAwEAAaOCAcswggHHMB0G
# A1UdDgQWBBQ+afMF6o46kMROJFkpIhrZuHs5dDAfBgNVHSMEGDAWgBRraSg6NS9I
# Y0DPe9ivSek+2T3bITBsBgNVHR8EZTBjMGGgX6BdhltodHRwOi8vd3d3Lm1pY3Jv
# c29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBQdWJsaWMlMjBSU0ElMjBU
# aW1lc3RhbXBpbmclMjBDQSUyMDIwMjAuY3JsMHkGCCsGAQUFBwEBBG0wazBpBggr
# BgEFBQcwAoZdaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9N
# aWNyb3NvZnQlMjBQdWJsaWMlMjBSU0ElMjBUaW1lc3RhbXBpbmclMjBDQSUyMDIw
# MjAuY3J0MAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwDgYD
# VR0PAQH/BAQDAgeAMGYGA1UdIARfMF0wUQYMKwYBBAGCN0yDfQEBMEEwPwYIKwYB
# BQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9jcy9SZXBv
# c2l0b3J5Lmh0bTAIBgZngQwBBAIwDQYJKoZIhvcNAQEMBQADggIBADWK4vQdERU7
# glE3Pqzn/wDKnAhuTMSV3nLMaIjRjw/2z6Ki2IDKkkEI5f290VrVthK+k/h7/K3X
# kXkKbw6oxVJvqOEcCaCQVB7ri60DMdwD1Ox+i46Jr24OlXYSdAHlU+7syddQHhJi
# k46onYJRGYvDlcCtKbBKMlDKot7WZxLDYYNlHYk7bJppM9lFgMDBn9aGts3U/JiP
# DVJ497rW3tYmha48FddvrE3Qp+ZXPKAbsak0s6F1+icWT+ucckykQsPBO2VeGzhg
# vKoI9jZomSeXzBO94dR/ysv2einBfSxWLMAmMbiCzsQpy88LwnUGcKiqMSbaqejY
# N3K7OiFHaZN6uzCadhFFHfIfJm/fzNiJkb0qNZKHqrCmrcwW3gj2nnhWDKpTI2YR
# vHw2/owJU4NoQh3N7/qnITzKDXoyqHHI+KGIwLsEEUCP1ZQWiP9L0SfgIeSpwI1H
# 91pKwz1d1XjaZ4I412fjIRgZaD4FbAvlBQ79qDU+bSt12TYcu//xq1FVBr1piDo7
# gmpv+nT6ININI0DEDpXzA31A2ENpsP2Rrh7dc5dLNV+7xqCjqHVFzZ761Vx2ddpK
# vn4rIHEilQ+vR9CgTfHi5prbaHS2r4i+Om9gZZ+o+TLeajYxTtcX7HqrFtGQZy1w
# uExQn22IJVWVXkuUU5Gf6fH+RG5zFwmKoYICwjCCAisCAQEwggEIoYHgpIHdMIHa
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSUwIwYDVQQLExxN
# aWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25zMSYwJAYDVQQLEx1UaGFsZXMgVFNT
# IEVTTjozREE1LTk2M0ItRTFGNDE1MDMGA1UEAxMsTWljcm9zb2Z0IFB1YmxpYyBS
# U0EgVGltZSBTdGFtcGluZyBBdXRob3JpdHmiIwoBATAHBgUrDgMCGgMVAMsUzF0W
# w0eC/1DXajnpi5/kr7b+oGcwZaRjMGExCzAJBgNVBAYTAlVTMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBQdWJsaWMg
# UlNBIFRpbWVzdGFtcGluZyBDQSAyMDIwMA0GCSqGSIb3DQEBBQUAAgUA6FEsfzAi
# GA8yMDIzMDcwNjIwMDUxOVoYDzIwMjMwNzA3MjAwNTE5WjB3MD0GCisGAQQBhFkK
# BAExLzAtMAoCBQDoUSx/AgEAMAoCAQACAiBHAgH/MAcCAQACAhEXMAoCBQDoUn3/
# AgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMHoSCh
# CjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAQneCKL4MYenkGQVwKSV2e46O
# N1nZIcBXUjcDxaWM/m8CAOa02h8cNCjAZGaap81gpU8e/dg4Ezn4GMDUocOKL7v2
# ppJHatva75YZfsRB2b82jhKuOpI71XrFJH5fAygOqbhgkpiartmYwiPNOTzOlCL1
# 4iVypDBeIPDqlkrYWHUxggPUMIID0AIBATB4MGExCzAJBgNVBAYTAlVTMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBQ
# dWJsaWMgUlNBIFRpbWVzdGFtcGluZyBDQSAyMDIwAhMzAAAAKiS/5UlJEbbrAAAA
# AAAqMA0GCWCGSAFlAwQCAQUAoIIBLTAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQ
# AQQwLwYJKoZIhvcNAQkEMSIEILF3Mc1EO/JPdf1Ca++zuPskVdKKmzBdO7cjAats
# JkHxMIHdBgsqhkiG9w0BCRACLzGBzTCByjCBxzCBoAQgLj0Lv58VpaysIF66pcVS
# 8ZjFhfqSkhAtRfLqFnGmhJUwfDBlpGMwYTELMAkGA1UEBhMCVVMxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFB1Ymxp
# YyBSU0EgVGltZXN0YW1waW5nIENBIDIwMjACEzMAAAAqJL/lSUkRtusAAAAAACow
# IgQgxX2VwabYMY725VABYA4p7oeaNG7ojcDkJO9jCbrlRkgwDQYJKoZIhvcNAQEL
# BQAEggIAA7T7KzvcaWwB8WLwNTZe+GEW6NSI7bzePvTL7eJoklpawqEB6Do4KtXr
# rrba20witP+QmqKW7wGN13lFQnuBfdpmj7LpfBX8L7Y1MbSVT7CJd6rGjyDH8sAk
# y2PMKgEUbaVSUCEDAR/AJu5lyQyL4sjHynySH6TgmU3xWJErvlgJLQI8ksEJrUkT
# wH2rPuruGUaSBviFlWzCYTitoSMBfwT78iPQDvkLMsA3MXtjJEVQc/QXmg0K+LVF
# VbPH5E9nJl+ivFWUbLn+xFK054jpXxioVqzpRcFcoTTXjPDJxt59kJWVaQYl912V
# DL2gw+uRzXJbT9Zd2UX3XsLU46RSHfPzu+RwChd+zXliEPRsXFIPz2ZAKE+w/18S
# QYhe7lvOyyNTzY6dHDx8b4pJzw9mBGMMPDJR1p42j9XnrZPREor+4pBnQvujlpzY
# DQNCPj8s1WmDTU2rhPXpYBWnwRiHJrMeXsI7TRyG++1RN96Yks4vlSTcV3iNX+k7
# kvYSNg6tqTnDTyLf69aced2d6Y35dZTM89k469w85nhlUvH0fgEquMcZDNe/0p1k
# Juq25lUW/rvGrCojxLkwi7znqyygtWnndcU05iHf3A+Y6wrxsYBHaN21qmur9m9K
# MLQ3wXdB5N+msb1K/pTO4GToIbtgCKDdF2dYwoUFwYmdQvmwf1w=
# SIG # End signature block