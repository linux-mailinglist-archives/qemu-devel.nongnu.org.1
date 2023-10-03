Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD67B685E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndz8-0001pJ-3z; Tue, 03 Oct 2023 07:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndz5-0001jq-PF; Tue, 03 Oct 2023 07:54:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndyx-0007y2-If; Tue, 03 Oct 2023 07:54:39 -0400
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0GSn5wnQz6K7Xr;
 Tue,  3 Oct 2023 19:54:17 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:54:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:54:26 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHZ8zQ7yGl3U6l090SRw8cLGCyLZ7A3POkAgAC7TKA=
Date: Tue, 3 Oct 2023 11:54:26 +0000
Message-ID: <25f9cedfb0444e92922de609b5e1028a@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-9-salil.mehta@huawei.com>
 <bc5e5558-8899-30d1-e64a-c1012437766e@redhat.com>
In-Reply-To: <bc5e5558-8899-30d1-e64a-c1012437766e@redhat.com>
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

SGkgR2F2aW4sDQoNCj4gRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgT2N0b2JlciAzLCAyMDIzIDI6MzcgQU0NCj4gVG86IFNhbGlsIE1laHRhIDxz
YWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsg
bHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5q
b25lc0BsaW51eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBl
cmljLmF1Z2VyQHJlZGhhdC5jb207IG9saXZlci51cHRvbkBsaW51eC5kZXY7DQo+IHBib256aW5p
QHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IHJhZmFlbEBrZXJu
ZWwub3JnOw0KPiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBsaW51eEBhcm1saW51eC5vcmcudWs7
DQo+IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBpbGtrYUBvcy5hbXBlcmVjb21wdXRp
bmcuY29tOw0KPiB2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsga2FybC5oZXViYXVtQG9y
YWNsZS5jb207DQo+IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5u
ZXQ7IHpodWtlcWlhbg0KPiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAo
QykgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+Ow0KPiB3YW5neWFuYW4gKFkpIDx3YW5neWFu
YW41NUBodWF3ZWkuY29tPjsgamlha2VybmVsMkBnbWFpbC5jb207DQo+IG1hb2JpYm9AbG9vbmdz
b24uY247IGxpeGlhbmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDA4LzEwXSBwaHlzbWVtOiBBZGQgaGVscGVy
IGZ1bmN0aW9uIHRvIGRlc3Ryb3kgQ1BVDQo+IEFkZHJlc3NTcGFjZQ0KPiANCj4gT24gOS8zMC8y
MyAxMDoxOSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gVmlydHVhbCBDUFUgSG90LXVucGx1ZyBs
ZWFkcyB0byB1bnJlYWxpemF0aW9uIG9mIGEgQ1BVIG9iamVjdC4gVGhpcyBhbHNvDQo+ID4gaW52
b2x2ZXMgZGVzdHJ1Y3Rpb24gb2YgdGhlIENQVSBBZGRyZXNzU3BhY2UuIEFkZCBjb21tb24gZnVu
Y3Rpb24gdG8gaGVscA0KPiA+IGRlc3Ryb3kgdGhlIENQVSBBZGRyZXNzU3BhY2UuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGluY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmggfCAgOCArKysrKysrKw0KPiA+
ICAgaW5jbHVkZS9ody9jb3JlL2NwdS5oICAgICB8ICAxICsNCj4gPiAgIHNvZnRtbXUvcGh5c21l
bS5jICAgICAgICAgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAzIGZpbGVz
IGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvY3B1LWNvbW1vbi5oIGIvaW5jbHVkZS9leGVjL2NwdS1jb21tb24uaA0KPiA+IGluZGV4
IDQxNzg4YzBiZGQuLmViNTZhMjI4YTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9leGVjL2Nw
dS1jb21tb24uaA0KPiA+ICsrKyBiL2luY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmgNCj4gPiBAQCAt
MTIwLDYgKzEyMCwxNCBAQCBzaXplX3QgcWVtdV9yYW1fcGFnZXNpemVfbGFyZ2VzdCh2b2lkKTsN
Cj4gPiAgICAqLw0KPiA+ICAgdm9pZCBjcHVfYWRkcmVzc19zcGFjZV9pbml0KENQVVN0YXRlICpj
cHUsIGludCBhc2lkeCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBj
aGFyICpwcmVmaXgsIE1lbW9yeVJlZ2lvbiAqbXIpOw0KPiA+ICsvKioNCj4gPiArICogY3B1X2Fk
ZHJlc3Nfc3BhY2VfZGVzdHJveToNCj4gPiArICogQGNwdTogQ1BVIGZvciB3aGljaCBhZGRyZXNz
IHNwYWNlIG5lZWRzIHRvIGJlIGRlc3Ryb3llZA0KPiA+ICsgKiBAYXNpZHg6IGludGVnZXIgaW5k
ZXggb2YgdGhpcyBhZGRyZXNzIHNwYWNlDQo+ID4gKyAqDQo+ID4gKyAqIE5vdGUgdGhhdCB3aXRo
IEtWTSBvbmx5IG9uZSBhZGRyZXNzIHNwYWNlIGlzIHN1cHBvcnRlZC4NCj4gPiArICovDQo+ID4g
K3ZvaWQgY3B1X2FkZHJlc3Nfc3BhY2VfZGVzdHJveShDUFVTdGF0ZSAqY3B1LCBpbnQgYXNpZHgp
Ow0KPiA+DQo+ID4gICB2b2lkIGNwdV9waHlzaWNhbF9tZW1vcnlfcncoaHdhZGRyIGFkZHIsIHZv
aWQgKmJ1ZiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgbGVuLCBi
b29sIGlzX3dyaXRlKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9jb3JlL2NwdS5oIGIv
aW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+ID4gaW5kZXggNjQ4YjViMzU4Ni4uNjVkMmFlNDU4MSAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gPiArKysgYi9pbmNsdWRl
L2h3L2NvcmUvY3B1LmgNCj4gPiBAQCAtMzU1LDYgKzM1NSw3IEBAIHN0cnVjdCBDUFVTdGF0ZSB7
DQo+ID4gICAgICAgUVNJTVBMRVFfSEVBRCgsIHFlbXVfd29ya19pdGVtKSB3b3JrX2xpc3Q7DQo+
ID4NCj4gPiAgICAgICBDUFVBZGRyZXNzU3BhY2UgKmNwdV9hc2VzOw0KPiA+ICsgICAgaW50IGNw
dV9hc2VzX2NvdW50Ow0KPiA+ICAgICAgIGludCBudW1fYXNlczsNCj4gPiAgICAgICBBZGRyZXNz
U3BhY2UgKmFzOw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiAqbWVtb3J5Ow0KPiANCj4gQG51bV9h
c2VzIGFuZCBAY3B1X2FzZXNfY291bnQgYXJlIGR1cGxpY2F0ZSB0byBlYWNoIG90aGVyIHRvIHNv
bWUgZXh0ZW50Lg0KPiBUaGUgcmVhbCBwcm9ibGVtIGlzIEBjcHVfYXNlcyBpcyBhbGxvY2F0ZWQg
YXQgb25jZSBhbmQgd2UgbmVlZCB0byBtYWtlIHRoZQ0KPiBhbGxvY2F0aW9uIHNwYXJzZS4gSW4g
dGhhdCB3YXksIGVhY2ggQ1BVIGFkZHJlc3Mgc3BhY2UgaXMgaW5kZXBlbmRlbnQgYW5kIGNhbiBi
ZQ0KPiBkZXN0cm95ZWQgaW5kZXBlbmRlbnRseS4gVGhlIHNwYXJzZSBhbGxvY2F0aW9uIGZvciB0
aGUgQ1BVIGFkZHJlc3Mgc3BhY2UgY2FuIGJlIGRvbmUNCj4gaW4gY3B1X2FkZHJlc3Nfc3BhY2Vf
aW5pdCgpIGxpa2UgYmVsb3c6DQoNCg0KV2VsbCwgSSB0aGluayBQaGlsL1JpY2hhcmQgYXJlIHBv
aW50aW5nIHRvIHNvbWV0aGluZyBlbHNlIGhlcmUgaS5lLiBkZXN0cm95DQphdCBvbmNlLiANCg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC81OTRiMjU1MC05YTczLTY4NGYtNmU1
NC0yOTQwMWRjNmNkN2FAbGluYXJvLm9yZy8NCg0KDQpJIHVzZWQgcmVmZXJlbmNlIGNvdW50ZXIg
YmVjYXVzZSBJIHdhcyBub3Qgc3VyZSBpZiBpdCBpcyBzYWZlIHRvDQphc3N1bWUgdGhhdCBBZGRy
ZXNzU3BhY2Ugd2lsbCBhbHdheXMgYmUgZGVzdHJveWVkIGF0IG9uY2UuDQoNCkJUVywgdGhlcmUg
aXMgbm8gZnVuY3Rpb25hbCBwcm9ibGVtIHdpdGggYWJvdmUgcGF0Y2guIEp1c3QgdGhhdCB3ZQ0K
ZG8gbm90IGhhdmUgdG8gbWFpbnRhaW4gdGhlIHJlZmVyZW5jZSBjb3VudGVyLg0KDQpZb3UgY2Fu
IHVzZSBiZWxvdyBjb21tYW5kIHRvIGNoZWNrIENQVSBtZW1vcnkgYWRkcmVzcyBzcGFjZXMgYXJl
IGdldHRpbmcNCmRlc3Ryb3llZCBwcm9wZXJseSBhbmQgZ2V0IHJlLWNyZWF0ZWQgYWdhaW4gd2l0
aCBDUFUgaG90KHVuKXBsdWc6DQoNClFlbXU+IGluZm8gbXRyZWUNCg0KDQpUaGFua3MNClNhbGls
Lg0KDQoNCg0K

