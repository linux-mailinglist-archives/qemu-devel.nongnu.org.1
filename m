Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9817B7D81
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzQm-0003dU-Mb; Wed, 04 Oct 2023 06:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnzQk-0003dF-5X; Wed, 04 Oct 2023 06:48:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnzQh-0002Gv-7R; Wed, 04 Oct 2023 06:48:37 -0400
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0rwG6HVCz6K67l;
 Wed,  4 Oct 2023 18:46:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 4 Oct 2023 11:48:17 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 4 Oct 2023 11:48:17 +0100
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
Thread-Index: AQHZ8zQ7yGl3U6l090SRw8cLGCyLZ7A3POkAgAI4RuA=
Date: Wed, 4 Oct 2023 10:48:17 +0000
Message-ID: <81113790e5ae41b792cef94024c27d38@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-9-salil.mehta@huawei.com>
 <bc5e5558-8899-30d1-e64a-c1012437766e@redhat.com>
In-Reply-To: <bc5e5558-8899-30d1-e64a-c1012437766e@redhat.com>
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

SGkgR2F2aW4sDQpSZXZpc2l0ZWQgeW91ciBjb21tZW50cyBhZ2Fpbi4NCg0KPiBGcm9tOiBHYXZp
biBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMsIDIw
MjMgMjozNyBBTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25nbnUub3JnDQo+IENjOiBtYXpA
a2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+
IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsN
Cj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVk
aGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xp
dmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5j
b207IHdpbGxAa2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFsZXguYmVubmVlQGxp
bmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1
dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBl
cmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNA
b3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1a2VxaWFuDQo+IDx6aHVrZXFp
YW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2Vp
LmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJu
ZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nv
bi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjIgMDgvMTBdIHBoeXNtZW06IEFkZCBoZWxwZXIgZnVuY3Rpb24gdG8gZGVzdHJveSBDUFUN
Cj4gQWRkcmVzc1NwYWNlDQo+IA0KPiBPbiA5LzMwLzIzIDEwOjE5LCBTYWxpbCBNZWh0YSB3cm90
ZToNCj4gPiBWaXJ0dWFsIENQVSBIb3QtdW5wbHVnIGxlYWRzIHRvIHVucmVhbGl6YXRpb24gb2Yg
YSBDUFUgb2JqZWN0LiBUaGlzIGFsc28NCj4gPiBpbnZvbHZlcyBkZXN0cnVjdGlvbiBvZiB0aGUg
Q1BVIEFkZHJlc3NTcGFjZS4gQWRkIGNvbW1vbiBmdW5jdGlvbiB0byBoZWxwDQo+ID4gZGVzdHJv
eSB0aGUgQ1BVIEFkZHJlc3NTcGFjZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9leGVj
L2NwdS1jb21tb24uaCB8ICA4ICsrKysrKysrDQo+ID4gICBpbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
ICAgIHwgIDEgKw0KPiA+ICAgc29mdG1tdS9waHlzbWVtLmMgICAgICAgICB8IDI1ICsrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmggYi9pbmNs
dWRlL2V4ZWMvY3B1LWNvbW1vbi5oDQo+ID4gaW5kZXggNDE3ODhjMGJkZC4uZWI1NmEyMjhhMiAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2V4ZWMvY3B1LWNvbW1vbi5oDQo+ID4gKysrIGIvaW5j
bHVkZS9leGVjL2NwdS1jb21tb24uaA0KPiA+IEBAIC0xMjAsNiArMTIwLDE0IEBAIHNpemVfdCBx
ZW11X3JhbV9wYWdlc2l6ZV9sYXJnZXN0KHZvaWQpOw0KPiA+ICAgICovDQo+ID4gICB2b2lkIGNw
dV9hZGRyZXNzX3NwYWNlX2luaXQoQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnByZWZpeCwgTWVtb3J5UmVnaW9u
ICptcik7DQo+ID4gKy8qKg0KPiA+ICsgKiBjcHVfYWRkcmVzc19zcGFjZV9kZXN0cm95Og0KPiA+
ICsgKiBAY3B1OiBDUFUgZm9yIHdoaWNoIGFkZHJlc3Mgc3BhY2UgbmVlZHMgdG8gYmUgZGVzdHJv
eWVkDQo+ID4gKyAqIEBhc2lkeDogaW50ZWdlciBpbmRleCBvZiB0aGlzIGFkZHJlc3Mgc3BhY2UN
Cj4gPiArICoNCj4gPiArICogTm90ZSB0aGF0IHdpdGggS1ZNIG9ubHkgb25lIGFkZHJlc3Mgc3Bh
Y2UgaXMgc3VwcG9ydGVkLg0KPiA+ICsgKi8NCj4gPiArdm9pZCBjcHVfYWRkcmVzc19zcGFjZV9k
ZXN0cm95KENQVVN0YXRlICpjcHUsIGludCBhc2lkeCk7DQo+ID4NCj4gPiAgIHZvaWQgY3B1X3Bo
eXNpY2FsX21lbW9yeV9ydyhod2FkZHIgYWRkciwgdm9pZCAqYnVmLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGh3YWRkciBsZW4sIGJvb2wgaXNfd3JpdGUpOw0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L2NvcmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4g
PiBpbmRleCA2NDhiNWIzNTg2Li42NWQyYWU0NTgxIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
aHcvY29yZS9jcHUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiA+IEBAIC0z
NTUsNiArMzU1LDcgQEAgc3RydWN0IENQVVN0YXRlIHsNCj4gPiAgICAgICBRU0lNUExFUV9IRUFE
KCwgcWVtdV93b3JrX2l0ZW0pIHdvcmtfbGlzdDsNCj4gPg0KPiA+ICAgICAgIENQVUFkZHJlc3NT
cGFjZSAqY3B1X2FzZXM7DQo+ID4gKyAgICBpbnQgY3B1X2FzZXNfY291bnQ7DQo+ID4gICAgICAg
aW50IG51bV9hc2VzOw0KPiA+ICAgICAgIEFkZHJlc3NTcGFjZSAqYXM7DQo+ID4gICAgICAgTWVt
b3J5UmVnaW9uICptZW1vcnk7DQo+IA0KPiBAbnVtX2FzZXMgYW5kIEBjcHVfYXNlc19jb3VudCBh
cmUgZHVwbGljYXRlIHRvIGVhY2ggb3RoZXIgdG8gc29tZSBleHRlbnQuDQo+IFRoZQ0KPiByZWFs
IHByb2JsZW0gaXMgQGNwdV9hc2VzIGlzIGFsbG9jYXRlZCBhdCBvbmNlIGFuZCB3ZSBuZWVkIHRv
IG1ha2UgdGhlDQo+IGFsbG9jYXRpb24NCj4gc3BhcnNlLiBJbiB0aGF0IHdheSwgZWFjaCBDUFUg
YWRkcmVzcyBzcGFjZSBpcyBpbmRlcGVuZGVudCBhbmQgY2FuIGJlDQo+IGRlc3Ryb3llZA0KPiBp
bmRlcGVuZGVudGx5Lg0KDQoocmV2aXNpdGluZyB0aGlzIGNvbW1lbnQgaS5lLiAnc3BhcnNlJykN
Cg0KSWYgeW91IG1lYW50LCB0aGUgb3JkZXIgb2YgaW5pdGlhbGl6YXRpb24gYW5kIGRlc3RydWN0
aW9uIG1pZ2h0IG5vdCBiZSBzYW1lDQp0aGVuIHllcywgQWRkcmVzc1NwYWNlIGNhbiBiZSAqY29u
ZGl0aW9uYWxseSogYWxsb2NhdGVkIGR1cmluZyBDUFUgcmVhbGl6YXRpb24NCnBoYXNlIGFuZCBz
aG91bGQgYmUgKmNvbmRpdGlvbmFsbHkqIGRlc3Ryb3llZCBhcyB3ZWxsIGR1cmluZyBDUFUNCnVu
LXJlYWxpemF0aW9uIHBoYXNlLiBMYXRlciBtZWFucywgaXQgaXMgbm90IHNhZmUgdG8gYXNzdW1l
IHRoYXQgaW5kZXhlcyB0bw0KdGhlIGFycmF5IG9mIEFkZHJlc3NTcGFjZSBtaWdodCBiZSBjb25z
ZWN1dGl2ZS4gSGVuY2UsIHRoZWlyIGRlc3RydWN0aW9uDQphdCBvbmNlIGNhbiBjcmVhdGUgcHJv
YmxlbXMuIA0KDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMzA5MjYx
MDA0MzYuMjgyODQtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tL1QvI200NGI4MWZiYmJhMzNhMzQ2
ZGQyMjkyMjU2MDEyZjg2ZWY3YzhlNzYxDQoNCg0KDQogVGhlIHNwYXJzZSBhbGxvY2F0aW9uIGZv
ciB0aGUgQ1BVIGFkZHJlc3Mgc3BhY2UgY2FuIGJlIGRvbmUNCj4gaW4NCj4gY3B1X2FkZHJlc3Nf
c3BhY2VfaW5pdCgpIGxpa2UgYmVsb3c6DQo+IA0KPiAjZGVmaW5lIENQVV9BRERSRVNTX1NQQUNF
X01BWCA4DQo+IA0KPiBzdHJ1Y3QgQ1BVU3RhdGUgew0KPiAgICAgIENQVUFkZHJlc3NTcGFjZSAq
Y3B1X2FzZXNbQ1BVX0FERFJFU1NfU1BBQ0VfTUFYXTsNCj4gfQ0KDQpZZXMsIHRoaXMgd2lsbCBh
bHNvIHdvcmsgYnV0IHdlIHdpbGwgZW5kIHVwIHJlZmFjdG9yaW5nDQpleGlzdGluZyBpbml0aWFs
aXphdGlvbiBpbnRlcmZhY2UuIERvIHdlIHJlcXVpcmUgYWxsIG9mIHRoaXMNCndoZW4gY291bnRl
ciBiYXNlZCBhcHByb2FjaCBhbHNvIHdvcmtzIHdpdGhvdXQgY2hhbmdpbmcNCmFueXRoaW5nPw0K
DQoNClRoYW5rcw0KU2FsaWwuDQo=

