Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436367B373B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmFis-0005ua-33; Fri, 29 Sep 2023 11:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qmFie-0005nm-Cm; Fri, 29 Sep 2023 11:47:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qmFiZ-00085a-N9; Fri, 29 Sep 2023 11:47:55 -0400
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rxvqz6rKcz6883d;
 Fri, 29 Sep 2023 23:47:43 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 29 Sep 2023 16:47:47 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Fri, 29 Sep 2023 16:47:47 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Subject: RE: [PATCH 3/9] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Topic: [PATCH 3/9] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Index: AQHZ8tLV3eHQepx06kOPyVlwR+5phbAxy7uAgAAgxjA=
Date: Fri, 29 Sep 2023 15:47:47 +0000
Message-ID: <00cb5ebaa2a246529a9095b5f7d185b4@huawei.com>
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-4-salil.mehta@huawei.com> <87y1gpnjf9.fsf@linaro.org>
In-Reply-To: <87y1gpnjf9.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.153]
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

PiBGcm9tOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDI5LCAyMDIzIDM6MjcgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFy
bUBub25nbnUub3JnOyBtYXpAa2VybmVsLm9yZzsgamVhbi0NCj4gcGhpbGlwcGVAbGluYXJvLm9y
ZzsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+IHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc7IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0Bs
aW51eC5kZXY7DQo+IGRhdmlkQHJlZGhhdC5jb207IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1
Z2VyQHJlZGhhdC5jb207DQo+IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhh
dC5jb207IG1zdEByZWRoYXQuY29tOw0KPiB3aWxsQGtlcm5lbC5vcmc7IGdzaGFuQHJlZGhhdC5j
b207IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhcnJlbkBv
cy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyB2
aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4ga2FybC5oZXViYXVtQG9yYWNsZS5jb207
IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7DQo+IHpodWtl
cWlhbiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4
aW9uZ2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWku
Y29tPjsNCj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlh
bmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvOV0gaHcvYWNwaTogQWRkIEFDUEkgQ1BVIGhvdHBsdWcgaW5p
dCBzdHViDQo+IA0KPiANCj4gU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdy
aXRlczoNCj4gDQo+ID4gQUNQSSBDUFUgaG90cGx1ZyByZWxhdGVkIGluaXRpYWxpemF0aW9uIHNo
b3VsZCBvbmx5IGhhcHBlbiBpZiBBQ1BJX0NQVV9IT1RQTFVHDQo+ID4gc3VwcG9ydCBoYXMgYmVl
biBlbmFibGVkIGZvciBwYXJ0aWN1bGFyIGFyY2hpdGVjdHVyZS4gQWRkIGNwdV9ob3RwbHVnX2h3
X2luaXQoKQ0KPiA+IHN0dWIgdG8gYXZvaWQgY29tcGlsYXRpb24gYnJlYWsuDQo+IA0KPiBXaGVu
IGRvZXMgdGhlIGNvbXBpbGF0aW9uIGJyZWFrPyBJdCdzIHVzdWFsbHkgb2sgdG8gaW5jbHVkZSBz
dHVicyB3aXRoDQo+IHRoYXQgY29tbWl0Lg0KDQoNClRvIGJlIHNwZWNpZmljLiBpdCBpcyBub3Qg
YSBjb21waWxhdGlvbiBicmVhayBidXQgbGlua2luZyBlcnJvci4NCg0KU3VwcG9ydCBvZiBBQ1BJ
X0NQVV9IT1RQTFVHIGlzIG9wdGlvbmFsLiBUaGlzIGZsYWcgaXMgZGVmaW5lZCBpbiBhcmNoaXRl
Y3R1cmUNCnNwZWNpZmljIEtjb25maWcuIEZ1bmN0aW9uIGNwdV9ob3RwbHVnX2h3X2luaXQoKSBp
cyBwYXJ0IG9mIHRoZSBody9hY3BpL2NwdS5jDQp3aGljaCBnZXRzIGNvbXBpbGVkIG9ubHkgd2hl
biBhIHBhcnRpY3VsYXIgYXJjaGl0ZWN0dXJlIGRlZmluZXMgQUNQSV9DUFVfSE9UUExVRw0KZmxh
Zy4gDQoNCkFDUEkgR0VEIGZyYW1ld29yayBzdXBwb3J0IGZvciBDUFUgSG90cGx1ZyBpcyBub3Qg
c3BlY2lmaWMgdG8gYW55IGFyY2hpdGVjdHVyZS4NCmFjcGlfZ2VkX2luaXRmbigpIGNhbGxzIGNw
dV9ob3RwbHVnX2h3X2luaXQoKSB3aGVuIEdFRCBkZXZpY2UgZ2V0cyBjcmVhdGVkLg0KVGhpcyBm
dW5jdGlvbnMgZ2V0cyBjYWxsZWQgaXJyZXNwZWN0aXZlIG9mIHRoZSBmYWN0IENQVSBIb3RwbHVn
IGlzIHN1cHBvcnRlZCBvcg0Kbm90LiBJZiBBQ1BJX0NQVV9IT1RQTFVHIGlzIG5vdCBlbmFibGVk
IHRoZW4gcHJlc2VuY2Ugb2YgY3B1X2hvdHBsdWdfaHdfaW5pdCgpDQp3aWxsIGNhdXNlIGxpbmtp
bmcgZXJyb3Igd2l0aG91dCB0aGUgcHJlc2VuY2Ugb2Ygc3R1Yi4NCg0KDQpUaGFua3MNClNhbGls
Lg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5j
b20+DQo+ID4gLS0tDQo+ID4gIGh3L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgfCA2ICsr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLXN0dWIuYyBiL2h3L2FjcGkvYWNwaS1j
cHUtaG90cGx1Zy0NCj4gc3R1Yi5jDQo+ID4gaW5kZXggM2ZjNGIxNGMyNi4uYzZjNjFiYjljZCAx
MDA2NDQNCj4gPiAtLS0gYS9ody9hY3BpL2FjcGktY3B1LWhvdHBsdWctc3R1Yi5jDQo+ID4gKysr
IGIvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLXN0dWIuYw0KPiA+IEBAIC0xOSw2ICsxOSwxMiBA
QCB2b2lkIGxlZ2FjeV9hY3BpX2NwdV9ob3RwbHVnX2luaXQoTWVtb3J5UmVnaW9uDQo+ICpwYXJl
bnQsIE9iamVjdCAqb3duZXIsDQo+ID4gICAgICByZXR1cm47DQo+ID4gIH0NCj4gPg0KPiA+ICt2
b2lkIGNwdV9ob3RwbHVnX2h3X2luaXQoTWVtb3J5UmVnaW9uICphcywgT2JqZWN0ICpvd25lciwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIENQVUhvdHBsdWdTdGF0ZSAqc3RhdGUsIGh3
YWRkciBiYXNlX2FkZHIpDQo+ID4gK3sNCj4gPiArICAgIHJldHVybjsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgdm9pZCBhY3BpX2NwdV9vc3BtX3N0YXR1cyhDUFVIb3RwbHVnU3RhdGUgKmNwdV9zdCwg
QUNQSU9TVEluZm9MaXN0DQo+ICoqKmxpc3QpDQo+ID4gIHsNCj4gPiAgICAgIHJldHVybjsNCj4g
DQo+IA0KPiAtLQ0KPiBBbGV4IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAg
TGluYXJvDQoNCg==

