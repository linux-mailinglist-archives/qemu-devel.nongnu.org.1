Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2547AECE9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7FF-0001tG-8g; Tue, 26 Sep 2023 08:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7Ew-0001iC-CE
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:32:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7Es-0006B6-9N
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:32:34 -0400
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RvzbN3xR2zrRyp;
 Tue, 26 Sep 2023 20:30:08 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 20:32:22 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 13:32:20 +0100
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
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAAAdJgIAA3/CAgAABaoCAAFe/AIARji0QgAALU5D///fCgIAAErCw
Date: Tue, 26 Sep 2023 12:32:20 +0000
Message-ID: <e4b1bd2abbbe4763953c611e0308a530@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <7906109a36c5467fa9b529520671fa77@huawei.com>
 <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
 <40647bc5-6a2e-0b59-3605-0de8d4639f66@redhat.com>
In-Reply-To: <40647bc5-6a2e-0b59-3605-0de8d4639f66@redhat.com>
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

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDE6MjQgUE0NCj4gDQo+IE9uIDI2LjA5LjIzIDEzOjU1
LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPj4gRnJvbTogU2FsaWwgTWVodGENCj4gPj4gU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDEyOjIxIFBNDQo+ID4+IFRvOiAnRGF2aWQgSGls
ZGVuYnJhbmQnIDxkYXZpZEByZWRoYXQuY29tPjsgbGl4aWFuZ2xhaQ0KPiA+PiA8bGl4aWFuZ2xh
aUBsb29uZ3Nvbi5jbj47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+OyBYaWFvanVhbiBZYW5nDQo+ID4+IDx5YW5neGlh
b2p1YW5AbG9vbmdzb24uY24+OyBTb25nIEdhbyA8Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1pY2hh
ZWwgUy4NCj4gPj4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92IDxpbWFt
bWVkb0ByZWRoYXQuY29tPjsgQW5pIFNpbmhhDQo+ID4+IDxhbmlzaW5oYUByZWRoYXQuY29tPjsg
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gPj4gSGVuZGVy
c29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+ID4+
IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1
bUBnbWFpbC5jb20+Ow0KPiA+PiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+OyB3YW5neWFuYW4gKFkpDQo+ID4+IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgRGFu
aWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47DQo+IFBldGVyDQo+ID4+IFh1
IDxwZXRlcnhAcmVkaGF0LmNvbT47IEJpYm8gTWFvIDxtYW9iaWJvQGxvb25nc29uLmNuPg0KPiA+
PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDA0LzEwXSBJbnRyb2R1Y2UgdGhlIENQVSBhZGRyZXNz
IHNwYWNlDQo+IGRlc3RydWN0aW9uDQo+ID4+IGZ1bmN0aW9uDQo+ID4+DQo+ID4+IEhpIERhdmlk
LA0KPiA+Pg0KPiA+Pj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
DQo+ID4+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxNSwgMjAyMyA5OjA3IEFNDQo+ID4+PiBU
bzogbGl4aWFuZ2xhaSA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbj47IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgU2FsaWwNCj4gPj4gTWVodGENCj4gPj4+IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiA+Pj4gQ2M6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0PjsgWGlhb2p1YW4g
WWFuZw0KPiA+Pj4gPHlhbmd4aWFvanVhbkBsb29uZ3Nvbi5jbj47IFNvbmcgR2FvIDxnYW9zb25n
QGxvb25nc29uLmNuPjsgTWljaGFlbCBTLg0KPiA+Pj4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgQW5pDQo+IFNpbmhhDQo+ID4+
PiA8YW5pc2luaGFAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+OyBSaWNoYXJkDQo+ID4+PiBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+OyBFZHVhcmRvIEhhYmtvc3QNCj4gPj4+IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyY2Vs
IEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+Ow0KPiA+Pj4gUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgd2FuZ3lhbmFuIChZKQ0KPiA+Pj4g
PHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUBy
ZWRoYXQuY29tPjsNCj4gUGV0ZXINCj4gPj4+IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IEJpYm8g
TWFvIDxtYW9iaWJvQGxvb25nc29uLmNuPg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAw
NC8xMF0gSW50cm9kdWNlIHRoZSBDUFUgYWRkcmVzcyBzcGFjZQ0KPiBkZXN0cnVjdGlvbg0KPiA+
Pj4gZnVuY3Rpb24NCj4gPj4+DQo+ID4+PiBPbiAxNS4wOS4yMyAwNDo1MywgbGl4aWFuZ2xhaSB3
cm90ZToNCj4gPj4+PiBIaSBEYXZpZCBIaWxkZW5icmFuZDoNCj4gPj4+Pg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBIaSBEYXZpZCBIaWxkZW5icmFuZDoNCj4gPj4+Pj4+IE9uIDE0LjA5LjIzIDE1OjAwLCBs
aXhpYW5nbGFpIHdyb3RlOg0KPiA+Pj4+Pj4+IEhpIERhdmlkOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IEhpIQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBPbiAxMi4wOS4yMyAwNDoxMSwg
eGlhbmdsYWkgbGkgd3JvdGU6DQo+ID4+Pj4+Pj4+PiBJbnRyb2R1Y2UgbmV3IGZ1bmN0aW9uIHRv
IGRlc3Ryb3kgQ1BVIGFkZHJlc3Mgc3BhY2UgcmVzb3VyY2VzDQo+ID4+Pj4+Pj4+PiBmb3IgY3B1
IGhvdC0odW4pcGx1Zy4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IEhvdyBkbyBvdGhlciBhcmNo
cyBoYW5kbGUgdGhhdD8gT3IgaG93IGFyZSB0aGV5IGFibGUgdG8gZ2V0IGF3YXkNCj4gPj4+Pj4+
Pj4gd2l0aG91dCBkZXN0cm95aW5nPw0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+IFRoZXkgZG8gbm90
IHJlbW92ZSB0aGUgY3B1IGFkZHJlc3Mgc3BhY2UsIHRha2luZyB0aGUgWDg2DQo+ID4+Pj4+Pj4g
YXJjaGl0ZWN0dXJlIGFzDQo+ID4+Pj4+Pj4gYW4gZXhhbXBsZToNCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+IDEuU3RhcnQgdGhlIHg4NiBWTToNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IC4vcWVtdS1zeXN0
ZW0teDg2XzY0IFwNCj4gPj4+Pj4+PiAtbWFjaGluZSBxMzXCoCBcDQo+ID4+Pj4+Pj4gLWNwdSBC
cm9hZHdlbGwtSUJSUyBcDQo+ID4+Pj4+Pj4gLXNtcCAxLG1heGNwdXM9MTAwLHNvY2tldHM9MTAw
LGNvcmVzPTEsdGhyZWFkcz0xIFwNCj4gPj4+Pj4+PiAtbSA0RyBcDQo+ID4+Pj4+Pj4gLWRyaXZl
IGZpbGU9fi9hbm9saXMtOC44LnFjb3cywqAgXA0KPiA+Pj4+Pj4+IC1zZXJpYWwgc3RkaW/CoMKg
IFwNCj4gPj4+Pj4+PiAtbW9uaXRvciB0ZWxuZXQ6bG9jYWxob3N0OjQ0OTgsc2VydmVyLG5vd2Fp
dMKgwqAgXA0KPiA+Pj4+Pj4+IC1ub2dyYXBoaWMNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IDIuQ29u
bmVjdCB0aGUgcWVtdSBtb25pdG9yDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiB0ZWxuZXQgMTI3LjAu
MC4xIDQ0OTgNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IGluZm8gbXRyZWUNCj4gPj4+Pj4+Pg0KPiA+
Pj4+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMA0KPiA+Pj4+Pj4+IGFkZHJlc3Mtc3Bh
Y2U6IG1lbW9yeQ0KPiA+Pj4+Pj4+ICAgwqAgwqAgMDAwMDAwMDAwMDAwMDAwMC1mZmZmZmZmZmZm
ZmZmZmZmIChwcmlvIDAsIGkvbyk6IHN5c3RlbQ0KPiA+Pj4+Pj4+ICAgwqAgwqDCoMKgIDAwMDAw
MDAwMDAwMDAwMDAtMDAwMDAwMDA3ZmZmZmZmZiAocHJpbyAwLCByYW0pOiBhbGlhcw0KPiA+Pj4+
Pj4+IHJhbS1iZWxvdy00Zw0KPiA+Pj4+Pj4+IEBwYy5yYW0gMDAwMDAwMDAwMDAwMDAwMC0wMDAw
MDAwMDdmZmZmZmZmDQo+ID4+Pj4+Pj4gICDCoCDCoMKgwqAgMDAwMDAwMDAwMDAwMDAwMC1mZmZm
ZmZmZmZmZmZmZmZmIChwcmlvIC0xLCBpL28pOiBwY2kNCj4gPj4+Pj4+PiAgIMKgIMKgwqDCoMKg
wqAgMDAwMDAwMDAwMDBhMDAwMC0wMDAwMDAwMDAwMGJmZmZmIChwcmlvIDEsIGkvbyk6IHZnYS0N
Cj4gbG93bWVtDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAzLlBlcmZvcm0gY3B1IGhvdCBzd2FwIGlu
dCBxZW11IG1vbml0b3INCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IGRldmljZV9hZGQNCj4gPj4+Pj4+
PiBCcm9hZHdlbGwtSUJSUy14ODZfNjQtY3B1LHNvY2tldC1pZD0xLGNvcmUtaWQ9MCx0aHJlYWQt
aWQ9MCxpZD1jcHUxDQo+ID4+Pj4+Pj4gZGV2aWNlX2RlbCBjcHUxDQo+ID4+Pj4+Pj4NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBIbSwgZG9lc24ndCBzZWVtIHRvIHdvcmsgZm9yIG1lIG9uIHVwc3RyZWFt
IFFFTVUgZm9yIHNvbWUgcmVhc29uOg0KPiA+Pj4+Pj4gIkVycm9yOiBhY3BpOiBkZXZpY2UgdW5w
bHVnIHJlcXVlc3QgZm9yIG5vdCBzdXBwb3J0ZWQgZGV2aWNlIHR5cGU6DQo+ID4+Pj4+PiBCcm9h
ZHdlbGwtSUJSUy14ODZfNjQtY3B1Ig0KPiA+Pj4+Pg0KPiA+Pj4+IEZpcnN0IEkgdXNlIHFlbXUg
dGNnLCBhbmQgdGhlbiB0aGUgY3B1IG5lZWRzIHRvIGJlIHJlbW92ZWQgYWZ0ZXIgdGhlDQo+ID4+
Pj4gb3BlcmF0aW5nIHN5c3RlbSBpcyBib290ZWQuDQo+ID4+Pg0KPiA+Pj4gQWgsIHRoZSBsYXN0
IHRoaW5nIGlzIHRoZSBpbXBvcnRhbnQgYml0LiBJIGNhbiByZXByb2R1Y2UgdGhpcyB3aXRoIEtW
TQ0KPiA+Pj4gZWFzaWx5Lg0KPiA+Pj4NCj4gPj4+IERvaW5nIGl0IGEgY291cGxlIG9mIHRpbWVz
DQo+ID4+Pg0KPiA+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0wDQo+ID4+PiBhZGRyZXNz
LXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0K
PiA+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+PiBhZGRyZXNzLXNwYWNlOiBj
cHUtbWVtb3J5LTENCj4gPj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4gYWRk
cmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+PiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5
LTENCj4gPj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4gYWRkcmVzcy1zcGFj
ZTogY3B1LW1lbW9yeS0xDQo+ID4+PiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+
IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1l
bW9yeS0xDQo+ID4+PiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+IGFkZHJlc3Mt
c3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+
ID4+PiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+IGFkZHJlc3Mtc3BhY2U6IGNw
dS1tZW1vcnktMQ0KPiA+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+PiBhZGRy
ZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+DQo+ID4+PiBMb29rcyBsaWtlIGEgcmVzb3Vy
Y2UvbWVtb3J5IGxlYWsuDQo+ID4+DQo+ID4+IFllcywgdGhlcmUgd2FzLiBUaGFua3MgZm9yIGlk
ZW50aWZ5aW5nIGl0LiBJIGhhdmUgZml4ZWQgaW4gdGhlDQo+ID4+IGxhdGVzdCBSRkMgVjIuIFBs
ZWFzZSBjaGVjayBoZXJlOg0KPiA+Pg0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjMwOTI2MTAwNDM2LjI4Mjg0LTEtDQo+ID4+IHNhbGlsLm1laHRhQGh1YXdlaS5j
b20vVC8jbTVmNWFlNDBiMDkxZDY5ZDAxMDEyODgwZDc1MDBkOTY4NzRhOWQzOWMNCj4gPj4NCj4g
Pj4gSSBoYXZlIHRlc3RlZCBhbmQgQWRkcmVzc1NwYWNlIGNvbWVzIGFuZCBnb2VzIGF3YXkgY2xl
YW5seQ0KPiA+PiBvbiBDUFUgaG90KHVuKXBsdWcgYWN0aW9uLg0KPiA+DQo+ID4gSGkgRGF2aWQv
WGlhbmdsYWksDQo+ID4gQXJlIHlvdSBva2F5IGlmIEkgcHV0IFJlcG9ydGVkLWJ5IGFuZCBnaXZl
IHJlZmVyZW5jZSB0byB0aGlzDQo+ID4gY29udmVyc2F0aW9uPw0KPiANCj4gWWVzLiBBbmQgaWRl
YWxseSwgc2VuZCB0aGUgZml4ZXMgc2VwYXJhdGVseSBmcm9tIHRoZSBvdGhlciBhcm0gcGF0Y2hl
cy4NCg0KQVJNIFZpcnR1YWwgQ1BVIEhvdHBsdWcgc3VwcG9ydCBwYXRjaGVzIGFyZSBzdGlsbCB1
bmRlciByZXZpZXcuDQoNClRoYW5rcw0KU2FsaWwuDQoNCg==

