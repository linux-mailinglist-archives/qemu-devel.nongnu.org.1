Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2577CB638
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsViy-0006kp-Jq; Mon, 16 Oct 2023 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsViw-0006kI-2r; Mon, 16 Oct 2023 18:06:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVis-000063-Bg; Mon, 16 Oct 2023 18:06:05 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8WMs2JV4z6K6Q5;
 Tue, 17 Oct 2023 06:03:37 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 23:05:55 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 23:05:54 +0100
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
Subject: RE: [PATCH RFC V2 17/37] arm/virt/acpi: Build CPUs AML with CPU
 Hotplug support
Thread-Topic: [PATCH RFC V2 17/37] arm/virt/acpi: Build CPUs AML with CPU
 Hotplug support
Thread-Index: AQHZ8GG1bGOsKQBVLUK/RpcGIrG1qbAvZsuAgB2xexA=
Date: Mon, 16 Oct 2023 22:05:54 +0000
Message-ID: <612789af828d4f31ab595a0580074d04@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-18-salil.mehta@huawei.com>
 <832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com>
In-Reply-To: <832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com>
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
U2VwdGVtYmVyIDI4LCAyMDIzIDI6MzYgQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
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
Z3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAxNy8zN10gYXJtL3ZpcnQvYWNw
aTogQnVpbGQgQ1BVcyBBTUwgd2l0aCBDUFUNCj4gSG90cGx1ZyBzdXBwb3J0DQo+IA0KPiBIaSBT
YWxpbCwNCj4gDQo+IE9uIDkvMjYvMjMgMjA6MDQsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiA+IFN1
cHBvcnQgb2YgdkNQVSBIb3RwbHVnIHJlcXVpcmVzIHNlcXVlbmNlIG9mIEFDUEkgaGFuZHNoYWtl
cyBiZXR3ZWVuIFFlbXUNCj4gYW5kDQo+ID4gR3Vlc3Qga2VybmVsIHdoZW4gYSB2Q1BVIGlzIHBs
dWdnZWQgb3IgdW5wbHVnZ2VkLiBNb3N0IG9mIHRoZSBBTUwgY29kZSB0bw0KPiA+IHN1cHBvcnQg
dGhlc2UgaGFuZHNoYWtlcyBhbHJlYWR5IGV4aXN0cy4gVGhpcyBBTUwgbmVlZCB0byBiZSBidWls
ZCBkdXJpbmcgVk0NCj4gPiBpbml0IGZvciBBUk0gYXJjaGl0ZWN0dXJlIGFzIHdlbGwgaWYgdGhl
IEdFRCBzdXBwb3J0IGV4aXN0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQtYWNw
aS1idWlsZC5jIHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0v
dmlydC1hY3BpLWJ1aWxkLmMgYi9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMNCj4gPiBpbmRleCA2
YjY3NDIzMWMyLi5kMjdkZjUwMzBlIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LWFjcGkt
YnVpbGQuYw0KPiA+ICsrKyBiL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYw0KPiA+IEBAIC04NTgs
NyArODU4LDE4IEBAIGJ1aWxkX2RzZHQoR0FycmF5ICp0YWJsZV9kYXRhLCBCSU9TTGlua2VyICps
aW5rZXIsDQo+IFZpcnRNYWNoaW5lU3RhdGUgKnZtcykNCj4gPiAgICAgICAgKiB0aGUgUlRDIEFD
UEkgZGV2aWNlIGF0IGFsbCB3aGVuIHVzaW5nIFVFRkkuDQo+ID4gICAgICAgICovDQo+ID4gICAg
ICAgc2NvcGUgPSBhbWxfc2NvcGUoIlxcX1NCIik7DQo+ID4gLSAgICBhY3BpX2RzZHRfYWRkX2Nw
dXMoc2NvcGUsIHZtcyk7DQo+ID4gKyAgICAvKiBpZiBHRUQgaXMgZW5hYmxlZCB0aGVuIGNwdXMg
QU1MIHNoYWxsIGJlIGFkZGVkIGFzIHBhcnQgYnVpbGRfY3B1c19hbWwgKi8NCj4gPiArICAgIGlm
ICh2bXMtPmFjcGlfZGV2KSB7DQo+ID4gKyAgICAgICAgQ1BVSG90cGx1Z0ZlYXR1cmVzIG9wdHMg
PSB7DQo+ID4gKyAgICAgICAgICAgICAuYWNwaV8xX2NvbXBhdGlibGUgPSBmYWxzZSwNCj4gPiAr
ICAgICAgICAgICAgIC5oYXNfbGVnYWN5X2NwaHAgPSBmYWxzZQ0KPiA+ICsgICAgICAgIH07DQo+
ID4gKw0KPiA+ICsgICAgICAgIGJ1aWxkX2NwdXNfYW1sKHNjb3BlLCBtcywgb3B0cywgbWVtbWFw
W1ZJUlRfQ1BVSFBfQUNQSV0uYmFzZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAiXFxf
U0IiLCBOVUxMLCBBTUxfU1lTVEVNX01FTU9SWSk7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsg
ICAgICAgIGFjcGlfZHNkdF9hZGRfY3B1cyhzY29wZSwgdm1zKTsNCj4gPiArICAgIH0NCj4gPiAg
ICAgICBhY3BpX2RzZHRfYWRkX3VhcnQoc2NvcGUsICZtZW1tYXBbVklSVF9VQVJUXSwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgKGlycW1hcFtWSVJUX1VBUlRdICsgQVJNX1NQSV9CQVNF
KSk7DQo+ID4gICAgICAgaWYgKHZtYy0+YWNwaV9leHBvc2VfZmxhc2gpIHsNCj4gDQo+IEkgZG9u
J3QgdGhpbmsgaXQncyBlbm91Z2ggdG8gY2hlY2sgdm1zLT5hY3BpX2Rldi4gdkNQVSBob3RwbHVn
IG5lZWRuJ3QgdG8gYmUNCj4gc3VwcG9ydGVkIGV2ZW4gdm1zLT5hY3BpX2RldiBleGlzdHMuIEZv
ciBleGFtcGxlIHdoZW4gdkdJQ3YyIGluc3RlYWQgb2YNCj4gdkdJQ3YzIGlzIGVuYWJsZWQsIGFu
ZCBzbyBvbi4NCg0KR29vZCBjYXRjaC4NCg0KJ21jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMnIGhh
cyB0byBiZSBhZGRlZC4gV2lsbCBmaXguDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0KDQoNCg0KDQo=

