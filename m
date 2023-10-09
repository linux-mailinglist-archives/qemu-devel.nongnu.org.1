Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A67BE545
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpsS7-0007Yi-Uf; Mon, 09 Oct 2023 11:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpsRs-0007Pv-5X; Mon, 09 Oct 2023 11:45:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpsRm-0006ih-9U; Mon, 09 Oct 2023 11:45:35 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S43GX52Jpz6K6Tb;
 Mon,  9 Oct 2023 23:43:32 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 16:45:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 16:45:27 +0100
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
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
Subject: RE: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Topic: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Thread-Index: AQHZ+qP+4EmuUazzyEe6jhCYlq8By7BBUIQAgAAoLOD///HBgIAAL2Tw
Date: Mon, 9 Oct 2023 15:45:27 +0000
Message-ID: <5d7f74d31ba449149ff04f107081ed2f@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-4-salil.mehta@huawei.com>
 <8a80612f-07d3-6302-31f9-232d9ce393a1@redhat.com>
 <08840ea0a68e46b1a9d98d1e3544f43b@huawei.com>
 <be019441-793f-bbf1-2b7e-aa32005ead80@redhat.com>
In-Reply-To: <be019441-793f-bbf1-2b7e-aa32005ead80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.154.91]
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

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDksIDIwMjMgMjo1NSBQTQ0KPiANCj4gT24gMDkuMTAuMjMgMTU6NDksIFNh
bGlsIE1laHRhIHdyb3RlOg0KPiA+PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDksIDIwMjMgMToyMyBQTQ0KPiA+
PiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5v
bmdudS5vcmc7IHFlbXUtDQo+ID4+IGFybUBub25nbnUub3JnDQo+ID4+IENjOiBtYXpAa2VybmVs
Lm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+ID4+IDxq
b25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+ID4+
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsN
Cj4gPj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgcGhpbG1k
QGxpbmFyby5vcmc7DQo+ID4+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxp
bnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gPj4gbXN0QHJlZGhhdC5jb207IHdpbGxA
a2VybmVsLm9yZzsgZ3NoYW5AcmVkaGF0LmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+ID4+IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gPj4gZGFycmVu
QG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+
ID4+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNv
bTsNCj4gPj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsg
emh1a2VxaWFuDQo+ID4+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChD
KSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+ID4+IHdhbmd5YW5hbiAoWSkgPHdhbmd5
YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gPj4gbWFvYmlib0Bs
b29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0NCj4gPGxpbnV4YXJt
QGh1YXdlaS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDMvMTBdIGh3L2FjcGk6
IEFkZCBBQ1BJIENQVSBob3RwbHVnIGluaXQgc3R1Yg0KPiA+Pg0KPiA+PiBPbiAwOS4xMC4yMyAx
MzoyOCwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4+PiBBQ1BJIENQVSBob3RwbHVnIHJlbGF0ZWQg
aW5pdGlhbGl6YXRpb24gc2hvdWxkIG9ubHkgaGFwcGVuIGlmDQo+ID4+IEFDUElfQ1BVX0hPVFBM
VUcNCj4gPj4+IHN1cHBvcnQgaGFzIGJlZW4gZW5hYmxlZCBmb3IgcGFydGljdWxhciBhcmNoaXRl
Y3R1cmUuIEFkZA0KPiA+PiBjcHVfaG90cGx1Z19od19pbml0KCkNCj4gPj4+IHN0dWIgdG8gYXZv
aWQgY29tcGlsYXRpb24gYnJlYWsuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4+PiBSZXZpZXdlZC1ieTogSm9uYXRo
YW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+Pj4gUmV2aWV3ZWQt
Ynk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGh3
L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgfCA2ICsrKysrKw0KPiA+Pj4gICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9ody9h
Y3BpL2FjcGktY3B1LWhvdHBsdWctc3R1Yi5jIGIvaHcvYWNwaS9hY3BpLWNwdS0NCj4gaG90cGx1
Zy0NCj4gPj4gc3R1Yi5jDQo+ID4+PiBpbmRleCAzZmM0YjE0YzI2Li5jNmM2MWJiOWNkIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLXN0dWIuYw0KPiA+Pj4gKysr
IGIvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLXN0dWIuYw0KPiA+Pj4gQEAgLTE5LDYgKzE5LDEy
IEBAIHZvaWQgbGVnYWN5X2FjcGlfY3B1X2hvdHBsdWdfaW5pdChNZW1vcnlSZWdpb24NCj4gPj4g
KnBhcmVudCwgT2JqZWN0ICpvd25lciwNCj4gPj4+ICAgICAgICByZXR1cm47DQo+ID4+PiAgICB9
DQo+ID4+Pg0KPiA+Pj4gK3ZvaWQgY3B1X2hvdHBsdWdfaHdfaW5pdChNZW1vcnlSZWdpb24gKmFz
LCBPYmplY3QgKm93bmVyLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBDUFVIb3Rw
bHVnU3RhdGUgKnN0YXRlLCBod2FkZHIgYmFzZV9hZGRyKQ0KPiA+Pj4gK3sNCj4gPj4+ICsgICAg
cmV0dXJuOw0KPiA+Pj4gK30NCj4gPj4NCj4gPj4gV2hpbGUgYXQgaXQsIGNhbiB3ZSBwcmVmaXgg
dGhhdCBmdW5jdGlvbiB3aXRoIGFjcGk/DQo+ID4NCj4gPiBJIGNhbiBkbyB0aGF0IGJ1dCBpdCBo
YXMgdG8gYmUgZG9uZSBhdCBvdGhlciBwbGFjZXMgYXMgd2VsbA0KPiA+IHN1Y2ggYXMgaW4gaHcv
YWNwaS9jcHVfaG90cGx1Zy5jIDxhY3BpX3N3aXRjaF90b19tb2Rlcm5fY3BocCgpPg0KPiA+DQo+
IA0KPiAkIGdpdCBncmVwIGNwdV9ob3RwbHVnX2h3X2luaXQNCj4gaHcvYWNwaS9jcHUuYzp2b2lk
IGNwdV9ob3RwbHVnX2h3X2luaXQoTWVtb3J5UmVnaW9uICphcywgT2JqZWN0ICpvd25lciwNCj4g
aHcvYWNwaS9jcHVfaG90cGx1Zy5jOiAgICBjcHVfaG90cGx1Z19od19pbml0KHBhcmVudCwgZ3Bl
X2NwdS0+ZGV2aWNlLA0KPiBjcHVocF9zdGF0ZSwgaW9fcG9ydCk7DQo+IGluY2x1ZGUvaHcvYWNw
aS9jcHUuaDp2b2lkIGNwdV9ob3RwbHVnX2h3X2luaXQoTWVtb3J5UmVnaW9uICphcywgT2JqZWN0
DQo+ICpvd25lciwNCj4gDQo+IE1pZ2h0IHdhbnQgdG8gZG8gdGhhdCBhcyBhIHNlcGFyYXRlIHBh
dGNoLCBhZ3JlZWQuDQoNClN1cmUsIHRoYW5rcw0KU2FsaWwuDQo=

