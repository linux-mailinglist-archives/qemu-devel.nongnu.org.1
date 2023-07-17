Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79E75638F
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNjI-0005pR-1T; Mon, 17 Jul 2023 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLNic-0005XT-Rz
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:52:51 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLNiZ-00018Q-N7
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:52:50 -0400
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "mark.cave-ayland@ilande.co.uk"
 <mark.cave-ayland@ilande.co.uk>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Topic: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Index: AQHZuFrFNlltFg4MfUmGmCXkRR+pm6+9DRuAgACaiID//4BWgIAAwmOA
Date: Mon, 17 Jul 2023 12:52:26 +0000
Message-ID: <F68DBAB0-B1CC-45FC-B1A7-8C62A5885031@baidu.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
In-Reply-To: <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <17D522A6E3815C41AD12AD39C0F9AF1F@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.17
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiA+ID4gPg0KPiA+ID4gU28gbW92ZSB0aGUgZ3Vlc3QgbW91c2UgcG9pbnRlciB0byAoMCwgMCkg
b2YgdGhlIHNjcmVlbiB3aGVuIGNvbm5lY3QgdGhlDQo+ID4gPiA+IFZOQywgYW5kIHRoZW4gbW92
ZSB0aGUgbW91c2UgcG9pbnRlciB0byB0aGUgY3Vyc29yIG9mIFZOQyhhYnNvbHV0ZQ0KPiA+ID4g
PiBjb29yZGluYXRlcyBhcmUgYWxzbyByZWxhdGl2ZSBjb29yZGluYXRlcykuDQo+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiBJdCdzIGhhcmRseSBhIHNvbHV0aW9uLCB5b3Ugc3RpbGwgaGF2ZSBubyBj
bHVlIHdoYXQgd2lsbCBiZSB0aGUgZ3Vlc3QNCj4gPiBtb3VzZQ0KPiA+ID4gcG9zaXRpb24uDQo+
ID4NCj4gPiBXZSBoYXZlIG5vIGNsdWUgd2hhdCB3aWxsIGJlIHRoZSBndWVzdCBtb3VzZSBwb3Np
dGlvbiwgd2UgY2FuIG1vdmUgdGhlDQo+ID4gZ3Vlc3QNCj4gPiBtb3VzZSB0byAoMCwwKSBlYWNo
IGNvbm5lY3QgdGhlIFZOQy4gTm93LCB0aGUgY3Vyc29yIG9mIFZOQyB3aWxsIGJlIHRoZQ0KPiA+
IHJlbGF0aXZlIGNvb3JkaW5hdGVzLiBJbiBhIHdheSwgdGhpcyBpcyBhIHF1aXJrIHRvIGtub3cg
dGhlIGd1ZXN0IG1vdXNlDQo+ID4gcG9zaXRpb24uDQo+ID4NCj4NCj4gVGhlcmUgaXMgbm8gZ3Vh
cmFudGVlIHRoZSBndWVzdCBwb2ludGVyIHdpbGwgYmUgYXQgKDAsMCkgdGhvdWdoLCBhbmQgdGhh
dA0KPiBkb2Vzbid0IGV4cGxhaW4gaG93IHRoYXQgd291bGQgaGVscC4gV2hpY2ggY2xpZW50IGFy
ZSB5b3UgdXNpbmc/IEFyZSB5b3UNCj4gZHJhd2luZyB0aGUgZ3Vlc3QgY3Vyc29yPyBUaGlzIGNh
bid0IGJlIGRvbmUgY3VycmVudGx5IHdpdGggdGhlIGxhY2sgb2YgYQ0KPiBtZXNzYWdlIHRvIHRl
bGwgdGhlIGd1ZXN0IG1vdXNlIHBvc2l0aW9uLiAobW92aW5nIC8gc3luYy1pbmcgdGhlIGNsaWVu
dA0KPiBjdXJzb3IgcG9zaXRpb24gd291bGQgYmUgZXZlbiB3b3JzZSBpbiBtYW55IHdheXMpDQoN
ClNvcnJ5LCBteSBkZXNjcmlwdGlvbiBpc24ndCBhY2N1cmF0ZS4NCg0KV2hlbiBjb25uZWN0IHRo
ZSB2bmMgc2VydmVyLA0KICAgIHZuY19jb25uZWN0DQogICAgICAtPiB2cy0+bGFzdF94ID0gLTE7
DQogICAgICAtPiB2cy0+bGFzdF95ID0gLTE7DQoNCm1vdmUgY2xpZW50IGN1cnNvciB0byB2bmMg
c2NyZWVuLA0KICAgIHZuY19jbGllbnRfaW8NCiAgICAgIC0+dm5jX2NsaWVudF9yZWFkDQogICAg
ICAgIC0+cHJvdG9jb2xfY2xpZW50X21zZw0KICAgICAgICAgIC0+cG9pbnRlcl9ldmVudCh4LHkp
DQogICAgICAgICAgICAtPiBxZW11X2lucHV0X3F1ZXVlX3JlbChjb24sIElOUFVUX0FYSVNfWCwg
MCAtIHdpZHRoKTsNCiAgICAgICAgICAgIC0+IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5Q
VVRfQVhJU19ZLCAwIC0gaGVpZ2h0KTsNCiAgICAgICAgICAgIC0+IHg9MCx5PTANCiAgICAgICAg
ICAgIC0+IHZzLT5sYXN0X3ggPSB4O3ZzLT5sYXN0X3kgPSB5Ow0KICAgICAgICAgICAgLT4gcWVt
dV9pbnB1dF9ldmVudF9zeW5jICAgLy8gdGhpcyB3aWxsIGluZm9ybSB0aGUgZ3Vlc3QgbW92ZSB0
byAoMCwgMCkNCg0KdGhlIG5leHQgZXZlbnQsDQogICAgICAgICAgLT5wb2ludGVyX2V2ZW50KHgs
eSkNCiAgICAgICAgICAgIC0+IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19Y
LCB4IC0gdnMtPmxhc3RfeCk7DQogICAgICAgICAgICAtPiBxZW11X2lucHV0X3F1ZXVlX3JlbChj
b24sIElOUFVUX0FYSVNfWCwgeCAtIHZzLT5sYXN0X3gpOw0KICAgICAgICAgICAgLT4gcWVtdV9p
bnB1dF9ldmVudF9zeW5jICAgIC8vIHRoaXMgd2lsbCBpbmZvcm0gdGhlIGd1ZXN0IGZyb20gKDAs
MCkgbW92ZSB0byAoeCx5KSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gdGhlIGNsaWVudCBjdXJzb3IgYW5kIGd1ZXN0
IG1vdXNlIHdpbGwgc3luYy4NCg0KYW5kIGlmIHRoZSByZXNvbHV0aW9uIGlzIGhpZ2gsIGFsc2Ug
bmVlZCBpbmNyZWFjZSB0aGUgcXVldWUgc2l6ZSBvZiBwczIgUFMyX1FVRVVFX1NJWkUuDQpPdGhl
cndpc2UsIGlmIHRoZSBndWVzdCBtb3VzZSBmYXIgZnJvbSB0aGUgKDAsMCkgYmVmb3JlIHZuYyBj
b25uZWN0LCBpdCBjYW4ndCBtb3ZlIHRvICgwLDApLg0KDQo+DQo+ID4gPg0KPiA+ID4NCj4gPiA+
ID4gT24gd2luZG93cyBWTSwgYWxzbyBuZWVkIGRpc2FibGUgIkVuaGFuY2UgUG9pbnRlciBQcmVj
aXNpb24iIE9wdGlvbiBpbg0KPiA+ID4gPiAiUG9pbnRlciBPcHRpb25zIiAoQ29udHJvbCBQYW5l
bCAtPiBNb3VzZSkuDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiBBcHBhcmVudGx5LCB0aGlzIG9w
dGlvbiBkb2Vzbid0IGhhdmUgbXVjaCB0byBkbyB3aXRoIHJlbGF0aXZlIG1vdXNlDQo+ID4gbW90
aW9uLg0KPiA+ID4gQ2FuIHlvdSBleHBsYWluIHdoYXQgaXQgZG9lcyB3aXRoIHRoaXMgY2hhbmdl
Pw0KPiA+DQo+ID4gRW1tbSwgSSBkb24ndCBrbm93IHdoeSB0aGlzIGNhbiBzb2x2ZSB0aGUgcHJv
YmxlbS4gSXQncyBxdWl0ZSBlZmZlY3RpdmUgYW5kDQo+ID4gZ2V0IHRoaXMgd2F5IGZyb20NCj4g
Pg0KPiA+IGh0dHBzOi8vZm9ydW0ucHJveG1veC5jb20vdGhyZWFkcy9pcy1pdC1wb3NzaWJsZS1u
b3QtdG8tdXNlLXVzYmRldmljZS10YWJsZXQuMTQ5OC8NCj4gPiAuDQo+ID4NCj4gPiBPbmx5IHVz
ZSB0aGlzIHdheSwgd2UgbmVlZCB0byBtYW51YWxseSBhbGlnbiB0aGUgVk5DIGN1cnNvciB3aXRo
IHRoZSBndWVzdA0KPiA+IG1vdXNlLg0KPiA+DQo+DQo+IEl0J3MgYSBiaXQgdmFndWUgd2hhdCB0
aGUgIlZOQyBjdXJzb3IiIG1lYW4uIElmIHlvdSBtZWFuIHRoZSBjbGllbnQgY3Vyc29yDQo+IHBv
c2l0aW9uLCB0aGVyZSBpcyBubyB3YXkgdG8gYWxpZ24gLyBzeW5jIHdpdGggdGhlIGd1ZXN0IHdp
dGhvdXQgYW4gZXh0cmENCj4gbWVzc2FnZSB0byBpbmZvcm0gdGhlIGNsaWVudCBvZiBpdHMgcG9z
aXRpb24uIFRoZXJlIGlzIGV2ZW4gYSBjb21tZW50IGFib3V0DQo+IHRoYXQgaW4gdm5jLmMgIC8q
IGNhbiB3ZSBhc2sgdGhlIGNsaWVudChzKSB0byBtb3ZlIHRoZSBwb2ludGVyID8/PyAqLykNCg0K
U29ycnksIEkgbWVhbiB0aGUgY2xpZW50IGN1cnNvciBwb3NpdGlvbi4gSSBmb3VuZCBkaXNhYmxl
ICJFbmhhbmNlIFBvaW50ZXIgUHJlY2lzaW9uIg0KT3B0aW9uLCBtb3ZlIGN1cnNvciB0byB0aGUg
Ym91bmQgb2YgdGhlIFZOQyBzY3JlZW4sIHRoZXkgbWF5YmUgYWxpZ24uDQoNCj4NCj4NCj4gPiA+
DQo+ID4gPiBXaGljaCBndWVzdCBPUyBhcmUgeW91IHVzaW5nPyBIb3BlZnVsbHkgdGhleSBhbGwg
c3VwcG9ydCBlaXRoZXINCj4gPiB1c2ItdGFibGV0DQo+ID4gPiBvciB2bW1vdXNlIGV4dGVuc2lv
biBmb3IgYWJzb2x1dGUgcG9zaXRpb25pbmcuIE90aGVyd2lzZSwgSSdkIHN1Z2dlc3QNCj4gPiB1
c2luZw0KPiA+ID4gU3BpY2UsIHdoaWNoIGhhcyB0aG9zZSBtZXNzYWdlcyBmb3IgY2xpZW50IHNp
ZGUgZ3Vlc3QtbW91c2UgZHJhd2luZy4NCj4gPiA+DQo+ID4NCj4gPiBZZWFoLCBJIGtub3cgdGhl
IGJlc3Qgd2F5IGlzIHVzZSBhIGFic29sdXRlIHBvc2l0aW9uaW5nLiBXZSBuZWVkIHJlbW92ZQ0K
PiA+IGFsbCB1c2IgZGV2aWNlcywNCj4gPiBJIGNhbiBvbmx5IHVzZSB0aGUgUFMvMiBtb3VzZS4N
Cj4gPg0KPg0KPiBDYW4ndCB5b3UgdXNlIHZtbW91c2UgZXh0ZW5zaW9uPw0KDQpUaGFua3MsIEkg
d2lsbCB0cnkgaXQuIEkgY2Fubid0IGZvdW5kIHRoZSBvZmZpY2lhbCBkcml2ZXIgb2Ygdm1tb3Vz
ZSwgY2FuIEkNCmluc3RhbGwgaXQgZm9yIGZyZWU/DQoNCg==

