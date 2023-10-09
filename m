Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF17BE23A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqzy-0000jO-K9; Mon, 09 Oct 2023 10:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqzs-0000Wa-Tz; Mon, 09 Oct 2023 10:12:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqzp-00070q-NK; Mon, 09 Oct 2023 10:12:36 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S41B417jpz6D8Wq;
 Mon,  9 Oct 2023 22:09:32 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 15:12:29 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 15:12:29 +0100
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
Subject: RE: [PATCH V3 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
Thread-Topic: [PATCH V3 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
Thread-Index: AQHZ+qQKlc9E+oOc5kSBsTtattk5ybBBUZ0AgAAt45A=
Date: Mon, 9 Oct 2023 14:12:29 +0000
Message-ID: <0e9c23f079ac417687c8261739ea22f2@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-5-salil.mehta@huawei.com>
 <794b07a3-6004-23e2-189a-f76952751112@redhat.com>
In-Reply-To: <794b07a3-6004-23e2-189a-f76952751112@redhat.com>
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
ZGF5LCBPY3RvYmVyIDksIDIwMjMgMToyNyBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
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
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGh3L2FjcGk6IEluaXQgR0VEIGZyYW1ld29y
ayB3aXRoIGNwdSBob3RwbHVnDQo+IGV2ZW50cw0KPiANCj4gT24gMDkuMTAuMjMgMTM6MjgsIFNh
bGlsIE1laHRhIHdyb3RlOg0KPiA+IEFDUEkgR0VEKGFzIGRlc2NyaWJlZCBpbiB0aGUgQUNQSSA2
LjIgc3BlYykgY2FuIGJlIHVzZWQgdG8gZ2VuZXJhdGUgQUNQSQ0KPiBldmVudHMNCj4gPiB3aGVu
IE9TUE0vZ3Vlc3QgcmVjZWl2ZXMgYW4gaW50ZXJydXB0IGxpc3RlZCBpbiB0aGUgX0NSUyBvYmpl
Y3Qgb2YgR0VELg0KPiBPU1BNDQo+ID4gdGhlbiBtYXBzIG9yIGRlbXVsdGlwbGV4ZXMgdGhlIGV2
ZW50IGJ5IGV2YWx1YXRpbmcgX0VWVCBtZXRob2QuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBhZGRz
IHRoZSBzdXBwb3J0IG9mIGNwdSBob3RwbHVnIGV2ZW50IGluaXRpYWxpemF0aW9uIGluIHRoZQ0K
PiA+IGV4aXN0aW5nIEdFRCBmcmFtZXdvcmsuDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IEtl
cWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZXFp
YW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFu
IENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
R2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FjcGkvZ2Vu
ZXJpY19ldmVudF9kZXZpY2UuYyAgICAgICAgIHwgOCArKysrKysrKw0KPiA+ICAgaW5jbHVkZS9o
dy9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmggfCA1ICsrKysrDQo+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hY3BpL2dl
bmVyaWNfZXZlbnRfZGV2aWNlLmMNCj4gYi9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMN
Cj4gPiBpbmRleCBhM2QzMTYzMWZlLi5kMmZhMWQwZTRhIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2Fj
cGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuYw0KPiA+ICsrKyBiL2h3L2FjcGkvZ2VuZXJpY19ldmVu
dF9kZXZpY2UuYw0KPiA+IEBAIC0yNSw2ICsyNSw3IEBAIHN0YXRpYyBjb25zdCB1aW50MzJfdCBn
ZWRfc3VwcG9ydGVkX2V2ZW50c1tdID0gew0KPiA+ICAgICAgIEFDUElfR0VEX01FTV9IT1RQTFVH
X0VWVCwNCj4gPiAgICAgICBBQ1BJX0dFRF9QV1JfRE9XTl9FVlQsDQo+ID4gICAgICAgQUNQSV9H
RURfTlZESU1NX0hPVFBMVUdfRVZULA0KPiA+ICsgICAgQUNQSV9HRURfQ1BVX0hPVFBMVUdfRVZU
LA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgLyoNCj4gPiBAQCAtNDAwLDYgKzQwMSwxMyBAQCBzdGF0
aWMgdm9pZCBhY3BpX2dlZF9pbml0Zm4oT2JqZWN0ICpvYmopDQo+ID4gICAgICAgbWVtb3J5X3Jl
Z2lvbl9pbml0X2lvKCZnZWRfc3QtPnJlZ3MsIG9iaiwgJmdlZF9yZWdzX29wcywgZ2VkX3N0LA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0FDUElfR0VEICItcmVncyIsIEFD
UElfR0VEX1JFR19DT1VOVCk7DQo+ID4gICAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZnZWRf
c3QtPnJlZ3MpOw0KPiA+ICsNCj4gPiArICAgIHMtPmNwdWhwLmRldmljZSA9IE9CSkVDVChzKTsN
Cj4gPiArICAgIG1lbW9yeV9yZWdpb25faW5pdCgmcy0+Y29udGFpbmVyX2NwdWhwLCBPQkpFQ1Qo
ZGV2KSwgImNwdWhwDQo+IGNvbnRhaW5lciIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
QUNQSV9DUFVfSE9UUExVR19SRUdfTEVOKTsNCj4gPiArICAgIHN5c2J1c19pbml0X21taW8oU1lT
X0JVU19ERVZJQ0UoZGV2KSwgJnMtPmNvbnRhaW5lcl9jcHVocCk7DQo+ID4gKyAgICBjcHVfaG90
cGx1Z19od19pbml0KCZzLT5jb250YWluZXJfY3B1aHAsIE9CSkVDVChkZXYpLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAmcy0+Y3B1aHBfc3RhdGUsIDApOw0KPiA+ICAgfQ0KPiA+DQo+
ID4gICBzdGF0aWMgdm9pZCBhY3BpX2dlZF9jbGFzc19pbml0KE9iamVjdENsYXNzICpjbGFzcywg
dm9pZCAqZGF0YSkNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hY3BpL2dlbmVyaWNfZXZl
bnRfZGV2aWNlLmgNCj4gYi9pbmNsdWRlL2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuaA0K
PiA+IGluZGV4IGQ4MzFiYmQ4ODkuLmQwYTVhNDNhYmYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2Fj
cGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuaA0KPiA+IEBAIC02MCw2ICs2MCw3IEBADQo+ID4gICAj
ZGVmaW5lIEhXX0FDUElfR0VORVJJQ19FVkVOVF9ERVZJQ0VfSA0KPiA+DQo+ID4gICAjaW5jbHVk
ZSAiaHcvc3lzYnVzLmgiDQo+ID4gKyNpbmNsdWRlICJody9hY3BpL2NwdV9ob3RwbHVnLmgiDQo+
ID4gICAjaW5jbHVkZSAiaHcvYWNwaS9tZW1vcnlfaG90cGx1Zy5oIg0KPiA+ICAgI2luY2x1ZGUg
Imh3L2FjcGkvZ2hlcy5oIg0KPiA+ICAgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4gPiBAQCAt
OTcsNiArOTgsNyBAQCBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShBY3BpR2VkU3RhdGUsIEFD
UElfR0VEKQ0KPiA+ICAgI2RlZmluZSBBQ1BJX0dFRF9NRU1fSE9UUExVR19FVlQgICAweDENCj4g
PiAgICNkZWZpbmUgQUNQSV9HRURfUFdSX0RPV05fRVZUICAgICAgMHgyDQo+ID4gICAjZGVmaW5l
IEFDUElfR0VEX05WRElNTV9IT1RQTFVHX0VWVCAweDQNCj4gPiArI2RlZmluZSBBQ1BJX0dFRF9D
UFVfSE9UUExVR19FVlQgICAgMHg4DQo+ID4NCj4gPiAgIHR5cGVkZWYgc3RydWN0IEdFRFN0YXRl
IHsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gZXZ0Ow0KPiA+IEBAIC0xMDgsNiArMTEwLDkgQEAg
c3RydWN0IEFjcGlHZWRTdGF0ZSB7DQo+ID4gICAgICAgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7
DQo+ID4gICAgICAgTWVtSG90cGx1Z1N0YXRlIG1lbWhwX3N0YXRlOw0KPiA+ICAgICAgIE1lbW9y
eVJlZ2lvbiBjb250YWluZXJfbWVtaHA7DQo+ID4gKyAgICBDUFVIb3RwbHVnU3RhdGUgY3B1aHBf
c3RhdGU7DQo+ID4gKyAgICBNZW1vcnlSZWdpb24gY29udGFpbmVyX2NwdWhwOw0KPiA+ICsgICAg
QWNwaUNwdUhvdHBsdWcgY3B1aHA7DQo+IA0KPiBBbSBJIHdyb25nIG9yIGlzIHRoYXQgbWVtYmVy
IGNvbXBsZXRlbHkgdW51c2VkL3VuaW5pdGlhbGl6ZWQ/DQoNCk5vIGl0IGlzIG5vdC4gUGxlYXNl
IGNoZWNrIGJlbG93IGNoYW5nZSBpbiBhY3BpX2dlZF9pbml0Zm4oKQ0KDQorICAgIHMtPmNwdWhw
LmRldmljZSA9IE9CSkVDVChzKTsNCg0KDQpUaGFua3MNClNhbGlsLg0K

