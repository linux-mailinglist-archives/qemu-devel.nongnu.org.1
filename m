Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C67CB5D6
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVae-0004UJ-Ch; Mon, 16 Oct 2023 17:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVac-0004Tr-6b; Mon, 16 Oct 2023 17:57:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVaa-000797-9N; Mon, 16 Oct 2023 17:57:29 -0400
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8WB25PD2z6K5dS;
 Tue, 17 Oct 2023 05:55:06 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 22:57:24 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 22:57:24 +0100
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
Subject: RE: [PATCH RFC V2 16/37] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Thread-Topic: [PATCH RFC V2 16/37] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Thread-Index: AQHZ8GGq8S4CfrEjAEuYiCf+HToRt7AvY/2AgB2yJoA=
Date: Mon, 16 Oct 2023 21:57:24 +0000
Message-ID: <283e5d2580814fbebeb33d66a1104cf5@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-17-salil.mehta@huawei.com>
 <26f2a18a-4315-443f-560a-c4f007434206@redhat.com>
In-Reply-To: <26f2a18a-4315-443f-560a-c4f007434206@redhat.com>
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
U2VwdGVtYmVyIDI4LCAyMDIzIDI6MjYgQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiBhcm1Abm9uZ251
Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgSm9u
YXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0BsaW51
eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgYXJkYkBrZXJuZWwub3JnOw0KPiBvbGl2ZXIu
dXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj4g
cmFmYWVsQGtlcm5lbC5vcmc7IGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb207IGFsZXguYmVubmVl
QGxpbmFyby5vcmc7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgZGFycmVuQG9zLmFtcGVyZWNv
bXB1dGluZy5jb207DQo+IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IHZpc2hudUBvcy5h
bXBlcmVjb21wdXRpbmcuY29tOw0KPiBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsgbWlndWVsLmx1
aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsNCj4gemh1a2VxaWFuIDx6aHVr
ZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKQ0KPiA8d2FuZ3hpb25nZmVuZzJA
aHVhd2VpLmNvbT47IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+Ow0KPiBq
aWFrZXJuZWwyQGdtYWlsLmNvbTsgbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29u
Z3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAxNi8zN10gaHcvYWNwaTogVXBk
YXRlIENQVXMgQU1MIHdpdGggY3B1LQ0KPiAoY3RybClkZXYgY2hhbmdlDQo+IA0KPiBPbiA5LzI2
LzIzIDIwOjA0LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPiBDUFVzIENvbnRyb2wgZGV2aWNlKFxc
X1NCLlBDSTApIHJlZ2lzdGVyIGludGVyZmFjZSBmb3IgdGhlIHg4NiBhcmNoIGlzDQo+IGJhc2Vk
IG9uDQo+ID4gUENJIGFuZCBpcyBJTyBwb3J0IGJhc2VkIGFuZCBoZW5jZSBleGlzdGluZyBjcHVz
IEFNTCBjb2RlIGFzc3VtZXMgX0NSUyBvYmplY3RzDQo+IA0KPiBeXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLiBUaGUgZXhpc3RpbmcgQU1MIGNvZGUgYXNzdW1lcyBfQ1JTIG9iamVjdA0KPiA+
IHdvdWxkIGV2YWx1YXRlIHRvIGEgc3lzdGVtIHJlc291cmNlIHdoaWNoIGRlc2NyaWJlcyBJTyBQ
b3J0IGFkZHJlc3MuIEJ1dA0KPiBvbiBBUk0NCj4gICAgXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiAg
ICBpcyBldmFsdWF0ZWQgdG8gYQ0KPiANCj4gPiBhcmNoIENQVXMgY29udHJvbCBkZXZpY2UoXFxf
U0IuUFJFUykgcmVnaXN0ZXIgaW50ZXJmYWNlIGlzIG1lbW9yeS1tYXBwZWQNCj4gaGVuY2UNCj4g
PiBfQ1JTIG9iamVjdCBzaG91bGQgZXZhbHVhdGUgdG8gc3lzdGVtIHJlc291cmNlIHdoaWNoIGRl
c2NyaWJlcyBtZW1vcnktbWFwcGVkDQo+ICAgICAgICAgICAgICAgIF5eXl5eXg0KPiAgICAgICAg
ICAgICAgICBzaG91bGQgYmUgZXZhbHVhdGVkDQo+ID4gYmFzZSBhZGRyZXNzLg0KPiA+DQo+ID4g
VGhpcyBjcHVzIEFNTCBjb2RlIGNoYW5nZSB1cGRhdGVzIHRoZSBleGlzdGluZyBpbmVyZmFjZSBv
ZiB0aGUgYnVpbGQgY3B1cyBBTUwNCj4gPiBmdW5jdGlvbiB0byBhY2NlcHQgYm90aCBJTy9NRU1P
UlkgdHlwZSByZWdpb25zIGFuZCB1cGRhdGUgdGhlIF9DUlMgb2JqZWN0DQo+ID4gY29ycmVzcG9u
ZGluZ2x5Lg0KPiA+DQo+ID4gTk9URTogQmVzaWRlIGFib3ZlIENQVSBzY2FuIHNoYWxsIGJlIHRy
aWdnZXJlZCB3aGVuIE9TUE0gZXZhbHVhdGVzIF9FVlQgbWV0aG9kDQo+ID4gICAgICAgIHBhcnQg
b2YgdGhlIEdFRCBmcmFtZXdvcmsgd2hpY2ggaXMgY292ZXJlZCBpbiBzdWJzZXF1ZW50IHBhdGNo
Lg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFAaHVh
d2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdl
aS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdl
aS5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hY3BpL2NwdS5jICAgICAgICAgfCAyMyArKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPiA+ICAgaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgIHwgIDIgKy0NCj4g
PiAgIGluY2x1ZGUvaHcvYWNwaS9jcHUuaCB8ICA1ICsrKy0tDQo+ID4gICAzIGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBJIGd1ZXNz
IHRoZSBjb21taXQgbG9nIGNhbiBiZSBzaW1wbGlmaWVkIHRvOg0KPiANCj4gVGhlIENQVSBob3Rw
bHVnIHJlZ2lzdGVyIGJsb2NrIGlzIGRlY2xhcmVkIGFzIGEgSU8gcmVnaW9uIG9uIHg4Niwgb3Ig
YSBtZW1vcnkNCj4gcmVnaW9uIG9uIGFybTY0IGluIGJ1aWxkX2NwdXNfYW1sKCksIGFzIHBhcnQg
b2YgdGhlIGdlbmVyaWMgY29udGFpbmVyIGRldmljZQ0KPiAoXFxfU0IuUENJMCBvciBcXF9TQi5Q
UkVTKS4NCj4gDQo+IEFkYXB0IGJ1aWxkX2NwdXNfYW1sKCkgc28gdGhhdCBJTyByZWdpb24gYW5k
IG1lbW9yeSByZWdpb24gY2FuIGJlIGhhbmRsZWQNCj4gaW4gdGhlIG1lYW4gd2hpbGUuDQo+IA0K
PiBSZXZpZXdlZC1ieTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCg0KSGFzIGJlZW4g
cmV2aWV3ZWQgYWxyZWFkeSBwYXJ0IG9mIGFyY2hpdGVjdHVyZSBhZ25vc3RpYyBwYXRjaC1zZXQs
DQoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC80NzY0Q0Y0Ny00N0NBLTQ2
ODUtODA1Qy1CQkU2MzEwQkUxNjRAb3JhY2xlLmNvbS9ULyNtZDYxNWM2ZDM0NjRlNzE3ODIxNDc4
NTUwMWU3MDM1YmY5Nzc4ODZmMg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0K

