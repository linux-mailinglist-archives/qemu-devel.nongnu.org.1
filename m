Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710E7B503A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnG7O-0001hW-O9; Mon, 02 Oct 2023 06:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnG6z-0001ez-HR; Mon, 02 Oct 2023 06:25:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnG6n-0001FQ-Ay; Mon, 02 Oct 2023 06:25:03 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzcT94TYCz6HJd7;
 Mon,  2 Oct 2023 18:22:21 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 2 Oct 2023 11:24:58 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 2 Oct 2023 11:24:58 +0100
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
Subject: RE: [PATCH RFC V2 03/37] hw/arm/virt: Move setting of common CPU
 properties in a function
Thread-Topic: [PATCH RFC V2 03/37] hw/arm/virt: Move setting of common CPU
 properties in a function
Thread-Index: AQHZ8GEaEyUsIrH+KUCDDRLt+0W0MrAuEgUAgAhCAZA=
Date: Mon, 2 Oct 2023 10:24:58 +0000
Message-ID: <fa8ec6306f124953b939c95a67de1d9a@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-4-salil.mehta@huawei.com>
 <c987543c-c05d-31cf-5cfa-e703d4b90d8f@redhat.com>
In-Reply-To: <c987543c-c05d-31cf-5cfa-e703d4b90d8f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjMgNjoxNyBBTQ0KPiBUbzogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
YXJtQG5vbmdudS5vcmcNCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFy
by5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBpbWFtbWVkb0ByZWRoYXQuY29tOyBhbmRyZXcu
am9uZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsg
ZXJpYy5hdWdlckByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGFyZGJAa2VybmVsLm9yZzsN
Cj4gb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhh
dC5jb207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBib3JudHJhZWdlckBsaW51eC5pYm0uY29tOyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhcnJlbkBv
cy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyB2
aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4ga2FybC5oZXViYXVtQG9yYWNsZS5jb207
IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7DQo+IHpodWtl
cWlhbiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4
aW9uZ2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWku
Y29tPjsNCj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlh
bmdsYWlAbG9vbmdzb24uY24NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgVjIgMDMvMzddIGh3
L2FybS92aXJ0OiBNb3ZlIHNldHRpbmcgb2YgY29tbW9uIENQVQ0KPiBwcm9wZXJ0aWVzIGluIGEg
ZnVuY3Rpb24NCj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAyMDowNCwgU2FsaWwg
TWVodGEgd3JvdGU6DQo+ID4gRmFjdG9yIG91dCBDUFUgcHJvcGVydGllcyBjb2RlIGNvbW1vbiBm
b3Ige2hvdCxjb2xkfS1wbHVnZ2VkIENQVXMuIFRoaXMNCj4gYWxsb3dzDQo+ID4gY29kZSByZXVz
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3
ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQuYyAgICAgICAgIHwgMjIwICsrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgaW5jbHVkZS9ody9h
cm0vdmlydC5oIHwgICA0ICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQwIGluc2VydGlvbnMo
KyksIDg0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMg
Yi9ody9hcm0vdmlydC5jDQo+ID4gaW5kZXggNTdmZTk3YzI0Mi4uMGViNmJmNWExOCAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ID4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiA+IEBA
IC0yMDE4LDE2ICsyMDE4LDEzMCBAQCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV9wb3N0X2luaXQoVmly
dE1hY2hpbmVTdGF0ZQ0KPiAqdm1zLCBNZW1vcnlSZWdpb24gKnN5c21lbSkNCj4gPiAgICAgICB9
DQo+ID4gICB9DQo+ID4NCg0KWy4uLl0NCg0KDQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAg
LyoNCj4gPiArICAgICAqIFJGQzogUXVlc3Rpb246IHRoaXMgbXVzdCBvbmx5IGJlIGNhbGxlZCBm
b3IgdGhlIGhvdHBsdWdnZWQgY3B1cy4gRm9yIHRoZQ0KPiA+ICsgICAgICogY29sZCBib290ZWQg
c2Vjb25kYXJ5IGNwdXMgdGhpcyBpcyBiZWluZyB0YWtlbiBjYXJlIGluIGFybV9sb2FkX2tlcm5l
bCgpDQo+ID4gKyAgICAgKiBpbiBib290LmMuIFBlcmhhcHMgd2Ugc2hvdWxkIHJlbW92ZSB0aGF0
IGNvZGUgbm93Pw0KPiA+ICsgICAgICovDQo+ID4gKyAgICBpZiAodm1zLT5wc2NpX2NvbmR1aXQg
IT0gUUVNVV9QU0NJX0NPTkRVSVRfRElTQUJMRUQpIHsNCj4gPiArICAgICAgICBvYmplY3RfcHJv
cGVydHlfc2V0X2ludChjcHVvYmosICJwc2NpLWNvbmR1aXQiLCB2bXMtPnBzY2lfY29uZHVpdCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4gPiArDQo+ID4g
KyAgICAgICAgLyogU2Vjb25kYXJ5IENQVXMgc3RhcnQgaW4gUFNDSSBwb3dlcmVkLWRvd24gc3Rh
dGUgKi8NCj4gPiArICAgICAgICBpZiAoQ1BVKGNwdW9iaiktPmNwdV9pbmRleCA+IDApIHsNCj4g
PiArICAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKGNwdW9iaiwgInN0YXJ0LXBv
d2VyZWQtb2ZmIiwgdHJ1ZSwgTlVMTCk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+
ICsNCj4gPiArb3V0Og0KPiA+ICsgICAgaWYgKGxvY2FsX2Vycikgew0KPiA+ICsgICAgICAgIGVy
cm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgcmV0
dXJuOw0KPiAgICAgICAgIF5eXl5eXg0KPiANCj4gSXQncyBub3QgbmVlZGVkIG9idmlvdXNseSA6
KQ0KDQoNClllcCwgd2lsbCByZW1vdmUgdGhhdC4NCg0KDQpUaGFua3MNClNhbGlsLg0KDQoNCg==

