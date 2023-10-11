Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8307C4F7C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:01:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqW0T-0003Od-Mx; Wed, 11 Oct 2023 05:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqW0F-0003MX-TM; Wed, 11 Oct 2023 05:59:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qqW0C-0005Ol-Ty; Wed, 11 Oct 2023 05:59:43 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S57T52VXTz6JB1Q;
 Wed, 11 Oct 2023 17:56:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 10:59:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 11 Oct 2023 10:59:27 +0100
To: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
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
 "rafael@kernel.org" <rafael@kernel.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Subject: RE: [PATCH V4 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V4 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHZ+vBgREM3O/r310KkRZMgbkve2LBEHPqAgAA8E7A=
Date: Wed, 11 Oct 2023 09:59:27 +0000
Message-ID: <d1b0c94a235747aeb6817bb07e49c190@huawei.com>
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-2-salil.mehta@huawei.com>
 <910cb268-7344-fa0b-aa1e-935ded612d3e@redhat.com>
In-Reply-To: <910cb268-7344-fa0b-aa1e-935ded612d3e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.228]
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
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDExLCAyMDIzIDg6MDkgQU0NCj4gVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFy
bUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8u
b3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBs
cGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3Lmpv
bmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gcGJvbnppbmlA
cmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgcmFmYWVsQGtlcm5l
bC5vcmc7DQo+IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsN
Cj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3Jh
Y2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5l
dDsgemh1a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChD
KSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5h
bjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nv
bi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMDEvMTBdIGFjY2VsL2t2bTogRXh0cmFjdCBj
b21tb24gS1ZNIHZDUFUNCj4ge2NyZWF0aW9uLHBhcmtpbmd9IGNvZGUNCj4gDQo+IEhpIFNhbGls
LA0KPiANCj4gT24gMTAvMTAvMjMgMDY6MzUsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiA+IEtWTSB2
Q1BVIGNyZWF0aW9uIGlzIGRvbmUgb25jZSBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRo
ZSBWTSB3aGVuIFFlbXUNCj4gPiB0aHJlYWQgaXMgc3Bhd25lZC4gVGhpcyBpcyBjb21tb24gdG8g
YWxsIHRoZSBhcmNoaXRlY3R1cmVzLg0KPiA+DQo+ID4gSG90LXVucGx1ZyBvZiB2Q1BVIHJlc3Vs
dHMgaW4gZGVzdHJ1Y3Rpb24gb2YgdGhlIHZDUFUgb2JqZWN0IGluIFFPTSBidXQgdGhlDQo+ID4g
Y29ycmVzcG9uZGluZyBLVk0gdkNQVSBvYmplY3QgaW4gdGhlIEhvc3QgS1ZNIGlzIG5vdCBkZXN0
cm95ZWQgYW5kIGl0cw0KPiA+IHJlcHJlc2VudGF0aXZlIEtWTSB2Q1BVIG9iamVjdC9jb250ZXh0
IGluIFFlbXUgaXMgcGFya2VkLg0KPiA+DQo+ID4gUmVmYWN0b3IgY29tbW9uIGxvZ2ljIHNvIHRo
YXQgc29tZSBBUElzIGNvdWxkIGJlIHJldXNlZCBieSB2Q1BVIEhvdHBsdWcgY29kZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgYWNjZWwva3ZtL2t2bS1hbGwuYyAgICB8IDY0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAgYWNjZWwva3ZtL3RyYWNlLWV2ZW50
cyB8ICA0ICsrKw0KPiA+ICAgaW5jbHVkZS9zeXNlbXUva3ZtLmggICB8IDE2ICsrKysrKysrKysr
DQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygt
KQ0KPiA+DQo+IA0KPiBXaXRoIHRoZSBmb2xsb3dpbmcgb25lIGNvbW1lbnQgYWRkcmVzc2VkOg0K
PiANCj4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQoNCg0KVGhh
bmtzDQoNCg0KWy4uLl0NCg0KPiA+IGRpZmYgLS1naXQgYS9hY2NlbC9rdm0vdHJhY2UtZXZlbnRz
IGIvYWNjZWwva3ZtL3RyYWNlLWV2ZW50cw0KPiA+IGluZGV4IDM5OWFhZWIwZWMuLjA4ZTJkYzI1
M2YgMTAwNjQ0DQo+ID4gLS0tIGEvYWNjZWwva3ZtL3RyYWNlLWV2ZW50cw0KPiA+ICsrKyBiL2Fj
Y2VsL2t2bS90cmFjZS1ldmVudHMNCj4gPiBAQCAtOSw2ICs5LDEwIEBAIGt2bV9kZXZpY2VfaW9j
dGwoaW50IGZkLCBpbnQgdHlwZSwgdm9pZCAqYXJnKSAiZGV2IGZkDQo+ICVkLCB0eXBlIDB4JXgs
IGFyZyAlcCINCj4gPiAgIGt2bV9mYWlsZWRfcmVnX2dldCh1aW50NjRfdCBpZCwgY29uc3QgY2hh
ciAqbXNnKSAiV2FybmluZzogVW5hYmxlIHRvIHJldHJpZXZlIE9ORVJFRyAlIiBQUkl1NjQgIiBm
cm9tIEtWTTogJXMiDQo+ID4gICBrdm1fZmFpbGVkX3JlZ19zZXQodWludDY0X3QgaWQsIGNvbnN0
IGNoYXIgKm1zZykgIldhcm5pbmc6IFVuYWJsZSB0byBzZXQgT05FUkVHICUiIFBSSXU2NCAiIHRv
IEtWTTogJXMiDQo+ID4gICBrdm1faW5pdF92Y3B1KGludCBjcHVfaW5kZXgsIHVuc2lnbmVkIGxv
bmcgYXJjaF9jcHVfaWQpICJpbmRleDogJWQgaWQ6ICVsdSINCj4gPiAra3ZtX2NyZWF0ZV92Y3B1
KGludCBjcHVfaW5kZXgsIHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVfaWQpICJjcmVhdGluZyBLVk0g
Y3B1OiBjcHVfaW5kZXg6ICVkIGFyY2ggdmNwdS1pZDogJWx1Ig0KPiA+ICtrdm1fZ2V0X3ZjcHUo
dW5zaWduZWQgbG9uZyBhcmNoX2NwdV9pZCkgInVucGFya2luZyBLVk0gdmNwdTogYXJjaCB2Y3B1
LWlkOiAlbHUiDQo+ID4gK2t2bV9kZXN0cm95X3ZjcHUoaW50IGNwdV9pbmRleCwgdW5zaWduZWQg
bG9uZyBhcmNoX2NwdV9pZCkgImRlc3Ryb3kgdmNwdTogY3B1X2luZGV4OiAlZCBhcmNoIHZjcHUt
aWQ6ICVsdSINCj4gPiAra3ZtX3BhcmtfdmNwdShpbnQgY3B1X2luZGV4LCB1bnNpZ25lZCBsb25n
IGFyY2hfY3B1X2lkKSAicGFya2luZyBLVk0gdmNwdTogY3B1X2luZGV4OiAlZCBhcmNoIHZjcHUt
aWQ6ICVsdSINCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGUgZHVwbGljYXRlIGlkZW50
aWZpZXJzIGxpa2UgImNyZWF0aW5nIEtWTSBjcHUiDQo+IHNpbmNlIHRoZSBldmVudCBuYW1lIGNh
biBzZXJ2ZSB0aGUgcHVycG9zZS4gQmVzaWRlcywgdGhlIHBhcmFtZXRlcnMNCj4gYXJlIGRlc2Ny
aXB0aXZlIGJ5ICJpbmRleDogJWQgaWQ6ICVsdSIsIHVzZWQgYnkga3ZtX2luaXRfdmNwdSgpLiBX
ZSBqdXN0DQo+IG5lZWQgdG8gZm9sbG93IHRoYXQgcGF0dGVybi4gT3RoZXJ3aXNlLCBpbmNvbnNp
c3RlbnQgb3V0cHV0IHdpbGwgYmUgcHJpbnRlZA0KPiBieSBrdm1faW5pdF92Y3B1KCkgYW5kIGt2
bV9nZXRfdmNwdSgpLiBTbyBJIHdvdWxkIGNoYW5nZSB0aGVtIGxpa2UgYmVsb3c6DQo+IA0KPiBr
dm1faW5pdF92Y3B1KGludCBjcHVfaW5kZXgsIHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVfaWQpICJp
bmRleDogJWQgaWQ6ICVsdSINCj4ga3ZtX2NyZWF0ZV92Y3B1KGludCBjcHVfaW5kZXgsIHVuc2ln
bmVkIGxvbmcgYXJjaF9jcHVfaWQpICJpbmRleDogJWQgaWQ6ICVsdSINCj4ga3ZtX2dldF92Y3B1
KHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVfaWQpICJpZDogJWx1Ig0KPiBrdm1fZGVzdHJveV92Y3B1
KGludCBjcHVfaW5kZXgsIHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVfaWQpICJpbmRleDogJWQgaWQ6
ICVsdSINCj4ga3ZtX3BhcmtfdmNwdShpbnQgY3B1X2luZGV4LCB1bnNpZ25lZCBsb25nIGFyY2hf
Y3B1X2lkKSAiaW5kZXg6ICVkIGlkOiAlbHUiDQoNCk5vIHByb2JsZW0uIFdpbGwgZml4DQoNCk9u
bHkgZXhlY3V0ZWQgYmVsb3cgdG8gY2hlY2sgZm9yIG5ldyB0cmFjZSBjb3VudGVyczoNClFlbXU+
IGluZm8gdHJhY2UtZXZlbnRzDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0K

