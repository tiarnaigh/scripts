#!/bin/sh
#
# usage: checkRemoteSslCertDetails.sh remote.host.name remote.port
#
REMHOST=$1
REMPORT=$2

echo "########## Cert details for $REMHOST:$REMPORT ##########";
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} -servername ${REMHOST} 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'

echo "########## Expiration dates ##########";
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} -servername ${REMHOST} 2>/dev/null | openssl x509 -noout -dates;


echo "########## Signature details ##########";
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} -servername ${REMHOST} 2>/dev/null |openssl x509 -text -in /dev/stdin |grep "Signature Algorithm"



# Should return something like the below:
[root@hostname ~]# sh checkRemoteSslCertDetails.sh www.google.com 443
########## Cert details for www.google.com:443 ##########
-----BEGIN CERTIFICATE-----
MIIEgjCCA2qgAwIBAgIIbiOB3uuxA6owDQYJKoZIhvcNAQELBQAwVDELMAkGA1UE
BhMCVVMxHjAcBgNVBAoTFUdvb2dsZSBUcnVzdCBTZXJ2aWNlczElMCMGA1UEAxMc
R29vZ2xlIEludGVybmV0IEF1dGhvcml0eSBHMzAeFw0xOTAxMjkxNDU4MDBaFw0x
OTA0MjMxNDU4MDBaMGgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlh
MRYwFAYDVQQHDA1Nb3VudGFpbiBWaWV3MRMwEQYDVQQKDApHb29nbGUgTExDMRcw
FQYDVQQDDA53d3cuZ29vZ2xlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAMLteS7Kmg3gz8ww3nHL4o8QO1GZ8flbuonZsjG6R0gFrVtnXSpjp/FH
PLdUXLSmNFitdlqqsgnsNdgDxeIm4y/tqh/wfosyINZUgmtwrmvgqxD72AM/JUwd
9VpXe8VLMuA2u26cMYjJ0mYv/Q9xbj6GLKcFLCwLW+NyKosFXD5/UkMglP5LONlm
LpwguRCQslEWl1hyuxHDqzb07nUBGLgnqgTMiiRXHaPmY85YabNsqfu4xRVkUCsK
1xrLf9FmEh23esCNOewDQ4Ujg/pF4p7NxXogWJIUl6dG7IXjA864uf0dYWWr+y/M
5t6CHvy1Lu6Qtth7s3AwRaMYVPwU2XMCAwEAAaOCAUIwggE+MBMGA1UdJQQMMAoG
CCsGAQUFBwMBMBkGA1UdEQQSMBCCDnd3dy5nb29nbGUuY29tMGgGCCsGAQUFBwEB
BFwwWjAtBggrBgEFBQcwAoYhaHR0cDovL3BraS5nb29nL2dzcjIvR1RTR0lBRzMu
Y3J0MCkGCCsGAQUFBzABhh1odHRwOi8vb2NzcC5wa2kuZ29vZy9HVFNHSUFHMzAd
BgNVHQ4EFgQUJvhVx9GCXNGrvPRTXFPb+TeD15EwDAYDVR0TAQH/BAIwADAfBgNV
HSMEGDAWgBR3wrhQmmd2drEtwobQg6B+pn66SzAhBgNVHSAEGjAYMAwGCisGAQQB
1nkCBQMwCAYGZ4EMAQICMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly9jcmwucGtp
Lmdvb2cvR1RTR0lBRzMuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAvEyDsvvrW3O5A
KvcIv8UypZ03KFZq4vknlPj8mWjKsFR6HRT7ZhWm0B5sfVxYNdxFVbBT8ZPBOHbh
rA2VQfcl0VhcQVZQPh1sWG6h0iYkNqxsVJe+pAhuppRz0zkz5ieoI8wiOG4NiPQO
IV5Zg/oJFHSFxM81yn02kAHPjwI9af/XX0mA5Id6YxFn2deP558DZll2ipo6XhKv
6B42ZxOqGBb+IlwNUKS02ClQIqkMvJmsfZYc2rVBqeyyo7qRBoqlQXQFgbJJBdW8
Xyc9zgDPWj5NauhmEZgRHx1u3z0hOSevcJprMCTxkpfPny7LMfgk/W/db63+9Wj4
ijSTkbBX
-----END CERTIFICATE-----
########## Expiration dates ##########
notBefore=Jan 29 14:58:00 2019 GMT
notAfter=Apr 23 14:58:00 2019 GMT
########## Signature details ##########
    Signature Algorithm: sha256WithRSAEncryption
    Signature Algorithm: sha256WithRSAEncryption
[root@zbx4lab0 pcf_scripts]#

