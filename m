Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E07BF7CD
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9L0-00037h-MR; Tue, 10 Oct 2023 05:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qq9Ky-000372-40; Tue, 10 Oct 2023 05:47:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qq9Kv-00032c-7U; Tue, 10 Oct 2023 05:47:35 -0400
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S4WFn1191z6J9NZ;
 Tue, 10 Oct 2023 17:44:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 10:47:28 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 10 Oct 2023 10:47:28 +0100
To: Shaoqin Huang <shahuang@redhat.com>, "qemu-devel@nongnu.org"
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
Subject: RE: [PATCH RFC V2 03/37] hw/arm/virt: Move setting of common CPU
 properties in a function
Thread-Topic: [PATCH RFC V2 03/37] hw/arm/virt: Move setting of common CPU
 properties in a function
Thread-Index: AQHZ8GEaEyUsIrH+KUCDDRLt+0W0MrBCmYeAgAA5DPA=
Date: Tue, 10 Oct 2023 09:47:28 +0000
Message-ID: <1aa6ddfdb874451a9446d1e6347f60c0@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-4-salil.mehta@huawei.com>
 <3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com>
In-Reply-To: <3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.234]
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

SGkgU2hhb3FpbiwNCg0KPiBGcm9tOiBTaGFvcWluIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEwLCAyMDIzIDc6NDcgQU0NCj4gDQo+IE9uIDkv
MjYvMjMgMTg6MDQsIFNhbGlsIE1laHRhIHZpYSB3cm90ZToNCj4gPiBGYWN0b3Igb3V0IENQVSBw
cm9wZXJ0aWVzIGNvZGUgY29tbW9uIGZvciB7aG90LGNvbGR9LXBsdWdnZWQgQ1BVcy4gVGhpcyBh
bGxvd3MNCj4gPiBjb2RlIHJldXNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vdmlydC5j
ICAgICAgICAgfCAyMjAgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
DQo+ID4gICBpbmNsdWRlL2h3L2FybS92aXJ0LmggfCAgIDQgKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxNDAgaW5zZXJ0aW9ucygrKSwgODQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4gPiBpbmRleCA1N2ZlOTdjMjQy
Li4wZWI2YmY1YTE4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gPiArKysgYi9o
dy9hcm0vdmlydC5jDQo+ID4gQEAgLTIwMTgsMTYgKzIwMTgsMTMwIEBAIHN0YXRpYyB2b2lkIHZp
cnRfY3B1X3Bvc3RfaW5pdChWaXJ0TWFjaGluZVN0YXRlDQo+ICp2bXMsIE1lbW9yeVJlZ2lvbiAq
c3lzbWVtKQ0KPiA+ICAgICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCB2aXJ0
X2NwdV9zZXRfcHJvcGVydGllcyhPYmplY3QgKmNwdW9iaiwgY29uc3QgQ1BVQXJjaElkDQo+ICpj
cHVfc2xvdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKQ0KPiA+ICt7DQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IFRoaXMgcGF0Y2ggc2VlbXMg
YnJlYWsgdGhlIGNvZGUsIHRoZSB2aXJ0X2NwdV9zZXRfcHJvcGVydGllcygpIGZ1bmN0aW9uDQo+
IGJlaW5nIGRlZmluZWQgYnV0IG5vdCB1c2VkIGluIHRoaXMgcGF0Y2gsIHNvIHRob3NlIG9yaWdp
bmFsIGNvZGUgaW4gdGhlDQo+IG1hY2h2aXJ0X2luaXQoKSBqdXN0IG5vdCB3b3JrLg0KDQoNCkdv
b2QgY2F0Y2guIA0KDQpCVFcsIHRoZSBjaGFuZ2UgaW4gdGhpcyBwYXRjaCBpcyBpbnRlbnRpb25h
bCBhcyBJIHdhbnRlZCB0byBjbGVhcmx5IHNob3cNCnRoZSBtb3ZlLiBCdXQgSSB3aWxsIGZpeCB0
aGUgY29tcGlsYXRpb24gYnJlYWsgaW4gdGhpcyBwYXRjaCB3aXRoIHNvbWUNCnRyaWNrLg0KDQpU
aGFua3MgZm9yIGlkZW50aWZ5aW5nIQ0KU2FsaWwuDQoNCg0KPiBXZSBzaG91bGQgdXNlIHRoaXMg
ZnVuY3Rpb24gaW4gdGhlIG1hY2h2aXJ0X2luaXQoKS4NCj4gDQo+ID4gKyAgICBNYWNoaW5lU3Rh
dGUgKm1zID0gTUFDSElORShxZGV2X2dldF9tYWNoaW5lKCkpOw0KPiA+ICsgICAgVmlydE1hY2hp
bmVTdGF0ZSAqdm1zID0gVklSVF9NQUNISU5FKG1zKTsNCj4gPiArICAgIEVycm9yICpsb2NhbF9l
cnIgPSBOVUxMOw0KPiA+ICsgICAgVmlydE1hY2hpbmVDbGFzcyAqdm1jOw0KPiA+ICsNCj4gPiAr
ICAgIHZtYyA9IFZJUlRfTUFDSElORV9HRVRfQ0xBU1MobXMpOw0KPiA+ICsNCj4gPiArICAgIC8q
IG5vdywgc2V0IHRoZSBjcHUgb2JqZWN0IHByb3BlcnR5IHZhbHVlcyAqLw0KPiA+ICsgICAgbnVt
YV9jcHVfcHJlX3BsdWcoY3B1X3Nsb3QsIERFVklDRShjcHVvYmopLCAmbG9jYWxfZXJyKTsNCj4g
PiArICAgIGlmIChsb2NhbF9lcnIpIHsNCj4gPiArICAgICAgICBnb3RvIG91dDsNCj4gPiArICAg
IH0NCj4gPiArDQo+ID4gKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChjcHVvYmosICJtcC1h
ZmZpbml0eSIsIGNwdV9zbG90LT5hcmNoX2lkLCBOVUxMKTsNCj4gPiArDQoNClsuLi5dDQoNCj4g
PiArICAgIC8qDQo+ID4gKyAgICAgKiBSRkM6IFF1ZXN0aW9uOiB0aGlzIG11c3Qgb25seSBiZSBj
YWxsZWQgZm9yIHRoZSBob3RwbHVnZ2VkIGNwdXMuIEZvciB0aGUNCj4gPiArICAgICAqIGNvbGQg
Ym9vdGVkIHNlY29uZGFyeSBjcHVzIHRoaXMgaXMgYmVpbmcgdGFrZW4gY2FyZSBpbiBhcm1fbG9h
ZF9rZXJuZWwoKQ0KPiA+ICsgICAgICogaW4gYm9vdC5jLiBQZXJoYXBzIHdlIHNob3VsZCByZW1v
dmUgdGhhdCBjb2RlIG5vdz8NCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKHZtcy0+cHNjaV9j
b25kdWl0ICE9IFFFTVVfUFNDSV9DT05EVUlUX0RJU0FCTEVEKSB7DQo+ID4gKyAgICAgICAgb2Jq
ZWN0X3Byb3BlcnR5X3NldF9pbnQoY3B1b2JqLCAicHNjaS1jb25kdWl0Iiwgdm1zLT5wc2NpX2Nv
bmR1aXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgIC8qIFNlY29uZGFyeSBDUFVzIHN0YXJ0IGluIFBTQ0kgcG93ZXJlZC1k
b3duIHN0YXRlICovDQo+ID4gKyAgICAgICAgaWYgKENQVShjcHVvYmopLT5jcHVfaW5kZXggPiAw
KSB7DQo+ID4gKyAgICAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChjcHVvYmosICJz
dGFydC1wb3dlcmVkLW9mZiIsIHRydWUsIE5VTEwpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAg
IH0NCj4gDQo+IEJlc2lkZXMsIGlmIHRoaXMgcGF0Y2ggaXMganVzdCBmYWN0b3Igb3V0IHRoZSBj
b2RlLCB3ZSBjb3VsZCBtb3ZlIHRoZQ0KPiBjaGVjayBwc2NpX2NvbmR1aXQgdG8gbGF0ZXIgcGF0
Y2gsIGFuZCBrZWVwIHRoaXMgcGF0Y2ggY2xlYW4uDQoNCkkgZG8gbm90IHNlZSB0aGUgcmVhc29u
IHdoeSB3ZSBzaG91bGQgZG8gdGhhdD8NCg0KDQpUaGFua3MNClNhbGlsLg0KDQoNCg==

