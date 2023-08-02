Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C068976C528
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 08:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR51d-0004bR-A8; Wed, 02 Aug 2023 02:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR51R-0004Yr-R5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:07:52 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR51N-00059y-O4
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690956459; x=1691561259; i=deller@gmx.de;
 bh=UQHyCi1fLy6uOsDKBqUU5lKYax7o5Xi+0Q0917bBuAw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LkZNJyue9aUvA5eXcmjU9+JrnB9u/aoRKByxWWyWH454jZ5XhXYWlfRwAMAoR1iceY+3dGo
 lS1iUUqWpRz6FbvM3Vdd/X/lHrEp+MnwZmzIcWLz6idl96mLSU83StjP2HdeVNO02HtDm9S8d
 m3HZINB1KHlWnt7evYDgQHbZEvVO5mAt2hkjU7wINBacoecHih36YQzmtH08NeNoQdJZM2bpj
 d2Ft4QautbX+vpFFAQXlbBDIgC+PpO5Rl63aIpTUWTXcVPyQmcjPux8QYE9znV2HpPB+f9Kr3
 vtWRjV6l0AhaTJVUeEUryr1p3zfyWDtUKLCcuQfquJXbKCoF6WMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1qR51H1hp2-00009s; Wed, 02
 Aug 2023 08:07:39 +0200
Message-ID: <7dcca85c-d0bf-c8de-3cf2-1f3fa863aa92@gmx.de>
Date: Wed, 2 Aug 2023 08:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/8] linux-user: Show heap address in /proc/pid/maps
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-7-deller@gmx.de>
 <c9812263-f0fe-aff4-b594-616601a5d2f1@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <c9812263-f0fe-aff4-b594-616601a5d2f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:v8MoUl6MqnI//K7N2c8TdSn5nJ44zghWFiIkoj+xcNywXUB+7QB
 xOiRgVVKOnNX7XnAOy9yYZvJ76YxA4wOUxwnacZpXyGNf+69tIKIO9iHu1+ArORtHqTxiq3
 9Fgk+8smjkbMRvKqaBzdAMUsDcohbbwmB2qsu76nVliohBWJsqalXg/5Bg8T/WfomM8lbGn
 F/HG/+T9R8xDcuhu85sWA==
UI-OutboundReport: notjunk:1;M01:P0:91K9Hi6vw0w=;dK5FqVWklubq/U7RP+ixjgIIAf7
 TENRIEBngOB6yTzLL7qS5PhBFOe2xIB6oDdpMgfyQyI0TlVG72a+A45x8nWRxc7q1UZaIN5Td
 Ar1nEy9g/y0KPpCVyOiITC8JcetfUU8yurpqqiraL6Uz8upFHAxYTsyiHTy1xWcvKFWBa8Q1S
 OLsF2R9UAzEMG5upKCWwypzJc9GNRY7ds1sxSx9QyUTK4qaKJjYD+Jbaro/j4KP3quGrR+zR0
 c60vurtIYlaKGF22xiaAP11y+cNzQCGJVl5kofnS/veEOieuof3Q+VUoG1YVMbGCwV0sG68vw
 MG8nkgs/vOdJdhoEk44e3H0engATlQVCgcI7rxvOBniZCEUUEFsX8TzCF/RgL4zjxMjZbsD5w
 FpDanui9ZhOS2tcAfNgL19Xa2SjF4k0rVP9Mj08K5pCAFl/nIUsK4eaz1qPzX6ioYQFDLxuNK
 sRE48wWvUcRkCO5wZidPlBqw9wi/umdJ8GbCb3kXDXjC3g+YF44h9SCJHUyLSq8TOE+shq1l6
 5W2htaPvvTSu8QNCVepUAMSjaTQP0g2DTIHpi2aQTrGBTo6NEMHM7oOB6z3Utp13sj2r2R9UB
 lpUd/KKMtesWRcQzUcXX4deXetBirxnA49ld59/5nwX98nVCr6/TnEmIxKU4O+Xr3Y0uotVnW
 DjxPeyr2WiTqoP5YACfSSXa6kGnip5aSRCoBc1clLb58OvNlLlxIOrv2mbT1O2i9gXFQuRgdl
 6pO6Dq3wpABwCwoUX/QdcpQ6zad8GNjzZpcrEoSsG/mYAwenMoIsdd3fmn6j8lTCuqk0Sr87p
 ogwZDF/8Q85XBNoJd0Z9JKPhvIyiXII9X5Zjk3dj0IWUfS60V/+iMj1qoPCKQw8lYxc8KcU0T
 ktVZS5DZ7V657QQ4q1WnrP6w9ClrxoWMKcERlbwbLwPY4BcbM6kEjqIQ5B9A0Zv3OUgMpW6xF
 6v544/kIHD8NeWS/s8AtGB+/ldc=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgUGhpbGlwbGxlLA0KDQpPbiA4LzIvMjMgMDc6NDEsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IHdyb3RlOg0KPiBPbiAyLzgvMjMgMDE6MjcsIEhlbGdlIERlbGxlciB3cm90ZToNCi4uDQo+PiBT
aG93IDMyLSBhbmQgNjQtYml0IHBvaW50ZXJzIHdpdGggOCBkaWdpdHMgYW5kIGxlYWRpbmcgemVy
b3MgKCUwOHgvJTA4bHgpLg0KPj4gRm9yIDY0LWJpdCB3ZSBjb3VsZCB1c2UgJTE2bHgsIGJ1dCB3
ZSBtaW1pYyB0aGUgTGludXgga2VybmVsLCB3aGljaCBzaG93cw0KPj4gZXZlbiA2NC1iaXQgYWRk
cmVzc2VzIHdpdGggJTA4bHguDQo+IA0KPiBZb3UgYXJlIGRlc2NyaWJpbmcgMyBjaGFuZ2VzLCBk
byB5b3UgbWluZCBzcGxpdHRpbmcgaW4gMyBwYXRjaGVzPw0KDQpZZXMsIHdpbGwgZG8uLi4NCg0K
Pj4gQEAgLTgwOTAsMTQgKzgwOTEsMTggQEAgc3RhdGljIGludCBvcGVuX3NlbGZfbWFwc18xKENQ
VUFyY2hTdGF0ZSAqY3B1X2VudiwgaW50IGZkLCBib29sIHNtYXBzKQ0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0NCj4+DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXRoID0gZS0+cGF0aDsN
Cj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0cy0+aGVhcF9iYXNlICYmIGgy
ZyhtaW4pID09IHRzLT5oZWFwX2Jhc2UpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGF0aCA9ICJbaGVhcF0iOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiAN
Cj4gUGF0Y2ggIzMgYnV0IHNlZSBiZWxvdywNCg0KT2suLi5idXQgKHNlZSBiZWxvdykuLi4NCg0K
ICANCj4+IMKgICNpZmRlZiBUQVJHRVRfSFBQQQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGgyZyhtYXgpID09IHRzLT5pbmZvLT5zdGFja19saW1pdCkgew0KPj4gwqAgI2Vsc2UN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChoMmcobWluKSA9PSB0cy0+aW5mby0+
c3RhY2tfbGltaXQpIHsNCj4+IMKgICNlbmRpZg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwYXRoID0gIltzdGFja10iOw0KPiANCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfSBlbHNlIGlmICh0cy0+aGVhcF9iYXNlICYmIGgyZyhtaW4pID09IHRzLT5oZWFw
X2Jhc2UpIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdGgg
PSAiW2hlYXBdIjsNCj4gDQoNCllvdSBjYW4ndCBwdXQgaXQgaW50byB0aGUgImVsc2UiIHBhcnQg
aGVyZS4uLiB0aGVuIGhlYXAgd2lsbCBuZXZlciBzaG93IHVwDQooYXMgaGVhcCBhbmQgc3RhY2sg
b2Z0ZW4gc2hhcmUgdGhlIHNhbWUgcmVnaW9uKS4NCg0KU2luY2UgImhlYXAiIGlzIGxvZ2ljYWxs
eSBhdCBzbWFsbGVyIGFkZHJlc3MgdGhhbiBzdGFjaywgSSBtb3ZlZCB0aGUNCmh1bmsgYWJvdmUg
dGhlICJzdGFjayIgcGFydC4NCiAgDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ug
ew0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXRoID0gZS0+cGF0aDsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb3VudCA9IGRwcmludGYoZmQsIFRBUkdFVF9BQklfRk1UX3B0ciAiLSIgVEFSR0VU
X0FCSV9GTVRfcHRyDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyENCkhlbGdlDQo=

