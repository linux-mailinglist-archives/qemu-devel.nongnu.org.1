Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7137186A9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4O3P-00007K-IV; Wed, 31 May 2023 11:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q4O3D-0008Rx-T5; Wed, 31 May 2023 11:47:51 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q4O38-0003gZ-Ew; Wed, 31 May 2023 11:47:49 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 31 May 2023 18:47:37 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Wed, 31 May 2023 18:47:37 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <philmd@linaro.org>, "Peter
 Maydell" <peter.maydell@linaro.org>, Sergey Kambalin <serg.oker@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Prepare bcm properties for videocore 4
Thread-Topic: [PATCH] Prepare bcm properties for videocore 4
Thread-Index: AQHZjnQFf0Q2c6tO7k+t5lGgZfG9869ykMkAgAA9vYX//+DiAIAB3+fL
Date: Wed, 31 May 2023 15:47:37 +0000
Message-ID: <49b0ba578bfb45f1be23f7608845d823@auriga.com>
References: <20230524191438.172019-1-sergey.kambalin@auriga.com>
 <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
 <15c444063e114814807551c36ea3389b@auriga.com>,
 <29192acf-0876-e14e-1331-45260cb179c3@linaro.org>
In-Reply-To: <29192acf-0876-e14e-1331-45260cb179c3@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.197.136.186]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--21.756200-8.000000
x-tmase-matchedrid: hanTHthjeUyJVA+ukO+5MW+O/HLchX8FfMhjt3b5PP1K0WT/zXAgkgPz
 oKxdv+wmduRFO7j4H00QSWI9Xhv3LnSKEvagy0HjUgKYbZFF6GhRpObkR9DMwhHcd/N8tFps6PQ
 HqhuqBva2x2RCqMUOG5MukukMeNp+0h9PZyvfl47fSQNpZkETVFTizEWrqKARSprpPKHJe892XX
 WXwtX0rRusZ9M71G9oBoYRaA2j95wYsgf0x8DpECrLqyE6Ur/jasHf7GLW0UBOaDdl7pggvTcpX
 pPCV0E384H0QJCUuBt3tlHqfT1SvI1DxVFCHBMnOjf3A4DTYuFNLPQl0QAltIG+e1larbBt1zOF
 7Lnq9EZhBHaMrj7UnZKGlulOhQfwriJx599t2CIotYKdGcWqiqiuB4qoLQw7IGqj5yPgTcgdjB1
 KZ6xMAIj01BdLzHaRFQQuVfaYT97Vz7Pxa/IuwPUMs5eBUu2degIHHX2L4YxRiRl337i3b73mJh
 WCLMZXULd14sEtBkH2CODBWINQwpK0D6qO4j3Nh2VzUlo4HVM10wJPYcToKALXROyKnJCr0kEAu
 EiAO7DpAijIP5mRu0Z/+lkjO0bJ0pE6X2byGstFuZWv3TATSNNt36mCIttpOyxd6V963VS48WuR
 FQVdauLzNWBegCW2dSg/jRMrTyd0DG5KjCRS/EgajxvGuzmhZffY7ZVRGrbOMLFwKL8lmxXz8NA
 K1bHu5QQpGehcQAt/ASQXWxm67Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.756200-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: 41CAFF3BA5A8BF05AB0AFC60F5A87C5865DF3EF5AB1DBEE34BE958B29EBFC9822000:8
Content-Type: multipart/alternative;
 boundary="_000_49b0ba578bfb45f1be23f7608845d823aurigacom_"
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

--_000_49b0ba578bfb45f1be23f7608845d823aurigacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8hDQoNClRoYW5rIHlvdSBndXlzIGZvciBjbGFyaWZpY2F0aW9ucyENCg0KDQo+IEFyZSB0
aGUgVkM0IHByb3BlcnRpZXMgc3VwcG9zZWQgdG8gYmUgcHJlc2VudCBvbg0KPiBhbGwgb3VyIGV4
aXN0aW5nIHJhc3BpIG1vZGVscz8gKGkuZS4gaXMgdGhpcyBhIGJ1Zw0KPiBmaXggZm9yIG91ciBl
eGlzdGluZyBtb2RlbHMgcmF0aGVyIHRoYW4gc3R1ZmYgd2Ugb25seQ0KPiB3YW50IG9uIHRoZSBu
ZXcgcmFzcGk0Yj8pDQoNCg0KWWVzLCB0aGV5J3JlIG5lZWRlZCB0byBzdXBwb3J0IFJQSTQgd29y
ay4gQW5kIEkgdGhpbmsgY2Fubm90IGJlIGNvbnNpZGVyZWQgYXMgYSBidWcgZml4Lg0KDQpTbyBJ
J20gZ29pbmcgdG8gc2VuZCBvbmUgcGF0Y2ggdG8gcmVwbGFjZSB0aGUgbWFnaWMgdmFsdWVzIHdp
dGggbmFtZWQgY29uc3RhbnRzLg0KDQpBbmQgdGhlbiBJJ20gZ29pbmcgdG8gc3BlbmQgc29tZSB0
aW1lIHRvIHNsaWNlIHRoZSBlbnRpcmUgcnBpNCBtYWNoaW5lIHRvIHNlcmllcyBvZiBzbWFsbCBw
YXRjaGVzLg0KDQpBbSBJIHVuZGVyc3RhbmQgaXQgcmlnaHQgdGhhdCBlYWNoIHBhdGNoIGluIHRo
ZSBzZXQgbXVzdCBwYXNzIGFsbCB0aGUgdGVzdHM/DQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQqnsKfkOiBQaGlsaXBwZSBNYXRoaWV1LURhdWSopiA8cGhpbG1kQGxpbmFyby5v
cmc+DQqnsKfkp+Gn4qfRp9On3afWp9+n4DogMzAgp96n0afxIDIwMjMgp9QuIDE3OjAyOjAwDQqn
rKfgp96n5TogS2FtYmFsaW4sIFNlcmdleTsgUGV0ZXIgTWF5ZGVsbDsgU2VyZ2V5IEthbWJhbGlu
DQqnrKfgp+Gn2qfxOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cqe0p9an3qfROiBSZTogW1BBVENIXSBQcmVwYXJlIGJjbSBwcm9wZXJ0aWVzIGZvciB2aWRlb2Nv
cmUgNA0KDQpPbiAzMC81LzIzIDE1OjAwLCBLYW1iYWxpbiwgU2VyZ2V5IHdyb3RlOg0KPiBHb3Qg
aXQhIFRoYW5rcyENCj4NCj4gSSdsbCBzcGxpdCB0aGlzIG9uZSB0byB0aHJlZSBwYXRjaGVzOg0K
PiAxKSByZXBsYWNlIG1hZ2ljIG51bWJlcnMgd2l0aCBuYW1lZCBjb25zdGFudHMgKHJlZmFjdG9y
aW5nKQ0KPg0KPiAyKSBhZGQgbmV3IHByb3BlcnRpZXMgZm9yIFZDIDQNCj4NCj4gMykgQWRkIHNv
bWUgdW5pdCB0ZXN0cyB0byBjaGVjayB0aGUgbmV3bHkgYWRkZWQgcHJvcGVydGllcyB2aWEgbWFp
bGJveA0KPg0KPg0KPiBJcyBpdCBPSz8NCg0KVGhpcyBsb29rcyBnb29kLiBUcnkgdG8gaW1hZ2lu
ZSBzaXR0aW5nIG9uIHRoZSBvdGhlciBzaWRlLCB3aGVyZQ0KZGV2ZWxvcGVycyB3aWxsIHJldmll
dyB5b3VyIGNvZGUuIFVzdWFsbHkgdGhlIHNpbXBsZXN0IHRoZSBiZXR0ZXIsDQpldmVuIGR1bWIg
cGF0Y2hlcywgc2luY2UgdGhlcmUgaXMgbm8gcmlzayBmb3IgZG91YnQuIERvbid0IGJlIGFmcmFp
ZA0KdG8gcG9zdCBtYW55IHNtYWxsIHBhdGNoZXMuDQoNClBlcnNvbmFsbHkgSSdkIGRvOg0KDQot
IGltcG9ydCBMaW51eCBkZWZpbml0aW9ucw0KLSByZXBsYWNlIGN1cnJlbnQgbWFnaWMgdmFsdWVz
IHdpdGggaW1wb3J0ZWQgTGludXggZGVmcw0KLSBhZGQgR0VUX0NMT0NLUyBwcm9wZXJ0eQ0KLSBh
ZGQgR0VUX1RIUk9UVExFRCBwcm9wZXJ0eQ0KLSBhZGQgRlJBTUVCVUZGRVIgcHJvcGVydGllcw0K
LSBhZGQgR1BJTyBwcm9wZXJ0aWVzDQotIGFkZCBWQ0hJUSBwcm9wZXJ0eQ0KDQpMb29rIGF0IGRv
X3Rlc3RfYXJtX3Jhc3BpKigpIGluIHRlc3RzL2F2b2NhZG8vYm9vdF9saW51eF9jb25zb2xlLnB5
LA0KeW91IGNvdWxkIGFkZCBuZXdlciBrZXJuZWxzIHdoaWNoIHVzZSB0aGUgcHJvcGVydGllcyB5
b3UgYWRkZWQuDQoNCj4gKFNvcnJ5IGZvciB3YXN0aW5nIHlvdXIgdGltZSBieSBpbmFwcHJvcHJp
YXRlIHBhdGNoZXMgLSB0aGlzIGlzIG15IGZpcnN0DQo+IGV4cGVyaWVuY2Ugd2l0aCBPU1MpDQoN
ClNvIGZhciB5b3UgYXJlIGRvaW5nIGdyZWF0IQ0KDQpUaGFua3MsDQoNClBoaWwuDQo=

--_000_49b0ba578bfb45f1be23f7608845d823aurigacom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><font size=3D"2"><span style=3D"font-size:10pt">Hello!<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Thank you guys for clari=
fications!<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt; Are the VC4 propert=
ies supposed to be present on<br>
&gt; all our existing raspi models? (i.e. is this a bug<br>
&gt; fix for our existing models rather than stuff we only<br>
&gt; want on the new raspi4b?)</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Yes, they're needed to s=
upport RPI4 work. And I think cannot be considered as a bug fix.
<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">So I'm going to send one=
 patch to replace the magic values with named constants.</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">And then I'm going to sp=
end some time to slice the entire rpi4 machine to series of small patches.<=
/span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Am I understand it right=
 that <b>each</b> patch in the set
<b>must </b>pass all the tests?<br>
</span></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=A7=B0=A7=E4:</b> Philippe Ma=
thieu-Daud=A8=A6 &lt;philmd@linaro.org&gt;<br>
<b>=A7=B0=A7=E4=A7=E1=A7=E2=A7=D1=A7=D3=A7=DD=A7=D6=A7=DF=A7=E0:</b> 30 =A7=
=DE=A7=D1=A7=F1 2023 =A7=D4. 17:02:00<br>
<b>=A7=AC=A7=E0=A7=DE=A7=E5:</b> Kambalin, Sergey; Peter Maydell; Sergey Ka=
mbalin<br>
<b>=A7=AC=A7=E0=A7=E1=A7=DA=A7=F1:</b> qemu-arm@nongnu.org; qemu-devel@nong=
nu.org<br>
<b>=A7=B4=A7=D6=A7=DE=A7=D1:</b> Re: [PATCH] Prepare bcm properties for vid=
eocore 4</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 30/5/23 15:00, Kambalin, Sergey wrote:<br>
&gt; Got it! Thanks!<br>
&gt; <br>
&gt; I'll split this one to three patches:<br>
&gt; 1) replace magic numbers with named&nbsp;constants (refactoring)<br>
&gt; <br>
&gt; 2) add new properties for VC 4<br>
&gt; <br>
&gt; 3) Add some unit tests to check the newly added properties via mailbox=
<br>
&gt; <br>
&gt; <br>
&gt; Is it OK?<br>
<br>
This looks good. Try to imagine sitting on the other side, where<br>
developers will review your code. Usually the simplest the better,<br>
even dumb patches, since there is no risk for doubt. Don't be afraid<br>
to post many small patches.<br>
<br>
Personally I'd do:<br>
<br>
- import Linux definitions<br>
- replace current magic values with imported Linux defs<br>
- add GET_CLOCKS property<br>
- add GET_THROTTLED property<br>
- add FRAMEBUFFER properties<br>
- add GPIO properties<br>
- add VCHIQ property<br>
<br>
Look at do_test_arm_raspi*() in tests/avocado/boot_linux_console.py,<br>
you could add newer kernels which use the properties you added.<br>
<br>
&gt; (Sorry for wasting your time by inappropriate patches - this is my fir=
st <br>
&gt; experience with OSS)<br>
<br>
So far you are doing great!<br>
<br>
Thanks,<br>
<br>
Phil.<br>
</div>
</span></font>
</body>
</html>

--_000_49b0ba578bfb45f1be23f7608845d823aurigacom_--

