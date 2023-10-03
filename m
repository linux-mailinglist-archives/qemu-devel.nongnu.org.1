Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774777B6863
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qne0n-0002oH-Gq; Tue, 03 Oct 2023 07:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qne0j-0002fF-2k; Tue, 03 Oct 2023 07:56:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qne0g-0008Nn-De; Tue, 03 Oct 2023 07:56:19 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0GVr41XMz67cTF;
 Tue,  3 Oct 2023 19:56:04 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:56:13 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:56:13 +0100
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
Subject: RE: [PATCH V2 09/10] gdbstub: Add helper function to unregister GDB
 register space
Thread-Topic: [PATCH V2 09/10] gdbstub: Add helper function to unregister GDB
 register space
Thread-Index: AQHZ8zRGPsMQQekjMEW7/A+UTTdUE7A3WOyAgAChr/A=
Date: Tue, 3 Oct 2023 11:56:12 +0000
Message-ID: <9fd7a974f5524eb28f0c0c546704d97d@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-10-salil.mehta@huawei.com>
 <1b018c9e-fde4-e486-b853-1d516db2d2b2@redhat.com>
In-Reply-To: <1b018c9e-fde4-e486-b853-1d516db2d2b2@redhat.com>
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDMsIDIwMjMgNDoxNyBBTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1
YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25nbnUub3Jn
DQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhh
biBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRl
djsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsg
bXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9z
LmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZp
c2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4g
bWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1a2VxaWFu
DQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25n
ZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5j
b20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFu
Z2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjIgMDkvMTBdIGdkYnN0dWI6IEFkZCBoZWxwZXIgZnVuY3Rpb24gdG8g
dW5yZWdpc3Rlcg0KPiBHREIgcmVnaXN0ZXIgc3BhY2UNCj4gDQo+IA0KPiBPbiA5LzMwLzIzIDEw
OjE5LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPiBBZGQgY29tbW9uIGZ1bmN0aW9uIHRvIGhlbHAg
dW5yZWdpc3RlciB0aGUgR0RCIFJlZ2lzdGVyIFNwYWNlLiBUaGlzIHNoYWxsDQo+IGJlDQo+ID4g
ZG9uZSBpbiBjb250ZXh0IHRvIHRoZSBDUFUgdW5yZWFsaXphdGlvbi4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZ2Ric3R1Yi9nZGJzdHViLmMgICAgICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gICBp
bmNsdWRlL2V4ZWMvZ2Ric3R1Yi5oIHwgIDUgKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBXaXRoIHRoZSBmb2xsb3dpbmcgbml0cyBhZGRy
ZXNzZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4N
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL2dkYnN0dWIvZ2Ric3R1Yi5jIGIvZ2Ric3R1Yi9nZGJzdHVi
LmMNCj4gPiBpbmRleCAzNDlkMzQ4YzdiLi44OWFjMGVkZmVhIDEwMDY0NA0KPiA+IC0tLSBhL2dk
YnN0dWIvZ2Ric3R1Yi5jDQo+ID4gKysrIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4gPiBAQCAtNDkx
LDYgKzQ5MSwyMCBAQCB2b2lkIGdkYl9yZWdpc3Rlcl9jb3Byb2Nlc3NvcihDUFVTdGF0ZSAqY3B1
LA0KPiA+ICAgICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+ICt2b2lkIGdkYl91bnJlZ2lzdGVyX2Nv
cHJvY2Vzc29yX2FsbChDUFVTdGF0ZSAqY3B1KQ0KPiA+ICt7DQo+ID4gKyAgICBHREJSZWdpc3Rl
clN0YXRlICpzLCAqcDsNCj4gPiArDQo+ID4gKyAgICBwID0gY3B1LT5nZGJfcmVnczsNCj4gPiAr
ICAgIHdoaWxlIChwKSB7DQo+ID4gKyAgICAgICAgcyA9IHA7DQo+ID4gKyAgICAgICAgcCA9IHAt
Pm5leHQ7DQo+ID4gKyAgICAgICAgLyogcy0+eG1sIGlzIHN0YXRpYyBjb25zdCBjaGFyIHNvIGlz
bid0IGZyZWVkICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5e
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaW5nIHNvIHRoYXQg
aXQgbmVlZG4ndCBiZSBmcmVlZA0KPiA+ICsgICAgICAgIGdfZnJlZShzKTsNCj4gPiArICAgIH0N
Cj4gPiArICAgIGNwdS0+Z2RiX3JlZ3MgPSBOVUxMOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gRm9y
IGNvbnNpc3RlbmN5LCBDUFVTdGF0ZTo6Z2RiX251bV9yZWdzIGFuZCBDUFVTdGF0ZTo6Z2RiX251
bV9nX3JlZ3MNCj4gbmVlZCB0byBiZSB1cGRhdGVkIGFjY29yZGluZ2x5LCBldmVuIHRoZSBDUFUg
aW5zdGFuY2Ugd2lsbCBiZSBkZXN0cm95ZWQNCj4gc2hvcnRseS4NCg0KR29vZCBwb2ludC4NCg0K
VGhhbmtzDQpTYWxpbC4NCg0KDQoNCg==

