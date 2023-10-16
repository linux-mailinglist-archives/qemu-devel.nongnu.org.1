Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7317CB6E9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsWoB-0004p6-Fk; Mon, 16 Oct 2023 19:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWo8-0004oi-FP; Mon, 16 Oct 2023 19:15:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsWo5-0002md-EX; Mon, 16 Oct 2023 19:15:32 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8Xy35SDFz6K92N;
 Tue, 17 Oct 2023 07:14:51 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 00:15:20 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 00:15:20 +0100
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
Subject: RE: [PATCH RFC V2 21/37] hw/arm: MADT Tbl change to size the guest
 with possible vCPUs
Thread-Topic: [PATCH RFC V2 21/37] hw/arm: MADT Tbl change to size the guest
 with possible vCPUs
Thread-Index: AQHZ8GHhu7/EC4ejOkqej5qvQbET0rAw2bIAgBxPcYA=
Date: Mon, 16 Oct 2023 23:15:20 +0000
Message-ID: <8f946b9978584363b3b6f59afb75c005@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-22-salil.mehta@huawei.com>
 <eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com>
In-Reply-To: <eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTI6NDQgQU0NCj4gVG86IFNhbGlsIE1laHRh
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
bGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDIxLzM3XSBody9h
cm06IE1BRFQgVGJsIGNoYW5nZSB0byBzaXplIHRoZSBndWVzdA0KPiB3aXRoIHBvc3NpYmxlIHZD
UFVzDQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IE9uIDkvMjYvMjMgMjA6MDQsIFNhbGlsIE1laHRh
IHdyb3RlOg0KPiA+IENoYW5nZXMgcmVxdWlyZWQgZHVyaW5nIGJ1aWxkaW5nIG9mIE1BRFQgVGFi
bGUgYnkgUUVNVSB0byBhY2NvbW1vZGF0ZSBkaXNhYmxlZA0KPiA+IHBvc3NpYmxlIHZDUFVzLiBU
aGlzIGluZm8gc2hhbGwgYmUgdXNlZCBieSB0aGUgZ3Vlc3Qga2VybmVsIHRvIHNpemUgdXAgaXRz
DQo+ID4gcmVzb3VyY2VzIGR1cmluZyBib290IHRpbWUuIFRoaXMgcHJlLXNpemluZyBvZiB0aGUg
Z3Vlc3Qga2VybmVsIGRvbmUgb24NCj4gPiBwb3NzaWJsZSB2Q1BVcyB3aWxsIGZhY2lsaXRhdGUg
aG90cGx1ZyBvZiB0aGUgZGlzYWJsZWQgdkNQVXMuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBhbHNv
IGNhdGVycyBBQ1BJIE1BRFQgR0lDIENQVSBJbnRlcmZhY2UgZmxhZyByZWxhdGVkIGNoYW5nZXMN
Cj4gPiByZWNlbnRseSBpbnRyb2R1Y2VkIGluIHRoZSBVRUZJIEFDUEkgNi41IFNwZWNpZmljYXRp
b24gd2hpY2ggYWxsb3dzIGRlZmVycmVkDQo+ID4gdmlydHVhbCBDUFUgb25saW5lJ2luZyBpbiB0
aGUgR3Vlc3QgS2VybmVsLg0KPiA+DQo+ID4gTGluazoNCj4gaHR0cHM6Ly91ZWZpLm9yZy9zcGVj
cy9BQ1BJLzYuNS8wNV9BQ1BJX1NvZnR3YXJlX1Byb2dyYW1taW5nX01vZGVsLmh0bWwjZ2ljLWNw
dS1pbnRlcmZhY2UtZ2ljYy1zdHJ1Y3R1cmUNCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogU2Fs
aWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2Fs
aWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBL
ZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2Vx
aWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3Zp
cnQtYWNwaS1idWlsZC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMgYi9ody9hcm0v
dmlydC1hY3BpLWJ1aWxkLmMNCj4gPiBpbmRleCBkMjdkZjUwMzBlLi5jYmNjZDJjYTJkIDEwMDY0
NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYw0KPiA+ICsrKyBiL2h3L2FybS92
aXJ0LWFjcGktYnVpbGQuYw0KPiA+IEBAIC03MDAsNiArNzAwLDI5IEBAIHN0YXRpYyB2b2lkIGJ1
aWxkX2FwcGVuZF9naWNyKEdBcnJheSAqdGFibGVfZGF0YSwgdWludDY0X3QgYmFzZSwgdWludDMy
X3Qgc2l6ZSkNCj4gPiAgICAgICBidWlsZF9hcHBlbmRfaW50X25vcHJlZml4KHRhYmxlX2RhdGEs
IHNpemUsIDQpOyAvKiBEaXNjb3ZlcnkgUmFuZ2UgTGVuZ3RoICovDQo+ID4gICB9DQo+ID4NCj4g
PiArc3RhdGljIHVpbnQzMl90IHZpcnRfYWNwaV9nZXRfZ2ljY19mbGFncyhDUFVTdGF0ZSAqY3B1
KQ0KPiA+ICt7DQo+ID4gKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9HRVRfQ0xBU1Mo
cWRldl9nZXRfbWFjaGluZSgpKTsNCj4gPiArDQo+ID4gKyAgICAvKiBjYW4gb25seSBleGlzdCBp
biAnZW5hYmxlZCcgc3RhdGUgKi8NCj4gPiArICAgIGlmICghbWMtPmhhc19ob3RwbHVnZ2FibGVf
Y3B1cykgew0KPiA+ICsgICAgICAgIHJldHVybiAxOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgIC8qDQo+ID4gKyAgICAgKiBBUk0gR0lDIENQVSBJbnRlcmZhY2UgY2FuIGJlICdvbmxpbmUt
Y2FwYWJsZScgb3IgJ2VuYWJsZWQnIGF0IGJvb3QNCj4gPiArICAgICAqIFdlIE1VU1Qgc2V0ICdv
bmxpbmUtY2FwYWJsZScgQml0IGZvciBhbGwgaG90cGx1Z2dhYmxlIENQVXMgZXhjZXB0IHRoZQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiaXQNCg0KOikNCg0KPiA+ICsgICAgICog
Zmlyc3QvYm9vdCBDUFUuIENvbGQtYm9vdGVkIENQVXMgd2l0aG91dCAnSWQnIGNhbiBhbHNvIGJl
IHVucGx1Z2dlZC4NCj4gPiArICAgICAqIFRob3VnaCBhcy1vZi1ub3cgdGhpcyBpcyBvbmx5IHVz
ZWQgYXMgYSBkZWJ1Z2dpbmcgZmVhdHVyZS4NCj4gPiArICAgICAqDQo+ID4gKyAgICAgKiAgIFVF
RkkgQUNQSSBTcGVjaWZpY2F0aW9uIDYuNQ0KPiA+ICsgICAgICogICBTZWN0aW9uOiA1LjIuMTIu
MTQuIEdJQyBDUFUgSW50ZXJmYWNlIChHSUNDKSBTdHJ1Y3R1cmUNCj4gPiArICAgICAqICAgVGFi
bGU6ICAgNS4zNyBHSUNDIENQVSBJbnRlcmZhY2UgRmxhZ3MNCj4gPiArICAgICAqICAgTGluazog
aHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNQ0KPiA+ICsgICAgICovDQo+ID4gKyAgICBy
ZXR1cm4gY3B1ICYmICFjcHUtPmNwdV9pbmRleCA/IDEgOiAoMSA8PCAzKTsNCj4gPiArfQ0KPiA+
ICsNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgYSBjb2xkLWJvb3RlZCBDUFUgY2FuIGJl
IGhvdCByZW1vdmVkIGlmIGl0IGRvZXNuJ3QNCj4gaGF2ZSBhIElEPyBCZXNpZGVzLCBob3cgY3B1
LT5jcHVfaW5kZXggaXMgemVybyBmb3IgdGhlIGZpcnN0IGNvbGQtYm9vdGVkDQo+IENQVT8NCg0K
U29tZSBjb2xkLWJvb3RlZCBDUFVzIGNhbiBiZSAncGx1Z2dhYmxlJy4gSGVuY2UsIGNhbiBoYXZl
ICdJRCcgc3BlY2lmaWVkDQphcyBwYXJ0IG9mIHRoZSBRRU1VIGNvbW1hbmQgbGluZS4gVGhpcyAn
SUQnIGNhbiBiZSB1c2VkIHRvIGhvdCh1bilwbHVnDQpsYXRlciAoaWYgc3VwcG9ydGVkKS4gDQoN
CllvdSBjYW4gYWxzbyBzdGFydCBRRU1VIHdpdGggJy1zJyBvcHRpb24gd2hpY2ggd2lsbCBwYXVz
ZSB0aGUgUUVNVSBhbmQNCnRoZW4geW91IGNhbiBjb2xkLXBsdWcgdGhlIENQVXMgZHVyaW5nIFZN
IGluaXRpYWxpemF0aW9uIHRpbWUuDQoNCkdvb2QgcG9pbnQgYWJvdXQgYm9vdCBDUFUuDQpCdXQs
IGl0IGlzIGEgZGVmYXVsdCBhc3N1bXB0aW9uIHRvIGhhdmUgYm9vdCBDUFUgYXMgMCBvbiBBUk0g
LSBJIHRoaW5rPw0KDQpJIHdpbGwgbmVlZCB0byBjcm9zcyB0aGlzIHBhcnQuDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgdGhpcyB0aG91Z2guDQoNCj4gDQo+ID4gICBzdGF0aWMgdm9pZA0KPiA+ICAg
YnVpbGRfbWFkdChHQXJyYXkgKnRhYmxlX2RhdGEsIEJJT1NMaW5rZXIgKmxpbmtlciwgVmlydE1h
Y2hpbmVTdGF0ZQ0KPiAqdm1zKQ0KPiA+ICAgew0KPiA+IEBAIC03MjYsMTIgKzc0OSwxMyBAQCBi
dWlsZF9tYWR0KEdBcnJheSAqdGFibGVfZGF0YSwgQklPU0xpbmtlciAqbGlua2VyLA0KPiBWaXJ0
TWFjaGluZVN0YXRlICp2bXMpDQo+ID4gICAgICAgYnVpbGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0
YWJsZV9kYXRhLCB2bXMtPmdpY192ZXJzaW9uLCAxKTsNCj4gPiAgICAgICBidWlsZF9hcHBlbmRf
aW50X25vcHJlZml4KHRhYmxlX2RhdGEsIDAsIDMpOyAgIC8qIFJlc2VydmVkICovDQo+ID4NCj4g
PiAtICAgIGZvciAoaSA9IDA7IGkgPCBNQUNISU5FKHZtcyktPnNtcC5jcHVzOyBpKyspIHsNCj4g
PiAtICAgICAgICBBUk1DUFUgKmFybWNwdSA9IEFSTV9DUFUocWVtdV9nZXRfY3B1KGkpKTsNCj4g
PiArICAgIGZvciAoaSA9IDA7IGkgPCBNQUNISU5FKHZtcyktPnNtcC5tYXhfY3B1czsgaSsrKSB7
DQo+ID4gKyAgICAgICAgQ1BVU3RhdGUgKmNwdSA9IHFlbXVfZ2V0X3Bvc3NpYmxlX2NwdShpKTsN
Cj4gPiAgICAgICAgICAgdWludDY0X3QgcGh5c2ljYWxfYmFzZV9hZGRyZXNzID0gMCwgZ2ljaCA9
IDAsIGdpY3YgPSAwOw0KPiA+ICAgICAgICAgICB1aW50MzJfdCB2Z2ljX2ludGVycnVwdCA9IHZt
cy0+dmlydCA/IFBQSShBUkNIX0dJQ19NQUlOVF9JUlEpIDoNCj4gMDsNCj4gPiAtICAgICAgICB1
aW50MzJfdCBwbXVfaW50ZXJydXB0ID0gYXJtX2ZlYXR1cmUoJmFybWNwdS0+ZW52LCBBUk1fRkVB
VFVSRV9QTVUpID8NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUFBJKFZJUlRVQUxfUE1VX0lSUSkgOiAwOw0KPiA+ICsgICAgICAgIHVpbnQzMl90IHBt
dV9pbnRlcnJ1cHQgPSB2bXMtPnBtdSA/IFBQSShWSVJUVUFMX1BNVV9JUlEpIDogMDsNCj4gPiAr
ICAgICAgICB1aW50MzJfdCBmbGFncyA9IHZpcnRfYWNwaV9nZXRfZ2ljY19mbGFncyhjcHUpOw0K
PiA+ICsgICAgICAgIHVpbnQ2NF90IG1waWRyID0gcWVtdV9nZXRfY3B1X2FyY2hpZChpKTsNCj4g
Pg0KPiANCj4gcWVtdV9nZXRfY3B1X2FyY2hpZCgpIGNhbiBiZSBkcm9wcGVkIHNpbmNlIGl0J3Mg
Y2FsbGVkIGZvciBvbmNlLiBNUElEUg0KPiBjYW4gYmUgZmV0Y2hlZCBmcm9tIG1zLT5wb3NzaWJs
ZV9jcHVzLT5jcHVzW2ldLmFyY2hfaWQsIHdoaWNoIGhhcyBiZWVuDQo+IGluaXRpYWxpemVkIHBy
ZS1oYW5kLg0KDQpJIHdhbnQgZXhwb3NlIHRoaXMgQVBJIHRvIG90aGVyIHBhcnRzIG9mIFFFTVUg
YW5kIG90aGVyIGFyY2hpdGVjdHVyZXMgYXMNCndlbGwuIEl0IGlzIGFuIGFjY2Vzc29yIEFQSSBh
bmQgc2hvdWxkIGJlIGVuY291cmFnZWQgYWxsIHRoZSB0aW1lLiBJdA0KcmVkdWNlcyB0aGUgdW5u
ZWNlc3NhcnkgYm9pbGVyIHBsYXRlIGNvZGUuDQoNClNvIHdvdWxkIGxpa2UgdG8ga2VlcCBpdCBi
dXQgY2FuIG1vdmUgdG8gYm9hcmQuaCBpZiB5b3Ugd2lzaD8NCg0KDQpUaGFua3MNClNhbGlsLg0K
DQoNCg0KDQoNCg==

