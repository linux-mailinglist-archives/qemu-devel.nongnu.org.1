Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2557AEB5C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql68I-0003cS-IA; Tue, 26 Sep 2023 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql68G-0003a2-04
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:21:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql68C-0003Xf-Mc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:21:35 -0400
Received: from dggpemm100021.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rvy1V6P7Gz15NL5;
 Tue, 26 Sep 2023 19:19:10 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm100021.china.huawei.com (7.185.36.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 19:21:23 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 12:21:21 +0100
To: David Hildenbrand <david@redhat.com>, lixianglai <lixianglai@loongson.cn>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Topic: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAAAdJgIAA3/CAgAABaoCAAFe/AIARji0Q
Date: Tue, 26 Sep 2023 11:21:21 +0000
Message-ID: <7906109a36c5467fa9b529520671fa77@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
In-Reply-To: <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=salil.mehta@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

SGkgRGF2aWQsDQoNCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDE1LCAyMDIzIDk6MDcgQU0NCj4gVG86IGxpeGlh
bmdsYWkgPGxpeGlhbmdsYWlAbG9vbmdzb24uY24+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFNh
bGlsIE1laHRhDQo+IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiBDYzogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+OyBYaWFvanVhbiBZYW5nDQo+IDx5YW5neGlhb2p1YW5A
bG9vbmdzb24uY24+OyBTb25nIEdhbyA8Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1pY2hhZWwgUy4N
Cj4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRo
YXQuY29tPjsgQW5pIFNpbmhhDQo+IDxhbmlzaW5oYUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+IDxlZHVhcmRvQGhhYmtvc3Qu
bmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+Ow0KPiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyB3YW5neWFuYW4gKFkp
DQo+IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFu
Z2VAcmVkaGF0LmNvbT47IFBldGVyDQo+IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IEJpYm8gTWFv
IDxtYW9iaWJvQGxvb25nc29uLmNuPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA0LzEwXSBJ
bnRyb2R1Y2UgdGhlIENQVSBhZGRyZXNzIHNwYWNlIGRlc3RydWN0aW9uDQo+IGZ1bmN0aW9uDQo+
IA0KPiBPbiAxNS4wOS4yMyAwNDo1MywgbGl4aWFuZ2xhaSB3cm90ZToNCj4gPiBIaSBEYXZpZCBI
aWxkZW5icmFuZDoNCj4gPg0KPiA+Pg0KPiA+PiBIaSBEYXZpZCBIaWxkZW5icmFuZDoNCj4gPj4+
IE9uIDE0LjA5LjIzIDE1OjAwLCBsaXhpYW5nbGFpIHdyb3RlOg0KPiA+Pj4+IEhpIERhdmlkOg0K
PiA+Pj4NCj4gPj4+IEhpIQ0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiBPbiAxMi4wOS4yMyAwNDox
MSwgeGlhbmdsYWkgbGkgd3JvdGU6DQo+ID4+Pj4+PiBJbnRyb2R1Y2UgbmV3IGZ1bmN0aW9uIHRv
IGRlc3Ryb3kgQ1BVIGFkZHJlc3Mgc3BhY2UgcmVzb3VyY2VzDQo+ID4+Pj4+PiBmb3IgY3B1IGhv
dC0odW4pcGx1Zy4NCj4gPj4+Pj4+DQo+ID4+Pj4+IEhvdyBkbyBvdGhlciBhcmNocyBoYW5kbGUg
dGhhdD8gT3IgaG93IGFyZSB0aGV5IGFibGUgdG8gZ2V0IGF3YXkNCj4gPj4+Pj4gd2l0aG91dCBk
ZXN0cm95aW5nPw0KPiA+Pj4+Pg0KPiA+Pj4+IFRoZXkgZG8gbm90IHJlbW92ZSB0aGUgY3B1IGFk
ZHJlc3Mgc3BhY2UsIHRha2luZyB0aGUgWDg2DQo+ID4+Pj4gYXJjaGl0ZWN0dXJlIGFzDQo+ID4+
Pj4gYW4gZXhhbXBsZToNCj4gPj4+Pg0KPiA+Pj4+IDEuU3RhcnQgdGhlIHg4NiBWTToNCj4gPj4+
Pg0KPiA+Pj4+IC4vcWVtdS1zeXN0ZW0teDg2XzY0IFwNCj4gPj4+PiAtbWFjaGluZSBxMzXCoCBc
DQo+ID4+Pj4gLWNwdSBCcm9hZHdlbGwtSUJSUyBcDQo+ID4+Pj4gLXNtcCAxLG1heGNwdXM9MTAw
LHNvY2tldHM9MTAwLGNvcmVzPTEsdGhyZWFkcz0xIFwNCj4gPj4+PiAtbSA0RyBcDQo+ID4+Pj4g
LWRyaXZlIGZpbGU9fi9hbm9saXMtOC44LnFjb3cywqAgXA0KPiA+Pj4+IC1zZXJpYWwgc3RkaW/C
oMKgIFwNCj4gPj4+PiAtbW9uaXRvciB0ZWxuZXQ6bG9jYWxob3N0OjQ0OTgsc2VydmVyLG5vd2Fp
dMKgwqAgXA0KPiA+Pj4+IC1ub2dyYXBoaWMNCj4gPj4+Pg0KPiA+Pj4+IDIuQ29ubmVjdCB0aGUg
cWVtdSBtb25pdG9yDQo+ID4+Pj4NCj4gPj4+PiB0ZWxuZXQgMTI3LjAuMC4xIDQ0OTgNCj4gPj4+
Pg0KPiA+Pj4+IGluZm8gbXRyZWUNCj4gPj4+Pg0KPiA+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1t
ZW1vcnktMA0KPiA+Pj4+IGFkZHJlc3Mtc3BhY2U6IG1lbW9yeQ0KPiA+Pj4+ICDCoCDCoCAwMDAw
MDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYgKHByaW8gMCwgaS9vKTogc3lzdGVtDQo+ID4+
Pj4gIMKgIMKgwqDCoCAwMDAwMDAwMDAwMDAwMDAwLTAwMDAwMDAwN2ZmZmZmZmYgKHByaW8gMCwg
cmFtKTogYWxpYXMNCj4gPj4+PiByYW0tYmVsb3ctNGcNCj4gPj4+PiBAcGMucmFtIDAwMDAwMDAw
MDAwMDAwMDAtMDAwMDAwMDA3ZmZmZmZmZg0KPiA+Pj4+ICDCoCDCoMKgwqAgMDAwMDAwMDAwMDAw
MDAwMC1mZmZmZmZmZmZmZmZmZmZmIChwcmlvIC0xLCBpL28pOiBwY2kNCj4gPj4+PiAgwqAgwqDC
oMKgwqDCoCAwMDAwMDAwMDAwMGEwMDAwLTAwMDAwMDAwMDAwYmZmZmYgKHByaW8gMSwgaS9vKTog
dmdhLWxvd21lbQ0KPiA+Pj4+DQo+ID4+Pj4gMy5QZXJmb3JtIGNwdSBob3Qgc3dhcCBpbnQgcWVt
dSBtb25pdG9yDQo+ID4+Pj4NCj4gPj4+PiBkZXZpY2VfYWRkDQo+ID4+Pj4gQnJvYWR3ZWxsLUlC
UlMteDg2XzY0LWNwdSxzb2NrZXQtaWQ9MSxjb3JlLWlkPTAsdGhyZWFkLWlkPTAsaWQ9Y3B1MQ0K
PiA+Pj4+IGRldmljZV9kZWwgY3B1MQ0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSG0sIGRvZXNuJ3Qg
c2VlbSB0byB3b3JrIGZvciBtZSBvbiB1cHN0cmVhbSBRRU1VIGZvciBzb21lIHJlYXNvbjoNCj4g
Pj4+ICJFcnJvcjogYWNwaTogZGV2aWNlIHVucGx1ZyByZXF1ZXN0IGZvciBub3Qgc3VwcG9ydGVk
IGRldmljZSB0eXBlOg0KPiA+Pj4gQnJvYWR3ZWxsLUlCUlMteDg2XzY0LWNwdSINCj4gPj4NCj4g
PiBGaXJzdCBJIHVzZSBxZW11IHRjZywgYW5kIHRoZW4gdGhlIGNwdSBuZWVkcyB0byBiZSByZW1v
dmVkIGFmdGVyIHRoZQ0KPiA+IG9wZXJhdGluZyBzeXN0ZW0gaXMgYm9vdGVkLg0KPiANCj4gQWgs
IHRoZSBsYXN0IHRoaW5nIGlzIHRoZSBpbXBvcnRhbnQgYml0LiBJIGNhbiByZXByb2R1Y2UgdGhp
cyB3aXRoIEtWTQ0KPiBlYXNpbHkuDQo+IA0KPiBEb2luZyBpdCBhIGNvdXBsZSBvZiB0aW1lcw0K
PiANCj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0wDQo+IGFkZHJlc3Mtc3BhY2U6IGNwdS1t
ZW1vcnktMQ0KPiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gYWRkcmVzcy1zcGFjZTog
Y3B1LW1lbW9yeS0xDQo+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiBhZGRyZXNzLXNw
YWNlOiBjcHUtbWVtb3J5LTENCj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+IGFkZHJl
c3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4g
YWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnkt
MQ0KPiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gYWRkcmVzcy1zcGFjZTogY3B1LW1l
bW9yeS0xDQo+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiBhZGRyZXNzLXNwYWNlOiBj
cHUtbWVtb3J5LTENCj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+IGFkZHJlc3Mtc3Bh
Y2U6IGNwdS1tZW1vcnktMQ0KPiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gYWRkcmVz
cy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiAN
Cj4gTG9va3MgbGlrZSBhIHJlc291cmNlL21lbW9yeSBsZWFrLg0KDQpZZXMsIHRoZXJlIHdhcy4g
VGhhbmtzIGZvciBpZGVudGlmeWluZyBpdC4gSSBoYXZlIGZpeGVkIGluIHRoZQ0KbGF0ZXN0IFJG
QyBWMi4gUGxlYXNlIGNoZWNrIGhlcmU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjAyMzA5MjYxMDA0MzYuMjgyODQtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tL1QvI201
ZjVhZTQwYjA5MWQ2OWQwMTAxMjg4MGQ3NTAwZDk2ODc0YTlkMzljDQoNCkkgaGF2ZSB0ZXN0ZWQg
YW5kIEFkZHJlc3NTcGFjZSBjb21lcyBhbmQgZ29lcyBhd2F5IGNsZWFubHkNCm9uIENQVSBob3Qo
dW4pcGx1ZyBhY3Rpb24uDQoNCg0KDQpbLi4uXQ0KDQoNCj4gPj4gSGkgU2FsaWwgTWVodGE6DQo+
ID4+DQo+ID4+IElzIHRoZSBjcHVfYWRkcmVzc19zcGFjZV9kZXN0cm95IGZ1bmN0aW9uIHN0aWxs
IHByZXNlbnQgaW4gdGhlIG5ldw0KPiA+PiBwYXRjaCB2ZXJzaW9uIG9mIGFybT8NCj4gPj4NCj4g
Pj4gQ2FuIHdlIHB1dCB0aGlzIGZ1bmN0aW9uIG9uIHRoZSBwdWJsaWMgcGF0aCBvZiBjcHUgZGVz
dHJveT8NCj4gDQo+IExvb2tzIGxpa2UgdGhpcyBoYXMgdG8gYmUgZml4ZWQgZm9yIGFsbCBhcmNo
cyB0aGF0IHN1cHBvcnQgVkNQVSB1bnBsdWcuDQo+IA0KPiBUaGUgQ1BVIGltcGxlbWVudGF0aW9u
IGVuZCB1cCBjYWxsIHFlbXVfaW5pdF92Y3B1KCkgaW4gdGhlaXIgcmVhbGl6ZQ0KPiBmdW5jdGlv
bjsgdGhlcmUgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHFlbXVfZGVzdHJveV92Y3B1KCkgb24g
dGhlDQo+IHVucmVhbGl6ZSBwYXRoIHRoYXQgdGFrZXMgY2FyZSBvZiB1bmRvaW5nIGFueSBjcHVf
YWRkcmVzc19zcGFjZV9pbml0KCkuDQo+IA0KPiBXZSBzZWVtIHRvIGhhdmUgY3B1X2NvbW1vbl91
bnJlYWxpemVmbigpLT5jcHVfZXhlY191bnJlYWxpemVmbigpIGJ1dA0KPiB0aGF0IGRvZXNuJ3Qg
dGFrZSBjYXJlIG9mIGFkZHJlc3Mgc3BhY2VzLg0KDQpZZXMsIHRoZSBjdXJyZW50IGNvbmNlcHQg
Y2FuIGJlIGV4dGVuZGVkDQoNCj4gDQo+IEFsc28sIGluIHFlbXVfaW5pdF92Y3B1KCkgd2UgZG8g
YSBjcHVzX2FjY2VsLT5jcmVhdGVfdmNwdV90aHJlYWQoY3B1KS4NCj4gSSdtLCBjdXJpb3VzIGlm
IHdlIGRlc3Ryb3kgdGhhdCB0aHJlYWQgc29tZWhvdy4NCg0KDQpZZXMgd2UgZG8uIEluIEFSTSBS
RkMsIHRoaXMgaGFwcGVucyBhZnRlciBDUFUgaGFzIGJlZW4gdW5wbHVnZ2VkIGFuZA0KQ1BVIGlz
IGJlaW5nIGRlc3Ryb3llZCBhbmQgdW5wYXJlbnRlZCAoYWxsIG9mIHRoaXMgaGFwcGVucyBpbiBj
b250ZXh0DQpBQ1BJIF9FSnggbWV0aG9kIGV2YWx1YXRlZCBieSBPU1BNKS4gVGhpcyBldmVudHVh
bGx5IGxlYWRzIHRvDQphcmNoaXRlY3R1cmUgc3BlY2lmaWMgQ1BVIHVucmVhbGl6ZSBhbmQgY2Fs
bCB0byBjcHVfcmVtb3ZlX3N5bmMoKS4NCg0KDQpUaGFua3MNClNhbGlsLg0KDQo=

