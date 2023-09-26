Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8E7AEB0D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5uI-0002vv-CL; Tue, 26 Sep 2023 07:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5uC-0002ud-CK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:07:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5u9-00089N-60
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:07:03 -0400
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RvxhS3Pt7z15NL5;
 Tue, 26 Sep 2023 19:04:24 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 19:06:37 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 12:06:35 +0100
To: lixianglai <lixianglai@loongson.cn>, David Hildenbrand <david@redhat.com>, 
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
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAEsxHUA==
Date: Tue, 26 Sep 2023 11:06:35 +0000
Message-ID: <95d2f7e2d846417da5ebadc5ab8c7086@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
In-Reply-To: <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
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

DQoNCj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1YXdlaS5jb21Abm9u
Z251Lm9yZyA8cWVtdS1kZXZlbC0NCj4gYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5v
bmdudS5vcmc+IE9uIEJlaGFsZiBPZiBsaXhpYW5nbGFpDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMTQsIDIwMjMgMjowMSBQTQ0KPiBUbzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJl
ZGhhdC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBvcG5zcmMubmV0PjsgWGlhb2p1YW4gWWFuZw0KPiA8eWFuZ3hpYW9qdWFuQGxvb25n
c29uLmNuPjsgU29uZyBHYW8gPGdhb3NvbmdAbG9vbmdzb24uY24+OyBNaWNoYWVsIFMuDQo+IFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPjsgSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNv
bT47IEFuaSBTaW5oYQ0KPiA8YW5pc2luaGFAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29zdA0KPiA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD47
IE1hcmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPjsNCj4gUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgd2FuZ3lhbmFuIChZKQ0KPiA8
d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJl
ZGhhdC5jb20+OyBQZXRlcg0KPiBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+OyBCaWJvIE1hbyA8bWFv
Ymlib0Bsb29uZ3Nvbi5jbj4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNC8xMF0gSW50cm9k
dWNlIHRoZSBDUFUgYWRkcmVzcyBzcGFjZSBkZXN0cnVjdGlvbg0KPiBmdW5jdGlvbg0KPiANCj4g
SGkgRGF2aWQ6DQo+IA0KPiA+IE9uIDEyLjA5LjIzIDA0OjExLCB4aWFuZ2xhaSBsaSB3cm90ZToN
Cj4gPj4gSW50cm9kdWNlIG5ldyBmdW5jdGlvbiB0byBkZXN0cm95IENQVSBhZGRyZXNzIHNwYWNl
IHJlc291cmNlcw0KPiA+PiBmb3IgY3B1IGhvdC0odW4pcGx1Zy4NCj4gPj4NCj4gPiBIb3cgZG8g
b3RoZXIgYXJjaHMgaGFuZGxlIHRoYXQ/IE9yIGhvdyBhcmUgdGhleSBhYmxlIHRvIGdldCBhd2F5
DQo+ID4gd2l0aG91dCBkZXN0cm95aW5nPw0KPiA+DQo+IFRoZXkgZG8gbm90IHJlbW92ZSB0aGUg
Y3B1IGFkZHJlc3Mgc3BhY2UsIHRha2luZyB0aGUgWDg2IGFyY2hpdGVjdHVyZSBhcw0KPiBhbiBl
eGFtcGxlOg0KPiANCj4gMS5TdGFydCB0aGUgeDg2IFZNOg0KPiANCj4gLi9xZW11LXN5c3RlbS14
ODZfNjQgXA0KPiAtbWFjaGluZSBxMzXCoCBcDQo+IC1jcHUgQnJvYWR3ZWxsLUlCUlMgXA0KPiAt
c21wIDEsbWF4Y3B1cz0xMDAsc29ja2V0cz0xMDAsY29yZXM9MSx0aHJlYWRzPTEgXA0KPiAtbSA0
RyBcDQo+IC1kcml2ZSBmaWxlPX4vYW5vbGlzLTguOC5xY293MsKgIFwNCj4gLXNlcmlhbCBzdGRp
b8KgwqAgXA0KPiAtbW9uaXRvciB0ZWxuZXQ6bG9jYWxob3N0OjQ0OTgsc2VydmVyLG5vd2FpdMKg
wqAgXA0KPiAtbm9ncmFwaGljDQo+IA0KPiAyLkNvbm5lY3QgdGhlIHFlbXUgbW9uaXRvcg0KPiAN
Cj4gdGVsbmV0IDEyNy4wLjAuMSA0NDk4DQo+IA0KPiBpbmZvIG10cmVlDQo+IA0KPiBhZGRyZXNz
LXNwYWNlOiBjcHUtbWVtb3J5LTANCj4gYWRkcmVzcy1zcGFjZTogbWVtb3J5DQo+ICDCoCAwMDAw
MDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYgKHByaW8gMCwgaS9vKTogc3lzdGVtDQo+ICDC
oMKgwqAgMDAwMDAwMDAwMDAwMDAwMC0wMDAwMDAwMDdmZmZmZmZmIChwcmlvIDAsIHJhbSk6IGFs
aWFzIHJhbS1iZWxvdy00Zw0KPiBAcGMucmFtIDAwMDAwMDAwMDAwMDAwMDAtMDAwMDAwMDA3ZmZm
ZmZmZg0KPiAgwqDCoMKgIDAwMDAwMDAwMDAwMDAwMDAtZmZmZmZmZmZmZmZmZmZmZiAocHJpbyAt
MSwgaS9vKTogcGNpDQo+ICDCoMKgwqDCoMKgIDAwMDAwMDAwMDAwYTAwMDAtMDAwMDAwMDAwMDBi
ZmZmZiAocHJpbyAxLCBpL28pOiB2Z2EtbG93bWVtDQo+IA0KPiAzLlBlcmZvcm0gY3B1IGhvdCBz
d2FwIGludCBxZW11IG1vbml0b3INCj4gDQo+IGRldmljZV9hZGQNCj4gQnJvYWR3ZWxsLUlCUlMt
eDg2XzY0LWNwdSxzb2NrZXQtaWQ9MSxjb3JlLWlkPTAsdGhyZWFkLWlkPTAsaWQ9Y3B1MQ0KPiBk
ZXZpY2VfZGVsIGNwdTENCj4gDQo+IGluZm8gbXRyZWUNCj4gDQo+IGFkZHJlc3Mtc3BhY2U6IGNw
dS1tZW1vcnktMA0KPiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gYWRkcmVzcy1zcGFj
ZTogbWVtb3J5DQo+ICDCoCAwMDAwMDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYgKHByaW8g
MCwgaS9vKTogc3lzdGVtDQo+ICDCoMKgwqAgMDAwMDAwMDAwMDAwMDAwMC0wMDAwMDAwMDdmZmZm
ZmZmIChwcmlvIDAsIHJhbSk6IGFsaWFzIHJhbS1iZWxvdy00Zw0KPiBAcGMucmFtIDAwMDAwMDAw
MDAwMDAwMDAtMDAwMDAwMDA3ZmZmZmZmZg0KPiAgwqDCoMKgIDAwMDAwMDAwMDAwMDAwMDAtZmZm
ZmZmZmZmZmZmZmZmZiAocHJpbyAtMSwgaS9vKTogcGNpDQo+ICDCoMKgwqDCoMKgIDAwMDAwMDAw
MDAwYTAwMDAtMDAwMDAwMDAwMDBiZmZmZiAocHJpbyAxLCBpL28pOiB2Z2EtbG93bWVtDQo+IA0K
PiANCj4gIEZyb20gdGhlIGFib3ZlIHRlc3QsIHlvdSBjYW4gc2VlIHdoZXRoZXIgdGhlIGFkZHJl
c3Mgc3BhY2Ugb2YgY3B1MSBpcw0KPiByZXNpZHVhbCBhZnRlciBhIGNwdSBob3Qgc3dhcCwgYW5k
IHdoZXRoZXIgaXQgaXMgcmVhc29uYWJsZT8NCj4gDQo+IFRoZSBhZGRyZXNzIHNwYWNlIGRlc3Ry
dWN0aW9uIGZ1bmN0aW9uIG9mIHRoZSBDUFUgY2FuIGJlIHVzZWQgdG8gZGVsZXRlDQo+IHRoZSBy
ZXNpZHVhbCBhZGRyZXNzIHNwYWNlIG9mIHRoZSBDUFUxLg0KDQpZZXMsIGl0IGNhbiBiZSBidXQg
SSB3b3VsZCBpbnRlcmVzdGVkIHRvIGtub3cgaWYgdGhlcmUgaXMgYW55IHByb2JsZW0NCndoaWNo
IG1pZ2h0IGhhdmUgZ29uZSB1bm5vdGljZWQgd2hpbGUgZG9pbmcgaXQuDQoNCk1hbnkgdGhhbmtz
DQpTYWxpbC4NCg0K

