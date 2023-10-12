Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AB7C696A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqruJ-0006ry-HG; Thu, 12 Oct 2023 05:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqruH-0006rF-Qj; Thu, 12 Oct 2023 05:23:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqruG-0004gv-6Z; Thu, 12 Oct 2023 05:23:01 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5kcP4Ss0z688d6;
 Thu, 12 Oct 2023 17:19:49 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 10:22:54 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Thu, 12 Oct 2023 10:22:54 +0100
To: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
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
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V5 8/9] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V5 8/9] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHZ/Hu2W97dHDuZJkS1Rvdlsfl3xbBFLG+AgAAJLgCAAAPWAIAAqJuQ
Date: Thu, 12 Oct 2023 09:22:54 +0000
Message-ID: <4ffab3f51cb4460bb36d4c923e3c3c9a@huawei.com>
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-9-salil.mehta@huawei.com>
 <69098d56-8b68-2734-ef40-7338386d7fa9@redhat.com>
 <e73217f7-e6c2-81e7-0174-54ef575ebbce@opnsrc.net>
 <b8c13adb-ce1e-41fc-daa0-4aa31bf5f7a0@redhat.com>
In-Reply-To: <b8c13adb-ce1e-41fc-daa0-4aa31bf5f7a0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.158]
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
T2N0b2JlciAxMiwgMjAyMyAxOjE4IEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFA
b3Buc3JjLm5ldD47IFNhbGlsIE1laHRhDQo+IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVs
Lm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1h
bW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNv
bTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVw
dG9uQGxpbnV4LmRldjsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHdp
bGxAa2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFsZXguYmVubmVlQGxpbmFyby5v
cmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5j
b207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVjb21w
dXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3JhY2xl
LmNvbTsgemh1a2VxaWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nDQo+
IChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5h
bjU1QGh1YXdlaS5jb20+Ow0KPiBqaWFrZXJuZWwyQGdtYWlsLmNvbTsgbWFvYmlib0Bsb29uZ3Nv
bi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdl
aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgOC85XSBwaHlzbWVtOiBBZGQgaGVscGVy
IGZ1bmN0aW9uIHRvIGRlc3Ryb3kgQ1BVDQo+IEFkZHJlc3NTcGFjZQ0KPiANCj4gSGkgU2FsaWws
DQo+IA0KPiBPbiAxMC8xMi8yMyAxMDowNCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gT24gMTIv
MTAvMjAyMyAwMDozMSwgR2F2aW4gU2hhbiB3cm90ZToNCj4gPj4gT24gMTAvMTIvMjMgMDU6NDMs
IFNhbGlsIE1laHRhIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+PiArdm9pZCBjcHVfYWRk
cmVzc19zcGFjZV9kZXN0cm95KENQVVN0YXRlICpjcHUsIGludCBhc2lkeCkNCj4gPj4+ICt7DQo+
ID4+PiArwqDCoMKgIENQVUFkZHJlc3NTcGFjZSAqY3B1YXM7DQo+ID4+PiArDQo+ID4+PiArwqDC
oMKgIGFzc2VydChhc2lkeCA8IGNwdS0+bnVtX2FzZXMpOw0KPiA+Pj4gK8KgwqDCoCBhc3NlcnQo
YXNpZHggPT0gMCB8fCAha3ZtX2VuYWJsZWQoKSk7DQo+ID4+PiArwqDCoMKgIGFzc2VydChjcHUt
PmNwdV9hc2VzKTsNCj4gPj4+ICsNCj4gPj4NCj4gPj4gVGhlIHR3byBhc3NlcnRzIG9uIEBhc2lk
eCBhbmQgQGNwdS0+Y3B1X2FzZXMgY2FuIGJlIGNvbWJpbmVkDQo+ID4+IHRvIG9uZSBzbyB0aGF0
IHRoZXNlIDMgYXNzZXJ0cyBjYW4gYmUgY29tYmluZWQgdG8gdHdvLg0KPiA+Pg0KPiA+PiDCoMKg
wqDCoMKgwqDCoCAvKiBPbmx5IG9uZSBhZGRyZXNzIHNwYWNlIGlzIHN1cHBvcnRlZCBieSBLVk0g
Ki8NCj4gPj4gwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KGFzaWR4ID09IDAgfHwgIWt2bV9lbmFibGVk
KCkpOw0KPiA+PiDCoMKgwqDCoMKgwqDCoCBhc3NlcnQoYXNpZHggPj0gMCAmJiBhc2lkeCA8IGNw
dS0+Y3B1X2FzZXNfY291bnQpDQo+ID4NCj4gPiBXZSBjYW4gZG8gdGhhdC4NCj4gPg0KPiA+IEkg
YW0gbm90IGluIGZhdm9yIHRvIHJlbW92ZcKgICdhc3NlcnQoY3B1LT5jcHVfYXNlcyk7JyBhcyB0
aGlzIGNhbiBzYXZlDQo+IGxvdCBvZiBkZWJ1Z2dpbmcuDQo+ID4NCj4gDQo+IE9rLCBJdCdzIGZp
bmUgdG8ga2VlcCAnYXNzZXJ0KGNwdS0+Y3B1X2FzZXMpJywgYnV0ICdhc3NlcnQoYXNpZHggPj0g
MCknIGlzDQo+IHN0aWxsIG5lZWRlZD8gRm9yIGV4YW1wbGUsIHRoZSB3cm9uZyBjaHVuayBvZiBt
ZW1vcnkgd2lsbCBiZSByZWxlYXNlIHdoZW4NCj4gQGFzaWR4IGlzIHNtYWxsZXIgdGhhbiB6ZXJv
LCB3aGljaCBpcyBvdXQtb2YtYm91bmQgdG8gQGNwdS0+Y3B1X2FzZXNbXQ0KDQpZZXMsIG9mIGNv
dXJzZSwgd2UgY2FuIGtlZXAgdGhhdC4NCg0KVGhhbmtzDQpTYWxpbC4NCg0K

