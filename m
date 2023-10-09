Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A752D7BEC0C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 22:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxHD-0008GC-W6; Mon, 09 Oct 2023 16:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpxH2-00084x-Jm; Mon, 09 Oct 2023 16:54:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpxGz-0001k7-FV; Mon, 09 Oct 2023 16:54:44 -0400
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S4B970LG5z6K7Gh;
 Tue, 10 Oct 2023 04:54:19 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 21:54:37 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 21:54:37 +0100
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
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
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
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
Subject: RE: [PATCH V4 10/10] target/arm/kvm: Write CPU state back to KVM on
 reset
Thread-Topic: [PATCH V4 10/10] target/arm/kvm: Write CPU state back to KVM on
 reset
Thread-Index: AQHZ+vDU4bIePd9190qIV2a+Q3I29rBB7aTg
Date: Mon, 9 Oct 2023 20:54:36 +0000
Message-ID: <816256a3dd1f406a84f448eeab969c45@huawei.com>
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-11-salil.mehta@huawei.com>
In-Reply-To: <20231009203601.17584-11-salil.mehta@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.175.116]
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

SGVsbG8sDQpQZXJoYXBzIEkgbmVlZCB0byBkcm9wIHRoaXMgcGF0Y2ggZnJvbSB0aGlzIHBhdGNo
LXNldCBhcyBpdCBpcyBBUk0gc3BlY2lmaWMuDQpJIHB1bGxlZCB0aGlzIGZyb20gUkZDIFYyIG9m
IFZpcnR1YWwgQ1BVIEhvdHBsdWcgU3VwcG9ydCBvbiBBUk12OCBhbmQgaXMNCm5vdCByZXF1aXJl
ZCBieSBvdGhlciBhcmNoaXRlY3R1cmVzIHRyeWluZyB0byBpbXBsZW1lbnQgVmlydHVhbCBDUFUg
SG90cGx1Zw0KU3VwcG9ydC4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDIzMDkyNjEwMzY1NC4zNDQyNC0yLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQoNCkkgd2lsbCBy
ZXRhaW4gdGhlIFJldmlld2VkLWJ5J3MgY29sbGVjdGVkIGhlcmUgaW4gdGhlIFJGQyBWMyBwYXRj
aC1zZXQuDQoNClNvcnJ5LCBmb3IgdGhlIG5vaXNlLg0KDQpUaGFua3MNClNhbGlsLg0KDQo+IEZy
b206IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiBTZW50OiBNb25kYXks
IE9jdG9iZXIgOSwgMjAyMyA5OjM2IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFl
bXUtYXJtQG5vbmdudS5vcmcNCj4gQ2M6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWku
Y29tPjsgbWF6QGtlcm5lbC5vcmc7IGplYW4tDQo+IHBoaWxpcHBlQGxpbmFyby5vcmc7IEpvbmF0
aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IGxwaWVyYWxpc2lA
a2VybmVsLm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiByaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnOyBpbWFtbWVkb0ByZWRoYXQuY29tOyBhbmRyZXcuam9uZXNAbGludXguZGV2
Ow0KPiBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJvLm9yZzsgZXJpYy5hdWdlckByZWRo
YXQuY29tOw0KPiBvbGl2ZXIudXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBt
c3RAcmVkaGF0LmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyBnc2hhbkByZWRoYXQuY29tOyByYWZh
ZWxAa2VybmVsLm9yZzsNCj4gYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgbGludXhAYXJtbGludXgu
b3JnLnVrOw0KPiBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgaWxra2FAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbTsNCj4gdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGthcmwuaGV1
YmF1bUBvcmFjbGUuY29tOw0KPiBtaWd1ZWwubHVpc0BvcmFjbGUuY29tOyBzYWxpbC5tZWh0YUBv
cG5zcmMubmV0OyB6aHVrZXFpYW4NCj4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4aW9u
Z2ZlbmcgKEMpIDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsNCj4gd2FuZ3lhbmFuIChZKSA8
d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IGppYWtlcm5lbDJAZ21haWwuY29tOw0KPiBtYW9iaWJv
QGxvb25nc29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBMaW51eGFybSA8bGludXhhcm1A
aHVhd2VpLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIFY0IDEwLzEwXSB0YXJnZXQvYXJtL2t2bTog
V3JpdGUgQ1BVIHN0YXRlIGJhY2sgdG8gS1ZNIG9uDQo+IHJlc2V0DQo+IA0KPiBGcm9tOiBKZWFu
LVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4NCj4gDQo+IFdoZW4g
YSBLVk0gdkNQVSBpcyByZXNldCBmb2xsb3dpbmcgYSBQU0NJIENQVV9PTiBjYWxsLCBpdHMgcG93
ZXIgc3RhdGUNCj4gaXMgbm90IHN5bmNocm9uaXplZCB3aXRoIEtWTSBhdCB0aGUgbW9tZW50LiBC
ZWNhdXNlIHRoZSB2Q1BVIGlzIG5vdA0KPiBtYXJrZWQgZGlydHksIHdlIG1pc3MgdGhlIGNhbGwg
dG8ga3ZtX2FyY2hfcHV0X3JlZ2lzdGVycygpIHRoYXQgd3JpdGVzDQo+IHRvIEtWTSdzIE1QX1NU
QVRFLiBGb3JjZSBtcF9zdGF0ZSBzeW5jaHJvbml6YXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4NCj4gU2ln
bmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IFJldmll
d2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IFJldmlld2Vk
LWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiAtLS0NCj4gIHRhcmdldC9hcm0v
a3ZtLmMgfCA4ICsrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9rdm0uYyBiL3Rhcmdl
dC9hcm0va3ZtLmMNCj4gaW5kZXggYjY2YjkzNmE5NS4uOGNiNzBiOWU3YyAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L2FybS9rdm0uYw0KPiArKysgYi90YXJnZXQvYXJtL2t2bS5jDQo+IEBAIC02NDIs
MTEgKzY0MiwxMiBAQCB2b2lkIGt2bV9hcm1fY3B1X3Bvc3RfbG9hZChBUk1DUFUgKmNwdSkNCj4g
IHZvaWQga3ZtX2FybV9yZXNldF92Y3B1KEFSTUNQVSAqY3B1KQ0KPiAgew0KPiAgICAgIGludCBy
ZXQ7DQo+ICsgICAgQ1BVU3RhdGUgKmNzID0gQ1BVKGNwdSk7DQo+IA0KPiAgICAgIC8qIFJlLWlu
aXQgVkNQVSBzbyB0aGF0IGFsbCByZWdpc3RlcnMgYXJlIHNldCB0bw0KPiAgICAgICAqIHRoZWly
IHJlc3BlY3RpdmUgcmVzZXQgdmFsdWVzLg0KPiAgICAgICAqLw0KPiAtICAgIHJldCA9IGt2bV9h
cm1fdmNwdV9pbml0KENQVShjcHUpKTsNCj4gKyAgICByZXQgPSBrdm1fYXJtX3ZjcHVfaW5pdChj
cyk7DQo+ICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAgICAgZnByaW50ZihzdGRlcnIsICJr
dm1fYXJtX3ZjcHVfaW5pdCBmYWlsZWQ6ICVzXG4iLCBzdHJlcnJvcigtcmV0KSk7DQo+ICAgICAg
ICAgIGFib3J0KCk7DQo+IEBAIC02NjMsNiArNjY0LDExIEBAIHZvaWQga3ZtX2FybV9yZXNldF92
Y3B1KEFSTUNQVSAqY3B1KQ0KPiAgICAgICAqIGZvciB0aGUgc2FtZSByZWFzb24gd2UgZG8gc28g
aW4ga3ZtX2FyY2hfZ2V0X3JlZ2lzdGVycygpLg0KPiAgICAgICAqLw0KPiAgICAgIHdyaXRlX2xp
c3RfdG9fY3B1c3RhdGUoY3B1KTsNCj4gKyAgICAvKg0KPiArICAgICAqIEVuc3VyZSB3ZSBjYWxs
IGt2bV9hcmNoX3B1dF9yZWdpc3RlcnMoKS4gVGhlIHZDUFUgaXNuJ3QgbWFya2VkDQo+IGRpcnR5
IGlmDQo+ICsgICAgICogaXQgd2FzIHBhcmtlZCBpbiBLVk0gYW5kIGlzIG5vdyBib290aW5nIGZy
b20gYSBQU0NJIENQVV9PTiBjYWxsLg0KPiArICAgICAqLw0KPiArICAgIGNzLT52Y3B1X2RpcnR5
ID0gdHJ1ZTsNCj4gIH0NCj4gDQo+ICAvKg0KPiAtLQ0KPiAyLjM0LjENCg0K

