Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E657CB6EA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsWq3-0005oH-2v; Mon, 16 Oct 2023 19:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWpw-0005n0-Lk; Mon, 16 Oct 2023 19:17:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWpu-0003AS-SP; Mon, 16 Oct 2023 19:17:24 -0400
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8Xx60pxCz6D8Ww;
 Tue, 17 Oct 2023 07:14:02 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 00:17:19 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 00:17:19 +0100
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
Subject: RE: [PATCH RFC V2 22/37] hw/acpi: Make _MAT method optional
Thread-Topic: [PATCH RFC V2 22/37] hw/acpi: Make _MAT method optional
Thread-Index: AQHZ8GHsQU7PC/tXh0W7a0FKHm8UJLAw23cAgBxRJUA=
Date: Mon, 16 Oct 2023 23:17:19 +0000
Message-ID: <8dcb9b1f298e4eabb5bb0dc7ad306f21@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-23-salil.mehta@huawei.com>
 <ae6cdf01-2ede-69d8-cc6d-60ea1c80cefd@redhat.com>
In-Reply-To: <ae6cdf01-2ede-69d8-cc6d-60ea1c80cefd@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTI6NTAgQU0NCj4gVG86IFNhbGlsIE1laHRh
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
bGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDIyLzM3XSBody9h
Y3BpOiBNYWtlIF9NQVQgbWV0aG9kIG9wdGlvbmFsDQo+IA0KPiBPbiA5LzI2LzIzIDIwOjA0LCBT
YWxpbCBNZWh0YSB3cm90ZToNCj4gPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4t
cGhpbGlwcGVAbGluYXJvLm9yZz4NCj4gPg0KPiA+IFRoZSBHSUNDIGludGVyZmFjZSBvbiBhcm02
NCB2Q1BVcyBpcyBzdGF0aWNhbGx5IGRlZmluZWQgaW4gdGhlIE1BRFQsIGFuZA0KPiA+IGRvZXNu
J3QgcmVxdWlyZSBhIF9NQVQgZW50cnkuIEFsdGhvdWdoIHRoZSBHSUNDIGlzIGluZGljYXRlZCBh
cyBwcmVzZW50DQo+ID4gYnkgdGhlIE1BRFQgZW50cnksIGl0IGNhbiBvbmx5IGJlIHVzZWQgZnJv
bSB2Q1BVIHN5c3JlZ3MsIHdoaWNoIGFyZW4ndA0KPiA+IGFjY2Vzc2libGUgdW50aWwgaG90LWFk
ZC4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFu
LXBoaWxpcHBlQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBC
cnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgaHcvYWNwaS9jcHUuYyB8IDEyICsrKysrKystLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4g
V2l0aCBmb2xsb3dpbmcgbml0cyBhZGRyZXNzZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogR2F2aW4g
U2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCg0KVGhhbmtzLg0KDQoNCj4gDQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FjcGkvY3B1LmMgYi9ody9hY3BpL2NwdS5jDQo+ID4gaW5kZXggZTEyOTk2OTZkMy4u
MjE3ZGI5OTUzOCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hY3BpL2NwdS5jDQo+ID4gKysrIGIvaHcv
YWNwaS9jcHUuYw0KPiA+IEBAIC03MTUsMTEgKzcxNSwxMyBAQCB2b2lkIGJ1aWxkX2NwdXNfYW1s
KEFtbCAqdGFibGUsIE1hY2hpbmVTdGF0ZQ0KPiAqbWFjaGluZSwgQ1BVSG90cGx1Z0ZlYXR1cmVz
IG9wdHMsDQo+ID4gICAgICAgICAgICAgICBhbWxfYXBwZW5kKGRldiwgbWV0aG9kKTsNCj4gPg0K
PiA+ICAgICAgICAgICAgICAgLyogYnVpbGQgX01BVCBvYmplY3QgKi8NCj4gPiAtICAgICAgICAg
ICAgYXNzZXJ0KGFkZXZjICYmIGFkZXZjLT5tYWR0X2NwdSk7DQo+ID4gLSAgICAgICAgICAgIGFk
ZXZjLT5tYWR0X2NwdShpLCBhcmNoX2lkcywgbWFkdF9idWYsDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB0cnVlKTsgLyogc2V0IGVuYWJsZWQgZmxhZyAqLw0KPiA+IC0gICAgICAg
ICAgICBhbWxfYXBwZW5kKGRldiwgYW1sX25hbWVfZGVjbCgiX01BVCIsDQo+ID4gLSAgICAgICAg
ICAgICAgICBhbWxfYnVmZmVyKG1hZHRfYnVmLT5sZW4sICh1aW50OF90ICopbWFkdF9idWYtPmRh
dGEpKSk7DQo+ID4gKyAgICAgICAgICAgIGlmIChhZGV2YyAmJiBhZGV2Yy0+bWFkdF9jcHUpIHsN
Cj4gPiArICAgICAgICAgICAgICAgIGFzc2VydChhZGV2YyAmJiBhZGV2Yy0+bWFkdF9jcHUpOw0K
PiA+ICsgICAgICAgICAgICAgICAgYWRldmMtPm1hZHRfY3B1KGksIGFyY2hfaWRzLCBtYWR0X2J1
ZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVlKTsgLyogc2V0IGVu
YWJsZWQgZmxhZyAqLw0KPiA+ICsgICAgICAgICAgICAgICAgYW1sX2FwcGVuZChkZXYsIGFtbF9u
YW1lX2RlY2woIl9NQVQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGFtbF9idWZmZXIobWFk
dF9idWYtPmxlbiwgKHVpbnQ4X3QgKiltYWR0X2J1Zi0+ZGF0YSkpKTsNCj4gPiArICAgICAgICAg
ICAgfQ0KPiA+ICAgICAgICAgICAgICAgZ19hcnJheV9mcmVlKG1hZHRfYnVmLCB0cnVlKTsNCj4g
Pg0KPiA+ICAgICAgICAgICAgICAgaWYgKENQVShhcmNoX2lkcy0+Y3B1c1tpXS5jcHUpICE9IGZp
cnN0X2NwdSkgew0KPiANCj4gTWF5IGJlIHdvcnRoeSB0byBoYXZlIGNvbW1lbnQgdG8gbWVudGlv
biBfTUFUIGlzbid0IG5lZWRlZCBvbiBhYXJjaDY0Lg0KPiANCj4gICAgICAgICAgICAgICAgIC8q
IEJ1aWxkIF9NQVQgb2JqZWN0LCB3aGljaCBpc24ndCBuZWVkZWQgYnkgYWFyY2g2NCAqLw0KDQpU
aGlzIGZpbGUgaXMgbm90IGFuIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBmaWxlIHNvIG5vdCBhIGdv
b2QgaWRlYQ0KdG8gbWVudGlvbiBhYm92ZS4NCg0KDQpUaGFua3MNClNhbGlsLg0KDQoNCg==

