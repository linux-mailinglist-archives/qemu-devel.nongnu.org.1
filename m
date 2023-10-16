Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7147CB542
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsV7T-0002J4-RC; Mon, 16 Oct 2023 17:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsV7Q-0002Id-Qu; Mon, 16 Oct 2023 17:27:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsV7P-0002OJ-3k; Mon, 16 Oct 2023 17:27:20 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8VYL4Hsxz6K91l;
 Tue, 17 Oct 2023 05:26:46 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 22:27:15 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 22:27:15 +0100
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
Subject: RE: [PATCH RFC V2 11/37] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Topic: [PATCH RFC V2 11/37] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Index: AQHZ8GF0jUEtMAUMjkC2sMOxOut0R7AvU9eAgB25x1A=
Date: Mon, 16 Oct 2023 21:27:15 +0000
Message-ID: <13766047efd84bf0b23dbc070578c320@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-12-salil.mehta@huawei.com>
 <dd1028a6-e229-07e3-95e8-ba636dc0651e@redhat.com>
In-Reply-To: <dd1028a6-e229-07e3-95e8-ba636dc0651e@redhat.com>
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
U2VwdGVtYmVyIDI4LCAyMDIzIDE6MjggQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
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
Z3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAxMS8zN10gaHcvYWNwaTogQWRk
IEFDUEkgQ1BVIGhvdHBsdWcgaW5pdCBzdHViDQo+IA0KPiBPbiA5LzI2LzIzIDIwOjA0LCBTYWxp
bCBNZWh0YSB3cm90ZToNCj4gPiBBQ1BJIENQVSBob3RwbHVnIHJlbGF0ZWQgaW5pdGlhbGl6YXRp
b24gc2hvdWxkIG9ubHkgaGFwcGVuZCBpZg0KPiBBQ1BJX0NQVV9IT1RQTFVHDQo+ID4gc3VwcG9y
dCBoYXMgYmVlbiBlbmFibGVkIGZvciBwYXJ0aWN1bGFyIGFyY2hpdGVjdHVyZS4gQWRkDQo+IGNw
dV9ob3RwbHVnX2h3X2luaXQoKQ0KPiA+IHN0dWIgdG8gYXZvaWQgY29tcGlsYXRpb24gYnJlYWsu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2Vp
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgfCA2
ICsrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0K
PiBSZXZpZXdlZC1ieTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCg0KQWxyZWFkeSBk
ZWFsdC4gTm93LCBwYXJ0IG9mIGFyY2hpdGVjdHVyZSBhZ25vc3RpYyBwYXRjaC1zZXQsDQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvNDc2NENGNDctNDdDQS00Njg1LTgwNUMt
QkJFNjMxMEJFMTY0QG9yYWNsZS5jb20vVC8jbThkMTRkZWRhYjhkYmQ5ZmRjNjYzMjRmZjAxM2I5
Yjk5NjY1Njk4MTMNCg0KDQpUaGFua3MNClNhbGlsLg0KDQo=

