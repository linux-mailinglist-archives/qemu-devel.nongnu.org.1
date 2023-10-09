Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94E7BE0C7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqXo-0004yc-3a; Mon, 09 Oct 2023 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqXj-0004yG-BT; Mon, 09 Oct 2023 09:43:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqXh-00012h-IN; Mon, 09 Oct 2023 09:43:31 -0400
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S40XY0rjVz6D8WV;
 Mon,  9 Oct 2023 21:40:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 14:43:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 14:43:26 +0100
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
Subject: RE: [PATCH V3 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Thread-Topic: [PATCH V3 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len
 macro to common header file
Thread-Index: AQHZ+qP0kECoHw+Aq0awyG8WwpofkrBBUDoAgAAnhNA=
Date: Mon, 9 Oct 2023 13:43:26 +0000
Message-ID: <c941597940e54d5c87aedbf129d79482@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-3-salil.mehta@huawei.com>
 <3380adbe-fbbe-797f-19c2-76aa2e4cfe30@redhat.com>
In-Reply-To: <3380adbe-fbbe-797f-19c2-76aa2e4cfe30@redhat.com>
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
ZGF5LCBPY3RvYmVyIDksIDIwMjMgMToyMiBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
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
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDIvMTBdIGh3L2FjcGk6IE1vdmUgQ1BVIGN0cmwtZGV2
IE1NSU8gcmVnaW9uIGxlbg0KPiBtYWNybyB0byBjb21tb24gaGVhZGVyIGZpbGUNCj4gDQo+IE9u
IDA5LjEwLjIzIDEzOjI4LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPiBDUFUgY3RybC1kZXYgTU1J
TyByZWdpb24gbGVuZ3RoIGNvdWxkIGJlIHVzZWQgaW4gQUNQSSBHRUQgYW5kIHZhcmlvdXMNCj4g
b3RoZXINCj4gPiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcGxhY2VzLiBNb3ZlIEFDUElfQ1BVX0hP
VFBMVUdfUkVHX0xFTiBtYWNybyB0byBtb3JlDQo+ID4gYXBwcm9wcmlhdGUgY29tbW9uIGhlYWRl
ciBmaWxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QGh1YXdlaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkBy
ZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYWNwaS9jcHUuYyAgICAgICAgICAgICAgICAg
fCAyICstDQo+ID4gICBpbmNsdWRlL2h3L2FjcGkvY3B1X2hvdHBsdWcuaCB8IDIgKysNCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaHcvYWNwaS9jcHUuYyBiL2h3L2FjcGkvY3B1LmMNCj4gPiBpbmRleCAx
OWMxNTRkNzhmLi40NWRlZmRjMGUyIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FjcGkvY3B1LmMNCj4g
PiArKysgYi9ody9hY3BpL2NwdS5jDQo+ID4gQEAgLTEsMTIgKzEsMTIgQEANCj4gPiAgICNpbmNs
dWRlICJxZW11L29zZGVwLmgiDQo+ID4gICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIN
Cj4gPiAgICNpbmNsdWRlICJody9hY3BpL2NwdS5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvYWNwaS9j
cHVfaG90cGx1Zy5oIg0KPiA+ICAgI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gPiAgICNpbmNs
dWRlICJxYXBpL3FhcGktZXZlbnRzLWFjcGkuaCINCj4gPiAgICNpbmNsdWRlICJ0cmFjZS5oIg0K
PiA+ICAgI2luY2x1ZGUgInN5c2VtdS9udW1hLmgiDQo+ID4NCj4gPiAtI2RlZmluZSBBQ1BJX0NQ
VV9IT1RQTFVHX1JFR19MRU4gMTINCj4gPiAgICNkZWZpbmUgQUNQSV9DUFVfU0VMRUNUT1JfT0ZG
U0VUX1dSIDANCj4gPiAgICNkZWZpbmUgQUNQSV9DUFVfRkxBR1NfT0ZGU0VUX1JXIDQNCj4gPiAg
ICNkZWZpbmUgQUNQSV9DUFVfQ01EX09GRlNFVF9XUiA1DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvYWNwaS9jcHVfaG90cGx1Zy5oDQo+IGIvaW5jbHVkZS9ody9hY3BpL2NwdV9ob3RwbHVn
LmgNCj4gPiBpbmRleCAzYjkzMmFiYmJiLi40OGIyOTFlNDVlIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvaHcvYWNwaS9jcHVfaG90cGx1Zy5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hY3BpL2Nw
dV9ob3RwbHVnLmgNCj4gPiBAQCAtMTksNiArMTksOCBAQA0KPiA+ICAgI2luY2x1ZGUgImh3L2hv
dHBsdWcuaCINCj4gPiAgICNpbmNsdWRlICJody9hY3BpL2NwdS5oIg0KPiA+DQo+ID4gKyNkZWZp
bmUgQUNQSV9DUFVfSE9UUExVR19SRUdfTEVOIDEyDQo+ID4gKw0KPiA+ICAgdHlwZWRlZiBzdHJ1
Y3QgQWNwaUNwdUhvdHBsdWcgew0KPiA+ICAgICAgIE9iamVjdCAqZGV2aWNlOw0KPiA+ICAgICAg
IE1lbW9yeVJlZ2lvbiBpbzsNCj4gDQo+IFJldmlld2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT4NCg0KVGhhbmtzDQpTYWxpbC4NCg==

