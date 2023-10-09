Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD437BE4FB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpsHc-0000Mg-IS; Mon, 09 Oct 2023 11:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpsHR-0000K9-Ep; Mon, 09 Oct 2023 11:34:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpsHP-0004jQ-2O; Mon, 09 Oct 2023 11:34:49 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S430x4bLbz67V3m;
 Mon,  9 Oct 2023 23:31:45 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 16:34:43 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 16:34:43 +0100
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
Subject: RE: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHZ+qPnrJn3/z1SYEi9OUvIaCcfXrBBUAWAgAAepOCAAAAuAIAAHeyg///1vICAABGbcA==
Date: Mon, 9 Oct 2023 15:34:42 +0000
Message-ID: <feb5459ddf5d463587353185a334780f@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-2-salil.mehta@huawei.com>
 <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
 <63f8e47efcd045b1b8481f6fd427c4b1@huawei.com>
 <ae2e0fc1-7967-2bae-e4fa-b4d886ba4671@redhat.com>
 <0c972e213f9a46c3a595dc7f933046aa@huawei.com>
 <792f9f38-6031-1269-109e-941d2ecaddf9@redhat.com>
In-Reply-To: <792f9f38-6031-1269-109e-941d2ecaddf9@redhat.com>
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
ZGF5LCBPY3RvYmVyIDksIDIwMjMgNDoyMSBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25n
bnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBK
b25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFs
aXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxp
bnV4LmRldjsgcGhpbG1kQGxpbmFyby5vcmc7DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xp
dmVyLnVwdG9uQGxpbnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gbXN0QHJlZGhhdC5j
b207IHdpbGxAa2VybmVsLm9yZzsgZ3NoYW5AcmVkaGF0LmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7
DQo+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFy
cmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207
DQo+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNv
bTsNCj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1
a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2Fu
Z3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1
YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsg
bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDEvMTBdIGFjY2VsL2t2bTogRXh0cmFjdCBjb21tb24g
S1ZNIHZDUFUNCj4ge2NyZWF0aW9uLHBhcmtpbmd9IGNvZGUNCj4gDQo+ID4NCj4gPj4NCj4gPj4g
a3ZtX3ByZWNyZWF0ZV92Y3B1DQo+ID4NCj4gPiBwcmUtY3JlYXRpb24gaXMgdmVyeSBtdWNoIHNw
ZWNpZmljIHRvIEFSTSByaWdodCBub3cuIEkgYW0gbm90IHN1cmUNCj4gPiBpZiBpdCBpcyByaWdo
dCB0byBoYXZlIGFuIEFQSSB3aXRoIHRoaXMgbmFtZSBpbiB0aGUgY29kZSB3aGljaCBpcw0KPiA+
IGNvbW1vbiB0byBvdGhlciBhcmNoaXRlY3R1cmVzLg0KPiANCj4gSSBkb24ndCBsaWtlIGV4cG9z
aW5nIHRoZSBjb25jZXB0IG9mICJwYXJraW5nIiBDUFVzIGV4dGVybmFsbHksIHdoaWNoIGlzDQo+
IHNvIGZhciBoYW5kbGVkIGNvbXBsZXRlbHkgaW50ZXJuYWxseS4NCg0KDQpJIHVuZGVyc3RhbmQg
eW91ciBwb2ludCBvZiB2aWV3LiBUaGVyZSBpcyBhIHN1YnRsZSBkaWZmZXJlbmNlIGluIHRoZQ0K
d2F5IHBhcmtpbmcgbG9naWMgaGFzIGJlZW4gdXNlZCB0aWxsIG5vdywgc2F5IGluIHg4NiB3b3Js
ZCBhbmQgaG93IGl0DQppcyBiZWluZyB1c2VkIGluIHRoZSBBUk0gaW4gdGhlIFJGQyBwYXRjaGVz
IGJlaW5nIHByb3Bvc2VkLiBBRkFJQ1MsIGluDQp4ODYgd29ybGQgd2UgaGF2ZSBhIGxpYmVydHkg
dG8gZGVsYXkgdGhlIGNyZWF0aW9uIG9mIHRoZSB2Q1BVcyBpbiBLVk0NCmZvciB0aGUgZmlyc3Qg
dGltZSBidXQgb25jZSB0aGV5IGFyZSBjcmVhdGVkIGNhbm5vdCBiZSBkZXN0cm95ZWQgaW4gdGhl
DQpLVk0gc28gYXJlICh1bilwYXJrZWQgZm9yIHN1YnNlcXVlbnQgdXNlIGR1cmluZyBob3QodW4p
cGx1Zy4NCg0KQmVjYXVzZSBvZiB0aGUgQVJNIENQVSBhcmNoaXRlY3R1cmUgbGltaXRhdGlvbnMg
YW5kIHRoYXQgb2YgR0lDLCB3ZQ0KYXJlIG5vdCBhbGxvd2VkIHRvIGRvIHRoaXMuIEhlbmNlLCB3
ZSBoYXZlIHRvIHByZS1jcmVhdGUgYWxsIHRoZQ0KS1ZNIHZDUFVzIGFuZCBzaXplIFZHSUMgZHVy
aW5nIGluaXRpYWxpemF0aW9uLiBTaW5jZSBzb21lIG9mIHRoZQ0KS1ZNIHZDUFVzIHdvbnQgaGF2
ZSBhbnkgUU9NIENQVSBvYmplY3RzIGJlY2F1c2UgdGhleSBhcmUNCid5ZXQtdG8tYmUtcGx1Z2dl
ZCcgc28gbmVlZCB0byBiZSBwYXJrZWQuIEhlbmNlLCB3ZSByZXF1aXJlIHRoYXQNCmNvbW1vbiBw
YXJraW5nIGxvZ2ljLg0KDQoNCg0KPiANCj4gWy4uLl0NCj4gDQo+ID4NCj4gPg0KPiA+PiBrdm1f
Y3JlYXRlX3ZjcHUNCj4gPj4ga3ZtX2Rlc3Ryb3lfdmNwdQ0KPiA+Pg0KPiA+PiBPbmUgY291bGQg
ZXZlbiBtYWtlIGt2bV9jcmVhdGVfdmNwdSgpIGZhaWwgb24gQVJNIGlmIHRoZSBWQ1BVIGhhc24n
dA0KPiA+PiBiZWVuIHByZS1jcmVhdGVkLg0KPiA+DQo+ID4gUmlnaHQgbm93LCB3ZSBhYm9ydCB0
aGUgQ1BVIGluaXRpYWxpemF0aW9uIHByb2Nlc3MgaWYgdGhpcyBoYXBwZW5zLiBJDQo+ID4gYW0g
cGxhbm5pbmcgdG8gY2hhbmdlIGFib3J0KCkgaW50byAnZmF0YWxfZXJyb3InIGluIFJGQyBWMyB0
aG91Z2guDQo+ID4NCj4gPg0KPiA+DQo+ID4+DQo+ID4+IE9yIGRpZCBJIGdldCBpdCBhbGwgd3Jv
bmc/IDopDQo+ID4NCj4gPiBJIHdvbid0IHNheSB0aGF0IGl0IGlzIGp1c3QgYW5vdGhlciBwb2lu
dCBvZiB2aWV3IHdoaWNoIGlzIGFic29sdXRlbHkNCj4gPiBmaW5lLiBCdXQgSSB3b3VsZCBsaWtl
IHRvIHN0aWNrIHRvIGN1cnJlbnQgQVBJcy4NCj4gDQo+IE5vIHJlYWxseSBzdHJvbmcgb3Bpbmlv
biwgSSB3b3VsZG4ndCBkbyBpdCB0aGF0IHdheS4gSSdsbCBsZXQgb3RoZXJzDQo+IGNoaW1lIGlu
IGlmIHRoZXkgaGF2ZSBhbiBvcGluaW9uLg0KDQpPaywgVGhhbmtzLg0KDQpTYWxpbC4NCg==

