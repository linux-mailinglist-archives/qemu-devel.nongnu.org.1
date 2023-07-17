Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 467DB755ECE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJzk-0005F5-G5; Mon, 17 Jul 2023 04:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLJzh-0005Ew-LN
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:54:13 -0400
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1qLJze-0004GJ-4v
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 04:54:13 -0400
From: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mark.cave-ayland@ilande.co.uk"
 <mark.cave-ayland@ilande.co.uk>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Topic: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Thread-Index: AQHZuFrFNlltFg4MfUmGmCXkRR+pm6+9DRuAgACaiIA=
Date: Mon, 17 Jul 2023 08:53:38 +0000
Message-ID: <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
In-Reply-To: <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <65AA497E39E88D48B9129EB9D78EBBF6@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.19
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

SGksDQo+IEhpIFNoaXl1YW4NCj4NCj4gT24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgNzoxNuKAr0FN
IFNoaXl1YW4gR2FvIDxnYW9zaGl5dWFuQGJhaWR1LmNvbT4gd3JvdGU6DQo+DQo+ID4gV2hlbiBv
bmx5IHVzZSBQUy8yIG1vdXNlIHdpdGhvdXQgdXNiLXRhYmxldCwgdGhlIG1vdXNlIHBvaW50ZXIg
b2YgdGhlDQo+ID4gZ3Vlc3Qgb24gdGhlIFZOQyB3aWxsIHdvcmsgYmFkbHkgdGhhdCB0aGUgY3Vy
c29yIG9mIFZOQyBpcyBpbmNvbnNpc3RlbnQNCj4gPiB3aXRoIHRoZSBtb3VzZSBwb2ludGVyIG9m
IGd1ZXN0Lg0KPiA+DQo+ID4NCj4gQWZhaWssIFZOQyBkb2Vzbid0IHN1cHBvcnQgY2xpZW50LXNp
ZGUgZHJhd2luZyBvZiBndWVzdCBtb3VzZSAodGhlcmUgYXJlIG5vDQo+IG1lc3NhZ2UgdG8gc2V0
IGd1ZXN0IG1vdXNlIHBvc2l0aW9uKS4gU28gdGhlIGd1ZXN0IG1vdXNlIHNob3VsZCBiZSBkcmF3
biBieQ0KPiB0aGUgc2VydmVyLCBhbmQgY3VycmVudGx5IFFFTVUgZG9lc24ndCBkbyBpdC4NCj4N
Cj4NCj4gPiBUaGUgcmVhc29uIGlzIHRoZSBQUy8yIG1vdXNlIHVzZSByZWxhdGl2ZSBjb29yZGlu
YXRlcyBhbmQgd2UgY2FuJ3Qga25vdw0KPiA+IHRoZSBpbml0aWFsIHBvc2l0aW9uIG9mIHRoZSBn
dWVzdCBtb3VzZSBwb2ludGVyLg0KPiA+DQo+DQo+IEl0J3Mgbm90IGp1c3QgYWJvdXQgdGhlIGlu
aXRpYWwgcG9zaXRpb24uDQoNCk5vdyBwb2ludGVyX2V2ZW50IHVzZSB0aGUgY3Vyc29yIG9mIFZO
QyBpbml0IHRoZSB2cy0+bGFzdF94LCB2cy0+bGFzdF95IHdoZW4NCmNvbm5lY3QgdGhlIFZOQyBh
bmQgdGhlIHJlbGF0aXZlIGNvb3JkaW5hdGVzIGlzIGJhc2VkIG9uIFZOQyBjdXJzb3IuIElmIHRo
ZQ0KaW5pdGlhbCBwb3NpdGlvbiBvZiBWTkMgY3Vyc29yIGlzIGluY29uc2lzdGVudCB3aXRoIGd1
ZXN0IG1vdXNlLCB0aGUNCmluY29uc2lzdGVuY3kgd2lsbCBrZWVwLiBJIHRoaW5rIHRoZSByb290
IGNhdXNlIGlzIHdlIGNhbm4ndCBrbm93IHRoZSBwb3N0aW9uDQpvZiB0aGUgZ3Vlc3QgbW91c2Ug
cG9pbnRlci4NCg0KPg0KPiA+DQo+ID4NCj4gU28gbW92ZSB0aGUgZ3Vlc3QgbW91c2UgcG9pbnRl
ciB0byAoMCwgMCkgb2YgdGhlIHNjcmVlbiB3aGVuIGNvbm5lY3QgdGhlDQo+ID4gVk5DLCBhbmQg
dGhlbiBtb3ZlIHRoZSBtb3VzZSBwb2ludGVyIHRvIHRoZSBjdXJzb3Igb2YgVk5DKGFic29sdXRl
DQo+ID4gY29vcmRpbmF0ZXMgYXJlIGFsc28gcmVsYXRpdmUgY29vcmRpbmF0ZXMpLg0KPiA+DQo+
ID4NCj4gSXQncyBoYXJkbHkgYSBzb2x1dGlvbiwgeW91IHN0aWxsIGhhdmUgbm8gY2x1ZSB3aGF0
IHdpbGwgYmUgdGhlIGd1ZXN0IG1vdXNlDQo+IHBvc2l0aW9uLg0KDQpXZSBoYXZlIG5vIGNsdWUg
d2hhdCB3aWxsIGJlIHRoZSBndWVzdCBtb3VzZSBwb3NpdGlvbiwgd2UgY2FuIG1vdmUgdGhlIGd1
ZXN0DQptb3VzZSB0byAoMCwwKSBlYWNoIGNvbm5lY3QgdGhlIFZOQy4gTm93LCB0aGUgY3Vyc29y
IG9mIFZOQyB3aWxsIGJlIHRoZQ0KcmVsYXRpdmUgY29vcmRpbmF0ZXMuIEluIGEgd2F5LCB0aGlz
IGlzIGEgcXVpcmsgdG8ga25vdyB0aGUgZ3Vlc3QgbW91c2UgcG9zaXRpb24uDQoNCj4NCj4NCj4g
PiBPbiB3aW5kb3dzIFZNLCBhbHNvIG5lZWQgZGlzYWJsZSAiRW5oYW5jZSBQb2ludGVyIFByZWNp
c2lvbiIgT3B0aW9uIGluDQo+ID4gIlBvaW50ZXIgT3B0aW9ucyIgKENvbnRyb2wgUGFuZWwgLT4g
TW91c2UpLg0KPiA+DQo+ID4NCj4gQXBwYXJlbnRseSwgdGhpcyBvcHRpb24gZG9lc24ndCBoYXZl
IG11Y2ggdG8gZG8gd2l0aCByZWxhdGl2ZSBtb3VzZSBtb3Rpb24uDQo+IENhbiB5b3UgZXhwbGFp
biB3aGF0IGl0IGRvZXMgd2l0aCB0aGlzIGNoYW5nZT8NCg0KRW1tbSwgSSBkb24ndCBrbm93IHdo
eSB0aGlzIGNhbiBzb2x2ZSB0aGUgcHJvYmxlbS4gSXQncyBxdWl0ZSBlZmZlY3RpdmUgYW5kDQpn
ZXQgdGhpcyB3YXkgZnJvbQ0KaHR0cHM6Ly9mb3J1bS5wcm94bW94LmNvbS90aHJlYWRzL2lzLWl0
LXBvc3NpYmxlLW5vdC10by11c2UtdXNiZGV2aWNlLXRhYmxldC4xNDk4Ly4NCg0KT25seSB1c2Ug
dGhpcyB3YXksIHdlIG5lZWQgdG8gbWFudWFsbHkgYWxpZ24gdGhlIFZOQyBjdXJzb3Igd2l0aCB0
aGUgZ3Vlc3QgbW91c2UuDQoNCj4NCj4gV2hpY2ggZ3Vlc3QgT1MgYXJlIHlvdSB1c2luZz8gSG9w
ZWZ1bGx5IHRoZXkgYWxsIHN1cHBvcnQgZWl0aGVyIHVzYi10YWJsZXQNCj4gb3Igdm1tb3VzZSBl
eHRlbnNpb24gZm9yIGFic29sdXRlIHBvc2l0aW9uaW5nLiBPdGhlcndpc2UsIEknZCBzdWdnZXN0
IHVzaW5nDQo+IFNwaWNlLCB3aGljaCBoYXMgdGhvc2UgbWVzc2FnZXMgZm9yIGNsaWVudCBzaWRl
IGd1ZXN0LW1vdXNlIGRyYXdpbmcuDQo+DQoNClllYWgsIEkga25vdyB0aGUgYmVzdCB3YXkgaXMg
dXNlIGEgYWJzb2x1dGUgcG9zaXRpb25pbmcuIFdlIG5lZWQgcmVtb3ZlIGFsbCB1c2IgZGV2aWNl
cywNCkkgY2FuIG9ubHkgdXNlIHRoZSBQUy8yIG1vdXNlLg0KDQpBbnl3YXksIHdoZW4gY29ubmVj
dGluZyB0byBWTkMsIG1vdmUgdGhlIG1vdXNlIHRvIHRoZSB1cHBlciBsZWZ0IGNvcm5lciwgYXQg
bGVhc3Qgbm90DQp0byBtYWtlIHRoaW5ncyB3b3JzZS4NCg0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNoaXl1YW4gR2FvIDxnYW9zaGl5dWFuQGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaW5w
dXQvcHMyLmMgfCAyICstDQo+ID4gIHVpL3ZuYy5jICAgICAgIHwgNSArKysrKw0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2h3L2lucHV0L3BzMi5jIGIvaHcvaW5wdXQvcHMyLmMNCj4gPiBpbmRleCA0NWFm
NzZhODM3Li5lMWY0NGJkMjk4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2lucHV0L3BzMi5jDQo+ID4g
KysrIGIvaHcvaW5wdXQvcHMyLmMNCj4gPiBAQCAtNzcsNyArNzcsNyBAQA0KPiA+ICAjZGVmaW5l
IE1PVVNFX1NUQVRVU19FTkFCTEVEICAgIDB4MjANCj4gPiAgI2RlZmluZSBNT1VTRV9TVEFUVVNf
U0NBTEUyMSAgICAweDEwDQo+ID4NCj4gPiAtI2RlZmluZSBQUzJfUVVFVUVfU0laRSAgICAgIDE2
ICAvKiBRdWV1ZSBzaXplIHJlcXVpcmVkIGJ5IFBTLzIgcHJvdG9jb2wgKi8NCj4gPiArI2RlZmlu
ZSBQUzJfUVVFVUVfU0laRSAgICAgIDMyICAvKiBRdWV1ZSBzaXplIHJlcXVpcmVkIGJ5IFBTLzIg
cHJvdG9jb2wgKi8NCj4gPiAgI2RlZmluZSBQUzJfUVVFVUVfSEVBRFJPT00gIDggICAvKiBRdWV1
ZSBzaXplIGZvciBrZXlib2FyZCBjb21tYW5kDQo+ID4gcmVwbGllcyAqLw0KPiA+DQo+ID4gIC8q
IEJpdHMgZm9yICdtb2RpZmllcnMnIGZpZWxkIGluIFBTMktiZFN0YXRlICovDQo+ID4gZGlmZiAt
LWdpdCBhL3VpL3ZuYy5jIGIvdWkvdm5jLmMNCj4gPiBpbmRleCA5Mjk2NGRjYzBjLi5hMWE2MDQ4
ZWU0IDEwMDY0NA0KPiA+IC0tLSBhL3VpL3ZuYy5jDQo+ID4gKysrIGIvdWkvdm5jLmMNCj4gPiBA
QCAtMTgxNiw2ICsxODE2LDExIEBAIHN0YXRpYyB2b2lkIHBvaW50ZXJfZXZlbnQoVm5jU3RhdGUg
KnZzLCBpbnQNCj4gPiBidXR0b25fbWFzaywgaW50IHgsIGludCB5KQ0KPiA+ICAgICAgICAgIGlm
ICh2cy0+bGFzdF94ICE9IC0xKSB7DQo+ID4gICAgICAgICAgICAgIHFlbXVfaW5wdXRfcXVldWVf
cmVsKGNvbiwgSU5QVVRfQVhJU19YLCB4IC0gdnMtPmxhc3RfeCk7DQo+ID4gICAgICAgICAgICAg
IHFlbXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19ZLCB5IC0gdnMtPmxhc3RfeSk7
DQo+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcWVtdV9pbnB1dF9xdWV1
ZV9yZWwoY29uLCBJTlBVVF9BWElTX1gsIDAgLSB3aWR0aCk7DQo+ID4gKyAgICAgICAgICAgIHFl
bXVfaW5wdXRfcXVldWVfcmVsKGNvbiwgSU5QVVRfQVhJU19ZLCAwIC0gaGVpZ2h0KTsNCj4gPiAr
ICAgICAgICAgICAgeCA9IDA7DQo+ID4gKyAgICAgICAgICAgIHkgPSAwOw0KPiA+ICAgICAgICAg
IH0NCj4gPiAgICAgICAgICB2cy0+bGFzdF94ID0geDsNCj4gPiAgICAgICAgICB2cy0+bGFzdF95
ID0geTsNCj4gPiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo+ID4NCg0K

