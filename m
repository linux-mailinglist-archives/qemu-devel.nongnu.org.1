Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7B7C6954
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrrC-0005kS-Ft; Thu, 12 Oct 2023 05:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqrrA-0005jj-5X; Thu, 12 Oct 2023 05:19:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqrr7-0003wn-H1; Thu, 12 Oct 2023 05:19:47 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5kYt4tDrz6K5v5;
 Thu, 12 Oct 2023 17:17:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 10:19:41 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Thu, 12 Oct 2023 10:19:41 +0100
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
Subject: RE: [PATCH V5 9/9] gdbstub: Add helper function to unregister GDB
 register space
Thread-Topic: [PATCH V5 9/9] gdbstub: Add helper function to unregister GDB
 register space
Thread-Index: AQHZ/HvBN0u3se0o1kicXc2uo3J6h7BFNl4AgACq53A=
Date: Thu, 12 Oct 2023 09:19:41 +0000
Message-ID: <bb13b0ee0a3544c7891ac29ecceb73d5@huawei.com>
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-10-salil.mehta@huawei.com>
 <ca79ed5f-b807-10eb-8f79-c2def1ab028f@redhat.com>
In-Reply-To: <ca79ed5f-b807-10eb-8f79-c2def1ab028f@redhat.com>
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

SGkgR2F2aW4sDQoNCj4gRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMTIsIDIwMjMgMTowNyBBTQ0KPiBUbzogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+
IGFybUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5h
cm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3
LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7
IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gcGJvbnpp
bmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgcmFmYWVsQGtl
cm5lbC5vcmc7DQo+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1
dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1A
b3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3Jj
Lm5ldDsgemh1a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5n
IChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5
YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29u
Z3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgOS85XSBnZGJzdHViOiBBZGQgaGVscGVy
IGZ1bmN0aW9uIHRvIHVucmVnaXN0ZXIgR0RCDQo+IHJlZ2lzdGVyIHNwYWNlDQo+IA0KPiBIaSBT
YWxpbCwNCj4gDQo+IE9uIDEwLzEyLzIzIDA1OjQzLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPiBB
ZGQgY29tbW9uIGZ1bmN0aW9uIHRvIGhlbHAgdW5yZWdpc3RlciB0aGUgR0RCIFJlZ2lzdGVyIFNw
YWNlLiBUaGlzIHNoYWxsDQo+IGJlDQo+ID4gZG9uZSBpbiBjb250ZXh0IHRvIHRoZSBDUFUgdW5y
ZWFsaXphdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5t
ZWh0YUBodWF3ZWkuY29tPg0KPiA+IFRlc3RlZC1ieTogVmlzaG51IFBhamp1cmkgPHZpc2hudUBv
cy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZ2Ric3R1Yi9nZGJzdHViLmMg
ICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9leGVjL2dkYnN0dWIuaCB8
ICA1ICsrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPg0K
PiANCj4gV2l0aCB0aGUgZm9sbG93aW5nIG5pdHMgYWRkcmVzc2VkOg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9n
ZGJzdHViL2dkYnN0dWIuYyBiL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+ID4gaW5kZXggMzQ5ZDM0OGM3
Yi4uOTdiODllMmQwMCAxMDA2NDQNCj4gPiAtLS0gYS9nZGJzdHViL2dkYnN0dWIuYw0KPiA+ICsr
KyBiL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+ID4gQEAgLTQ5MSw2ICs0OTEsMjEgQEAgdm9pZCBnZGJf
cmVnaXN0ZXJfY29wcm9jZXNzb3IoQ1BVU3RhdGUgKmNwdSwNCj4gPiAgICAgICB9DQo+ID4gICB9
DQo+ID4NCj4gPiArdm9pZCBnZGJfdW5yZWdpc3Rlcl9jb3Byb2Nlc3Nvcl9hbGwoQ1BVU3RhdGUg
KmNwdSkNCj4gPiArew0KPiA+ICsgICAgR0RCUmVnaXN0ZXJTdGF0ZSAqcywgKnA7DQo+ID4gKw0K
PiA+ICsgICAgcCA9IGNwdS0+Z2RiX3JlZ3M7DQo+ID4gKyAgICB3aGlsZSAocCkgew0KPiA+ICsg
ICAgICAgIHMgPSBwOw0KPiA+ICsgICAgICAgIHAgPSBwLT5uZXh0Ow0KPiA+ICsgICAgICAgIC8q
IHMtPnhtbCBpcyBzdGF0aWMgY29uc3QgY2hhciBzbyBpc24ndCBmcmVlZCAqLw0KPiA+ICsgICAg
ICAgIGdfZnJlZShzKTsNCj4gPiArICAgIH0NCj4gPiArICAgIGNwdS0+Z2RiX3JlZ3MgPSBOVUxM
Ow0KPiANCj4gICAgICAgICBjcHUtPmJhc2VfcmVnID0gMDsNCj4gICAgICAgICBjcHUtPm51bV9y
ZWdzID0gMDsNCg0KDQpTdXJlLiB0aGFua3MNCg0KU2FsaWwuDQoNCj4gDQo+ID4gKyAgICBjcHUt
PmdkYl9udW1fZ19yZWdzID0gMDsNCj4gPiArfQ0K

