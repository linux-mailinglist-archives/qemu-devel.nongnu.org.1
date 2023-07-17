Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFD75638E
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNiD-0004UH-0x; Mon, 17 Jul 2023 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLNgt-0002Yc-R6
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:51:25 -0400
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLNgj-0000tc-Aa
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:50:55 -0400
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "mark.cave-ayland@ilande.co.uk"
 <mark.cave-ayland@ilande.co.uk>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Topic: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Index: AQHZuFrFNlltFg4MfUmGmCXkRR+pm6+9NTOAgAC0aoA=
Date: Mon, 17 Jul 2023 12:49:46 +0000
Message-ID: <7B9782E4-0C02-4862-B5B8-06735ABD4D2D@baidu.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <ZLUSEb4w0ZtzwB1H@redhat.com>
In-Reply-To: <ZLUSEb4w0ZtzwB1H@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDF718F7A05BFB4D8B86225E3732A61E@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.20
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.202.115.85; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
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

PiBPbiBNb24sIEp1bCAxNywgMjAyMyBhdCAxMDo1OTozNkFNICswODAwLCBTaGl5dWFuIEdhbyB3
cm90ZToNCj4gPiBXaGVuIG9ubHkgdXNlIFBTLzIgbW91c2Ugd2l0aG91dCB1c2ItdGFibGV0LCB0
aGUgbW91c2UgcG9pbnRlciBvZiB0aGUNCj4gPiBndWVzdCBvbiB0aGUgVk5DIHdpbGwgd29yayBi
YWRseSB0aGF0IHRoZSBjdXJzb3Igb2YgVk5DIGlzIGluY29uc2lzdGVudA0KPiA+IHdpdGggdGhl
IG1vdXNlIHBvaW50ZXIgb2YgZ3Vlc3QuDQo+ID4NCj4gPiBUaGUgcmVhc29uIGlzIHRoZSBQUy8y
IG1vdXNlIHVzZSByZWxhdGl2ZSBjb29yZGluYXRlcyBhbmQgd2UgY2FuJ3Qga25vdw0KPiA+IHRo
ZSBpbml0aWFsIHBvc2l0aW9uIG9mIHRoZSBndWVzdCBtb3VzZSBwb2ludGVyLg0KPiA+DQo+ID4g
U28gbW92ZSB0aGUgZ3Vlc3QgbW91c2UgcG9pbnRlciB0byAoMCwgMCkgb2YgdGhlIHNjcmVlbiB3
aGVuIGNvbm5lY3QgdGhlDQo+ID4gVk5DLCBhbmQgdGhlbiBtb3ZlIHRoZSBtb3VzZSBwb2ludGVy
IHRvIHRoZSBjdXJzb3Igb2YgVk5DKGFic29sdXRlDQo+ID4gY29vcmRpbmF0ZXMgYXJlIGFsc28g
cmVsYXRpdmUgY29vcmRpbmF0ZXMpLg0KPg0KPiBUaGlzIGlzIG5vdCBhIHNvbHV0aW9uLCBiZWNh
dXNlIGV2ZW4gaWYgeW91IGtub3cgdGhlIHN0YXJ0aW5nIHBvc2l0aW9uDQo+IG9mIHRoZSBwb2lu
dGVyLCB0aGUgaG9zdC9ndWVzdCBwb2ludGVycyBjYW4gaGF2ZSBkaWZmZXJlbnQgbW90aW9uDQo+
IGFjY2VsZXJhdGlvbiBiZWhhdmlvdXIsIHNvIHRoZXknbGwgbG9vc2Ugc3luYyB3aXRoIGVhY2gg
b3RoZXIuIFlvdSdsbA0KPiBoYXZlIHByb2JsZW1zIHN1Y2ggYXMgdGhlIGhvc3QgcG9pbnRlciBl
eGl0aW5nIHRoZSBWTkMgd2luZG93IGJlZm9yZQ0KPiB0aGUgZ3Vlc3QgcG9pbnRlciBoYXMgZ290
IHRvIHRoZSBmYXIgZWRnZS4NCg0KTWF5YmUgdGhleSB3aWxsIGxvb3NlIHN5bmMgd2l0aCBlYWNo
IG90aGVyIGFnYWluLiBPbiB3aW5kb3dzIFZNIHN1Y2ggYXMgd2luMTAsDQpkaXNhYmxlICJFbmhh
bmNlIFBvaW50ZXIgUHJlY2lzaW9uIiBPcHRpb24gaW4gIlBvaW50ZXIgT3B0aW9ucyINCihDb250
cm9sIFBhbmVsIC0+IE1vdXNlKSwgSSBjYW4ndCBmb3VuZCB0aGlzIHByb2JsZW0uDQoNCj4NCj4g
VHJ5aW5nIHRvIG1ha2UgYSByZWxhdGl2ZSBwb2ludGVyIHdvcmsgY29ycmVjdGx5IGluIGNvbWJp
bmF0aW9uIHdpdGgNCj4gYWJzb2x1dGUgaW5wdXQgZXZlbnRzIGZyb20gVk5DIGlzIG5ldmVyIGdv
aW5nIHRvIHdvcmsuDQo+DQo+DQo+IFRoaXMgaXMgd2h5IFFFTVUgY3JlYXRlZCBhIFZOQyBleHRl
bnNpb24gdG8gYWxsb3dzIHN3aXRjaGluZyB0aGUgVk5DDQo+IHByb3RvY29sIGZyb20gYWJzb2x1
dGUgdG8gcmVsYXRpdmUgcG9pbnRlciBtb3Rpb24gZXZlbnRzLg0KPg0KPg0KPiBJZiB5b3UgbmVl
ZCB0byBydW4gYSBWTSB3aXRoIG9ubHkgdGhlIFBTLzIgcG9pbnRlciwgdGhlbiB5b3UgbmVlZA0K
PiB0byBiZSB1c2luZyBhIGNsaWVudCB0aGF0IHN1cHBvcnRzIHRoaXMgZXh0ZW5zaW9uOg0KPg0K
Pg0KPiBodHRwczovL2dpdGh1Yi5jb20vcmZicHJvdG8vcmZicHJvdG8vYmxvYi9tYXN0ZXIvcmZi
cHJvdG8ucnN0I3FlbXUtcG9pbnRlci1tb3Rpb24tY2hhbmdlLXBzZXVkby1lbmNvZGluZyA8aHR0
cHM6Ly9naXRodWIuY29tL3JmYnByb3RvL3JmYnByb3RvL2Jsb2IvbWFzdGVyL3JmYnByb3RvLnJz
dCNxZW11LXBvaW50ZXItbW90aW9uLWNoYW5nZS1wc2V1ZG8tZW5jb2Rpbmc+DQo+DQoNClRoYW5r
cyBhIGxvdCwgSSB3aWxsIHJlYWQgaXQgZm9yIG1vcmUgaW5mby4NCg0K

