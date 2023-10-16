Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEDA7CB592
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVPz-0001f0-Sx; Mon, 16 Oct 2023 17:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVPy-0001eO-26; Mon, 16 Oct 2023 17:46:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVPw-0005Za-AQ; Mon, 16 Oct 2023 17:46:29 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8VxM3MWhz6K6K4;
 Tue, 17 Oct 2023 05:44:07 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 22:46:25 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 22:46:25 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
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
Subject: RE: [PATCH RFC V2 14/37] arm/virt: Add cpu hotplug events to GED
 during creation
Thread-Topic: [PATCH RFC V2 14/37] arm/virt: Add cpu hotplug events to GED
 during creation
Thread-Index: AQHZ8GGUCDZ7UAtL0E+Up3q+ynu+4LAvXa2AgB21lfA=
Date: Mon, 16 Oct 2023 21:46:24 +0000
Message-ID: <f6508f4d86424959b72b8faa423e95a0@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-15-salil.mehta@huawei.com>
 <1e526a50-7001-a15b-79cb-e223048b52ce@redhat.com>
In-Reply-To: <1e526a50-7001-a15b-79cb-e223048b52ce@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.41]
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
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyOCwgMjAyMyAyOjA0IEFNDQo+IFRvOiBTYWxpbCBNZWh0
YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1h
cm1Abm9uZ251Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsg
bHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5q
b25lc0BsaW51eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBl
cmljLmF1Z2VyQHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgYXJkYkBrZXJuZWwub3JnOw0K
PiBvbGl2ZXIudXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0
LmNvbTsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb207IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgZGFycmVuQG9z
LmFtcGVyZWNvbXB1dGluZy5jb207DQo+IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IHZp
c2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsg
bWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsNCj4gemh1a2Vx
aWFuIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKQ0KPiA8d2FuZ3hp
b25nZmVuZzJAaHVhd2VpLmNvbT47IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5j
b20+Ow0KPiBqaWFrZXJuZWwyQGdtYWlsLmNvbTsgbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFu
Z2xhaUBsb29uZ3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAxNC8zN10gYXJt
L3ZpcnQ6IEFkZCBjcHUgaG90cGx1ZyBldmVudHMgdG8gR0VEDQo+IGR1cmluZyBjcmVhdGlvbg0K
PiANCj4gSGkgU2FsaWwsDQo+IA0KPiBPbiA5LzI2LzIzIDIwOjA0LCBTYWxpbCBNZWh0YSB3cm90
ZToNCj4gPiBBZGQgQ1BVIEhvdHBsdWcgZXZlbnQgdG8gdGhlIHNldCBvZiBzdXBwb3J0ZWQgZ2Vk
LWV2ZW50cyBkdXJpbmcgdGhlIGNyZWF0aW9uIG9mDQo+ID4gR0VEIGRldmljZSBkdXJpbmcgVk0g
aW5pdC4gQWxzbyBpbml0aWFsaXplIHRoZSBtZW1vcnkgbWFwIGZvciBDUFUgSG90cGx1Zw0KPiAg
ICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eDQo+ICAgICAgICAgICAgICAgaXQgY2FuIGJlIGRy
b3BwZWQuDQoNCk9rIDopDQoNCj4gPiBjb250cm9sIGRldmljZSB1c2VkIGluIGV2ZW50IGV4Y2hh
bmdlcyBiZXR3ZWVuIFFlbXUvVk1NIGFuZCB0aGUgZ3Vlc3QuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGh3L2FybS92aXJ0LmMgICAgICAgICB8IDUgKysrKy0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL3Zp
cnQuaCB8IDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiANCj4gVGhlIGNoYW5nZXMgbG9vayBnb29kIHRvIG1lOg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQoNCg0KR3JlYXQuIFRo
YW5rcw0KDQpjaGVlcnMNClNhbGlsLg0KDQo=

