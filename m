Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D37B664B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncYU-0001fV-04; Tue, 03 Oct 2023 06:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qncYR-0001fI-UQ; Tue, 03 Oct 2023 06:23:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qncYP-0005ri-Cd; Tue, 03 Oct 2023 06:23:03 -0400
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0DN526DSz6HJbn;
 Tue,  3 Oct 2023 18:20:05 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 11:22:45 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 11:22:45 +0100
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
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
Thread-Index: AQHZ8GJOJm4BpzZJyEy2op+9dP4UprA3lZiAgABOcdA=
Date: Tue, 3 Oct 2023 10:22:44 +0000
Message-ID: <7e02ed766bd54b7184e349611e61cf12@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-32-salil.mehta@huawei.com>
 <b71a91cc-a0fe-230b-f895-e163b37be157@linaro.org>
In-Reply-To: <b71a91cc-a0fe-230b-f895-e163b37be157@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.138]
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

SGkgUGhpbCwNCg0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMywgMjAyMyA3OjM0IEFNDQo+IFRvOiBT
YWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmcNCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqZWFuLXBo
aWxpcHBlQGxpbmFyby5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT47IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBpbWFtbWVkb0ByZWRoYXQu
Y29tOyBhbmRyZXcuam9uZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOw0KPiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgYXJkYkBrZXJuZWwub3JnOw0KPiBvbGl2
ZXIudXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsN
Cj4gZ3NoYW5AcmVkaGF0LmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7IGJvcm50cmFlZ2VyQGxpbnV4
LmlibS5jb207DQo+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1
dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1A
b3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3Jj
Lm5ldDsgemh1a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5n
IChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5
YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29u
Z3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJG
QyBWMiAzMS8zN10gcGh5c21lbSxnZGJzdHViOiBDb21tb24gaGVscGluZw0KPiBmdW5jcy9jaGFu
Z2VzIHRvICp1bnJlYWxpemUqIHZDUFUNCj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gMjYvOS8y
MyAxMjowNCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gU3VwcG9ydGluZyB2Q1BVIEhvdHBsdWcg
Zm9yIEFSTSBhcmNoIGFsc28gbWVhbnMgaW50cm9kdWNpbmcgbmV3DQo+IGZ1bmN0aW9uYWxpdHkg
b2YNCj4gPiB1bnJlYWxpemluZyB0aGUgQVJNQ1BVLiBUaGlzIHJlcXVpcmVzIHNvbWUgbmV3IGNv
bW1vbiBmdW5jdGlvbnMuDQo+ID4NCj4gPiBEZWZpbmluZyB0aGVtIGFzIHBhcnQgb2YgYXJjaGl0
ZWN0dXJlIGluZGVwZW5kZW50IGNoYW5nZSBzbyB0aGF0IHRoaXMNCj4gY29kZSBjb3VsZA0KPiA+
IGJlIHJldXNlZCBieSBvdGhlciBpbnRlcmVzdGVkIHBhcnRpZXMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gICBp
bmNsdWRlL2V4ZWMvY3B1LWNvbW1vbi5oIHwgIDggKysrKysrKysNCj4gPiAgIGluY2x1ZGUvZXhl
Yy9nZGJzdHViLmggICAgfCAgMSArDQo+ID4gICBpbmNsdWRlL2h3L2NvcmUvY3B1LmggICAgIHwg
IDEgKw0KPiA+ICAgc29mdG1tdS9waHlzbWVtLmMgICAgICAgICB8IDI1ICsrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgIDUgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY29yZS9jcHUuaCBiL2luY2x1ZGUvaHcv
Y29yZS9jcHUuaA0KPiA+IGluZGV4IGRhYjU3MmM5YmQuLmZmZDgxNWEwZDggMTAwNjQ0DQo+ID4g
LS0tIGEvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9jb3JlL2Nw
dS5oDQo+ID4gQEAgLTM2Niw2ICszNjYsNyBAQCBzdHJ1Y3QgQ1BVU3RhdGUgew0KPiA+ICAgICAg
IFFTSU1QTEVRX0hFQUQoLCBxZW11X3dvcmtfaXRlbSkgd29ya19saXN0Ow0KPiA+DQo+ID4gICAg
ICAgQ1BVQWRkcmVzc1NwYWNlICpjcHVfYXNlczsNCj4gPiArICAgIGludCBjcHVfYXNlc19yZWZf
Y291bnQ7DQo+ID4gICAgICAgaW50IG51bV9hc2VzOw0KPiA+ICAgICAgIEFkZHJlc3NTcGFjZSAq
YXM7DQo+ID4gICAgICAgTWVtb3J5UmVnaW9uICptZW1vcnk7DQo+ID4gZGlmZiAtLWdpdCBhL3Nv
ZnRtbXUvcGh5c21lbS5jIGIvc29mdG1tdS9waHlzbWVtLmMNCj4gPiBpbmRleCAzZGY3MzU0MmUx
Li5hOTNhZTc4M2FmIDEwMDY0NA0KPiA+IC0tLSBhL3NvZnRtbXUvcGh5c21lbS5jDQo+ID4gKysr
IGIvc29mdG1tdS9waHlzbWVtLmMNCj4gPiBAQCAtNzYyLDYgKzc2Miw3IEBAIHZvaWQgY3B1X2Fk
ZHJlc3Nfc3BhY2VfaW5pdChDUFVTdGF0ZSAqY3B1LCBpbnQgYXNpZHgsDQo+ID4NCj4gPiAgICAg
ICBpZiAoIWNwdS0+Y3B1X2FzZXMpIHsNCj4gPiAgICAgICAgICAgY3B1LT5jcHVfYXNlcyA9IGdf
bmV3MChDUFVBZGRyZXNzU3BhY2UsIGNwdS0+bnVtX2FzZXMpOw0KPiA+ICsgICAgICAgIGNwdS0+
Y3B1X2FzZXNfcmVmX2NvdW50ID0gY3B1LT5udW1fYXNlczsNCj4gPiAgICAgICB9DQo+ID4NCj4g
PiAgICAgICBuZXdhcyA9ICZjcHUtPmNwdV9hc2VzW2FzaWR4XTsNCj4gPiBAQCAtNzc1LDYgKzc3
NiwzMCBAQCB2b2lkIGNwdV9hZGRyZXNzX3NwYWNlX2luaXQoQ1BVU3RhdGUgKmNwdSwgaW50DQo+
IGFzaWR4LA0KPiA+ICAgICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+ICt2b2lkIGNwdV9hZGRyZXNz
X3NwYWNlX2Rlc3Ryb3koQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4KQ0KPiA+ICt7DQo+ID4gKyAg
ICBDUFVBZGRyZXNzU3BhY2UgKmNwdWFzOw0KPiA+ICsNCj4gPiArICAgIGFzc2VydChhc2lkeCA8
IGNwdS0+bnVtX2FzZXMpOw0KPiA+ICsgICAgYXNzZXJ0KGFzaWR4ID09IDAgfHwgIWt2bV9lbmFi
bGVkKCkpOw0KPiA+ICsgICAgYXNzZXJ0KGNwdS0+Y3B1X2FzZXMpOw0KPiA+ICsNCj4gPiArICAg
IGNwdWFzID0gJmNwdS0+Y3B1X2FzZXNbYXNpZHhdOw0KPiA+ICsgICAgaWYgKHRjZ19lbmFibGVk
KCkpIHsNCj4gPiArICAgICAgICBtZW1vcnlfbGlzdGVuZXJfdW5yZWdpc3RlcigmY3B1YXMtPnRj
Z19hc19saXN0ZW5lcik7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgYWRkcmVzc19zcGFj
ZV9kZXN0cm95KGNwdWFzLT5hcyk7DQo+ID4gKyAgICBnX2ZyZWVfcmN1KGNwdWFzLT5hcywgcmN1
KTsNCj4gPiArDQo+ID4gKyAgICBpZiAoY3B1LT5jcHVfYXNlc19yZWZfY291bnQgPT0gMSkgew0K
PiA+ICsgICAgICAgIGdfZnJlZShjcHUtPmNwdV9hc2VzKTsNCj4gPiArICAgICAgICBjcHUtPmNw
dV9hc2VzID0gTlVMTDsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBjcHUtPmNwdV9hc2Vz
X3JlZl9jb3VudC0tOw0KPiANCj4gU2VlIFJpY2hhcmQgY29tbWVudCBmcm9tOg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzU5NGIyNTUwLTlhNzMtNjg0Zi02ZTU0LQ0KPiAy
OTQwMWRjNmNkN2FAbGluYXJvLm9yZy8NCj4gDQo+ICJJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRl
ciB0byBkZXN0cm95IGFsbCBhZGRyZXNzIHNwYWNlcyBhdCBvbmNlLA0KPiAic28gdGhhdCB5b3Ug
ZG9uJ3QgbmVlZCAgdG8gaW52ZW50IGEgcmVmZXJlbmNlIGNvdW50IHRoYXQgaXNuJ3QgdXNlZA0K
PiAiZm9yIGFueXRoaW5nIGVsc2UuDQoNClllcywgd2UgY2FuIGRvIHRoYXQgYW5kIHJlbW92ZSB0
aGUgcmVmZXJlbmNlIGNvdW50LiBUaGUgb25seSByZWFzb24gSQ0KZGlkIGl0IHdhcyBiZWNhdXNl
IEkgd2FzIG5vdCBzdXJlIGlmIGl0IGlzIHNhZmUgdG8gYXNzdW1lIHRoYXQgYWxsDQp0aGUgQWRk
cmVzc1NwYWNlIHdpbGwgYWx3YXlzIGJlIGRlc3Ryb3llZCAqdG9nZXRoZXIqLiBBbmQgbm93IHNp
bmNlDQp0aGlzIGlzIGJlaW5nIHBvcnRlZCB0byBvdGhlciBhcmNoaXRlY3R1cmVzIHdpbGwgdGhl
IHNhbWUgaG9sZA0KdHJ1ZSBldmVyeXdoZXJlPw0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0K

