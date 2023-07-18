Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F39757199
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 04:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLa8z-0005bD-7v; Mon, 17 Jul 2023 22:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLa8u-0005ax-67
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 22:08:49 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLa8q-0005bv-HL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 22:08:47 -0400
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "mark.cave-ayland@ilande.co.uk"
 <mark.cave-ayland@ilande.co.uk>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Topic: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Index: AQHZuFrFNlltFg4MfUmGmCXkRR+pm6+9DRuAgACaiID//4BWgIAAwmOA//9/ewCAAI5AAP//gJQAACn944A=
Date: Tue, 18 Jul 2023 02:07:51 +0000
Message-ID: <57634FEE-D9E5-459C-A32E-6371685A9EDE@baidu.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
 <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
 <CAMxuvawBOLcS8SQzPiVgMuyMXFadrqrMzcuA1ddB-uaDd1qZgA@mail.gmail.com>
 <3AC28C88-5682-4EBD-8996-5125FAF5F2A4@baidu.com>
 <CAMxuvazXYgKeaBoJxqxEEM2opiYAqQA=2Zg_6K2kUFUTSmjwog@mail.gmail.com>
In-Reply-To: <CAMxuvazXYgKeaBoJxqxEEM2opiYAqQA=2Zg_6K2kUFUTSmjwog@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2DDD51435CF914DB3D62D41D29FCD16@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.47
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

PiBIaQ0KPg0KPiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCA1OjQz4oCvUE0gR2FvLFNoaXl1YW4g
PGdhb3NoaXl1YW5AYmFpZHUuY29tPiB3cm90ZToNCj4NCj4gPiA+IEhpDQo+ID4gPg0KPiA+ID4g
T24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgNDo1M+KAr1BNIEdhbyxTaGl5dWFuIDxnYW9zaGl5dWFu
QGJhaWR1LmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gU28gbW92ZSB0aGUgZ3Vlc3QgbW91c2UgcG9pbnRlciB0byAoMCwgMCkgb2YgdGhlIHNj
cmVlbiB3aGVuDQo+ID4gY29ubmVjdA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBWTkMs
IGFuZCB0aGVuIG1vdmUgdGhlIG1vdXNlIHBvaW50ZXIgdG8gdGhlIGN1cnNvciBvZg0KPiA+IFZO
QyhhYnNvbHV0ZQ0KPiA+ID4gPiA+ID4gPiA+IGNvb3JkaW5hdGVzIGFyZSBhbHNvIHJlbGF0aXZl
IGNvb3JkaW5hdGVzKS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IEl0J3MgaGFyZGx5IGEgc29sdXRpb24sIHlvdSBzdGlsbCBoYXZlIG5vIGNsdWUgd2hh
dCB3aWxsIGJlIHRoZQ0KPiA+IGd1ZXN0DQo+ID4gPiA+ID4gPiBtb3VzZQ0KPiA+ID4gPiA+ID4g
PiBwb3NpdGlvbi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBoYXZlIG5vIGNsdWUgd2hh
dCB3aWxsIGJlIHRoZSBndWVzdCBtb3VzZSBwb3NpdGlvbiwgd2UgY2FuIG1vdmUNCj4gPiB0aGUN
Cj4gPiA+ID4gPiA+IGd1ZXN0DQo+ID4gPiA+ID4gPiBtb3VzZSB0byAoMCwwKSBlYWNoIGNvbm5l
Y3QgdGhlIFZOQy4gTm93LCB0aGUgY3Vyc29yIG9mIFZOQyB3aWxsDQo+ID4gYmUgdGhlDQo+ID4g
PiA+ID4gPiByZWxhdGl2ZSBjb29yZGluYXRlcy4gSW4gYSB3YXksIHRoaXMgaXMgYSBxdWlyayB0
byBrbm93IHRoZSBndWVzdA0KPiA+IG1vdXNlDQo+ID4gPiA+ID4gPiBwb3NpdGlvbi4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVyZSBpcyBubyBndWFyYW50ZWUgdGhlIGd1
ZXN0IHBvaW50ZXIgd2lsbCBiZSBhdCAoMCwwKSB0aG91Z2gsIGFuZA0KPiA+IHRoYXQNCj4gPiA+
ID4gPiBkb2Vzbid0IGV4cGxhaW4gaG93IHRoYXQgd291bGQgaGVscC4gV2hpY2ggY2xpZW50IGFy
ZSB5b3UgdXNpbmc/IEFyZQ0KPiA+IHlvdQ0KPiA+ID4gPiA+IGRyYXdpbmcgdGhlIGd1ZXN0IGN1
cnNvcj8gVGhpcyBjYW4ndCBiZSBkb25lIGN1cnJlbnRseSB3aXRoIHRoZSBsYWNrDQo+ID4gb2Yg
YQ0KPiA+ID4gPiA+IG1lc3NhZ2UgdG8gdGVsbCB0aGUgZ3Vlc3QgbW91c2UgcG9zaXRpb24uICht
b3ZpbmcgLyBzeW5jLWluZyB0aGUNCj4gPiBjbGllbnQNCj4gPiA+ID4gPiBjdXJzb3IgcG9zaXRp
b24gd291bGQgYmUgZXZlbiB3b3JzZSBpbiBtYW55IHdheXMpDQo+ID4gPiA+DQo+ID4gPiA+IFNv
cnJ5LCBteSBkZXNjcmlwdGlvbiBpc24ndCBhY2N1cmF0ZS4NCj4gPiA+ID4NCj4gPiA+ID4gV2hl
biBjb25uZWN0IHRoZSB2bmMgc2VydmVyLA0KPiA+ID4gPiAgICAgdm5jX2Nvbm5lY3QNCj4gPiA+
ID4gICAgICAgLT4gdnMtPmxhc3RfeCA9IC0xOw0KPiA+ID4gPiAgICAgICAtPiB2cy0+bGFzdF95
ID0gLTE7DQo+ID4gPiA+DQo+ID4gPiA+IG1vdmUgY2xpZW50IGN1cnNvciB0byB2bmMgc2NyZWVu
LA0KPiA+ID4gPiAgICAgdm5jX2NsaWVudF9pbw0KPiA+ID4gPiAgICAgICAtPnZuY19jbGllbnRf
cmVhZA0KPiA+ID4gPiAgICAgICAgIC0+cHJvdG9jb2xfY2xpZW50X21zZw0KPiA+ID4gPiAgICAg
ICAgICAgLT5wb2ludGVyX2V2ZW50KHgseSkNCj4gPiA+ID4gICAgICAgICAgICAgLT4gcWVtdV9p
bnB1dF9xdWV1ZV9yZWwoY29uLCBJTlBVVF9BWElTX1gsIDAgLSB3aWR0aCk7DQo+ID4gPiA+ICAg
ICAgICAgICAgIC0+IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19ZLCAwIC0g
aGVpZ2h0KTsNCj4gPiA+ID4gICAgICAgICAgICAgLT4geD0wLHk9MA0KPiA+ID4gPiAgICAgICAg
ICAgICAtPiB2cy0+bGFzdF94ID0geDt2cy0+bGFzdF95ID0geTsNCj4gPiA+ID4gICAgICAgICAg
ICAgLT4gcWVtdV9pbnB1dF9ldmVudF9zeW5jICAgLy8gdGhpcyB3aWxsIGluZm9ybSB0aGUgZ3Vl
c3QNCj4gPiBtb3ZlDQo+ID4gPiA+IHRvICgwLCAwKQ0KPiA+ID4gPg0KPiA+ID4gPiB0aGUgbmV4
dCBldmVudCwNCj4gPiA+ID4gICAgICAgICAgIC0+cG9pbnRlcl9ldmVudCh4LHkpDQo+ID4gPiA+
ICAgICAgICAgICAgIC0+IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19YLCB4
IC0gdnMtPmxhc3RfeCk7DQo+ID4gPiA+ICAgICAgICAgICAgIC0+IHFlbXVfaW5wdXRfcXVldWVf
cmVsKGNvbiwgSU5QVVRfQVhJU19YLCB4IC0gdnMtPmxhc3RfeCk7DQo+ID4gPiA+ICAgICAgICAg
ICAgIC0+IHFlbXVfaW5wdXRfZXZlbnRfc3luYyAgICAvLyB0aGlzIHdpbGwgaW5mb3JtIHRoZSBn
dWVzdA0KPiA+IGZyb20NCj4gPiA+ID4gKDAsMCkgbW92ZSB0byAoeCx5KSwNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvLyB0aGUNCj4gPiA+ID4gY2xpZW50IGN1cnNvciBhbmQgZ3Vlc3QgbW91c2Ugd2lsbCBz
eW5jLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEFjdHVhbGx5LCBpdCB3aWxsIGJlICggeCAtIHZz
LT5sYXN0X3gsIHkgLSB2cy0+bGFzdF95KSwgbm90IG5lY2Vzc2FyaWx5DQo+ID4gKHgsDQo+ID4g
PiB5KSwgdW5sZXNzIHlvdSBhbHNvIHNldCBsYXN0X3ggPSAwIC8gbGFzdF95ID0gMC4NCj4gPg0K
PiA+IHllcywgc2V0IGxhc3RfeCA9IDAgLyBsYXN0X3kgPSAwIGFuZCBvbmx5IHRoZSBmaXJzdCB0
aW1lIGVudGVyDQo+ID4gcG9pbnRlcl9ldmVudC4NCj4gPg0KPiA+ICAgICAgICAgIGlmICh2cy0+
bGFzdF94ICE9IC0xKSB7DQo+ID4gICAgICAgICAgICAgIHFlbXVfaW5wdXRfcXVldWVfcmVsKGNv
biwgSU5QVVRfQVhJU19YLCB4IC0gdnMtPmxhc3RfeCk7DQo+ID4gICAgICAgICAgICAgIHFlbXVf
aW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19ZLCB5IC0gdnMtPmxhc3RfeSk7DQo+ID4g
KyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcWVtdV9pbnB1dF9xdWV1ZV9yZWwo
Y29uLCBJTlBVVF9BWElTX1gsIDAgLSB3aWR0aCk7DQo+ID4gKyAgICAgICAgICAgIHFlbXVfaW5w
dXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19ZLCAwIC0gaGVpZ2h0KTsNCj4gPiArICAgICAg
ICAgICAgeCA9IDA7DQo+ID4gKyAgICAgICAgICAgIHkgPSAwOw0KPiA+ICAgICAgICAgIH0NCj4g
PiAgICAgICAgICB2cy0+bGFzdF94ID0geDsNCj4gPiAgICAgICAgICB2cy0+bGFzdF95ID0geTsN
Cj4gPg0KPiA+ID4NCj4gPiA+IEJ1dCBldmVuIHRoZW4sIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0
aGUgZ3Vlc3QgcG9zaXRpb24gd2lsbCBiZSBhIHgveS4uLg0KPiA+ID4NCj4gPg0KPiA+IEVtbW0s
IGNvbXBhcmVkIHRvIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCBpdCBpcyBhdCBsZWFzdCBn
ZXR0aW5nDQo+ID4gY2xvc2VyLg0KPiA+IFRoZSBjdXJyZW50IHN0YXRlIGlzIHNpbXBseSB1bmJl
YXJhYmxlLg0KPiA+DQo+ID4gPiBJdCdzIGJlZW4gaW1wbGVtZW50ZWQgb24gTGludXggVk0gZm9y
IGEgbG9uZyB3aGlsZSAoZmlyc3QgaW4gdXNlcnNwYWNlLA0KPiA+ID4gdGhlbiBpbiBrZXJuZWwg
c2luY2UgfjIwMTUpLiBCdXQgSSBkb24ndCBrbm93IGFib3V0IHRoZSBXaW5kb3dzIHN1cHBvcnQs
DQo+ID4gaXQNCj4gPiA+IGxvb2tzIGxpa2UgeW91IG5lZWQgYSBkcml2ZXIgc3VjaCBhcyBwcm92
aWRlZCBieSBWTVdhdmUsIGJ1dCBpdCBzZWVtcw0KPiA+ID4gY2xvc2VkLXNvdXJjZS4uLiAgQXQg
dGhpcyBwb2ludCBpdCdzIHByb2JhYmx5IGJldHRlciB0byB1c2UgdmlydGlvLWlucHV0LA0KPiA+
ID4gd2hpY2ggaGFzIG9wZW4tc291cmNlL2ZyZWUgd2luZG93cyBkcml2ZXJzLg0KPiA+DQo+ID4g
VGhhbmtzLCBJIHRyaWVkIGluc3RhbGwgdm1tb3VzZSBkcml2ZXIgaW4gd2luZG93cyBzdWNjZXNz
IGFuZCByZWJvb3QuDQo+ID4gSG93ZXZlciAnaW5mbyBtaWNlJyBhcw0KPiA+IGZvbGxvd3MgYW5k
IGRvbid0IGhhdmUgdm1tb3VzZSAoYWJzb2x1dGUpLg0KPiA+DQo+ID4gKiBNb3VzZSAjMjogUUVN
VSBQUy8yIE1vdXNlDQo+ID4NCj4gPiBUaGUgZ3Vlc3QgbW91c2UgaXNuJ3Qgc3luYyB3aXRoIGNs
aWVudCBjdXJzb3IuLi4NCj4gPg0KPg0KPiBMb29rIGlmIHlvdSBoYXZlICJkZXY6IHZtbW91c2Us
IGlkICIgaW4gImluZm8gcXRyZWUiIG9yIHNldCAtbWFjaGluZQ0KPiB2bXBvcnQ9b24uDQoNCiJp
bmZvIHF0cmVlIiBhcyBmb2xsb3dzLCB0aGUgY2xpZW50IGN1cnNvciBhbmQgZ3Vlc3QgbW91c2Ug
Y2Fubid0IGFsaWduLi4uDQoNCiAgICAgICAgICBkZXY6IHZtbW91c2UsIGlkICIiDQogICAgICAg
ICAgZGV2OiB2bXBvcnQsIGlkICIiDQogICAgICAgICAgICB4LXJlYWQtc2V0LWVheCA9IHRydWUN
CiAgICAgICAgICAgIHgtc2lnbmFsLXVuc3VwcG9ydGVkLWNtZCA9IHRydWUNCiAgICAgICAgICAg
IHgtcmVwb3J0LXZteC10eXBlID0gdHJ1ZQ0KICAgICAgICAgICAgeC1jbWRzLXYyID0gdHJ1ZQ0K
ICAgICAgICAgICAgdm13YXJlLXZteC12ZXJzaW9uID0gNiAoMHg2KQ0KICAgICAgICAgICAgdm13
YXJlLXZteC10eXBlID0gMiAoMHgyKQ0KICAgICAgICAgIGRldjogaTgwNDIsIGlkICIiDQogICAg
ICAgICAgICBncGlvLW91dCAiYTIwIiAxDQogICAgICAgICAgICBleHRlbmRlZC1zdGF0ZSA9IHRy
dWUNCiAgICAgICAgICAgIGtiZC10aHJvdHRsZSA9IGZhbHNlDQogICAgICAgICAgICBpc2EgaXJx
cyAxLDEyDQoNCkkgaGF2ZSBkZWNpZGVkIHRvIHN0aWxsIHVzZSB0aGUgbWV0aG9kIGluIHRoaXMg
cGF0Y2guIA0KDQpUaGFua3MgTWFyYy1BbmRyw6kuDQoNCg==

