Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FA7CF425
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPQm-0006Mf-ST; Thu, 19 Oct 2023 05:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qtPQf-0006Lz-BQ; Thu, 19 Oct 2023 05:34:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qtPQb-0004Eb-VG; Thu, 19 Oct 2023 05:34:57 -0400
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB2bc4CVCz6K6gc;
 Thu, 19 Oct 2023 17:34:04 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 10:34:36 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Thu, 19 Oct 2023 10:34:36 +0100
To: Shaoqin Huang <shahuang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
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
Subject: RE: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHZ/cNQxAxt9PC9FEqdNAxyY88QobBQylAAgAAYu3A=
Date: Thu, 19 Oct 2023 09:34:36 +0000
Message-ID: <262138951966462dbc7f05a5efa146d6@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <d1278ad1-cb78-90f1-64a6-c3e8711bacd7@redhat.com>
In-Reply-To: <d1278ad1-cb78-90f1-64a6-c3e8711bacd7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.120]
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

SGkgU2hhb3FpbiwNCg0KPiBGcm9tOiBTaGFvcWluIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxOSwgMjAyMyAxMDowNSBBTQ0KPiBUbzogU2Fs
aWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7
IHFlbXUtDQo+IGFybUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGls
aXBwZUBsaW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZzsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNv
bTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxp
bmFyby5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsN
Cj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsg
Z3NoYW5AcmVkaGF0LmNvbTsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGFsZXguYmVubmVlQGxpbmFy
by5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVj
b21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3Jh
Y2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1a2VxaWFuDQo+IDx6aHVrZXFpYW4x
QGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNv
bT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwy
QGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5j
bjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
VjYgMC85XSBBZGQgYXJjaGl0ZWN0dXJlIGFnbm9zdGljIGNvZGUgdG8gc3VwcG9ydCB2Q1BVDQo+
IEhvdHBsdWcNCj4gDQo+IA0KPiANCj4gT24gMTAvMTMvMjMgMTg6NTEsIFNhbGlsIE1laHRhIHZp
YSB3cm90ZToNCj4gPiBWaXJ0dWFsIENQVSBob3RwbHVnIHN1cHBvcnQgaXMgYmVpbmcgYWRkZWQg
YWNyb3NzIHZhcmlvdXMNCj4gYXJjaGl0ZWN0dXJlc1sxXVszXS4NCj4gPiBUaGlzIHNlcmllcyBh
ZGRzIHZhcmlvdXMgY29kZSBiaXRzIGNvbW1vbiBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXM6DQo+
ID4NCj4gPiAxLiB2Q1BVIGNyZWF0aW9uIGFuZCBQYXJraW5nIGNvZGUgcmVmYWN0b3IgW1BhdGNo
IDFdDQo+ID4gMi4gVXBkYXRlIEFDUEkgR0VEIGZyYW1ld29yayB0byBzdXBwb3J0IHZDUFUgSG90
cGx1ZyBbUGF0Y2ggNCw2LDddDQo+ID4gMy4gQUNQSSBDUFVzIEFNTCBjb2RlIGNoYW5nZSBbUGF0
Y2ggNV0NCj4gPiA0LiBIZWxwZXIgZnVuY3Rpb25zIHRvIHN1cHBvcnQgdW5yZWFsaXphdGlvbiBv
ZiBDUFUgb2JqZWN0cyBbUGF0Y2ggOCw5XQ0KPiA+IDUuIE1pc2MgW1BhdGNoIDIsM10NCj4gPg0K
PiA+DQo+ID4gUmVwb3NpdG9yeToNCj4gPg0KPiA+IFsqXSBodHRwczovL2dpdGh1Yi5jb20vc2Fs
aWwtbWVodGEvcWVtdS5naXQgdmlydC1jcHVocC1hcm12OC9yZmMtDQo+IHYyLmNvbW1vbi52Ng0K
PiA+DQo+ID4NCj4gPiBSZXZpc2lvbiBIaXN0b3J5Og0KPiA+DQo+ID4gUGF0Y2gtc2V0ICBWNSAt
PiBWNg0KPiA+IDEuIEFkZHJlc3NlZCBHYXZpbiBTaGFuJ3MgY29tbWVudHMNCj4gPiAgICAgLSBG
aXhlZCB0aGUgYXNzZXJ0KCkgcmFuZ2VzIG9mIGFkZHJlc3Mgc3BhY2VzDQo+ID4gICAgIC0gUmVi
YXNlZCB0aGUgcGF0Y2gtc2V0IHRvIGxhdGVzdCBjaGFuZ2VzIGluIHRoZSBxZW11LmdpdA0KPiA+
ICAgICAtIEFkZGVkIFJldmlld2VkLWJ5IHRhZ3MgZm9yIHBhdGNoZXMgezgsOX0NCj4gPiAyLiBB
ZGRyZXNzZWQgSm9uYXRoYW4gQ2FtZXJvbidzIGNvbW1lbnRzDQo+ID4gICAgIC0gVXBkYXRlZCBj
b21taXQtbG9nIGZvciBbUGF0Y2ggVjUgMS85XSB3aXRoIG1lbnRpb24gb2YgdHJhY2UgZXZlbnRz
DQo+ID4gICAgIC0gQWRkZWQgUmV2aWV3ZWQtYnkgdGFncyBmb3IgcGF0Y2hlcyB7MSw1fQ0KPiA+
IDMuIEFkZGVkIFRlc3RlZC1ieSB0YWdzIGZyb20gWGlhbmdsYWkgTGkNCj4gPiA0LiBGaXhlZCBj
aGVja3BhdGNoLnBsIGVycm9yICJRZW11IC0+IFFFTVUiIGluIFtQYXRjaCBWNSAxLzldDQo+ID4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMTAxMTE5NDM1NS4x
NTYyOC0xLQ0KPiBzYWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KPiA+DQo+ID4gUGF0Y2gtc2V0ICBW
NCAtPiBWNQ0KPiA+IDEuIEFkZHJlc3NlZCBHYXZpbiBTaGFuJ3MgY29tbWVudHMNCj4gPiAgICAg
LSBGaXhlZCB0aGUgdHJhY2UgZXZlbnRzIHByaW50IHN0cmluZyBmb3INCj4ga3ZtX3tjcmVhdGUs
Z2V0LHBhcmssZGVzdHJveX1fdmNwdQ0KPiA+ICAgICAtIEFkZGVkIFJldmlld2VkLWJ5IHRhZyBm
b3IgcGF0Y2ggezF9DQo+ID4gMi4gQWRkZWQgU2hhb3FpbiBIdWFuZydzIFJldmlld2VkLWJ5IHRh
Z3MgZm9yIFBhdGNoZXMgezIsM30NCj4gPiAzLiBBZGRlZCBUZXN0ZWQtYnkgVGFnIGZyb20gVmlz
aG51IFBhamp1cmkgdG8gdGhlIHBhdGNoLXNldA0KPiA+IDQuIERyb3BwZWQgdGhlIEFSTSBzcGVj
aWZpYyBbUGF0Y2ggVjQgMTAvMTBdDQo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDIzMTAwOTIwMzYwMS4xNzU4NC0xLQ0KPiBzYWxpbC5tZWh0YUBodWF3ZWku
Y29tLw0KPiA+DQo+ID4gUGF0Y2gtc2V0ICBWMyAtPiBWNA0KPiA+IDEuIEFkZHJlc3NlZCBEYXZp
ZCBIaWxkZXJicmFuZCdzIGNvbW1lbnRzDQo+ID4gICAgIC0gRml4ZWQgdGhlIHdyb25nIGRvYyBj
b21tZW50IG9mIGt2bV9wYXJrX3ZjcHUgQVBJIHByb3RvdHlwZQ0KPiA+ICAgICAtIEFkZGVkIFJl
dmlld2VkLWJ5IHRhZ3MgZm9yIHBhdGNoZXMgezIsNH0NCj4gPiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjMxMDA5MTEyODEyLjEwNjEyLTEtDQo+IHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20vDQo+ID4NCj4gPiBQYXRjaC1zZXQgIFYyIC0+IFYzDQo+ID4gMS4gQWRk
cmVzc2VkIEpvbmF0aGFuIENhbWVyb24ncyBjb21tZW50cw0KPiA+ICAgICAtIEZpeGVkICd2Y3B1
LWlkJyB0eXBlIHdyb25nbHkgY2hhbmdlZCBmcm9tICd1bnNpZ25lZCBsb25nJyB0bw0KPiAnaW50
ZWdlcicNCj4gPiAgICAgLSBSZW1vdmVkIHVubmVjZXNzYXJ5IHVzZSBvZiB2YXJpYWJsZSAndmNw
dV9pZCcgaW4ga3ZtX3BhcmtfdmNwdQ0KPiA+ICAgICAtIFVwZGF0ZWQgW1BhdGNoIFYyIDMvMTBd
IGNvbW1pdC1sb2cgd2l0aCBkZXRhaWxzIG9mDQo+IEFDUElfQ1BVX1NDQU5fTUVUSE9EIG1hY3Jv
DQo+ID4gICAgIC0gVXBkYXRlZCBbUGF0Y2ggVjIgNS8xMF0gY29tbWl0LWxvZyB3aXRoIGRldGFp
bHMgb2YgY29uZGl0aW9uYWwNCj4gZXZlbnQgaGFuZGxlciBtZXRob2QNCj4gPiAgICAgLSBBZGRl
ZCBSZXZpZXdlZC1ieSB0YWdzIGZvciBwYXRjaGVzIHsyLDMsNCw2LDd9DQo+ID4gMi4gQWRkcmVz
c2VkIEdhdmluIFNoYW4ncyBjb21tZW50cw0KPiA+ICAgICAtIFJlbW92ZSB1bm5lY2Vzc2FyeSB1
c2Ugb2YgdmFyaWFibGUgJ3ZjcHVfaWQnIGluIGt2bV9wYXJfdmNwdQ0KPiA+ICAgICAtIEZpeGVk
IHJldHVybiB2YWx1ZSBpbiBrdm1fZ2V0X3ZjcHUgZnJvbSAtMSB0byAtRU5PRU5UDQo+ID4gICAg
IC0gUmVzZXQgdGhlIHZhbHVlIG9mICdnZGJfbnVtX2dfcmVncycgaW4NCj4gZ2RiX3VucmVnaXN0
ZXJfY29wcm9jZXNzb3JfYWxsDQo+ID4gICAgIC0gRml4ZWQgdGhlIGt2bV97Y3JlYXRlLHBhcmt9
X3ZjcHUgcHJvdG90eXBlcyBkb2NzDQo+ID4gICAgIC0gQWRkZWQgUmV2aWV3ZWQtYnkgdGFncyBm
b3IgcGF0Y2hlcyB7MiwzLDQsNSw2LDcsOSwxMH0NCj4gPiAzLiBBZGRyZXNzZWQgb25lIGVhcmxp
ZXIgbWlzc2VkIGNvbW1lbnQgYnkgQWxleCBCZW5uw6llIGluIFJGQyBWMQ0KPiA+ICAgICAtIEFk
ZGVkIHRyYWNlcyBpbnN0ZWFkIG9mIERQUklOVEYgaW4gdGhlIG5ld2x5IGFkZGVkIGFuZCBzb21l
DQo+IGV4aXN0aW5nIGZ1bmN0aW9ucw0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyMzA5MzAwMDE5MzMuMjY2MC0xLQ0KPiBzYWxpbC5tZWh0YUBodWF3ZWku
Y29tLw0KPiA+DQo+ID4gUGF0Y2gtc2V0IFYxIC0+IFYyDQo+ID4gMS4gQWRkcmVzc2VkIEFsZXgg
QmVubsOpZSdzIGNvbW1lbnRzDQo+ID4gICAgIC0gUmVmYWN0b3JlZCB0aGUga3ZtX2NyZWF0ZV92
Y3B1IGxvZ2ljIHRvIGdldCByaWQgb2YgZ290bw0KPiA+ICAgICAtIEFkZGVkIHRoZSBkb2NzIGZv
ciBrdm1fe2NyZWF0ZSxwYXJrfV92Y3B1IHByb3RvdHlwZXMNCj4gPiAgICAgLSBTcGxpdHRlZCB0
aGUgZ2Ric3R1YiBhbmQgQWRkcmVzc1NwYWNlIGRlc3RydWN0aW9uIGNoYW5nZSBpbnRvDQo+IHNl
cGFyYXRlIHBhdGNoZXMNCj4gPiAgICAgLSBBZGRlZCBSZXZpZXdlZC1ieSB0YWdzIGZvciBwYXRj
aGVzIHsyLDEwfQ0KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
MjAyMzA5MjkxMjQzMDQuMTM2NzItMS0NCj4gc2FsaWwubWVodGFAaHVhd2VpLmNvbS8NCj4gPg0K
PiA+IFJlZmVyZW5jZXM6DQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDIzMDkyNjEwMDQzNi4yODI4NC0xLQ0KPiBzYWxpbC5tZWh0YUBodWF3ZWkuY29t
Lw0KPiA+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA5MTMxNjM4MjMuNzg4
MC0xLQ0KPiBqYW1lcy5tb3JzZUBhcm0uY29tLw0KPiA+IFszXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LQ0KPiBkZXZlbC9jb3Zlci4xNjk1Njk3NzAxLmdpdC5saXhpYW5nbGFpQGxvb25n
c29uLmNuLw0KPiA+DQo+ID4NCj4gPiBTYWxpbCBNZWh0YSAoOSk6DQo+ID4gICAgYWNjZWwva3Zt
OiBFeHRyYWN0IGNvbW1vbiBLVk0gdkNQVSB7Y3JlYXRpb24scGFya2luZ30gY29kZQ0KPiA+ICAg
IGh3L2FjcGk6IE1vdmUgQ1BVIGN0cmwtZGV2IE1NSU8gcmVnaW9uIGxlbiBtYWNybyB0byBjb21t
b24gaGVhZGVyIGZpbGUNCj4gPiAgICBody9hY3BpOiBBZGQgQUNQSSBDUFUgaG90cGx1ZyBpbml0
IHN0dWINCj4gPiAgICBody9hY3BpOiBJbml0IEdFRCBmcmFtZXdvcmsgd2l0aCBDUFUgaG90cGx1
ZyBldmVudHMNCj4gPiAgICBody9hY3BpOiBVcGRhdGUgQ1BVcyBBTUwgd2l0aCBjcHUtKGN0cmwp
ZGV2IGNoYW5nZQ0KPiA+ICAgIGh3L2FjcGk6IFVwZGF0ZSBHRUQgX0VWVCBtZXRob2QgQU1MIHdp
dGggQ1BVIHNjYW4NCj4gPiAgICBody9hY3BpOiBVcGRhdGUgQUNQSSBHRUQgZnJhbWV3b3JrIHRv
IHN1cHBvcnQgdkNQVSBIb3RwbHVnDQo+ID4gICAgcGh5c21lbTogQWRkIGhlbHBlciBmdW5jdGlv
biB0byBkZXN0cm95IENQVSBBZGRyZXNzU3BhY2UNCj4gPiAgICBnZGJzdHViOiBBZGQgaGVscGVy
IGZ1bmN0aW9uIHRvIHVucmVnaXN0ZXIgR0RCIHJlZ2lzdGVyIHNwYWNlDQo+ID4NCj4gPiAgIGFj
Y2VsL2t2bS9rdm0tYWxsLmMgICAgICAgICAgICAgICAgICAgIHwgNjQgKysrKysrKysrKysrKysr
KysrKystLS0tLS0NCj4gPiAgIGFjY2VsL2t2bS90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAg
IHwgIDQgKysNCj4gPiAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgICAgICAgICAgICAgIHwg
MTIgKysrKysNCj4gPiAgIGh3L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMgICAgICAgIHwg
IDYgKysrDQo+ID4gICBody9hY3BpL2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI3
ICsrKysrKystLS0tDQo+ID4gICBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMgICAgICAg
ICB8IDIyICsrKysrKysrKw0KPiA+ICAgaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgICAgICAgICAgICAg
ICAgICAgfCAgMyArLQ0KPiA+ICAgaW5jbHVkZS9leGVjL2NwdS1jb21tb24uaCAgICAgICAgICAg
ICAgfCAgOCArKysrDQo+ID4gICBpbmNsdWRlL2V4ZWMvZ2Ric3R1Yi5oICAgICAgICAgICAgICAg
ICB8ICA1ICsrDQo+ID4gICBpbmNsdWRlL2h3L2FjcGkvY3B1LmggICAgICAgICAgICAgICAgICB8
ICA1ICstDQo+ID4gICBpbmNsdWRlL2h3L2FjcGkvY3B1X2hvdHBsdWcuaCAgICAgICAgICB8ICA0
ICsrDQo+ID4gICBpbmNsdWRlL2h3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZpY2UuaCB8ICA1ICsr
DQo+ID4gICBpbmNsdWRlL2h3L2NvcmUvY3B1LmggICAgICAgICAgICAgICAgICB8ICAxICsNCj4g
PiAgIGluY2x1ZGUvc3lzZW11L2t2bS5oICAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKw0K
PiA+ICAgc3lzdGVtL3BoeXNtZW0uYyAgICAgICAgICAgICAgICAgICAgICAgfCAyOSArKysrKysr
KysrKysNCj4gPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDE4NCBpbnNlcnRpb25zKCspLCAyNyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiANCj4gSGkgc2FsaWwsDQo+IA0KPiBBbGwgcGF0Y2hlcyBsb29rcyBn
b29kIHRvIG1lLiBUaGFua3MgZm9yIHlvdSBlZmZvcnQgdG8gdXBkYXRlIGl0IHNvDQo+IGFjdGl2
ZWx5LiBObyBpc3N1ZXMgYmVpbmcgZm91bmQgYnkgc2ltcGx5IHRlc3RpbmcgYW5kIHNldmVyYWwg
ZGFpbHkgdXNlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFNoYW9xaW4gSHVhbmcgPHNoYWh1YW5nQHJl
ZGhhdC5jb20+DQoNCk1hbnkgdGhhbmtzISBKdXN0IHdhbnRlZCB0byBjb25maXJtIGlmIHlvdSBo
YXZlIHRlc3RlZCB0aGlzIHBhdGNoIG92ZXINCng4NiBwbGF0Zm9ybSBhcyB3ZWxsPw0KDQoNCkNo
ZWVycw0KU2FsaWwuDQo=

