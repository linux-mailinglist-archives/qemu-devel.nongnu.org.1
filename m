Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9737B7BBE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny1X-0005gs-Aa; Wed, 04 Oct 2023 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qny12-0005fA-6g
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:18:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qny0y-0003W4-N0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:17:59 -0400
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0pvy3NVtz6K6BB;
 Wed,  4 Oct 2023 17:16:14 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 4 Oct 2023 10:17:52 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 4 Oct 2023 10:17:52 +0100
To: Salil Mehta <salil.mehta@huawei.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: RE: [PATCH RFC V2 31/37] physmem,gdbstub: Common helping
 funcs/changes to *unrealize* vCPU
Thread-Topic: [PATCH RFC V2 31/37] physmem,gdbstub: Common helping
 funcs/changes to *unrealize* vCPU
Thread-Index: AQHZ8GJOJm4BpzZJyEy2op+9dP4UprA3lZiAgABOcdCAAX+xQA==
Date: Wed, 4 Oct 2023 09:17:52 +0000
Message-ID: <d5191246e108473c95fb6e9a6925f1bd@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-32-salil.mehta@huawei.com>
 <b71a91cc-a0fe-230b-f895-e163b37be157@linaro.org>
 <7e02ed766bd54b7184e349611e61cf12@huawei.com>
In-Reply-To: <7e02ed766bd54b7184e349611e61cf12@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.92]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
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

SGkgUGhpbC9SaWNoYXJkLA0KDQo+IEZyb206IHFlbXUtYXJtLWJvdW5jZXMrc2FsaWwubWVodGE9
aHVhd2VpLmNvbUBub25nbnUub3JnIDxxZW11LWFybS0NCj4gYm91bmNlcytzYWxpbC5tZWh0YT1o
dWF3ZWkuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBTYWxpbCBNZWh0YSB2aWENCj4gU2Vu
dDogVHVlc2RheSwgT2N0b2JlciAzLCAyMDIzIDExOjIzIEFNDQo+IA0KPiBIaSBQaGlsLA0KPiAN
Cj4gPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+
ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAzLCAyMDIzIDc6MzQgQU0NCj4gPiBUbzogU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFl
bXUtDQo+ID4gYXJtQG5vbmdudS5vcmcNCj4gPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhp
bGlwcGVAbGluYXJvLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA+IDxqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+ID4gcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiA+IGltYW1tZWRvQHJl
ZGhhdC5jb207IGFuZHJldy5qb25lc0BsaW51eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+ID4g
ZXJpYy5hdWdlckByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGFyZGJAa2VybmVsLm9yZzsN
Cj4gPiBvbGl2ZXIudXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBtc3RAcmVk
aGF0LmNvbTsNCj4gPiBnc2hhbkByZWRoYXQuY29tOyByYWZhZWxAa2VybmVsLm9yZzsgYm9ybnRy
YWVnZXJAbGludXguaWJtLmNvbTsNCj4gPiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBsaW51eEBh
cm1saW51eC5vcmcudWs7DQo+ID4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2th
QG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+ID4gdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5j
b207IGthcmwuaGV1YmF1bUBvcmFjbGUuY29tOw0KPiA+IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207
IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7IHpodWtlcWlhbg0KPiA+IDx6aHVrZXFpYW4xQGh1YXdl
aS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+
ID4gd2FuZ3lhbmFuIChZKSA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IGppYWtlcm5lbDJAZ21h
aWwuY29tOw0KPiA+IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlhbmdsYWlAbG9vbmdzb24uY24N
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAzMS8zN10gcGh5c21lbSxnZGJzdHViOiBD
b21tb24gaGVscGluZw0KPiA+IGZ1bmNzL2NoYW5nZXMgdG8gKnVucmVhbGl6ZSogdkNQVQ0KPiA+
DQo+ID4gSGkgU2FsaWwsDQo+ID4NCj4gPiBPbiAyNi85LzIzIDEyOjA0LCBTYWxpbCBNZWh0YSB3
cm90ZToNCj4gPiA+IFN1cHBvcnRpbmcgdkNQVSBIb3RwbHVnIGZvciBBUk0gYXJjaCBhbHNvIG1l
YW5zIGludHJvZHVjaW5nIG5ldw0KPiA+IGZ1bmN0aW9uYWxpdHkgb2YNCj4gPiA+IHVucmVhbGl6
aW5nIHRoZSBBUk1DUFUuIFRoaXMgcmVxdWlyZXMgc29tZSBuZXcgY29tbW9uIGZ1bmN0aW9ucy4N
Cj4gPiA+DQo+ID4gPiBEZWZpbmluZyB0aGVtIGFzIHBhcnQgb2YgYXJjaGl0ZWN0dXJlIGluZGVw
ZW5kZW50IGNoYW5nZSBzbyB0aGF0IHRoaXMNCj4gPiBjb2RlIGNvdWxkDQo+ID4gPiBiZSByZXVz
ZWQgYnkgb3RoZXIgaW50ZXJlc3RlZCBwYXJ0aWVzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gPiAg
IGluY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmggfCAgOCArKysrKysrKw0KPiA+ID4gICBpbmNsdWRl
L2V4ZWMvZ2Ric3R1Yi5oICAgIHwgIDEgKw0KPiA+ID4gICBpbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
ICAgIHwgIDEgKw0KPiA+ID4gICBzb2Z0bW11L3BoeXNtZW0uYyAgICAgICAgIHwgMjUgKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ID4gICA1IGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9jb3JlL2NwdS5o
IGIvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+ID4gPiBpbmRleCBkYWI1NzJjOWJkLi5mZmQ4MTVh
MGQ4IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+ID4gPiArKysg
Yi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gPiA+IEBAIC0zNjYsNiArMzY2LDcgQEAgc3RydWN0
IENQVVN0YXRlIHsNCj4gPiA+ICAgICAgIFFTSU1QTEVRX0hFQUQoLCBxZW11X3dvcmtfaXRlbSkg
d29ya19saXN0Ow0KPiA+ID4NCj4gPiA+ICAgICAgIENQVUFkZHJlc3NTcGFjZSAqY3B1X2FzZXM7
DQo+ID4gPiArICAgIGludCBjcHVfYXNlc19yZWZfY291bnQ7DQo+ID4gPiAgICAgICBpbnQgbnVt
X2FzZXM7DQo+ID4gPiAgICAgICBBZGRyZXNzU3BhY2UgKmFzOw0KPiA+ID4gICAgICAgTWVtb3J5
UmVnaW9uICptZW1vcnk7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvc29mdG1tdS9waHlzbWVtLmMgYi9z
b2Z0bW11L3BoeXNtZW0uYw0KPiA+ID4gaW5kZXggM2RmNzM1NDJlMS4uYTkzYWU3ODNhZiAxMDA2
NDQNCj4gPiA+IC0tLSBhL3NvZnRtbXUvcGh5c21lbS5jDQo+ID4gPiArKysgYi9zb2Z0bW11L3Bo
eXNtZW0uYw0KPiA+ID4gQEAgLTc2Miw2ICs3NjIsNyBAQCB2b2lkIGNwdV9hZGRyZXNzX3NwYWNl
X2luaXQoQ1BVU3RhdGUgKmNwdSwgaW50DQo+IGFzaWR4LA0KPiA+ID4NCj4gPiA+ICAgICAgIGlm
ICghY3B1LT5jcHVfYXNlcykgew0KPiA+ID4gICAgICAgICAgIGNwdS0+Y3B1X2FzZXMgPSBnX25l
dzAoQ1BVQWRkcmVzc1NwYWNlLCBjcHUtPm51bV9hc2VzKTsNCj4gPiA+ICsgICAgICAgIGNwdS0+
Y3B1X2FzZXNfcmVmX2NvdW50ID0gY3B1LT5udW1fYXNlczsNCj4gPiA+ICAgICAgIH0NCj4gPiA+
DQo+ID4gPiAgICAgICBuZXdhcyA9ICZjcHUtPmNwdV9hc2VzW2FzaWR4XTsNCj4gPiA+IEBAIC03
NzUsNiArNzc2LDMwIEBAIHZvaWQgY3B1X2FkZHJlc3Nfc3BhY2VfaW5pdChDUFVTdGF0ZSAqY3B1
LCBpbnQNCj4gPiBhc2lkeCwNCj4gPiA+ICAgICAgIH0NCj4gPiA+ICAgfQ0KPiA+ID4NCj4gPiA+
ICt2b2lkIGNwdV9hZGRyZXNzX3NwYWNlX2Rlc3Ryb3koQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4
KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgQ1BVQWRkcmVzc1NwYWNlICpjcHVhczsNCj4gPiA+ICsN
Cj4gPiA+ICsgICAgYXNzZXJ0KGFzaWR4IDwgY3B1LT5udW1fYXNlcyk7DQo+ID4gPiArICAgIGFz
c2VydChhc2lkeCA9PSAwIHx8ICFrdm1fZW5hYmxlZCgpKTsNCj4gPiA+ICsgICAgYXNzZXJ0KGNw
dS0+Y3B1X2FzZXMpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICBjcHVhcyA9ICZjcHUtPmNwdV9hc2Vz
W2FzaWR4XTsNCj4gPiA+ICsgICAgaWYgKHRjZ19lbmFibGVkKCkpIHsNCj4gPiA+ICsgICAgICAg
IG1lbW9yeV9saXN0ZW5lcl91bnJlZ2lzdGVyKCZjcHVhcy0+dGNnX2FzX2xpc3RlbmVyKTsNCj4g
PiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICBhZGRyZXNzX3NwYWNlX2Rlc3Ryb3koY3B1
YXMtPmFzKTsNCj4gPiA+ICsgICAgZ19mcmVlX3JjdShjcHVhcy0+YXMsIHJjdSk7DQo+ID4gPiAr
DQo+ID4gPiArICAgIGlmIChjcHUtPmNwdV9hc2VzX3JlZl9jb3VudCA9PSAxKSB7DQo+ID4gPiAr
ICAgICAgICBnX2ZyZWUoY3B1LT5jcHVfYXNlcyk7DQo+ID4gPiArICAgICAgICBjcHUtPmNwdV9h
c2VzID0gTlVMTDsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICBjcHUtPmNwdV9h
c2VzX3JlZl9jb3VudC0tOw0KPiA+DQo+ID4gU2VlIFJpY2hhcmQgY29tbWVudCBmcm9tOg0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvNTk0YjI1NTAtOWE3My02ODRmLTZl
NTQtDQo+ID4gMjk0MDFkYzZjZDdhQGxpbmFyby5vcmcvDQo+ID4NCj4gPiAiSSB0aGluayBpdCB3
b3VsZCBiZSBiZXR0ZXIgdG8gZGVzdHJveSBhbGwgYWRkcmVzcyBzcGFjZXMgYXQgb25jZSwNCj4g
PiAic28gdGhhdCB5b3UgZG9uJ3QgbmVlZCAgdG8gaW52ZW50IGEgcmVmZXJlbmNlIGNvdW50IHRo
YXQgaXNuJ3QgdXNlZA0KPiA+ICJmb3IgYW55dGhpbmcgZWxzZS4NCj4gDQo+IFllcywgd2UgY2Fu
IGRvIHRoYXQgYW5kIHJlbW92ZSB0aGUgcmVmZXJlbmNlIGNvdW50LiBUaGUgb25seSByZWFzb24g
SQ0KPiBkaWQgaXQgd2FzIGJlY2F1c2UgSSB3YXMgbm90IHN1cmUgaWYgaXQgaXMgc2FmZSB0byBh
c3N1bWUgdGhhdCBhbGwNCj4gdGhlIEFkZHJlc3NTcGFjZSB3aWxsIGFsd2F5cyBiZSBkZXN0cm95
ZWQgKnRvZ2V0aGVyKi4gQW5kIG5vdyBzaW5jZQ0KPiB0aGlzIGlzIGJlaW5nIHBvcnRlZCB0byBv
dGhlciBhcmNoaXRlY3R1cmVzIHdpbGwgdGhlIHNhbWUgaG9sZA0KPiB0cnVlIGV2ZXJ5d2hlcmU/
DQoNCihzb3JyeSwgSSBtaXNzZWQga2V5IHBvaW50KQ0KDQpUbyBtYWtlIHRoaW5ncyBjbGVhciBm
dXJ0aGVyIGZvciBBUk0sIHByZXNlbmNlIG9mIHRhZ2dlZC9zZWN1cmUgbWVtb3J5DQppcyBvcHRp
b25hbCAoYW5kIEkgYW0gbm90IGV2ZW4gc3VyZSBhbGwgb2YgdGhlc2UgYXJlIHN1cHBvcnRlZCB3
aXRoDQphY2NlbD1LVk0pLiBUaGUgQWRkcmVzcyBTcGFjZSBkZXN0cnVjdGlvbiBmdW5jdGlvbiBp
cyBjb21tb24gdG8gYWxsDQphcmNoaXRlY3R1cmVzIGFuZCBoZW5jZSBpdCBpcyBub3Qgc2FmZSB0
byBkZXN0cm95IGFsbCBvZiB0aGVzZSB0b2dldGhlci4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDIzMDkyNjEwMDQzNi4yODI4NC0xLXNhbGlsLm1laHRhQGh1YXdlaS5j
b20vVC8jbWZiMmE1MjUwODFjNDEyOTE3YTAwMjZkNTU4ZTcyZjQ4ODc1ZTM4NmQNCg0KK3N0YXRp
YyB2b2lkIGFybV9jcHVfdW5yZWFsaXplZm4oRGV2aWNlU3RhdGUgKmRldikNCit7DQorICAgIEFS
TUNQVUNsYXNzICphY2MgPSBBUk1fQ1BVX0dFVF9DTEFTUyhkZXYpOw0KKyAgICBBUk1DUFUgKmNw
dSA9IEFSTV9DUFUoZGV2KTsNCisgICAgQ1BVQVJNU3RhdGUgKmVudiA9ICZjcHUtPmVudjsNCisg
ICAgQ1BVU3RhdGUgKmNzID0gQ1BVKGRldik7DQorICAgIGJvb2wgaGFzX3NlY3VyZTsNCisNCisg
ICAgaGFzX3NlY3VyZSA9IGNwdS0+aGFzX2VsMyB8fCBhcm1fZmVhdHVyZShlbnYsIEFSTV9GRUFU
VVJFX01fU0VDVVJJVFkpOw0KKw0KKyAgICAvKiByb2NrICduJyB1bi1yb2xsLCB3aGF0ZXZlciBo
YXBwZW5lZCBpbiB0aGUgYXJtX2NwdV9yZWFsaXplZm4gY2xlYW5seSAqLw0KKyAgICBjcHVfYWRk
cmVzc19zcGFjZV9kZXN0cm95KGNzLCBBUk1BU0lkeF9OUyk7DQorDQorICAgIGlmIChjcHUtPnRh
Z19tZW1vcnkgIT0gTlVMTCkgew0KKyAgICAgICAgY3B1X2FkZHJlc3Nfc3BhY2VfZGVzdHJveShj
cywgQVJNQVNJZHhfVGFnTlMpOw0KKyAgICAgICAgaWYgKGhhc19zZWN1cmUpIHsNCisgICAgICAg
ICAgICBjcHVfYWRkcmVzc19zcGFjZV9kZXN0cm95KGNzLCBBUk1BU0lkeF9UYWdTKTsNCisgICAg
ICAgIH0NCisgICAgfQ0KKw0KKyAgICBpZiAoaGFzX3NlY3VyZSkgew0KKyAgICAgICAgY3B1X2Fk
ZHJlc3Nfc3BhY2VfZGVzdHJveShjcywgQVJNQVNJZHhfUyk7DQorICAgIH0NCiBbLi4uXQ0KfQ0K
DQoNCg0KQFJpY2hhcmQsIHBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHVuZGVyc3Rvb2QgeW91ciBj
b21tZW50IGNvcnJlY3RseT8NCg0KDQpUaGFua3MNClNhbGlsLg0KDQoNCg0KDQoNCg0K

