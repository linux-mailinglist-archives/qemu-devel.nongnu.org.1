Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A17AECE5
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7Ec-0001RY-Ui; Tue, 26 Sep 2023 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7EO-0001QE-Tf
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:32:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7EL-00066N-7T
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:32:00 -0400
Received: from dggpemm100024.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvyn26X32zrSJV;
 Tue, 26 Sep 2023 19:53:26 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm100024.china.huawei.com (7.185.36.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 19:55:40 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 12:55:38 +0100
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
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAAAdJgIAA3/CAgAABaoCAAFe/AIARji0QgAALU5A=
Date: Tue, 26 Sep 2023 11:55:38 +0000
Message-ID: <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <7906109a36c5467fa9b529520671fa77@huawei.com>
In-Reply-To: <7906109a36c5467fa9b529520671fa77@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=salil.mehta@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiBGcm9tOiBTYWxpbCBNZWh0YQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjMg
MTI6MjEgUE0NCj4gVG86ICdEYXZpZCBIaWxkZW5icmFuZCcgPGRhdmlkQHJlZGhhdC5jb20+OyBs
aXhpYW5nbGFpDQo+IDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPjsgcWVtdS1kZXZlbEBub25nbnUu
b3JnDQo+IENjOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAb3Buc3JjLm5ldD47IFhpYW9qdWFu
IFlhbmcNCj4gPHlhbmd4aWFvanVhbkBsb29uZ3Nvbi5jbj47IFNvbmcgR2FvIDxnYW9zb25nQGxv
b25nc29uLmNuPjsgTWljaGFlbCBTLg0KPiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IElnb3Ig
TWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBBbmkgU2luaGENCj4gPGFuaXNpbmhhQHJl
ZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUmljaGFyZA0K
PiBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBFZHVhcmRvIEhhYmtv
c3QNCj4gPGVkdWFyZG9AaGFia29zdC5uZXQ+OyBNYXJjZWwgQXBmZWxiYXVtIDxtYXJjZWwuYXBm
ZWxiYXVtQGdtYWlsLmNvbT47DQo+IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz47IHdhbmd5YW5hbiAoWSkNCj4gPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBEYW5p
ZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgUGV0ZXINCj4gWHUgPHBldGVy
eEByZWRoYXQuY29tPjsgQmlibyBNYW8gPG1hb2JpYm9AbG9vbmdzb24uY24+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0ggdjIgMDQvMTBdIEludHJvZHVjZSB0aGUgQ1BVIGFkZHJlc3Mgc3BhY2UgZGVz
dHJ1Y3Rpb24NCj4gZnVuY3Rpb24NCj4gDQo+IEhpIERhdmlkLA0KPiANCj4gPiBGcm9tOiBEYXZp
ZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIFNlcHRl
bWJlciAxNSwgMjAyMyA5OjA3IEFNDQo+ID4gVG86IGxpeGlhbmdsYWkgPGxpeGlhbmdsYWlAbG9v
bmdzb24uY24+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFNhbGlsDQo+IE1laHRhDQo+ID4gPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gQ2M6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBv
cG5zcmMubmV0PjsgWGlhb2p1YW4gWWFuZw0KPiA+IDx5YW5neGlhb2p1YW5AbG9vbmdzb24uY24+
OyBTb25nIEdhbyA8Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1pY2hhZWwgUy4NCj4gPiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT47IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBB
bmkgU2luaGENCj4gPiA8YW5pc2luaGFAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+ID4gSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+ID4gPGVkdWFyZG9AaGFia29zdC5uZXQ+
OyBNYXJjZWwgQXBmZWxiYXVtIDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47DQo+ID4gUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgd2FuZ3lhbmFuIChZKQ0K
PiA+IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFu
Z2VAcmVkaGF0LmNvbT47IFBldGVyDQo+ID4gWHUgPHBldGVyeEByZWRoYXQuY29tPjsgQmlibyBN
YW8gPG1hb2JpYm9AbG9vbmdzb24uY24+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNC8x
MF0gSW50cm9kdWNlIHRoZSBDUFUgYWRkcmVzcyBzcGFjZSBkZXN0cnVjdGlvbg0KPiA+IGZ1bmN0
aW9uDQo+ID4NCj4gPiBPbiAxNS4wOS4yMyAwNDo1MywgbGl4aWFuZ2xhaSB3cm90ZToNCj4gPiA+
IEhpIERhdmlkIEhpbGRlbmJyYW5kOg0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+IEhpIERhdmlkIEhp
bGRlbmJyYW5kOg0KPiA+ID4+PiBPbiAxNC4wOS4yMyAxNTowMCwgbGl4aWFuZ2xhaSB3cm90ZToN
Cj4gPiA+Pj4+IEhpIERhdmlkOg0KPiA+ID4+Pg0KPiA+ID4+PiBIaSENCj4gPiA+Pj4NCj4gPiA+
Pj4+DQo+ID4gPj4+Pj4gT24gMTIuMDkuMjMgMDQ6MTEsIHhpYW5nbGFpIGxpIHdyb3RlOg0KPiA+
ID4+Pj4+PiBJbnRyb2R1Y2UgbmV3IGZ1bmN0aW9uIHRvIGRlc3Ryb3kgQ1BVIGFkZHJlc3Mgc3Bh
Y2UgcmVzb3VyY2VzDQo+ID4gPj4+Pj4+IGZvciBjcHUgaG90LSh1bilwbHVnLg0KPiA+ID4+Pj4+
Pg0KPiA+ID4+Pj4+IEhvdyBkbyBvdGhlciBhcmNocyBoYW5kbGUgdGhhdD8gT3IgaG93IGFyZSB0
aGV5IGFibGUgdG8gZ2V0IGF3YXkNCj4gPiA+Pj4+PiB3aXRob3V0IGRlc3Ryb3lpbmc/DQo+ID4g
Pj4+Pj4NCj4gPiA+Pj4+IFRoZXkgZG8gbm90IHJlbW92ZSB0aGUgY3B1IGFkZHJlc3Mgc3BhY2Us
IHRha2luZyB0aGUgWDg2DQo+ID4gPj4+PiBhcmNoaXRlY3R1cmUgYXMNCj4gPiA+Pj4+IGFuIGV4
YW1wbGU6DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gMS5TdGFydCB0aGUgeDg2IFZNOg0KPiA+ID4+Pj4N
Cj4gPiA+Pj4+IC4vcWVtdS1zeXN0ZW0teDg2XzY0IFwNCj4gPiA+Pj4+IC1tYWNoaW5lIHEzNcKg
IFwNCj4gPiA+Pj4+IC1jcHUgQnJvYWR3ZWxsLUlCUlMgXA0KPiA+ID4+Pj4gLXNtcCAxLG1heGNw
dXM9MTAwLHNvY2tldHM9MTAwLGNvcmVzPTEsdGhyZWFkcz0xIFwNCj4gPiA+Pj4+IC1tIDRHIFwN
Cj4gPiA+Pj4+IC1kcml2ZSBmaWxlPX4vYW5vbGlzLTguOC5xY293MsKgIFwNCj4gPiA+Pj4+IC1z
ZXJpYWwgc3RkaW/CoMKgIFwNCj4gPiA+Pj4+IC1tb25pdG9yIHRlbG5ldDpsb2NhbGhvc3Q6NDQ5
OCxzZXJ2ZXIsbm93YWl0wqDCoCBcDQo+ID4gPj4+PiAtbm9ncmFwaGljDQo+ID4gPj4+Pg0KPiA+
ID4+Pj4gMi5Db25uZWN0IHRoZSBxZW11IG1vbml0b3INCj4gPiA+Pj4+DQo+ID4gPj4+PiB0ZWxu
ZXQgMTI3LjAuMC4xIDQ0OTgNCj4gPiA+Pj4+DQo+ID4gPj4+PiBpbmZvIG10cmVlDQo+ID4gPj4+
Pg0KPiA+ID4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0wDQo+ID4gPj4+PiBhZGRyZXNz
LXNwYWNlOiBtZW1vcnkNCj4gPiA+Pj4+ICDCoCDCoCAwMDAwMDAwMDAwMDAwMDAwLWZmZmZmZmZm
ZmZmZmZmZmYgKHByaW8gMCwgaS9vKTogc3lzdGVtDQo+ID4gPj4+PiAgwqAgwqDCoMKgIDAwMDAw
MDAwMDAwMDAwMDAtMDAwMDAwMDA3ZmZmZmZmZiAocHJpbyAwLCByYW0pOiBhbGlhcw0KPiA+ID4+
Pj4gcmFtLWJlbG93LTRnDQo+ID4gPj4+PiBAcGMucmFtIDAwMDAwMDAwMDAwMDAwMDAtMDAwMDAw
MDA3ZmZmZmZmZg0KPiA+ID4+Pj4gIMKgIMKgwqDCoCAwMDAwMDAwMDAwMDAwMDAwLWZmZmZmZmZm
ZmZmZmZmZmYgKHByaW8gLTEsIGkvbyk6IHBjaQ0KPiA+ID4+Pj4gIMKgIMKgwqDCoMKgwqAgMDAw
MDAwMDAwMDBhMDAwMC0wMDAwMDAwMDAwMGJmZmZmIChwcmlvIDEsIGkvbyk6IHZnYS1sb3dtZW0N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiAzLlBlcmZvcm0gY3B1IGhvdCBzd2FwIGludCBxZW11IG1vbml0
b3INCj4gPiA+Pj4+DQo+ID4gPj4+PiBkZXZpY2VfYWRkDQo+ID4gPj4+PiBCcm9hZHdlbGwtSUJS
Uy14ODZfNjQtY3B1LHNvY2tldC1pZD0xLGNvcmUtaWQ9MCx0aHJlYWQtaWQ9MCxpZD1jcHUxDQo+
ID4gPj4+PiBkZXZpY2VfZGVsIGNwdTENCj4gPiA+Pj4+DQo+ID4gPj4+DQo+ID4gPj4+IEhtLCBk
b2Vzbid0IHNlZW0gdG8gd29yayBmb3IgbWUgb24gdXBzdHJlYW0gUUVNVSBmb3Igc29tZSByZWFz
b246DQo+ID4gPj4+ICJFcnJvcjogYWNwaTogZGV2aWNlIHVucGx1ZyByZXF1ZXN0IGZvciBub3Qg
c3VwcG9ydGVkIGRldmljZSB0eXBlOg0KPiA+ID4+PiBCcm9hZHdlbGwtSUJSUy14ODZfNjQtY3B1
Ig0KPiA+ID4+DQo+ID4gPiBGaXJzdCBJIHVzZSBxZW11IHRjZywgYW5kIHRoZW4gdGhlIGNwdSBu
ZWVkcyB0byBiZSByZW1vdmVkIGFmdGVyIHRoZQ0KPiA+ID4gb3BlcmF0aW5nIHN5c3RlbSBpcyBi
b290ZWQuDQo+ID4NCj4gPiBBaCwgdGhlIGxhc3QgdGhpbmcgaXMgdGhlIGltcG9ydGFudCBiaXQu
IEkgY2FuIHJlcHJvZHVjZSB0aGlzIHdpdGggS1ZNDQo+ID4gZWFzaWx5Lg0KPiA+DQo+ID4gRG9p
bmcgaXQgYSBjb3VwbGUgb2YgdGltZXMNCj4gPg0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1v
cnktMA0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6
IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJl
c3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0K
PiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1t
ZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3Bh
Y2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFk
ZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnkt
MQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNw
dS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mt
c3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+
IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1v
cnktMQ0KPiA+DQo+ID4gTG9va3MgbGlrZSBhIHJlc291cmNlL21lbW9yeSBsZWFrLg0KPiANCj4g
WWVzLCB0aGVyZSB3YXMuIFRoYW5rcyBmb3IgaWRlbnRpZnlpbmcgaXQuIEkgaGF2ZSBmaXhlZCBp
biB0aGUNCj4gbGF0ZXN0IFJGQyBWMi4gUGxlYXNlIGNoZWNrIGhlcmU6DQo+IA0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjMwOTI2MTAwNDM2LjI4Mjg0LTEtDQo+IHNh
bGlsLm1laHRhQGh1YXdlaS5jb20vVC8jbTVmNWFlNDBiMDkxZDY5ZDAxMDEyODgwZDc1MDBkOTY4
NzRhOWQzOWMNCj4gDQo+IEkgaGF2ZSB0ZXN0ZWQgYW5kIEFkZHJlc3NTcGFjZSBjb21lcyBhbmQg
Z29lcyBhd2F5IGNsZWFubHkNCj4gb24gQ1BVIGhvdCh1bilwbHVnIGFjdGlvbi4NCg0KSGkgRGF2
aWQvWGlhbmdsYWksDQpBcmUgeW91IG9rYXkgaWYgSSBwdXQgUmVwb3J0ZWQtYnkgYW5kIGdpdmUg
cmVmZXJlbmNlIHRvIHRoaXMNCmNvbnZlcnNhdGlvbj8NCg0KTWFueSB0aGFua3MNClNhbGlsDQoN
Cg0K

