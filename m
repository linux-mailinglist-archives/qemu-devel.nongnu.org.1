Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF27BE174
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqdk-0000D0-H2; Mon, 09 Oct 2023 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqdh-0000Bs-Oo; Mon, 09 Oct 2023 09:49:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqdd-0002IE-DA; Mon, 09 Oct 2023 09:49:41 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S40hp1157z6K5xy;
 Mon,  9 Oct 2023 21:47:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 14:49:32 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 14:49:32 +0100
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Subject: RE: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Topic: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Index: AQHZ+qP+4EmuUazzyEe6jhCYlq8By7BBUIQAgAAoLOA=
Date: Mon, 9 Oct 2023 13:49:32 +0000
Message-ID: <08840ea0a68e46b1a9d98d1e3544f43b@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-4-salil.mehta@huawei.com>
 <8a80612f-07d3-6302-31f9-232d9ce393a1@redhat.com>
In-Reply-To: <8a80612f-07d3-6302-31f9-232d9ce393a1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.154.91]
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

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDksIDIwMjMgMToyMyBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25n
bnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBK
b25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFs
aXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxp
bnV4LmRldjsgcGhpbG1kQGxpbmFyby5vcmc7DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xp
dmVyLnVwdG9uQGxpbnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gbXN0QHJlZGhhdC5j
b207IHdpbGxAa2VybmVsLm9yZzsgZ3NoYW5AcmVkaGF0LmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7
DQo+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFy
cmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207
DQo+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNv
bTsNCj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1
a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2Fu
Z3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1
YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsg
bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDMvMTBdIGh3L2FjcGk6IEFkZCBBQ1BJIENQVSBob3Rw
bHVnIGluaXQgc3R1Yg0KPiANCj4gT24gMDkuMTAuMjMgMTM6MjgsIFNhbGlsIE1laHRhIHdyb3Rl
Og0KPiA+IEFDUEkgQ1BVIGhvdHBsdWcgcmVsYXRlZCBpbml0aWFsaXphdGlvbiBzaG91bGQgb25s
eSBoYXBwZW4gaWYNCj4gQUNQSV9DUFVfSE9UUExVRw0KPiA+IHN1cHBvcnQgaGFzIGJlZW4gZW5h
YmxlZCBmb3IgcGFydGljdWxhciBhcmNoaXRlY3R1cmUuIEFkZA0KPiBjcHVfaG90cGx1Z19od19p
bml0KCkNCj4gPiBzdHViIHRvIGF2b2lkIGNvbXBpbGF0aW9uIGJyZWFrLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGh3L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgfCA2ICsrKysrKw0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgYi9ody9hY3BpL2FjcGktY3B1LWhvdHBsdWct
DQo+IHN0dWIuYw0KPiA+IGluZGV4IDNmYzRiMTRjMjYuLmM2YzYxYmI5Y2QgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLXN0dWIuYw0KPiA+ICsrKyBiL2h3L2FjcGkv
YWNwaS1jcHUtaG90cGx1Zy1zdHViLmMNCj4gPiBAQCAtMTksNiArMTksMTIgQEAgdm9pZCBsZWdh
Y3lfYWNwaV9jcHVfaG90cGx1Z19pbml0KE1lbW9yeVJlZ2lvbg0KPiAqcGFyZW50LCBPYmplY3Qg
Km93bmVyLA0KPiA+ICAgICAgIHJldHVybjsNCj4gPiAgIH0NCj4gPg0KPiA+ICt2b2lkIGNwdV9o
b3RwbHVnX2h3X2luaXQoTWVtb3J5UmVnaW9uICphcywgT2JqZWN0ICpvd25lciwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgIENQVUhvdHBsdWdTdGF0ZSAqc3RhdGUsIGh3YWRkciBiYXNl
X2FkZHIpDQo+ID4gK3sNCj4gPiArICAgIHJldHVybjsNCj4gPiArfQ0KPiANCj4gV2hpbGUgYXQg
aXQsIGNhbiB3ZSBwcmVmaXggdGhhdCBmdW5jdGlvbiB3aXRoIGFjcGk/DQoNCkkgY2FuIGRvIHRo
YXQgYnV0IGl0IGhhcyB0byBiZSBkb25lIGF0IG90aGVyIHBsYWNlcyBhcyB3ZWxsDQpzdWNoIGFz
IGluIGh3L2FjcGkvY3B1X2hvdHBsdWcuYyA8YWNwaV9zd2l0Y2hfdG9fbW9kZXJuX2NwaHAoKT4N
Cg0KSG9wZSB0aGlzIGlzIG5vdCBhbiBleHRyYW5lb3VzIGNoYW5nZSB0byB0aGlzIHBhdGNoLXNl
dD8NCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQoNCg==

