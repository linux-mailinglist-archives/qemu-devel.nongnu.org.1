Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B17CB741
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 02:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsXYn-0003w0-6m; Mon, 16 Oct 2023 20:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXYi-0003vR-I1; Mon, 16 Oct 2023 20:03:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXYf-0002c5-DN; Mon, 16 Oct 2023 20:03:40 -0400
Received: from lhrpeml100005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8YyN0q5vz6D8WY;
 Tue, 17 Oct 2023 08:00:12 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 01:03:29 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 01:03:29 +0100
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
Subject: RE: [PATCH RFC V2 34/37] target/arm/kvm,tcg: Register/Handle SMCCC
 hypercall exits to VMM/Qemu
Thread-Topic: [PATCH RFC V2 34/37] target/arm/kvm,tcg: Register/Handle SMCCC
 hypercall exits to VMM/Qemu
Thread-Index: AQHZ8GWMDdii6sX7lUSrQMIiRR4LzrAxJX4AgBwQ8gA=
Date: Tue, 17 Oct 2023 00:03:29 +0000
Message-ID: <363b994b5e904622a8f5dde980d48056@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
 <20230926103654.34424-3-salil.mehta@huawei.com>
 <a3ae4b88-6066-4c21-5fe5-cfe74bc58aaa@redhat.com>
In-Reply-To: <a3ae4b88-6066-4c21-5fe5-cfe74bc58aaa@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgNToxNSBBTQ0KPiBUbzogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJt
QG5vbmdudS5vcmcNCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5v
cmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyByaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBpbWFtbWVkb0ByZWRoYXQuY29tOyBhbmRyZXcuam9u
ZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgZXJp
Yy5hdWdlckByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGFyZGJAa2VybmVsLm9yZzsNCj4g
b2xpdmVyLnVwdG9uQGxpbnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5j
b207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBib3JudHJhZWdlckBsaW51eC5pYm0uY29tOyBhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhcnJlbkBvcy5h
bXBlcmVjb21wdXRpbmcuY29tOw0KPiBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyB2aXNo
bnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4ga2FybC5oZXViYXVtQG9yYWNsZS5jb207IG1p
Z3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7DQo+IHpodWtlcWlh
biA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4aW9u
Z2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWkuY29t
PjsNCj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlhbmds
YWlAbG9vbmdzb24uY24NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgVjIgMzQvMzddIHRhcmdl
dC9hcm0va3ZtLHRjZzogUmVnaXN0ZXIvSGFuZGxlIFNNQ0NDDQo+IGh5cGVyY2FsbCBleGl0cyB0
byBWTU0vUWVtdQ0KPiANCj4gSGkgU2FsaWwsDQo+IA0KPiBPbiA5LzI2LzIzIDIwOjM2LCBTYWxp
bCBNZWh0YSB3cm90ZToNCj4gPiBGcm9tOiBBdXRob3IgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QGh1YXdlaS5jb20+DQo+ID4NCj4gPiBBZGQgcmVnaXN0cmF0aW9uIGFuZCBIYW5kbGluZyBvZiBI
VkMvU01DIGh5cGVyY2FsbCBleGl0cyB0byBWTU0NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTog
U2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5
OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2Vp
LmNvbT4NCg0KWy4uLl0NCg0KPiA+ICtzdGF0aWMgQ1BVQXJjaElkICphcm1fZ2V0X2FyY2hpZF9i
eV9pZCh1aW50NjRfdCBpZCkNCj4gPiArew0KPiA+ICsgICAgaW50IG47DQo+ID4gKyAgICBDUFVB
cmNoSWQgKmFyY2hfaWQ7DQo+ID4gKyAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORShxZGV2
X2dldF9tYWNoaW5lKCkpOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBBdCB0aGlz
IHBvaW50IGRpc2FibGVkIENQVXMgZG9uJ3QgaGF2ZSBhIENQVVN0YXRlLCBidXQgdGhlaXIgQ1BV
QXJjaElkDQo+ID4gKyAgICAgKiBleGlzdHMuDQo+ID4gKyAgICAgKg0KPiA+ICsgICAgICogVE9E
TzogSXMgYXJjaF9pZCA9PSBtcF9hZmZpbml0eT8gVGhpcyBuZWVkcyB3b3JrLg0KPiA+ICsgICAg
ICovDQo+ID4gKyAgICBmb3IgKG4gPSAwOyBuIDwgbXMtPnBvc3NpYmxlX2NwdXMtPmxlbjsgbisr
KSB7DQo+ID4gKyAgICAgICAgYXJjaF9pZCA9ICZtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tuXTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgaWYgKGFyY2hfaWQtPmFyY2hfaWQgPT0gaWQpIHsNCj4gPiAr
ICAgICAgICAgICAgcmV0dXJuIGFyY2hfaWQ7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0K
PiA+ICsgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBUaGUgQGFyY2hfaWQg
c2hvdWxkIGJlIHNhbWUgdGhpbmcgdG8gQG1wX2FmZmluaXR5IGV4Y2VwdCBmb3IgdGhlIGJvb3Qg
Q1BVLg0KPiBGb3IgdGhlIGJvb3QgQ1BVLCBpdHMgdmFsdWUgaXMgZmV0Y2hlZCBmcm9tIE1QSURS
LCB3aGljaCBpcyBkZXRlcm1pbmVkIGJ5DQo+IGNzLT5jcHVfaW5kZXgsIHBhc3NlZCB0byBob3N0
IHZpYSBpb2N0bChDUkVBVEVfVkNQVSkuIEJlc2lkZXMsIGFub3RoZXINCj4gc2ltaWxpYXIgZnVu
Y3Rpb24gcWVtdV9nZXRfY3B1X2FyY2hpZCgpIGV4aXN0cyBpbiBjcHVzLWNvbW1vbi5jLiBJIHRo
aW5rDQo+IHRoZXkgY2FuIGJlIGNvbWJpbmVkLiBBZ2FpbiwgYWxsIHRoZXNlIGluZm9ybWF0aW9u
IGluaGVyaXRlZCBmcm9tDQo+IG1zLT5wb3NzaWJsZV9jcHVzIG1heSBiZSBiZXR0ZXIgdG8gYmUg
bWFuYWdlZCBpbiBib2FyZCBsZXZlbCwgbGlrZSB0aGUNCj4gdkNQVSBzdGF0ZXMuDQoNClllcywg
Z29vZCBjYXRjaC4gVGhpcyBoYXMgYmVlbiBleGlzdGluZyBmb3IgbG9uZyBzbyBteSBleWVzIGdv
dCBiaWFzZWQuDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQpbLi4uXQ0KDQo+ID4gQEAgLTE2OCwx
MiArMTg5LDI0IEBAIGludCBhcm1fc2V0X2NwdV9vbih1aW50NjRfdCBjcHVpZCwgdWludDY0X3Qg
ZW50cnksDQo+IHVpbnQ2NF90IGNvbnRleHRfaWQsDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAg
ICAgLyogUmV0cmlldmUgdGhlIGNwdSB3ZSBhcmUgcG93ZXJpbmcgdXAgKi8NCj4gPiAtICAgIHRh
cmdldF9jcHVfc3RhdGUgPSBhcm1fZ2V0X2NwdV9ieV9pZChjcHVpZCk7DQo+ID4gLSAgICBpZiAo
IXRhcmdldF9jcHVfc3RhdGUpIHsNCj4gPiArICAgIGFyY2hfaWQgPSBhcm1fZ2V0X2FyY2hpZF9i
eV9pZChjcHVpZCk7DQo+ID4gKyAgICBpZiAoIWFyY2hfaWQpIHsNCj4gPiAgICAgICAgICAgLyog
VGhlIGNwdSB3YXMgbm90IGZvdW5kICovDQo+ID4gICAgICAgICAgIHJldHVybiBRRU1VX0FSTV9Q
T1dFUkNUTF9JTlZBTElEX1BBUkFNOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgdGFyZ2V0
X2NwdV9zdGF0ZSA9IENQVShhcmNoX2lkLT5jcHUpOw0KPiA+ICsgICAgaWYgKCFxZW11X2VuYWJs
ZWRfY3B1KHRhcmdldF9jcHVfc3RhdGUpKSB7DQo+ID4gKyAgICAgICAgLyoNCj4gPiArICAgICAg
ICAgKiBUaGUgY3B1IGlzIG5vdCBwbHVnZ2VkIGluIG9yIGRpc2FibGVkLiBXZSBzaG91bGQgcmV0
dXJuIGFwcHJvcHJpYXRlDQo+ID4gKyAgICAgICAgICogdmFsdWUgYXMgaW50cm9kdWNlZCBpbiBE
RU4wMDIyRSBQU0NJIDEuMiBpc3N1ZSBFDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlzc3VlIEUsIHdoaWNoIGlzIFFF
TVVfUFNDSV9SRVRfREVOSUVELg0KDQogICBQU0NJX1JFVF9ERU5JRUQNCg0KDQpbLi4uXQ0KDQo+
ID4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPiA+ICsrKyBiL3RhcmdldC9hcm0vaGVscGVy
LmMNCj4gPiBAQCAtMTExODcsNyArMTExODcsNyBAQCB2b2lkIGFybV9jcHVfZG9faW50ZXJydXB0
KENQVVN0YXRlICpjcykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPmV4Y2VwdGlv
bi5zeW5kcm9tZSk7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gLSAgICBpZiAodGNnX2VuYWJsZWQo
KSAmJiBhcm1faXNfcHNjaV9jYWxsKGNwdSwgY3MtPmV4Y2VwdGlvbl9pbmRleCkpIHsNCj4gPiAr
ICAgIGlmIChhcm1faXNfcHNjaV9jYWxsKGNwdSwgY3MtPmV4Y2VwdGlvbl9pbmRleCkpIHsNCj4g
PiAgICAgICAgICAgYXJtX2hhbmRsZV9wc2NpX2NhbGwoY3B1KTsNCj4gPiAgICAgICAgICAgcWVt
dV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIi4uLmhhbmRsZWQgYXMgUFNDSSBjYWxsXG4iKTsNCj4g
PiAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gV2UgbWF5IHN0aWxsIGxpbWl0IHRoZSBjYXBhYmls
aXR5IHRvIGhhbmRsZSBQU0NJIGNhbGxzIHRvIFRDRyBhbmQgS1ZNLA0KPiBtZWFuaW5nIEhWRiBh
bmQgUVRlc3Qgd29uJ3QgaGF2ZSB0aGlzIGNhcGFiaWxpdHkuDQoNCg0KV2UgZG8gbm90IHN1cHBv
cnQgdGhlbSBub3cuIEkgbmVlZCB0byBjb25kaXRpb25hbGx5IHJlZ2lzdGVyIFNNQ0MgY2FsbHMN
CldpdGggS1ZNLiBXaWxsIGNoZWNrIHRoaXMuIEdvb2QgcG9pbnQgdGhvdWdoLg0KDQpUaGFua3MN
ClNhbGlsLg0KDQoNClsuLi5dDQoNCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS9rdm0uYyBi
L3RhcmdldC9hcm0va3ZtLmMNCj4gPiBpbmRleCA4ZTdjNjhhZjZhLi42ZjNmZDVhZWNkIDEwMDY0
NA0KPiA+IC0tLSBhL3RhcmdldC9hcm0va3ZtLmMNCj4gPiArKysgYi90YXJnZXQvYXJtL2t2bS5j
DQo+ID4gQEAgLTI1MCw2ICsyNTAsNyBAQCBpbnQga3ZtX2FybV9nZXRfbWF4X3ZtX2lwYV9zaXpl
KE1hY2hpbmVTdGF0ZSAqbXMsDQo+IGJvb2wgKmZpeGVkX2lwYSkNCj4gPiAgIGludCBrdm1fYXJj
aF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMsIEtWTVN0YXRlICpzKQ0KPiA+ICAgew0KPiA+ICAgICAg
IGludCByZXQgPSAwOw0KPiA+ICsNCj4gICAgXl5eXg0KPiBVbm5lY2Vzc2FyeSBjaGFuZ2UuDQoN
Clllcy4NCg0KVGhhbmtzLg0KDQoNClsuLi5dDQoNCj4gPiBAQCAtMjgwLDYgKzI4MSwyMiBAQCBp
bnQga3ZtX2FyY2hfaW5pdChNYWNoaW5lU3RhdGUgKm1zLCBLVk1TdGF0ZSAqcykNCj4gPiAgICAg
ICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIFRvIGJl
IGFibGUgdG8gaGFuZGxlIFBTQ0kgQ1BVIE9OIGNhbGxzIGluIFFFTVUsIHdlIG5lZWQgdG8gaW5z
dGFsbCBTTUNDQw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT04vT0ZGDQoNClll
cy4NCg0KPiA+ICsgICAgICogZmlsdGVyIGluIHRoZSBIb3N0IEtWTS4gVGhpcyBpcyByZXF1aXJl
ZCB0byBzdXBwb3J0IGZlYXR1cmVzIGxpa2UNCj4gPiArICAgICAqIHZpcnR1YWwgQ1BVIEhvdHBs
dWcgb24gQVJNIHBsYXRmb3Jtcy4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKGt2bV9hcm1f
c2V0X3NtY2NjX2ZpbHRlcihQU0NJXzBfMl9GTjY0X0NQVV9PTiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgS1ZNX1NNQ0NDX0ZJTFRFUl9GV0RfVE9fVVNFUikpIHsNCj4g
PiArICAgICAgICBlcnJvcl9yZXBvcnQoIkNQVSBPbiBQU0NJLXRvLXVzZXItc3BhY2UgZndkIGZp
bHRlciBpbnN0YWxsIGZhaWxlZCIpOw0KPiA+ICsgICAgICAgIGFib3J0KCk7DQo+ID4gKyAgICB9
DQo+ID4gKyAgICBpZiAoa3ZtX2FybV9zZXRfc21jY2NfZmlsdGVyKFBTQ0lfMF8yX0ZOX0NQVV9P
RkYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEtWTV9TTUNDQ19GSUxU
RVJfRldEX1RPX1VTRVIpKSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDUFUgT2ZmIFBT
Q0ktdG8tdXNlci1zcGFjZSBmd2QgZmlsdGVyIGluc3RhbGwgZmFpbGVkIik7DQo+ID4gKyAgICAg
ICAgYWJvcnQoKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICAga3ZtX2FybV9pbml0X2Rl
YnVnKHMpOw0KPiA+DQo+ID4gICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IFRoZSBQU0NJX09OIGFu
ZCBQU0NJX09GRiB3aWxsIGJlIHVuY29uZGl0aW9uYWxseSBoYW5kbGVkIGJ5IFFFTVUgaWYgS1ZN
IGlzDQo+IGVuYWJsZWQsIGV2ZW4gdkNQVSBob3RwbHVnIGlzbid0IHN1cHBvcnRlZCBvbiBody9h
cm0vdmlydCBib2FyZC4gRG8gd2UgbmVlZCB0bw0KPiBlbmFibGUgaXQgb25seSB3aGVuIHZDUFUg
aG90cGx1ZyBpcyBzdXBwb3J0ZWQ/DQoNClllcy4gVHJ1ZS4gSSBtaXNzZWQgdGhpcyBlYXJsaWVy
LiBJdCBzaG91bGQgYmUgY29uZGl0aW9uYWwuDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQo+IA0K
PiA+IEBAIC05NTIsNiArOTY5LDM4IEBAIHN0YXRpYyBpbnQga3ZtX2FybV9oYW5kbGVfZGFidF9u
aXN2KENQVVN0YXRlICpjcywNCj4gdWludDY0X3QgZXNyX2lzcywNCj4gPiAgICAgICByZXR1cm4g
LTE7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBrdm1fYXJtX2hhbmRsZV9oeXBlcmNh
bGwoQ1BVU3RhdGUgKmNzLCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQ0KPiA+ICt7DQo+ID4gKyAgICBB
Uk1DUFUgKmNwdSA9IEFSTV9DUFUoY3MpOw0KPiA+ICsgICAgQ1BVQVJNU3RhdGUgKmVudiA9ICZj
cHUtPmVudjsNCj4gPiArDQo+ID4gKyAgICBrdm1fY3B1X3N5bmNocm9uaXplX3N0YXRlKGNzKTsN
Cj4gPiArDQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogaGFyZCBjb2RpbmcgaW1tZWRpYXRlIHRv
IDAgYXMgd2UgZG9udCBleHBlY3Qgbm9uLXplcm8gdmFsdWUgYXMgb2Ygbm93DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRvbid0DQoNClRoYW5rcw0KU2FsaWwuDQoN
Cg==

