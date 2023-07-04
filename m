Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1E74750C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhiH-0003mj-Px; Tue, 04 Jul 2023 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5423dbf64=dwmw@amazon.co.uk>)
 id 1qGhiE-0003hJ-Hu
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:13:06 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5423dbf64=dwmw@amazon.co.uk>)
 id 1qGhiC-000867-9H
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1688483584; x=1720019584;
 h=from:to:cc:subject:date:message-id:references: in-reply-to;
 bh=G4zchxGYtYwOGh9FLa4sAzq7JCB+tDZQsbwmCadS7dw=;
 b=Z+I5lohoZ/w3X2LQPzcppKsBybcOpkWFAzxO0rlzOZtMU7UuRYPNG7i8
 opo15AT5B2Va+BST5DeeQc9PFzexNkeRoXNT3jQq4nJP1oZ1n1qRbGuqZ
 kTe2YXHw6tUY14ghtGhrpLBZIo5Z2ahvDtq9ByHB0sN4a497RgXBeCHEb 8=;
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.01,181,1684800000"; 
 d="p7s'?scan'208";a="1141150388"
Content-Type: multipart/mixed; boundary="===============4724235755153146704=="
MIME-Version: 1.0
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-9103.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 15:12:53 +0000
Received: from EX19MTAUEA001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix)
 with ESMTPS id 8FE8640D60; Tue,  4 Jul 2023 15:12:53 +0000 (UTC)
Received: from EX19D008UEC004.ant.amazon.com (10.252.135.170) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 4 Jul 2023 15:12:45 +0000
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19D008UEC004.ant.amazon.com (10.252.135.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Tue, 4 Jul 2023 15:12:45 +0000
Received: from EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797]) by
 EX19D008UEC001.ant.amazon.com ([fe80::4702:5d1a:c556:797%3]) with mapi id
 15.02.1118.030; Tue, 4 Jul 2023 15:12:45 +0000
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "paul@xen.org"
 <paul@xen.org>
Subject: [PATCH] i386/xen: fix off-by-one in xen_evtchn_set_gsi()
Thread-Topic: [PATCH] i386/xen: fix off-by-one in xen_evtchn_set_gsi()
Thread-Index: AQHZron8iF7VJjXs5kWTD2FxIbnv+w==
Date: Tue, 4 Jul 2023 15:12:45 +0000
Message-ID: <4eb4c9868798cbfd2819c317a80037f4820b0502.camel@amazon.co.uk>
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-57-pbonzini@redhat.com>
 <CAFEAcA9KXrRscf9QK2Z5Say91KDm7xRLMZGh4A1rQ1+0TCHtcA@mail.gmail.com>
In-Reply-To: <CAFEAcA9KXrRscf9QK2Z5Say91KDm7xRLMZGh4A1rQ1+0TCHtcA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.83.21]
MIME-Version: 1.0
Precedence: Bulk
Received-SPF: pass client-ip=207.171.188.200;
 envelope-from=prvs=5423dbf64=dwmw@amazon.co.uk; helo=smtp-fw-9103.amazon.com
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

--===============4724235755153146704==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-xscgucQms3KOnuGHfFT9"

--=-xscgucQms3KOnuGHfFT9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coverity points out (CID 1508128) a bounds checking error. We need to check
for gsi >=3D IOAPIC_NUM_PINS, not just greater-than.

Also fix up an assert() that has the same problem, that Coverity didn't see=
.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3d810dbd59..0e9c108614 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1587,7 +1587,7 @@ static int allocate_pirq(XenEvtchnState *s, int type,=
 int gsi)
  found:
     pirq_inuse_word(s, pirq) |=3D pirq_inuse_bit(pirq);
     if (gsi >=3D 0) {
-        assert(gsi <=3D IOAPIC_NUM_PINS);
+        assert(gsi < IOAPIC_NUM_PINS);
         s->gsi_pirq[gsi] =3D pirq;
     }
     s->pirq[pirq].gsi =3D gsi;
@@ -1601,7 +1601,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
=20
     assert(qemu_mutex_iothread_locked());
=20
-    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {
+    if (!s || gsi < 0 || gsi >=3D IOAPIC_NUM_PINS) {
         return false;
     }
=20
--=20
2.34.1



--=-xscgucQms3KOnuGHfFT9
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
KoZIhvcNAQkFMQ8XDTIzMDcwNDE1MTI0NFowLwYJKoZIhvcNAQkEMSIEII4rugOqdnSGw5ghK+iD
oOG1SYGIvdxryTGJOnvGaBoIMIG9BgkrBgEEAYI3EAQxga8wgawwgZYxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
Y3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9u
IGFuZCBTZWN1cmUgRW1haWwgQ0ECEQC/QgfpbUT3q2fHshU/ReqfMIG/BgsqhkiG9w0BCRACCzGB
r6CBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL9CB+ltRPerZ8ey
FT9F6p8wDQYJKoZIhvcNAQEBBQAEggIAkA1X/Fy+jCiqFXN8vNfKU5QyyRWt+RWb1W434MsqYE3D
nM7nq4eTxBZUAcgRROERFutK5mnk7ONM9kMO/ciI7Yhm5nXw9sEMJUiE/VtdKLAVxr7l4Ks95Ts3
zBLpdEeM7+3FGbuviBOUJvbAsq+M16DZfxLaJnj6xYKXssM+mQEOog8n5ubSnJYEAiTWO/i8/yqr
cb14VTIlks1dG3vdOXxrJrlPcWR4wZwOIZKKoydNjJyFJgKA/le/fGdgs6QqhQkA/H1Kgr3Su/yu
fXVoUlHkOJhmMIQuPyvSs6VEgUjYU5dj6wVNYnA8AXK2C81tRnulW657FEjC4wFzFM9FfOjr3rAA
l3LRWR26gZCORcr1Nud0dXqRw4gvqLVsYNctmsHfPE+cytGE4Hma8yxpIA6vjslk2a5Lu+0KEEu0
2j+X2KaNu+HIP+HvBGR6RG3OXnlvb7n6T/JezuvW/3IuDClRF/lVqmBeB5xxr2Le2wWp4Xe9Mt22
+KepFjFk/yKq6/rZsz8L9ieVe9cNFWkxxlRPMKUO6O2Mc1IUHkBO/uHow3XjkPJDVj/BWfn/BhDp
xou/AryQx7wZkHk44Ll1kRoILlLx64/Bw4hXgWS/BhRK8XHNFXQBAKISm+vaUVxmF0XJhhE5kxyM
5M9GgjvKBZwQcByXHgM/0nJR824jNawAAAAAAAA=


--=-xscgucQms3KOnuGHfFT9--

--===============4724235755153146704==
Content-Type: multipart/alternative; boundary="===============4762182238558662761=="
MIME-Version: 1.0
Content-Disposition: inline

--===============4762182238558662761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============4762182238558662761==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============4762182238558662761==--

--===============4724235755153146704==--

