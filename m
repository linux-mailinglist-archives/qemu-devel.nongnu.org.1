Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE387CF535
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:28:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQFq-0001Xi-6Z; Thu, 19 Oct 2023 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qtQFl-0001VX-2L; Thu, 19 Oct 2023 06:27:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qtQFh-0006xB-QO; Thu, 19 Oct 2023 06:27:44 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB3jT0f7fz6HJMR;
 Thu, 19 Oct 2023 18:24:13 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 11:27:37 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Thu, 19 Oct 2023 11:27:37 +0100
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
Subject: RE: [PATCH V6 4/9] hw/acpi: Init GED framework with CPU hotplug events
Thread-Topic: [PATCH V6 4/9] hw/acpi: Init GED framework with CPU hotplug
 events
Thread-Index: AQHZ/cN5nupvt1X/j0S+fZufTSL4urBQ3j+AgAATTTA=
Date: Thu, 19 Oct 2023 10:27:37 +0000
Message-ID: <a7025265329d486f8684f43a573acaa4@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-5-salil.mehta@huawei.com> <87fs26apcd.fsf@linaro.org>
In-Reply-To: <87fs26apcd.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.120]
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

SGkgQWxleCwNCg0KPiBGcm9tOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDIzIDExOjE2IEFNDQo+IFRvOiBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgbWF6QGtlcm5lbC5vcmc7IGplYW4tDQo+IHBoaWxp
cHBlQGxpbmFyby5vcmc7IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2Vp
LmNvbT47DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
Ow0KPiByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBpbWFtbWVkb0ByZWRoYXQuY29tOyBh
bmRyZXcuam9uZXNAbGludXguZGV2Ow0KPiBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJv
Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiBvbGl2ZXIudXB0b25AbGludXguZGV2OyBw
Ym9uemluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyBn
c2hhbkByZWRoYXQuY29tOyByYWZhZWxAa2VybmVsLm9yZzsNCj4gbGludXhAYXJtbGludXgub3Jn
LnVrOyBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4gaWxra2FAb3MuYW1wZXJlY29t
cHV0aW5nLmNvbTsgdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IGthcmwuaGV1YmF1
bUBvcmFjbGUuY29tOyBtaWd1ZWwubHVpc0BvcmFjbGUuY29tOyBzYWxpbC5tZWh0YUBvcG5zcmMu
bmV0Ow0KPiB6aHVrZXFpYW4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4aW9uZ2Zlbmcg
KEMpDQo+IDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuIChZKSA8d2FuZ3lh
bmFuNTVAaHVhd2VpLmNvbT47DQo+IGppYWtlcm5lbDJAZ21haWwuY29tOyBtYW9iaWJvQGxvb25n
c29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVh
d2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNiA0LzldIGh3L2FjcGk6IEluaXQgR0VE
IGZyYW1ld29yayB3aXRoIENQVSBob3RwbHVnDQo+IGV2ZW50cw0KPiANCj4gDQo+IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEFDUEkgR0VEKGFz
IGRlc2NyaWJlZCBpbiB0aGUgQUNQSSA2LjIgc3BlYykgY2FuIGJlIHVzZWQgdG8gZ2VuZXJhdGUg
QUNQSSBldmVudHMNCj4gPiB3aGVuIE9TUE0vZ3Vlc3QgcmVjZWl2ZXMgYW4gaW50ZXJydXB0IGxp
c3RlZCBpbiB0aGUgX0NSUyBvYmplY3Qgb2YgR0VELiBPU1BNDQo+ID4gdGhlbiBtYXBzIG9yIGRl
bXVsdGlwbGV4ZXMgdGhlIGV2ZW50IGJ5IGV2YWx1YXRpbmcgX0VWVCBtZXRob2QuDQo+ID4NCj4g
PiBUaGlzIGNoYW5nZSBhZGRzIHRoZSBzdXBwb3J0IG9mIENQVSBob3RwbHVnIGV2ZW50IGluaXRp
YWxpemF0aW9uIGluIHRoZQ0KPiA+IGV4aXN0aW5nIEdFRCBmcmFtZXdvcmsuDQo+IA0KPiBTaG91
bGQgd2UgYWxzbyB1cGRhdGUgdGhlIGRvY3MgaGVyZToNCj4gDQo+ICAgaHR0cHM6Ly9xZW11LnJl
YWR0aGVkb2NzLmlvL2VuL21hc3Rlci9zcGVjcy9hY3BpX2h3X3JlZHVjZWRfaG90cGx1Zy5odG1s
DQo+IA0KPiAoc2VlIGRvY3Mvc3BlY3MvYWNwaV9od19yZWR1Y2VkX2hvdHBsdWcucnN0KQ0KDQoN
Ckdvb2QgcG9pbnQuIFdpbGwgZG8uDQoNCg0KPiB0byBhZGQgdGhlIG5ldyBiaXRzPyBPciBtYXli
ZSBhbiB1cGRhdGUgdG8gZG9jdW1lbnRhdGlvbiBhcyB0aGUgbGFzdA0KPiBjb21taXQ/DQoNCldp
bGwgYWRkIG9uZSBtb3JlIHBhdGNoIGF0IHRoZSBsYXN0IGZvciB0aGlzIGRvY3VtZW50YXRpb24g
Y2hhbmdlLg0KDQpUaGFua3MgZm9yIGlkZW50aWZ5aW5nIHRoaXMuDQoNCkNoZWVycw0KU2FsaWwu
DQoNCg0KPiANCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFu
MUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFA
aHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFA
aHVhd2VpLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4u
Q2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkBy
ZWRoYXQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4NCj4gPiBUZXN0ZWQtYnk6IFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IFhpYW5nbGFpIExpIDxsaXhpYW5nbGFpQGxv
b25nc29uLmNuPg0KPiA+IC0tLQ0KPiA+ICBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMg
ICAgICAgICB8IDggKysrKysrKysNCj4gPiAgaW5jbHVkZS9ody9hY3BpL2dlbmVyaWNfZXZlbnRf
ZGV2aWNlLmggfCA1ICsrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuYw0K
PiBiL2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuYw0KPiA+IGluZGV4IGEzZDMxNjMxZmUu
LmQyZmExZDBlNGEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2Rldmlj
ZS5jDQo+ID4gKysrIGIvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5jDQo+ID4gQEAgLTI1
LDYgKzI1LDcgQEAgc3RhdGljIGNvbnN0IHVpbnQzMl90IGdlZF9zdXBwb3J0ZWRfZXZlbnRzW10g
PSB7DQo+ID4gICAgICBBQ1BJX0dFRF9NRU1fSE9UUExVR19FVlQsDQo+ID4gICAgICBBQ1BJX0dF
RF9QV1JfRE9XTl9FVlQsDQo+ID4gICAgICBBQ1BJX0dFRF9OVkRJTU1fSE9UUExVR19FVlQsDQo+
ID4gKyAgICBBQ1BJX0dFRF9DUFVfSE9UUExVR19FVlQsDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoN
Cj4gPiBAQCAtNDAwLDYgKzQwMSwxMyBAQCBzdGF0aWMgdm9pZCBhY3BpX2dlZF9pbml0Zm4oT2Jq
ZWN0ICpvYmopDQo+ID4gICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJmdlZF9zdC0+cmVncywg
b2JqLCAmZ2VkX3JlZ3Nfb3BzLCBnZWRfc3QsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVFlQRV9BQ1BJX0dFRCAiLXJlZ3MiLCBBQ1BJX0dFRF9SRUdfQ09VTlQpOw0KPiA+ICAgICAg
c3lzYnVzX2luaXRfbW1pbyhzYmQsICZnZWRfc3QtPnJlZ3MpOw0KPiA+ICsNCj4gPiArICAgIHMt
PmNwdWhwLmRldmljZSA9IE9CSkVDVChzKTsNCj4gPiArICAgIG1lbW9yeV9yZWdpb25faW5pdCgm
cy0+Y29udGFpbmVyX2NwdWhwLCBPQkpFQ1QoZGV2KSwgImNwdWhwDQo+IGNvbnRhaW5lciIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgQUNQSV9DUFVfSE9UUExVR19SRUdfTEVOKTsNCj4g
PiArICAgIHN5c2J1c19pbml0X21taW8oU1lTX0JVU19ERVZJQ0UoZGV2KSwgJnMtPmNvbnRhaW5l
cl9jcHVocCk7DQo+ID4gKyAgICBjcHVfaG90cGx1Z19od19pbml0KCZzLT5jb250YWluZXJfY3B1
aHAsIE9CSkVDVChkZXYpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAmcy0+Y3B1aHBf
c3RhdGUsIDApOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgYWNwaV9nZWRfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqY2xhc3MsIHZvaWQgKmRhdGEpDQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5oDQo+IGIvaW5jbHVkZS9ody9hY3Bp
L2dlbmVyaWNfZXZlbnRfZGV2aWNlLmgNCj4gPiBpbmRleCBiYTg0Y2UwMjE0Li5hODAzZWE4MThl
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5o
DQo+ID4gKysrIGIvaW5jbHVkZS9ody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmgNCj4gPiBA
QCAtNjAsNiArNjAsNyBAQA0KPiA+ICAjZGVmaW5lIEhXX0FDUElfR0VORVJJQ19FVkVOVF9ERVZJ
Q0VfSA0KPiA+DQo+ID4gICNpbmNsdWRlICJody9zeXNidXMuaCINCj4gPiArI2luY2x1ZGUgImh3
L2FjcGkvY3B1X2hvdHBsdWcuaCINCj4gPiAgI2luY2x1ZGUgImh3L2FjcGkvbWVtb3J5X2hvdHBs
dWcuaCINCj4gPiAgI2luY2x1ZGUgImh3L2FjcGkvZ2hlcy5oIg0KPiA+ICAjaW5jbHVkZSAicW9t
L29iamVjdC5oIg0KPiA+IEBAIC05NSw2ICs5Niw3IEBAIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9U
WVBFKEFjcGlHZWRTdGF0ZSwgQUNQSV9HRUQpDQo+ID4gICNkZWZpbmUgQUNQSV9HRURfTUVNX0hP
VFBMVUdfRVZUICAgMHgxDQo+ID4gICNkZWZpbmUgQUNQSV9HRURfUFdSX0RPV05fRVZUICAgICAg
MHgyDQo+ID4gICNkZWZpbmUgQUNQSV9HRURfTlZESU1NX0hPVFBMVUdfRVZUIDB4NA0KPiA+ICsj
ZGVmaW5lIEFDUElfR0VEX0NQVV9IT1RQTFVHX0VWVCAgICAweDgNCj4gPg0KPiA+ICB0eXBlZGVm
IHN0cnVjdCBHRURTdGF0ZSB7DQo+ID4gICAgICBNZW1vcnlSZWdpb24gZXZ0Ow0KPiA+IEBAIC0x
MDYsNiArMTA4LDkgQEAgc3RydWN0IEFjcGlHZWRTdGF0ZSB7DQo+ID4gICAgICBTeXNCdXNEZXZp
Y2UgcGFyZW50X29iajsNCj4gPiAgICAgIE1lbUhvdHBsdWdTdGF0ZSBtZW1ocF9zdGF0ZTsNCj4g
PiAgICAgIE1lbW9yeVJlZ2lvbiBjb250YWluZXJfbWVtaHA7DQo+ID4gKyAgICBDUFVIb3RwbHVn
U3RhdGUgY3B1aHBfc3RhdGU7DQo+ID4gKyAgICBNZW1vcnlSZWdpb24gY29udGFpbmVyX2NwdWhw
Ow0KPiA+ICsgICAgQWNwaUNwdUhvdHBsdWcgY3B1aHA7DQo+ID4gICAgICBHRURTdGF0ZSBnZWRf
c3RhdGU7DQo+ID4gICAgICB1aW50MzJfdCBnZWRfZXZlbnRfYml0bWFwOw0KPiA+ICAgICAgcWVt
dV9pcnEgaXJxOw0KPiANCj4gDQo+IC0tDQo+IEFsZXggQmVubsOpZQ0KPiBWaXJ0dWFsaXNhdGlv
biBUZWNoIExlYWQgQCBMaW5hcm8NCg0K

