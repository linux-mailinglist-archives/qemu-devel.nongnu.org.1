Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA587F29ED
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NnK-0001gB-Na; Tue, 21 Nov 2023 05:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=682fc07e5=dwmw@amazon.co.uk>)
 id 1r5NnA-0001cq-RP
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:15:41 -0500
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=682fc07e5=dwmw@amazon.co.uk>)
 id 1r5Nn6-0005cS-Qt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1700561737; x=1732097737;
 h=from:to:cc:subject:date:message-id:references: in-reply-to;
 bh=wrhnFVWXxjWGynl4jCLIjb6dANjHT2EA8Hhq8uorF3M=;
 b=scMcLPpiFU6XB+2RD5D34pw4+Fu6sXc96ON3lxud9pqTQVH1B3vhDOtk
 oxIcOgUVP2ZhDP1tWsV2OoKD3Kkg21j0MqJkIzlHjx5V2qp37NvrBUmCQ
 01LFFJgk38CBH/U1FEolPdpDJ+7xhjqhxTAkDhUSKDrpqlVkR5q8qAjfq c=;
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.04,215,1695686400"; 
 d="p7s'?scan'208";a="620798596"
Content-Type: multipart/mixed; boundary="===============2024097494123669535=="
MIME-Version: 1.0
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:15:22 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev
 (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
 by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix)
 with ESMTPS id 0A10181FE9; Tue, 21 Nov 2023 10:15:19 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:3546]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.44.170:2525]
 with esmtp (Farcaster)
 id 71340a75-6f3f-44db-bbcb-f8d5c95f55c0; Tue, 21 Nov 2023 10:15:19 +0000 (UTC)
X-Farcaster-Flow-ID: 71340a75-6f3f-44db-bbcb-f8d5c95f55c0
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 10:15:19 +0000
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Tue, 21 Nov 2023 10:15:18 +0000
Received: from EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797]) by
 EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797%3]) with mapi id
 15.02.1118.039; Tue, 21 Nov 2023 10:15:18 +0000
To: "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "gmaglione@gmail.com"
 <gmaglione@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: Re:  [PATCH for-8.2 0/3] UI: fix default VC regressions
Thread-Topic: [PATCH for-8.2 0/3] UI: fix default VC regressions
Thread-Index: AQHaHGOgETWF09tw90Si2ZE8T8q7aw==
Date: Tue, 21 Nov 2023 10:15:18 +0000
Message-ID: <3c467e84bcbde020f9e3323de1abb69d78b552c9.camel@amazon.co.uk>
References: <20231117143506.1521718-1-marcandre.lureau@redhat.com>
 <CAJ+F1CL_a72vuH0ShLwVXKW-2sTzSX0LnWtSDT6BxKNx_ZUhzg@mail.gmail.com>
In-Reply-To: <CAJ+F1CL_a72vuH0ShLwVXKW-2sTzSX0LnWtSDT6BxKNx_ZUhzg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.83.15]
MIME-Version: 1.0
Precedence: Bulk
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=682fc07e5=dwmw@amazon.co.uk; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Woodhouse, David" <dwmw@amazon.co.uk>
From:  "Woodhouse, David" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--===============2024097494123669535==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-P6cCP0wZt6ivw+N3tm0t"

--=-P6cCP0wZt6ivw+N3tm0t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-11-21 at 11:37 +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Nov 17, 2023 at 6:36=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
> >=20
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > Hi,
> >=20
> > There are a few annoying regressions with the default VCs introduced wi=
th the
> > pixman series. The "vl: revert behaviour for -display none" change solv=
es most
> > of the issues. Another one is hit when using remote displays, and VCs a=
re not
> > created as they used to, see: "ui/console: fix default VC when there ar=
e no
> > display". Finally, "ui: use "vc" chardev for dbus, gtk & spice-app" was=
 meant to
> > be included in the pixman series and also brings back default VCs creat=
ion.
> >=20
> > Marc-Andr=C3=A9 Lureau (3):
> > =C2=A0=C2=A0 vl: revert behaviour for -display none
> > =C2=A0=C2=A0 ui: use "vc" chardev for dbus, gtk & spice-app
> > =C2=A0=C2=A0 ui/console: fix default VC when there are no display
>=20
> I wish to send a PR (rc1 today), together with "[PATCH] vl: add
> missing display_remote++".
>=20
> Some R-B/A-B appreciated! thanks

Not sure I can give coherent review on the other two, but the first
patch does fix the Xen command line and looks sane.

Please could I ask you to also include
https://lore.kernel.org/qemu-devel/20231115172723.1161679-3-dwmw2@infradead=
.org/
in the series as you push it?


--=-P6cCP0wZt6ivw+N3tm0t
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEjww
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhAwggT4oAMCAQICEQC/QgfpbUT3q2fHshU/ReqfMA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowIjEgMB4GCSqGSIb3DQEJARYRZHdtd0BhbWF6b24uY28udWsw
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCZgnzd4h6STv/MQcUPixvDN/dNtp4yVSdc
xz9mB1OcA7HXd4WdPyYagmkcH0WguDYaQnOszkSdElI+2XRFSlGXhY7U9tktvdWuY1zAY1UWES8e
3BUHqSKbIKx4SX6GuctCcPnyagVZ9Hk21YUElx9cdmrqt0bGoydgxAspEx56J9Q5a48WfvFYjLBF
NL1dw+P1eUeAljco30+Xggf5faawKfPArUX0cmU4VIh5DMUyv4d0xxfNN6cK1GMj/HGUg2T9OTHW
nbTdq+OHJwHGi/37mCWx1O3uV0hbZzA1fNklaqlsr1Acg0elPeCFXLb8dSkMgQZHNJVjn+mBvG4d
MG4FS3ntipApytA+a5IaMP3LNAo0EoBd5/xVy0M6TXbiYesYLq9rhnrLgO1qcw7+if0jH9YoEJ6a
Je1m7omfEXh2XpospSLaohmAqaBKlyhXDXbTnUVnIf79zU5ohHZof0cP2amnnvYUVD72iuf9qe7X
4L1Rj589qEWYROKiMil5X7l/smE1dAmxhKxx6YWvWkXH9u7JOcmLGdKST0voaY7j3Wk0lxK3NKsk
q0G3BpqbPz3P8BYtn38BvbkFnwVW7F7Qzus3KZJgP62eN25QHxoFj44x3sppx4I5WlYG4lxdFZsY
smQdj64c7MaJ7cp8RJN+eO32RKrkndEkihzxevl11wIDAQABo4IByjCCAcYwHwYDVR0jBBgwFoAU
CcDy/AvalNtf/ivfqJlCz8ngrQAwHQYDVR0OBBYEFJ418HpIgZaPnwpWdCNSvm4XgH/lMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjBA
BgNVHSAEOTA3MDUGDCsGAQQBsjEBAgEBATAlMCMGCCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28u
Y29tL0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29S
U0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+
MHwwVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1
dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3Nw
LnNlY3RpZ28uY29tMBwGA1UdEQQVMBOBEWR3bXdAYW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUA
A4IBAQCSez7gtf1wlWJr568crX21nm6QFWRdJ/YxMOReeqYtGs8QZf2zm2vIEFab61MrgJFJcFJL
sRhVHwnH/hvax3ZldDpUhM0ODpA9soUjYsvKJ0boFAHPtI1BL0yrZNCBdsUGxMv0t64Acj2ovxQ+
OxPd5ngHu0MzYIKLDvTSehxkh/qW23X7Ey/fPR0sgnAK4IV7clidmuWBbrqX+WKEyEP2kaEvLsRg
8plzYbVVFJl37rX2waKnGaWYnJ3BrvcMMgDSQCuoxMThWAOr7wxOh0ni0K3rW7CwDIAjUSk+fFmS
2EacUvIv/0xUW1nXzGJ12/Qyi+Mw65m0qE776qfcftg3MIIGEDCCBPigAwIBAgIRAL9CB+ltRPer
Z8eyFT9F6p8wDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+
MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0EwHhcNMjIwMTA3MDAwMDAwWhcNMjUwMTA2MjM1OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFk
d213QGFtYXpvbi5jby51azCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJmCfN3iHpJO
/8xBxQ+LG8M39022njJVJ1zHP2YHU5wDsdd3hZ0/JhqCaRwfRaC4NhpCc6zORJ0SUj7ZdEVKUZeF
jtT22S291a5jXMBjVRYRLx7cFQepIpsgrHhJfoa5y0Jw+fJqBVn0eTbVhQSXH1x2auq3RsajJ2DE
CykTHnon1DlrjxZ+8ViMsEU0vV3D4/V5R4CWNyjfT5eCB/l9prAp88CtRfRyZThUiHkMxTK/h3TH
F803pwrUYyP8cZSDZP05MdadtN2r44cnAcaL/fuYJbHU7e5XSFtnMDV82SVqqWyvUByDR6U94IVc
tvx1KQyBBkc0lWOf6YG8bh0wbgVLee2KkCnK0D5rkhow/cs0CjQSgF3n/FXLQzpNduJh6xgur2uG
esuA7WpzDv6J/SMf1igQnpol7WbuiZ8ReHZemiylItqiGYCpoEqXKFcNdtOdRWch/v3NTmiEdmh/
Rw/Zqaee9hRUPvaK5/2p7tfgvVGPnz2oRZhE4qIyKXlfuX+yYTV0CbGErHHpha9aRcf27sk5yYsZ
0pJPS+hpjuPdaTSXErc0qySrQbcGmps/Pc/wFi2ffwG9uQWfBVbsXtDO6zcpkmA/rZ43blAfGgWP
jjHeymnHgjlaVgbiXF0VmxiyZB2PrhzsxontynxEk3547fZEquSd0SSKHPF6+XXXAgMBAAGjggHK
MIIBxjAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUnjXwekiBlo+f
ClZ0I1K+bheAf+UwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYB
BQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEW
F2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9T
ZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEF
BQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHAYDVR0RBBUwE4ERZHdtd0BhbWF6b24uY28u
dWswDQYJKoZIhvcNAQELBQADggEBAJJ7PuC1/XCVYmvnrxytfbWebpAVZF0n9jEw5F56pi0azxBl
/bOba8gQVpvrUyuAkUlwUkuxGFUfCcf+G9rHdmV0OlSEzQ4OkD2yhSNiy8onRugUAc+0jUEvTKtk
0IF2xQbEy/S3rgByPai/FD47E93meAe7QzNggosO9NJ6HGSH+pbbdfsTL989HSyCcArghXtyWJ2a
5YFuupf5YoTIQ/aRoS8uxGDymXNhtVUUmXfutfbBoqcZpZicncGu9wwyANJAK6jExOFYA6vvDE6H
SeLQretbsLAMgCNRKT58WZLYRpxS8i//TFRbWdfMYnXb9DKL4zDrmbSoTvvqp9x+2DcxggTHMIIE
wwIBATCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL9CB+ltRPer
Z8eyFT9F6p8wDQYJYIZIAWUDBAIBBQCgggHrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMTEyMTEwMTUxN1owLwYJKoZIhvcNAQkEMSIEIDZEcp5YNrYaWk9xq1+A
SZ6re51q3Qmx5GBBCb6le30HMIG9BgkrBgEEAYI3EAQxga8wgawwgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEQC/QgfpbUT3q2fHshU/ReqfMIG/BgsqhkiG9w0BCRACCzGB
r6CBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL9CB+ltRPerZ8ey
FT9F6p8wDQYJKoZIhvcNAQEBBQAEggIANrjp38NCcM00oha+jMD9K2u6faXt5y2fkMm5E+OCfJoI
BPShloZZ+wAe123AFN8nIagGfJ4pQKPT+1wFus+FPXyvSvW+g2LP6HgDSCnKMNRxSVp436lvxfa3
n3zhPvRtvesfJZYi3UEf1uVR1BdWxEiJjp60k9ObPi7FKFFnFuAY3riUTOuAQLzYlDJf+gbW0UvD
eMKwwiw3PH4hhMBTO+efOEo8vkHnceCqEX+CtBhaMwgXA3RkzJsH1o+KKDSPvWFplqfX5wY5Pjjz
VcC5uKD0zXcWKybaOvcsPEBWzlbBQLCZVNbYiu2dYW83lU/jTQ2LBRJ/EtD3JX074kcnzwcGmWfQ
ezHSTmZ7ORTUekFClo/rxtLEhX+5Y+2jiUXDHXaV3orw4xr/w4t3GWOBODpL7xGYwxfwuGOlUVmG
8rQUlm7lrMIXFosYF9JrJF/qLWJ/30N8et54IUw5WAtbdyFkA0Atkw9HqHO0AeNoB4JA6/ecnJhj
5nlC45YqKGl/Ob9xr/tA1U6m5PElw0T/RpNMGYpCOPG1hyR2qXDjdnH2MBs94/vxX5dR1qPl2r92
IsZEhiUtpcLxzZq7idcR+L2sG22hOh1fkHzj/NJ+Q0bwznQVIJaJk0PbPfzT+E9W13NXRtkr5seW
DG9qCJJOlXfm2l48hd+SMtY/druYIPoAAAAAAAA=


--=-P6cCP0wZt6ivw+N3tm0t--

--===============2024097494123669535==
Content-Type: multipart/alternative; boundary="===============0898203704776017476=="
MIME-Version: 1.0
Content-Disposition: inline

--===============0898203704776017476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============0898203704776017476==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============0898203704776017476==--

--===============2024097494123669535==--

