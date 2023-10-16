Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B047CB6D4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsWZJ-0000UO-2F; Mon, 16 Oct 2023 19:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWZA-0000Tf-Ls; Mon, 16 Oct 2023 19:00:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWZ7-0000Cw-P6; Mon, 16 Oct 2023 19:00:04 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8XZ60dr2z6K5wl;
 Tue, 17 Oct 2023 06:57:34 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 23:59:52 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 23:59:51 +0100
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
Subject: RE: [PATCH RFC V2 19/37] hw/acpi: ACPI/AML Changes to reflect the
 correct _STA.{PRES,ENA} Bits to Guest
Thread-Topic: [PATCH RFC V2 19/37] hw/acpi: ACPI/AML Changes to reflect the
 correct _STA.{PRES,ENA} Bits to Guest
Thread-Index: AQHZ8GHLlEX4Xw6l3UmDTRJisxuK9rAw1u+AgBxMmfA=
Date: Mon, 16 Oct 2023 22:59:51 +0000
Message-ID: <138a62be6bdd4146b4dfcf0c45991a38@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-20-salil.mehta@huawei.com>
 <da5e5609-1883-8650-c7d8-6868c7b74f1c@redhat.com>
In-Reply-To: <da5e5609-1883-8650-c7d8-6868c7b74f1c@redhat.com>
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

SGkgR2F2aW4sDQoNCj4gRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTI6MzQgQU0NCj4gVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFy
bUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8u
b3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBs
cGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3Lmpv
bmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBhcmRiQGtlcm5lbC5vcmc7DQo+
IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhhdC5jb207IG1zdEByZWRoYXQu
Y29tOw0KPiByYWZhZWxAa2VybmVsLm9yZzsgYm9ybnRyYWVnZXJAbGludXguaWJtLmNvbTsgYWxl
eC5iZW5uZWVAbGluYXJvLm9yZzsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBkYXJyZW5Ab3Mu
YW1wZXJlY29tcHV0aW5nLmNvbTsNCj4gaWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgdmlz
aG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IGthcmwuaGV1YmF1bUBvcmFjbGUuY29tOyBt
aWd1ZWwubHVpc0BvcmFjbGUuY29tOyBzYWxpbC5tZWh0YUBvcG5zcmMubmV0Ow0KPiB6aHVrZXFp
YW4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4aW9uZ2ZlbmcgKEMpDQo+IDx3YW5neGlv
bmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuIChZKSA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNv
bT47DQo+IGppYWtlcm5lbDJAZ21haWwuY29tOyBtYW9iaWJvQGxvb25nc29uLmNuOyBsaXhpYW5n
bGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDE5LzM3XSBody9h
Y3BpOiBBQ1BJL0FNTCBDaGFuZ2VzIHRvIHJlZmxlY3QgdGhlDQo+IGNvcnJlY3QgX1NUQS57UFJF
UyxFTkF9IEJpdHMgdG8gR3Vlc3QNCj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAy
MDowNCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gQUNQSSBBTUwgY2hhbmdlcyB0byBwcm9wZXJs
eSByZWZsZWN0IHRoZSBfU1RBLlBSRVMgYW5kIF9TVEEuRU5BIEJpdHMgdG8NCj4gdGhlDQo+ID4g
Z3Vlc3QgZHVyaW5nIGluaXRpYWx6YXRpb24sIHdoZW4gQ1BVcyBhcmUgaG90cGx1Z2dlZCBhbmQg
YWZ0ZXIgQ1BVcyBhcmUNCj4gPiBob3QtdW5wbHVnZ2VkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBo
dy9hY3BpL2NwdS5jICAgICAgICAgICAgICAgICAgfCA0OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+ID4gICBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMgfCAxMSAr
KysrKysrKw0KPiA+ICAgaW5jbHVkZS9ody9hY3BpL2NwdS5oICAgICAgICAgIHwgIDIgKysNCj4g
PiAgIDMgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody9hY3BpL2NwdS5jIGIvaHcvYWNwaS9jcHUuYw0KPiA+IGlu
ZGV4IDIzMjcyMDk5MmQuLmUxMjk5Njk2ZDMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYWNwaS9jcHUu
Yw0KPiA+ICsrKyBiL2h3L2FjcGkvY3B1LmMNCj4gPiBAQCAtNjMsMTAgKzYzLDExIEBAIHN0YXRp
YyB1aW50NjRfdCBjcHVfaG90cGx1Z19yZCh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPiBhZGRyLCB1
bnNpZ25lZCBzaXplKQ0KPiA+ICAgICAgIGNkZXYgPSAmY3B1X3N0LT5kZXZzW2NwdV9zdC0+c2Vs
ZWN0b3JdOw0KPiA+ICAgICAgIHN3aXRjaCAoYWRkcikgew0KPiA+ICAgICAgIGNhc2UgQUNQSV9D
UFVfRkxBR1NfT0ZGU0VUX1JXOiAvKiBwYWNrIGFuZCByZXR1cm4gaXNfKiBmaWVsZHMgKi8NCj4g
PiAtICAgICAgICB2YWwgfD0gY2Rldi0+Y3B1ID8gMSA6IDA7DQo+ID4gKyAgICAgICAgdmFsIHw9
IGNkZXYtPmlzX2VuYWJsZWQgPyAxIDogMDsNCj4gPiAgICAgICAgICAgdmFsIHw9IGNkZXYtPmlz
X2luc2VydGluZyA/IDIgOiAwOw0KPiA+ICAgICAgICAgICB2YWwgfD0gY2Rldi0+aXNfcmVtb3Zp
bmcgID8gNCA6IDA7DQo+ID4gICAgICAgICAgIHZhbCB8PSBjZGV2LT5md19yZW1vdmUgID8gMTYg
OiAwOw0KPiA+ICsgICAgICAgIHZhbCB8PSBjZGV2LT5pc19wcmVzZW50ID8gMzIgOiAwOw0KPiA+
ICAgICAgICAgICB0cmFjZV9jcHVocF9hY3BpX3JlYWRfZmxhZ3MoY3B1X3N0LT5zZWxlY3Rvciwg
dmFsKTsNCj4gPiAgICAgICAgICAgYnJlYWs7DQo+IA0KPiBUaGUgdkNQVSBzdGF0ZXMgYXJlIHN5
bmNocm9uaXplZCB0byB3aGF0IHdlIGhhZC4gSXQgbWVhbnMgd2UncmUgbWFpbnRhaW5pbmcgdHdv
IHNldA0KPiB2Q1BVIHN0YXRlcywgb25lIGZvciBib2FyZCBsZXZlbCBhbmQgYW5vdGhlciBzZXQg
Zm9yIHZDUFUgaG90cGx1ZyBoZXJlLiBUaGV5IGxvb2sNCj4gZHVwbGljYXRlIHRvIGVhY2ggb3Ro
ZXIuIEhvd2V2ZXIsIGl0IHdpbGwgbmVlZCB0b28gbXVjaCBjb2RlIGNoYW5nZXMgdG8gY29tYmlu
ZQ0KPiB0aGVtLg0KDQpXZSBuZWVkIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gQUNQSSBDUFUgSG90
cGx1ZyBzdGF0ZXMgYW5kIFFPTSBDUFUgc3RhdGVzLg0KQUNQSSBleHBvc2VzIHRoZSBRT00gQ1BV
IHN0YXRlIHRvIEd1ZXN0IE9TLiBUaWxsIG5vdyBBQ1BJIENQVSBIb3RwbHVnDQpzdGF0ZXMgYW5k
IFFPTSBDUFUgc3RhdGVzIHdlcmUgY29uc2lzdGVudCB0byBlYWNoIG90aGVyLiBBQ1BJIGluZmVy
cmVkDQp0aGUgcHJlc2VuY2Ugb2YgUU9NIENQVVN0YXRlIG9iamVjdCBhcyBfU1RBLlBSRVNFTlQ9
MSBhbmQgX1NUQS5FTkFCTEVEPTEuDQoNCkJ1dCB3aXRoIHRoZSBBUk0gQ1BVIGhvdCh1bilwbHVn
IGNoYW5nZXMsIHRoaXMgYXNzdW1wdGlvbiBpcyBubyBsb25nZXIgdHJ1ZS4gDQpRT00gQ1BVU3Rh
dGUgb2JqZWN0IG1pZ2h0IHN0aWxsIGJlIHByZXNlbnQgb3IgTlVMTCBidXQgQUNQSSBDUFUgSG90
cGx1Zw0KU3RhdGUgd2lsbCBhbHdheXMgZXhwb3NlIHVuLXBsdWdnZWQgQ1BVIGkuZS4gd2l0aCBO
VUxMIENQVVN0YXRlIG9iamVjdA0KYXMgX1NUQS5QUkVTRU5UPTEgYW5kIF9TVEEuRU5BQkxFRD0w
LiBUaGlzIGlzIGEga2V5IGNoYW5nZSBiZWNhdXNlIG9mDQp3aGljaCB3ZSBhcmUgYWJsZSB0byBl
bmFibGUgaG90KHVuKXBsdWcgbWVjaGFuaXNtIG9uIEFSTS4NCg0KDQo+IA0KPiA+ICAgICAgIGNh
c2UgQUNQSV9DUFVfQ01EX0RBVEFfT0ZGU0VUX1JXOg0KPiA+IEBAIC0yMjgsNyArMjI5LDIxIEBA
IHZvaWQgY3B1X2hvdHBsdWdfaHdfaW5pdChNZW1vcnlSZWdpb24gKmFzLCBPYmplY3QNCj4gKm93
bmVyLA0KPiA+ICAgICAgICAgICBzdHJ1Y3QgQ1BVU3RhdGUgKmNwdSA9IENQVShpZF9saXN0LT5j
cHVzW2ldLmNwdSk7DQo+ID4gICAgICAgICAgIGlmIChxZW11X3ByZXNlbnRfY3B1KGNwdSkpIHsN
Cj4gPiAgICAgICAgICAgICAgIHN0YXRlLT5kZXZzW2ldLmNwdSA9IGNwdTsNCj4gPiArICAgICAg
ICAgICAgc3RhdGUtPmRldnNbaV0uaXNfcHJlc2VudCA9IHRydWU7DQo+ID4gKyAgICAgICAgfSBl
bHNlIHsNCj4gPiArICAgICAgICAgICAgaWYgKHFlbXVfcGVyc2lzdGVudF9jcHUoY3B1KSkgew0K
PiA+ICsgICAgICAgICAgICAgICAgc3RhdGUtPmRldnNbaV0uaXNfcHJlc2VudCA9IHRydWU7DQo+
ID4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICBzdGF0ZS0+ZGV2
c1tpXS5pc19wcmVzZW50ID0gZmFsc2U7DQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiAgICAgICAg
ICAgfQ0KPiANCj4gc3RhdGUtPmRldnNbaV0uaXNfcHJlc2VudCA9IHFlbXVfcGVyc2lzdGVudF9j
cHUoY3B1KTsNCg0KDQpTdXJlLiBUaGFua3MgZm9yIHBvaW50aW5nLiA6KQ0KDQoNCj4gPiArDQo+
ID4gKyAgICAgICAgaWYgKHFlbXVfZW5hYmxlZF9jcHUoY3B1KSkgew0KPiA+ICsgICAgICAgICAg
ICBzdGF0ZS0+ZGV2c1tpXS5pc19lbmFibGVkID0gdHJ1ZTsNCj4gPiArICAgICAgICB9IGVsc2Ug
ew0KPiA+ICsgICAgICAgICAgICBzdGF0ZS0+ZGV2c1tpXS5pc19lbmFibGVkID0gZmFsc2U7DQo+
ID4gKyAgICAgICAgfQ0KPiA+ICsNCj4gDQo+IHN0YXRlLT5kZXZbaV0uaXNfZW5hYmxlZCA9IHFl
bXVfZW5hYmxlZF9jcHUoY3B1KTsNCg0KDQpTdXJlLiBZZXMuDQoNCg0KVGhhbmtzDQpTYWxpbC4N
Cg==

