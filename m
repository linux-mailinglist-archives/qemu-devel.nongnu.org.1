Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32479756552
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOVc-0003ko-R8; Mon, 17 Jul 2023 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLOVY-0003kG-Ui
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:43:24 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLOVU-0000VN-6q
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:43:24 -0400
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "mark.cave-ayland@ilande.co.uk"
 <mark.cave-ayland@ilande.co.uk>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Topic: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Index: AQHZuFrFNlltFg4MfUmGmCXkRR+pm6+9DRuAgACaiID//4BWgIAAwmOA//9/ewCAAI5AAA==
Date: Mon, 17 Jul 2023 13:41:34 +0000
Message-ID: <3AC28C88-5682-4EBD-8996-5125FAF5F2A4@baidu.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
 <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
 <CAMxuvawBOLcS8SQzPiVgMuyMXFadrqrMzcuA1ddB-uaDd1qZgA@mail.gmail.com>
In-Reply-To: <CAMxuvawBOLcS8SQzPiVgMuyMXFadrqrMzcuA1ddB-uaDd1qZgA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC07B9B9E1D8DA4EB4B0826EB021D1E5@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.20
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

PiBIaQ0KPg0KPiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCA0OjUz4oCvUE0gR2FvLFNoaXl1YW4g
PGdhb3NoaXl1YW5AYmFpZHUuY29tPiB3cm90ZToNCj4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
U28gbW92ZSB0aGUgZ3Vlc3QgbW91c2UgcG9pbnRlciB0byAoMCwgMCkgb2YgdGhlIHNjcmVlbiB3
aGVuIGNvbm5lY3QNCj4gPiB0aGUNCj4gPiA+ID4gPiA+IFZOQywgYW5kIHRoZW4gbW92ZSB0aGUg
bW91c2UgcG9pbnRlciB0byB0aGUgY3Vyc29yIG9mIFZOQyhhYnNvbHV0ZQ0KPiA+ID4gPiA+ID4g
Y29vcmRpbmF0ZXMgYXJlIGFsc28gcmVsYXRpdmUgY29vcmRpbmF0ZXMpLg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQncyBoYXJkbHkgYSBzb2x1dGlvbiwgeW91IHN0aWxs
IGhhdmUgbm8gY2x1ZSB3aGF0IHdpbGwgYmUgdGhlIGd1ZXN0DQo+ID4gPiA+IG1vdXNlDQo+ID4g
PiA+ID4gcG9zaXRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFdlIGhhdmUgbm8gY2x1ZSB3aGF0IHdp
bGwgYmUgdGhlIGd1ZXN0IG1vdXNlIHBvc2l0aW9uLCB3ZSBjYW4gbW92ZSB0aGUNCj4gPiA+ID4g
Z3Vlc3QNCj4gPiA+ID4gbW91c2UgdG8gKDAsMCkgZWFjaCBjb25uZWN0IHRoZSBWTkMuIE5vdywg
dGhlIGN1cnNvciBvZiBWTkMgd2lsbCBiZSB0aGUNCj4gPiA+ID4gcmVsYXRpdmUgY29vcmRpbmF0
ZXMuIEluIGEgd2F5LCB0aGlzIGlzIGEgcXVpcmsgdG8ga25vdyB0aGUgZ3Vlc3QgbW91c2UNCj4g
PiA+ID4gcG9zaXRpb24uDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhlcmUgaXMgbm8gZ3VhcmFu
dGVlIHRoZSBndWVzdCBwb2ludGVyIHdpbGwgYmUgYXQgKDAsMCkgdGhvdWdoLCBhbmQgdGhhdA0K
PiA+ID4gZG9lc24ndCBleHBsYWluIGhvdyB0aGF0IHdvdWxkIGhlbHAuIFdoaWNoIGNsaWVudCBh
cmUgeW91IHVzaW5nPyBBcmUgeW91DQo+ID4gPiBkcmF3aW5nIHRoZSBndWVzdCBjdXJzb3I/IFRo
aXMgY2FuJ3QgYmUgZG9uZSBjdXJyZW50bHkgd2l0aCB0aGUgbGFjayBvZiBhDQo+ID4gPiBtZXNz
YWdlIHRvIHRlbGwgdGhlIGd1ZXN0IG1vdXNlIHBvc2l0aW9uLiAobW92aW5nIC8gc3luYy1pbmcg
dGhlIGNsaWVudA0KPiA+ID4gY3Vyc29yIHBvc2l0aW9uIHdvdWxkIGJlIGV2ZW4gd29yc2UgaW4g
bWFueSB3YXlzKQ0KPiA+DQo+ID4gU29ycnksIG15IGRlc2NyaXB0aW9uIGlzbid0IGFjY3VyYXRl
Lg0KPiA+DQo+ID4gV2hlbiBjb25uZWN0IHRoZSB2bmMgc2VydmVyLA0KPiA+ICAgICB2bmNfY29u
bmVjdA0KPiA+ICAgICAgIC0+IHZzLT5sYXN0X3ggPSAtMTsNCj4gPiAgICAgICAtPiB2cy0+bGFz
dF95ID0gLTE7DQo+ID4NCj4gPiBtb3ZlIGNsaWVudCBjdXJzb3IgdG8gdm5jIHNjcmVlbiwNCj4g
PiAgICAgdm5jX2NsaWVudF9pbw0KPiA+ICAgICAgIC0+dm5jX2NsaWVudF9yZWFkDQo+ID4gICAg
ICAgICAtPnByb3RvY29sX2NsaWVudF9tc2cNCj4gPiAgICAgICAgICAgLT5wb2ludGVyX2V2ZW50
KHgseSkNCj4gPiAgICAgICAgICAgICAtPiBxZW11X2lucHV0X3F1ZXVlX3JlbChjb24sIElOUFVU
X0FYSVNfWCwgMCAtIHdpZHRoKTsNCj4gPiAgICAgICAgICAgICAtPiBxZW11X2lucHV0X3F1ZXVl
X3JlbChjb24sIElOUFVUX0FYSVNfWSwgMCAtIGhlaWdodCk7DQo+ID4gICAgICAgICAgICAgLT4g
eD0wLHk9MA0KPiA+ICAgICAgICAgICAgIC0+IHZzLT5sYXN0X3ggPSB4O3ZzLT5sYXN0X3kgPSB5
Ow0KPiA+ICAgICAgICAgICAgIC0+IHFlbXVfaW5wdXRfZXZlbnRfc3luYyAgIC8vIHRoaXMgd2ls
bCBpbmZvcm0gdGhlIGd1ZXN0IG1vdmUNCj4gPiB0byAoMCwgMCkNCj4gPg0KPiA+IHRoZSBuZXh0
IGV2ZW50LA0KPiA+ICAgICAgICAgICAtPnBvaW50ZXJfZXZlbnQoeCx5KQ0KPiA+ICAgICAgICAg
ICAgIC0+IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19YLCB4IC0gdnMtPmxh
c3RfeCk7DQo+ID4gICAgICAgICAgICAgLT4gcWVtdV9pbnB1dF9xdWV1ZV9yZWwoY29uLCBJTlBV
VF9BWElTX1gsIHggLSB2cy0+bGFzdF94KTsNCj4gPiAgICAgICAgICAgICAtPiBxZW11X2lucHV0
X2V2ZW50X3N5bmMgICAgLy8gdGhpcyB3aWxsIGluZm9ybSB0aGUgZ3Vlc3QgZnJvbQ0KPiA+ICgw
LDApIG1vdmUgdG8gKHgseSksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyB0aGUNCj4gPiBjbGllbnQgY3Vyc29y
IGFuZCBndWVzdCBtb3VzZSB3aWxsIHN5bmMuDQo+ID4NCj4NCj4gQWN0dWFsbHksIGl0IHdpbGwg
YmUgKCB4IC0gdnMtPmxhc3RfeCwgeSAtIHZzLT5sYXN0X3kpLCBub3QgbmVjZXNzYXJpbHkgKHgs
DQo+IHkpLCB1bmxlc3MgeW91IGFsc28gc2V0IGxhc3RfeCA9IDAgLyBsYXN0X3kgPSAwLg0KDQp5
ZXMsIHNldCBsYXN0X3ggPSAwIC8gbGFzdF95ID0gMCBhbmQgb25seSB0aGUgZmlyc3QgdGltZSBl
bnRlciBwb2ludGVyX2V2ZW50Lg0KDQogICAgICAgICBpZiAodnMtPmxhc3RfeCAhPSAtMSkgew0K
ICAgICAgICAgICAgIHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19YLCB4IC0g
dnMtPmxhc3RfeCk7DQogICAgICAgICAgICAgcWVtdV9pbnB1dF9xdWV1ZV9yZWwoY29uLCBJTlBV
VF9BWElTX1ksIHkgLSB2cy0+bGFzdF95KTsNCisgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAg
ICAgcWVtdV9pbnB1dF9xdWV1ZV9yZWwoY29uLCBJTlBVVF9BWElTX1gsIDAgLSB3aWR0aCk7DQor
ICAgICAgICAgICAgcWVtdV9pbnB1dF9xdWV1ZV9yZWwoY29uLCBJTlBVVF9BWElTX1ksIDAgLSBo
ZWlnaHQpOw0KKyAgICAgICAgICAgIHggPSAwOw0KKyAgICAgICAgICAgIHkgPSAwOw0KICAgICAg
ICAgfQ0KICAgICAgICAgdnMtPmxhc3RfeCA9IHg7DQogICAgICAgICB2cy0+bGFzdF95ID0geTsN
Cg0KPg0KPiBCdXQgZXZlbiB0aGVuLCB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhlIGd1ZXN0IHBv
c2l0aW9uIHdpbGwgYmUgYSB4L3kuLi4NCj4NCg0KRW1tbSwgY29tcGFyZWQgdG8gdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24sIGl0IGlzIGF0IGxlYXN0IGdldHRpbmcgY2xvc2VyLg0KVGhlIGN1
cnJlbnQgc3RhdGUgaXMgc2ltcGx5IHVuYmVhcmFibGUuDQoNCj4gSXQncyBiZWVuIGltcGxlbWVu
dGVkIG9uIExpbnV4IFZNIGZvciBhIGxvbmcgd2hpbGUgKGZpcnN0IGluIHVzZXJzcGFjZSwNCj4g
dGhlbiBpbiBrZXJuZWwgc2luY2UgfjIwMTUpLiBCdXQgSSBkb24ndCBrbm93IGFib3V0IHRoZSBX
aW5kb3dzIHN1cHBvcnQsIGl0DQo+IGxvb2tzIGxpa2UgeW91IG5lZWQgYSBkcml2ZXIgc3VjaCBh
cyBwcm92aWRlZCBieSBWTVdhdmUsIGJ1dCBpdCBzZWVtcw0KPiBjbG9zZWQtc291cmNlLi4uICBB
dCB0aGlzIHBvaW50IGl0J3MgcHJvYmFibHkgYmV0dGVyIHRvIHVzZSB2aXJ0aW8taW5wdXQsDQo+
IHdoaWNoIGhhcyBvcGVuLXNvdXJjZS9mcmVlIHdpbmRvd3MgZHJpdmVycy4NCg0KVGhhbmtzLCBJ
IHRyaWVkIGluc3RhbGwgdm1tb3VzZSBkcml2ZXIgaW4gd2luZG93cyBzdWNjZXNzIGFuZCByZWJv
b3QuIEhvd2V2ZXIgJ2luZm8gbWljZScgYXMNCmZvbGxvd3MgYW5kIGRvbid0IGhhdmUgdm1tb3Vz
ZSAoYWJzb2x1dGUpLg0KDQoqIE1vdXNlICMyOiBRRU1VIFBTLzIgTW91c2UNCg0KVGhlIGd1ZXN0
IG1vdXNlIGlzbid0IHN5bmMgd2l0aCBjbGllbnQgY3Vyc29yLi4uDQoNCg==

