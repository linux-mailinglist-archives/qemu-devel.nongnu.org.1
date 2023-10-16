Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B37CB564
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVLd-0006sA-Gu; Mon, 16 Oct 2023 17:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVLZ-0006rJ-L6; Mon, 16 Oct 2023 17:41:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVLV-0004eo-Nm; Mon, 16 Oct 2023 17:41:56 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8Vpr2HP9z67M1h;
 Tue, 17 Oct 2023 05:38:28 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 22:41:45 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 22:41:45 +0100
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
Subject: RE: [PATCH RFC V2 12/37] hw/acpi: Use qemu_present_cpu() API in ACPI
 CPU hotplug init
Thread-Topic: [PATCH RFC V2 12/37] hw/acpi: Use qemu_present_cpu() API in ACPI
 CPU hotplug init
Thread-Index: AQHZ8GF/j6Ya82xiO0+8VnmK407UIrAvV0gAgB23i4A=
Date: Mon, 16 Oct 2023 21:41:45 +0000
Message-ID: <6bfe936bdfa94dad97c59451f5ce5f09@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-13-salil.mehta@huawei.com>
 <4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com>
In-Reply-To: <4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com>
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
U2VwdGVtYmVyIDI4LCAyMDIzIDE6NDEgQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBub25nbnUub3Jn
DQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhh
biBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRl
djsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBhcmRiQGtlcm5lbC5vcmc7DQo+IG9saXZlci51cHRv
bkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOw0KPiByYWZh
ZWxAa2VybmVsLm9yZzsgYm9ybnRyYWVnZXJAbGludXguaWJtLmNvbTsgYWxleC5iZW5uZWVAbGlu
YXJvLm9yZzsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0
aW5nLmNvbTsNCj4gaWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgdmlzaG51QG9zLmFtcGVy
ZWNvbXB1dGluZy5jb207DQo+IGthcmwuaGV1YmF1bUBvcmFjbGUuY29tOyBtaWd1ZWwubHVpc0Bv
cmFjbGUuY29tOyBzYWxpbC5tZWh0YUBvcG5zcmMubmV0Ow0KPiB6aHVrZXFpYW4gPHpodWtlcWlh
bjFAaHVhd2VpLmNvbT47IHdhbmd4aW9uZ2ZlbmcgKEMpDQo+IDx3YW5neGlvbmdmZW5nMkBodWF3
ZWkuY29tPjsgd2FuZ3lhbmFuIChZKSA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47DQo+IGppYWtl
cm5lbDJAZ21haWwuY29tOyBtYW9iaWJvQGxvb25nc29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29u
LmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDEyLzM3XSBody9hY3BpOiBVc2UgcWVt
dV9wcmVzZW50X2NwdSgpIEFQSSBpbg0KPiBBQ1BJIENQVSBob3RwbHVnIGluaXQNCj4gDQo+IEhp
IFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAyMDowNCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4g
QUNQSSBDUFUgSG90cGx1ZyBjb2RlIGFzc3VtZXMgYSB2aXJ0dWFsIENQVSBpcyB1bnBsdWdnZWQg
aWYgdGhlIENQVVN0YXRlIG9iamVjdA0KPiA+IGlzIGFic2VudCBpbiB0aGUgbGlzdCBvZiB0aHMg
cG9zc2libGUgQ1BVcyhDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9jcHVzKQ0KPiA+IG1haW50YWlu
ZWQgb24gcGVyLW1hY2hpbmUgYmFzaXMuIFVzZSB0aGUgZWFybGllciBpbnRyb2R1Y2VkIHFlbXVf
cHJlc2VudF9jcHUoKQ0KPiA+IEFQSSB0byBjaGVjayB0aGlzIHN0YXRlLg0KPiA+DQo+ID4gVGhp
cyBjaGFuZ2Ugc2hvdWxkIGhhdmUgbm8gYmVhcmluZyBvbiB0aGUgZnVuY3Rpb25hbGl0eSBvZiBh
bnkgYXJjaGl0ZWN0dXJlIGFuZA0KPiA+IGlzIG1lcmUgYSByZXByZXNlbnRhdGlvbmFsIGNoYW5n
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3
ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYWNwaS9jcHUuYyB8IDUgKysrKy0NCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hY3BpL2NwdS5jIGIvaHcvYWNwaS9jcHUuYw0KPiA+IGluZGV4IDQ1ZGVm
ZGMwZTIuLmQ1YmEzN2IyMDkgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYWNwaS9jcHUuYw0KPiA+ICsr
KyBiL2h3L2FjcGkvY3B1LmMNCj4gPiBAQCAtMjI1LDcgKzIyNSwxMCBAQCB2b2lkIGNwdV9ob3Rw
bHVnX2h3X2luaXQoTWVtb3J5UmVnaW9uICphcywgT2JqZWN0ICpvd25lciwNCj4gPiAgICAgICBz
dGF0ZS0+ZGV2X2NvdW50ID0gaWRfbGlzdC0+bGVuOw0KPiA+ICAgICAgIHN0YXRlLT5kZXZzID0g
Z19uZXcwKHR5cGVvZigqc3RhdGUtPmRldnMpLCBzdGF0ZS0+ZGV2X2NvdW50KTsNCj4gPiAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgaWRfbGlzdC0+bGVuOyBpKyspIHsNCj4gPiAtICAgICAgICBzdGF0
ZS0+ZGV2c1tpXS5jcHUgPSAgQ1BVKGlkX2xpc3QtPmNwdXNbaV0uY3B1KTsNCj4gPiArICAgICAg
ICBzdHJ1Y3QgQ1BVU3RhdGUgKmNwdSA9IENQVShpZF9saXN0LT5jcHVzW2ldLmNwdSk7DQo+ID4g
KyAgICAgICAgaWYgKHFlbXVfcHJlc2VudF9jcHUoY3B1KSkgew0KPiA+ICsgICAgICAgICAgICBz
dGF0ZS0+ZGV2c1tpXS5jcHUgPSBjcHU7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgICAgICBz
dGF0ZS0+ZGV2c1tpXS5hcmNoX2lkID0gaWRfbGlzdC0+Y3B1c1tpXS5hcmNoX2lkOw0KPiA+ICAg
ICAgIH0NCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnN0YXRlLT5jdHJsX3JlZywg
b3duZXIsICZjcHVfaG90cGx1Z19vcHMsIHN0YXRlLA0KPiANCj4gSSBkb24ndCB0aGluayBxZW11
X3ByZXNlbnRfY3B1KCkgaXMgbmVlZGVkIGJlY2F1c2UgYWxsIHBvc3NpYmxlIHZDUFVzIGFyZSBw
cmVzZW50DQo+IGZvciB4ODYgYW5kIGFybTY0IGF0IHRoaXMgcG9pbnQ/IEJlc2lkZXMsIHdlIGhh
dmUgdGhlIGFzc3VtcHRpb24gYWxsIGhvdHBsdWdnYWJsZQ0KPiB2Q1BVcyBhcmUgcHJlc2VudCwg
bG9va2luZyBhdCBKYW1lcycga2VybmVsIHNlcmllcyB3aGVyZSBBQ1BJX0hPVFBMVUdfUFJFU0VO
VF9DUFUNCj4gZXhpc3RzIGluIGxpbnV4L2RyaXZlcnMvYWNwaS9LY29uZmlnIDopDQoNCk5vLCBm
b3IgeDg2IG5vdCBhbGwgcG9zc2libGUgdkNQVXMgbmVlZCB0byBiZSBwcmVzZW50IGF0IFZNIGlu
aXQuIElPQVBJQyBoYXMNCmdvdCBubyBzdWNoIGxpbWl0YXRpb24gbGlrZSBHSUMuIEhvdC1wbHVn
Z2FibGUgdkNQVXMgY2FuIGJlIGRlZmVycmVkIGNyZWF0ZWQuDQpIZW5jZSwgUU9NIENQVVN0YXRl
IG9iamVjdHMgd2lsbCBub3QgYmUgcHJlc2VudCBhbmQgQUNQSSB3aWxsIGV4cG9zZSB0aGVtIGFz
DQpOT1QgUFJFU0VOVCB0byB0aGUgR3Vlc3QgT1MuDQoNClRoaXMgaXMgbm90IHRoZSBjYXNlIHdp
dGggQVJNLiBOb3QgYWxsIHBvc3NpYmxlIHZDUFVzIGFyZSBwcmVzZW50IGF0IFFPTQ0KbGV2ZWwg
YnV0IFFFTVUgKmZha2VzKiB0aGUgcHJlc2VuY2Ugb2YgdkNQVXMgaS5lLiB0aGUgdW5wbHVnZ2Vk
IG9uZXMgdG8NCnRoZSBHdWVzdCBPUyBieSBleHBvc2luZyB0aGVtIGFzIFBSRVNFTlQgaW4gQUNQ
SSBfU1RBIG1ldGhvZC4gTGF0ZXIgaXMNCnJlcXVpcmVkIGR1ZSB0byB0aGUgYXJjaGl0ZWN0dXJh
bCBsaW1pdGF0aW9uIG9mIEFSTS4gR0lDIENQVSBpbnRlcmZhY2VzDQpuZWVkIHRvIGJlIHByZXNl
bnQgaW4gTUFEVCBmb3IgYWxsIHBvc3NpYmxlIHZDUFVzIGF0IGd1ZXN0IGJvb3QgdGltZS4NCg0K
SGVuY2UsIHdlIHJlcXVpcmUgYWJvdmUgY2hhbmdlLg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0K
DQoNCg0KDQo=

