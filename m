Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D97CB729
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsXKT-0001Iu-Sl; Mon, 16 Oct 2023 19:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXKR-0001IE-DX; Mon, 16 Oct 2023 19:48:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXKP-0008HV-8w; Mon, 16 Oct 2023 19:48:55 -0400
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8Yhg2SZBz6K8yZ;
 Tue, 17 Oct 2023 07:48:19 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 00:48:48 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 00:48:48 +0100
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
Subject: RE: [PATCH RFC V2 29/37] arm/virt: Update the guest(via GED) about
 CPU hot-(un)plug events
Thread-Topic: [PATCH RFC V2 29/37] arm/virt: Update the guest(via GED) about
 CPU hot-(un)plug events
Thread-Index: AQHZ8GI4VynMOEOUREq7gvOpSDchX7Aw5taAgBxM3NA=
Date: Mon, 16 Oct 2023 23:48:48 +0000
Message-ID: <a6ff886e9e6246cbb10f55eee4d85c97@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-30-salil.mehta@huawei.com>
 <4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com>
In-Reply-To: <4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTozMSBBTQ0KPiBUbzogU2FsaWwgTWVodGEg
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
YWlAbG9vbmdzb24uY24NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgVjIgMjkvMzddIGFybS92
aXJ0OiBVcGRhdGUgdGhlIGd1ZXN0KHZpYSBHRUQpIGFib3V0DQo+IENQVSBob3QtKHVuKXBsdWcg
ZXZlbnRzDQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IE9uIDkvMjYvMjMgMjA6MDQsIFNhbGlsIE1l
aHRhIHdyb3RlOg0KPiA+IER1cmluZyBhbnkgdkNQVSBob3QtKHVuKXBsdWcsIHJ1bm5pbmcgZ3Vl
c3QgVk0gbmVlZHMgdG8gYmUgaW50aW1hdGVkIGFib3V0IHRoZQ0KPiA+IG5ldyB2Q1BVIGJlaW5n
IGFkZGVkIG9yIHJlcXVlc3QgdGhlIGRlbGV0aW9uIG9mIHRoZSB2Q1BVIHdoaWNoIGlzIGFscmVh
ZHkgcGFydA0KPiA+IG9mIHRoZSBndWVzdCBWTS4gVGhpcyBpcyBkb25lIHVzaW5nIHRoZSBBQ1BJ
IEdFRCBldmVudCB3aGljaCBldmVudHVhbGx5IGdldHMNCj4gPiBkZW11bHRpcGxleGVkIHRvIGEg
Q1BVIGhvdHBsdWcgZXZlbnQgYW5kIGZ1cnRoZXIgdG8gc3BlY2lmaWMgaG90LSh1bilwbHVnIGV2
ZW50DQo+ID4gb2YgYSBwYXJ0aWN1bGFyIHZDUFUuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBhZGRz
IHRoZSBBQ1BJIGNhbGxzIHRvIHRoZSBleGlzdGluZyBob3QtKHVuKXBsdWcgaG9va3MgdG8gdHJp
Z2dlcg0KPiA+IEFDUEkgR0VEIGV2ZW50cyBmcm9tIFFFTVUgdG8gZ3Vlc3QgVk0uDQo+ID4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiA+IENvLWRldmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4g
PiAtLS0NCg0KWy4uLl0NCg0KPiA+IEBAIC0zMTY5LDEyICszMTcwLDIwIEBAIHN0YXRpYyB2b2lk
IHZpcnRfY3B1X3BsdWcoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LCBEZXZpY2VTdGF0ZSAq
ZGV2LA0KPiA+ICAgICAgICAqIHBsdWdnZWQsIGd1ZXN0IGlzIGFsc28gbm90aWZpZWQuDQo+ID4g
ICAgICAgICovDQo+ID4gICAgICAgaWYgKHZtcy0+YWNwaV9kZXYpIHsNCj4gPiAtICAgICAgICAv
KiBUT0RPOiB1cGRhdGUgYWNwaSBob3RwbHVnIHN0YXRlLiBTZW5kIGNwdSBob3RwbHVnIGV2ZW50
IHRvIGd1ZXN0ICovDQo+ID4gKyAgICAgICAgSG90cGx1Z0hhbmRsZXJDbGFzcyAqaGhjOw0KPiA+
ICsgICAgICAgIC8qIHVwZGF0ZSBhY3BpIGhvdHBsdWcgc3RhdGUgYW5kIHNlbmQgY3B1IGhvdHBs
dWcgZXZlbnQgdG8gZ3Vlc3QgKi8NCj4gPiArICAgICAgICBoaGMgPSBIT1RQTFVHX0hBTkRMRVJf
R0VUX0NMQVNTKHZtcy0+YWNwaV9kZXYpOw0KPiA+ICsgICAgICAgIGhoYy0+cGx1ZyhIT1RQTFVH
X0hBTkRMRVIodm1zLT5hY3BpX2RldiksIGRldiwgJmxvY2FsX2Vycik7DQo+ID4gKyAgICAgICAg
aWYgKGxvY2FsX2Vycikgew0KPiA+ICsgICAgICAgICAgICBnb3RvIGZhaWw7DQo+ID4gKyAgICAg
ICAgfQ0KPiA+ICAgICAgICAgICAvKiBUT0RPOiByZWdpc3RlciBjcHUgZm9yIHJlc2V0ICYgdXBk
YXRlIEYvVyBpbmZvIGZvciB0aGUgbmV4dCBib290ICovDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgY3MtPmRpc2FibGVkID0gZmFsc2U7DQo+ID4gICAgICAgcmV0dXJuOw0KPiA+ICtmYWls
Og0KPiA+ICsgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ID4gICB9DQo+
ID4NCj4gDQo+ICdmYWlsJyB0YWcgaXNuJ3QgbmVlZGVkIHNpbmNlIGl0J3MgdXNlZCBmb3Igb25j
ZS4gd2UgY2FuIGJhaWwgZWFybHk6DQo+IA0KPiAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4gICAg
ICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCj4gICAgICAgICByZXR1cm47
DQo+ICAgICAgfQ0KDQoNCkFncmVlZC4gSW5kZWVkIHdlIGNhbiByZW1vdmUgZ290by4NCg0KDQpb
Li4uXQ0KDQo+ID4gQEAgLTMyMDIsOSArMzIxMywxNiBAQCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV91
bnBsdWdfcmVxdWVzdChIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQo+ID4gICAgICAgICAg
IHJldHVybjsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAtICAgIC8qIFRPRE86IHJlcXVlc3QgY3B1
IGhvdHBsdWcgZnJvbSBndWVzdCAqLw0KPiA+ICsgICAgLyogcmVxdWVzdCBjcHUgaG90cGx1ZyBm
cm9tIGd1ZXN0ICovDQo+ID4gKyAgICBoaGMgPSBIT1RQTFVHX0hBTkRMRVJfR0VUX0NMQVNTKHZt
cy0+YWNwaV9kZXYpOw0KPiA+ICsgICAgaGhjLT51bnBsdWdfcmVxdWVzdChIT1RQTFVHX0hBTkRM
RVIodm1zLT5hY3BpX2RldiksIGRldiwgJmxvY2FsX2Vycik7DQo+ID4gKyAgICBpZiAobG9jYWxf
ZXJyKSB7DQo+ID4gKyAgICAgICAgZ290byBmYWlsOw0KPiA+ICsgICAgfQ0KPiA+DQo+ID4gICAg
ICAgcmV0dXJuOw0KPiA+ICtmYWlsOg0KPiA+ICsgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxv
Y2FsX2Vycik7DQo+ID4gICB9DQo+ID4NCj4gDQo+IFNhbWUgYXMgYWJvdmUsICdmYWlsJyB0YWcg
aXNuJ3QgbmVlZGVkLiBCZXNpZGVzLCAncmV0dXJuJyBpc24ndCBuZWVkZWQuDQoNCg0KQWdyZWVk
LiBXZSBjYW4gcmVtb3ZlIGdvdG8NCg0KDQoNClsuLi5dDQoNCj4gPiBAQCAtMzIyMiw3ICszMjQy
LDEyIEBAIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3VucGx1ZyhIb3RwbHVnSGFuZGxlcg0KPiAqaG90
cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsDQo+ID4NCj4gPiAgICAgICBjcHVfc2xvdCA9IHZp
cnRfZmluZF9jcHVfc2xvdChtcywgY3MtPmNwdV9pbmRleCk7DQo+ID4NCj4gPiAtICAgIC8qIFRP
RE86IHVwZGF0ZSB0aGUgYWNwaSBjcHUgaG90cGx1ZyBzdGF0ZSBmb3IgY3B1IGhvdC11bnBsdWcg
Ki8NCj4gPiArICAgIC8qIHVwZGF0ZSB0aGUgYWNwaSBjcHUgaG90cGx1ZyBzdGF0ZSBmb3IgY3B1
IGhvdC11bnBsdWcgKi8NCj4gPiArICAgIGhoYyA9IEhPVFBMVUdfSEFORExFUl9HRVRfQ0xBU1Mo
dm1zLT5hY3BpX2Rldik7DQo+ID4gKyAgICBoaGMtPnVucGx1ZyhIT1RQTFVHX0hBTkRMRVIodm1z
LT5hY3BpX2RldiksIGRldiwgJmxvY2FsX2Vycik7DQo+ID4gKyAgICBpZiAobG9jYWxfZXJyKSB7
DQo+ID4gKyAgICAgICAgZ290byBmYWlsOw0KPiA+ICsgICAgfQ0KPiA+DQo+ID4gICAgICAgdW53
aXJlX2dpY19jcHVfaXJxcyh2bXMsIGNzKTsNCj4gPiAgICAgICB2aXJ0X3VwZGF0ZV9naWModm1z
LCBjcyk7DQo+ID4gQEAgLTMyMzYsNiArMzI2MSw4IEBAIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3Vu
cGx1ZyhIb3RwbHVnSGFuZGxlcg0KPiAqaG90cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsDQo+
ID4gICAgICAgY3MtPmRpc2FibGVkID0gdHJ1ZTsNCj4gPg0KPiA+ICAgICAgIHJldHVybjsNCj4g
PiArZmFpbDoNCj4gPiArICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiA+
ICAgfQ0KPiA+DQo+IA0KPiBTYW1lIGFzIGFib3ZlLg0KDQoNCkFncmVlZC4gV2lsbCBmaXguDQoN
Cg0KVGhhbmtzDQpTYWxpbC4NCg==

