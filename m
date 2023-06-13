Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5472EB70
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 21:02:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q99GX-0007xG-Qt; Tue, 13 Jun 2023 15:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q99GQ-0007w8-A9; Tue, 13 Jun 2023 15:01:10 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q99GM-0006HR-By; Tue, 13 Jun 2023 15:01:09 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 13 Jun 2023 22:00:57 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Tue, 13 Jun 2023 22:00:57 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <philmd@linaro.org>, "Sergey
 Kambalin" <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] Use named constants in BCM props
Thread-Topic: [PATCH v2] Use named constants in BCM props
Thread-Index: AQHZnSVtuceQCRhQG0GzQIhzANeD2K+HjoKAgAGC8e4=
Date: Tue, 13 Jun 2023 19:00:57 +0000
Message-ID: <60638efd8f464e66afc5e2a106f09d5f@auriga.com>
References: <5b407848-2a4c-6447-6726-cf85f278f3e7@linaro.org>
 <20230612115950.5002-1-sergey.kambalin@auriga.com>,
 <6fe833be-d884-663d-a58e-d3716e52e3d9@linaro.org>
In-Reply-To: <6fe833be-d884-663d-a58e-d3716e52e3d9@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [90.131.37.98]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--18.360800-8.000000
x-tmase-matchedrid: FWxETXsSM3yJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1d/O
 0TkwpBlDW5prtLhe9fW2kdECpOqtDcgM2GUFlvvaAjqAxuWkdTGOVGny5q72hpbI+L60qto8csx
 FLHbqBOKueOHAsvFJr1fQosWj+mfx+niVaMBfU7P/McoAQhls9ByVg41UOfy6DpnuR5eZKJYdjB
 1KZ6xMAIj01BdLzHaRp0zWEHov9BuYdDw4MLzGtmQFd4bOnrT6Yb/nLV/lbk9UjspoiX02F44FX
 KY0aP1xdEFcfN2dct7j9ZxpJJDibYgrKnsJ1GRgzYK5U+QI3O7BOVz0Jwcxl6vCrG0TnfVUg9xe
 4gtUJtpPfFsDwKf5665pphoUR1Toa2mlFaJP/q4IoUOTWQl7Et4Z4Nykx3k2NWO9z3c712SkLR5
 cMEnz0dY8qTWNMLWmFVZ/qX6HeZqPaFHMfVTC4FSeX1pUaPNfAX9GIncKpj2DcQaLKMLN/Ydm7I
 Pxq/o0Bqf2t8ki2oqbESrt9trA9C+rMhAlqq34
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--18.360800-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: BBE18B43475DF6BC277C72E2A1E92ACA3D6DABE300A6C01FF418B9CE24FB24A42000:8
Content-Type: multipart/alternative;
 boundary="_000_60638efd8f464e66afc5e2a106f09d5faurigacom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=82.97.202.32;
 envelope-from=sergey.kambalin@auriga.com; helo=hq-ms.auriga.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--_000_60638efd8f464e66afc5e2a106f09d5faurigacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCqewp+Q6IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZKimIDxwaGlsbWRAbGluYXJvLm9yZz4NCqewp+Sn4afip9Gn06fdp9an36fgOiAx
MyCn2qfwp9+n8SAyMDIzIKfULiAxOjMwDQqnrKfgp96n5TogU2VyZ2V5IEthbWJhbGluOyBxZW11
LWFybUBub25nbnUub3JnDQqnrKfgp+Gn2qfxOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IEthbWJh
bGluLCBTZXJnZXkNCqe0p9an3qfROiBSZTogW1BBVENIIHYyXSBVc2UgbmFtZWQgY29uc3RhbnRz
IGluIEJDTSBwcm9wcw0KDQpPbiAxMi82LzIzIDEzOjU5LCBTZXJnZXkgS2FtYmFsaW4gd3JvdGU6
DQo+IHBpbmcNCj4NCj4gLSBQSV9GSVJNV0FSRV8qX1JBVEUgY29uc3RzbnRzIHdlcmUgbW92ZWQg
dG8gcmFzcGJlcnJ5cGktZnctZGVmcy5oDQo+ICAgIChzZWVtcyBtb3JlIHN1aXRhYmxlIHBsYWNl
IGZvciB0aGVtKQ0KPiAtIGluY2x1c2lvbiBvZiAicWVtdS9vc2RlcC5oIiBoYXMgYmVlbiByZW1v
dmVkDQo+IC0geWVhciBpbiBjb3B5cmlnaHQgaGVhZGVyIGhhcyBiZWVuIHVwZGF0ZWQNCj4NCj4g
U2lnbmVkLW9mZi1ieTogU2VyZ2V5IEthbWJhbGluIDxzZXJnZXkua2FtYmFsaW5AYXVyaWdhLmNv
bT4NCj4gLS0tDQo+ICAgaHcvbWlzYy9iY20yODM1X3Byb3BlcnR5LmMgICAgICAgICAgICB8IDEy
MCArKysrKysrKysrLS0tLS0tLS0tDQo+ICAgaW5jbHVkZS9ody9hcm0vcmFzcGlfcGxhdGZvcm0u
aCAgICAgICB8ICAgNiArDQo+ICAgaW5jbHVkZS9ody9taXNjL3Jhc3BiZXJyeXBpLWZ3LWRlZnMu
aCB8IDE2MyArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MjM2IGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2h3L21pc2MvcmFzcGJlcnJ5cGktZnctZGVmcy5oDQoNCg0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9hcm0vcmFzcGlfcGxhdGZvcm0uaCBiL2luY2x1ZGUvaHcvYXJtL3Jhc3Bp
X3BsYXRmb3JtLmgNCj4gaW5kZXggNGE1NmRkNGI4OS4uOTJhMzE3OTUwYSAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9ody9hcm0vcmFzcGlfcGxhdGZvcm0uaA0KPiArKysgYi9pbmNsdWRlL2h3L2Fy
bS9yYXNwaV9wbGF0Zm9ybS5oDQo+IEBAIC0xNzAsNCArMTcwLDEwIEBADQo+ICAgI2RlZmluZSBJ
TlRFUlJVUFRfSUxMRUdBTF9UWVBFMCAgICAgICAgNg0KPiAgICNkZWZpbmUgSU5URVJSVVBUX0lM
TEVHQUxfVFlQRTEgICAgICAgIDcNCj4NCj4gKy8qIENsb2NrIHJhdGVzICovDQo+ICsjZGVmaW5l
IFJQSV9GSVJNV0FSRV9FTU1DX0NMS19SQVRFICAgIDUwMDAwMDAwDQoNCk9LLg0KDQo+ICsjZGVm
aW5lIFJQSV9GSVJNV0FSRV9VQVJUX0NMS19SQVRFICAgIDMwMDAwMDANCg0KT0suDQoNCj4gKyNk
ZWZpbmUgUlBJX0ZJUk1XQVJFX0NPUkVfQ0xLX1JBVEUgICAgMzUwMDAwMDAwDQoNClNlZW1zIFZD
NCBmcmVxdWVuY3kgcmFuZ2UsIGFkYXB0ZWQgZm9yIHJhc3BpMyAoQkNNMjgzNykuDQoNCklJVUMg
dGhlIFZDNiAocmFzcGk0KSBpcyBjbG9ja2VkIGF0IDUwME1Iei4NCg0KUy5LLjogWW91J3JlIHJp
Z2h0ISBUaGVyZSBzaG91bGQgYmUgMjUwIE1IeiBhcyB0aGVzZSBhcmUgYmNtMjgzNSB2YWx1ZXMs
IG5vdCBiY20yNzExKHJwaTQpDQoNCj4gKyNkZWZpbmUgUlBJX0ZJUk1XQVJFX0RFRkFVTFRfQ0xL
X1JBVEUgNzAwMDAwMDAwDQoNClNlZW1zIFZDNCBmcmVxIGZvciByYXNwaTEgKEJDTTI4MzUpDQoN
Ckxpa2VseSB3ZSBkb24ndCB3YW50IHRvIHVzZSBhIGRlZmF1bHQsIGJ1dCB0aGUgY29ycmVjdCBw
ZXItc29jDQp2YWx1ZS4uLg0KDQpTLksuOiAgUGVyLXNvYyB2YWx1ZXMgYXJlIG5vdCBpbXBsZW1l
bnRlZCB5ZXQsIGFuZCBJJ20gbm90IDEwMCUgc3VyZSBpZiBpdCdzIG5lZWRlZC4NCiAgICAgICAg
ICBTbyBJIGRlY2lkZWQgdG8gcmV0dXJuIEJDTTI4MzUgY29yZSBjbG9jayBhcyBhIGRlZmF1bHQg
dmFsdWUuDQogICAgICAgICAgTWF5IGJlIGxlYXZpbmcgTE9HX1VOSU1QIG1lc3NhZ2Ugd291bGQg
aGF2ZSBiZWVuIGEgYmV0dGVyIG9wdGlvbj8NCg0KU2hvdWxkIEkgZml4IGl0IHRoZXJlIG9yIHB1
bGwgeW91ciBzcGxpdCBwYXRjaCBhbmQgY29udGludWUgaXQgYXMgdjQ/DQo=

--_000_60638efd8f464e66afc5e2a106f09d5faurigacom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>=A7=B0=A7=E4:</b> Philippe Ma=
thieu-Daud=A8=A6 &lt;philmd@linaro.org&gt;<br>
<b>=A7=B0=A7=E4=A7=E1=A7=E2=A7=D1=A7=D3=A7=DD=A7=D6=A7=DF=A7=E0:</b> 13 =A7=
=DA=A7=F0=A7=DF=A7=F1 2023 =A7=D4. 1:30<br>
<b>=A7=AC=A7=E0=A7=DE=A7=E5:</b> Sergey Kambalin; qemu-arm@nongnu.org<br>
<b>=A7=AC=A7=E0=A7=E1=A7=DA=A7=F1:</b> qemu-devel@nongnu.org; Kambalin, Ser=
gey<br>
<b>=A7=B4=A7=D6=A7=DE=A7=D1:</b> Re: [PATCH v2] Use named constants in BCM =
props</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 12/6/23 13:59, Sergey Kambalin wrote:<br>
&gt; ping<br>
&gt; <br>
&gt; - PI_FIRMWARE_*_RATE constsnts were moved to raspberrypi-fw-defs.h<br>
&gt;&nbsp;&nbsp;&nbsp; (seems more suitable place for them)<br>
&gt; - inclusion of &quot;qemu/osdep.h&quot; has been removed<br>
&gt; - year in copyright header has been updated<br>
&gt; <br>
&gt; Signed-off-by: Sergey Kambalin &lt;sergey.kambalin@auriga.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; hw/misc/bcm2835_property.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 120 &#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;---------<br>
&gt;&nbsp;&nbsp; include/hw/arm/raspi_platform.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp;&nbsp; 6 &#43;<br>
&gt;&nbsp;&nbsp; include/hw/misc/raspberrypi-fw-defs.h | 163 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 3 files changed, 236 insertions(&#43;), 53 deletions(-)<br=
>
&gt;&nbsp;&nbsp; create mode 100644 include/hw/misc/raspberrypi-fw-defs.h<b=
r>
<br>
<br>
&gt; diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_pl=
atform.h<br>
&gt; index 4a56dd4b89..92a317950a 100644<br>
&gt; --- a/include/hw/arm/raspi_platform.h<br>
&gt; &#43;&#43;&#43; b/include/hw/arm/raspi_platform.h<br>
&gt; @@ -170,4 &#43;170,10 @@<br>
&gt;&nbsp;&nbsp; #define INTERRUPT_ILLEGAL_TYPE0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 6<br>
&gt;&nbsp;&nbsp; #define INTERRUPT_ILLEGAL_TYPE1&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 7<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/* Clock rates */<br>
&gt; &#43;#define RPI_FIRMWARE_EMMC_CLK_RATE&nbsp;&nbsp;&nbsp; 50000000<br>
<br>
OK.<br>
<br>
&gt; &#43;#define RPI_FIRMWARE_UART_CLK_RATE&nbsp;&nbsp;&nbsp; 3000000<br>
<br>
OK.<br>
<br>
&gt; &#43;#define RPI_FIRMWARE_CORE_CLK_RATE&nbsp;&nbsp;&nbsp; 350000000<br=
>
<br>
Seems VC4 frequency range, adapted for raspi3 (BCM2837).<br>
<br>
IIUC the VC6 (raspi4) is clocked at 500MHz.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
S.K.: You're right! There should be 250 MHz as these are bcm2835 values, no=
t bcm2711(rpi4</span>)<br>
<br>
&gt; &#43;#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000<br>
<br>
Seems VC4 freq for raspi1 (BCM2835)<br>
<br>
Likely we don't want to use a default, but the correct per-soc<br>
value...</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
S.K.:&nbsp; Per-soc values are not implemented yet, and I'm not 100% sure i=
f it's needed.
</span><br>
</div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So I decided to retu=
rn
</span><font size=3D"2"><span style=3D"font-size: 10pt; background-color: r=
gb(0, 255, 0);">BCM2835</span></font><span style=3D"background-color: rgb(0=
, 255, 0);"> core clock as a default value.
</span><br>
</div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
<span style=3D"background-color: rgb(0, 255, 0);">May be leaving </span><sp=
an style=3D"background-color: rgb(0, 255, 0);">LOG_UNIMP</span><span style=
=3D"background-color: rgb(0, 255, 0);"> message would have been a better op=
tion?</span></div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
<br>
</span></div>
<div class=3D"PlainText"><span style=3D"background-color: rgb(0, 255, 0);">=
Should I fix it there or pull your split patch and continue it as v4?
<br>
</span></div>
</span></font></div>
</div>
</body>
</html>

--_000_60638efd8f464e66afc5e2a106f09d5faurigacom_--

