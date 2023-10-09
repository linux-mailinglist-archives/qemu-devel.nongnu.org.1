Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB07BE0B9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqWi-0004Ck-KJ; Mon, 09 Oct 2023 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqWf-0004Bo-4B; Mon, 09 Oct 2023 09:42:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qpqWc-0000uN-9v; Mon, 09 Oct 2023 09:42:24 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S40W92vq0z6D8WC;
 Mon,  9 Oct 2023 21:39:17 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 14:42:14 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 9 Oct 2023 14:42:14 +0100
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
Thread-Index: AQHZ+qPnrJn3/z1SYEi9OUvIaCcfXrBBUAWAgAAepOA=
Date: Mon, 9 Oct 2023 13:42:14 +0000
Message-ID: <63f8e47efcd045b1b8481f6fd427c4b1@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-2-salil.mehta@huawei.com>
 <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
In-Reply-To: <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
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

SGkgRGF2aWQsDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gRnJvbTogRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDE6MjEgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFybUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVs
Lm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1h
bW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRldjsgcGhpbG1kQGxpbmFyby5v
cmc7DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsgcGJv
bnppbmlAcmVkaGF0LmNvbTsNCj4gbXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgZ3No
YW5AcmVkaGF0LmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFsZXguYmVubmVlQGxpbmFyby5v
cmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5j
b207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZpc2hudUBvcy5hbXBlcmVjb21w
dXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4gbWlndWVsLmx1aXNAb3JhY2xl
LmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1a2VxaWFuDQo+IDx6aHVrZXFpYW4xQGh1
YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbT47
DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBqaWFrZXJuZWwyQGdt
YWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbjsg
TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMg
MDEvMTBdIGFjY2VsL2t2bTogRXh0cmFjdCBjb21tb24gS1ZNIHZDUFUNCj4ge2NyZWF0aW9uLHBh
cmtpbmd9IGNvZGUNCj4gDQo+IE9uIDA5LjEwLjIzIDEzOjI4LCBTYWxpbCBNZWh0YSB3cm90ZToN
Cj4gPiBLVk0gdkNQVSBjcmVhdGlvbiBpcyBkb25lIG9uY2UgZHVyaW5nIHRoZSBpbml0aWFsaXph
dGlvbiBvZiB0aGUgVk0gd2hlbiBRZW11DQo+ID4gdGhyZWFkIGlzIHNwYXduZWQuIFRoaXMgaXMg
Y29tbW9uIHRvIGFsbCB0aGUgYXJjaGl0ZWN0dXJlcy4NCj4gPg0KPiA+IEhvdC11bnBsdWcgb2Yg
dkNQVSByZXN1bHRzIGluIGRlc3RydWN0aW9uIG9mIHRoZSB2Q1BVIG9iamVjdCBpbiBRT00gYnV0
IHRoZQ0KPiA+IGNvcnJlc3BvbmRpbmcgS1ZNIHZDUFUgb2JqZWN0IGluIHRoZSBIb3N0IEtWTSBp
cyBub3QgZGVzdHJveWVkIGFuZCBpdHMNCj4gPiByZXByZXNlbnRhdGl2ZSBLVk0gdkNQVSBvYmpl
Y3QvY29udGV4dCBpbiBRZW11IGlzIHBhcmtlZC4NCj4gPg0KPiA+IFJlZmFjdG9yIGNvbW1vbiBs
b2dpYyBzbyB0aGF0IHNvbWUgQVBJcyBjb3VsZCBiZSByZXVzZWQgYnkgdkNQVSBIb3RwbHVnIGNv
ZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+DQo+ID4gICBpbnQga3ZtX2luaXRfdmNwdShD
UFVTdGF0ZSAqY3B1LCBFcnJvciAqKmVycnApDQo+ID4gQEAgLTM5NSwxOSArNDM0LDE0IEBAIGlu
dCBrdm1faW5pdF92Y3B1KENQVVN0YXRlICpjcHUsIEVycm9yICoqZXJycCkNCj4gPg0KPiA+ICAg
ICAgIHRyYWNlX2t2bV9pbml0X3ZjcHUoY3B1LT5jcHVfaW5kZXgsIGt2bV9hcmNoX3ZjcHVfaWQo
Y3B1KSk7DQo+ID4NCj4gPiAtICAgIHJldCA9IGt2bV9nZXRfdmNwdShzLCBrdm1fYXJjaF92Y3B1
X2lkKGNwdSkpOw0KPiA+ICsgICAgcmV0ID0ga3ZtX2NyZWF0ZV92Y3B1KGNwdSk7DQo+ID4gICAg
ICAgaWYgKHJldCA8IDApIHsNCj4gPiAtICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1y
ZXQsICJrdm1faW5pdF92Y3B1OiBrdm1fZ2V0X3ZjcHUgZmFpbGVkICglbHUpIiwNCj4gPiArICAg
ICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAia3ZtX2luaXRfdmNwdToga3ZtX2NyZWF0ZV92Y3B1IGZhaWxlZCAoJWx1KSIsDQo+
IA0KPiBVbnJlbGF0ZWQgY2hhbmdlLg0KDQoNCkl0IGlzIHJlbGF0ZWQuIEkgdGhpbmsgeW91IG1p
c3NlZCBrdm1fZ2V0X3ZjcHUgLT4ga3ZtX2NyZWF0ZV92Y3B1IGNoYW5nZQ0KaW4gdGhlIHN0cmlu
Zy4NCg0KDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAga3ZtX2FyY2hfdmNwdV9pZChj
cHUpKTsNCj4gPiAgICAgICAgICAgZ290byBlcnI7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gLSAg
ICBjcHUtPmt2bV9mZCA9IHJldDsNCj4gPiAtICAgIGNwdS0+a3ZtX3N0YXRlID0gczsNCj4gPiAt
ICAgIGNwdS0+dmNwdV9kaXJ0eSA9IHRydWU7DQo+ID4gLSAgICBjcHUtPmRpcnR5X3BhZ2VzID0g
MDsNCj4gPiAtICAgIGNwdS0+dGhyb3R0bGVfdXNfcGVyX2Z1bGwgPSAwOw0KPiA+IC0NCj4gPiAg
ICAgICBtbWFwX3NpemUgPSBrdm1faW9jdGwocywgS1ZNX0dFVF9WQ1BVX01NQVBfU0laRSwgMCk7
DQo+ID4gICAgICAgaWYgKG1tYXBfc2l6ZSA8IDApIHsNCj4gPiAgICAgICAgICAgcmV0ID0gbW1h
cF9zaXplOw0KPiA+IGRpZmYgLS1naXQgYS9hY2NlbC9rdm0vdHJhY2UtZXZlbnRzIGIvYWNjZWwv
a3ZtL3RyYWNlLWV2ZW50cw0KPiA+IGluZGV4IDM5OWFhZWIwZWMuLjA4ZTJkYzI1M2YgMTAwNjQ0
DQo+ID4gLS0tIGEvYWNjZWwva3ZtL3RyYWNlLWV2ZW50cw0KPiA+ICsrKyBiL2FjY2VsL2t2bS90
cmFjZS1ldmVudHMNCj4gPiBAQCAtOSw2ICs5LDEwIEBAIGt2bV9kZXZpY2VfaW9jdGwoaW50IGZk
LCBpbnQgdHlwZSwgdm9pZCAqYXJnKSAiZGV2IGZkICVkLCB0eXBlIDB4JXgsIGFyZyAlcCINCj4g
PiAgIGt2bV9mYWlsZWRfcmVnX2dldCh1aW50NjRfdCBpZCwgY29uc3QgY2hhciAqbXNnKSAiV2Fy
bmluZzogVW5hYmxlIHRvIHJldHJpZXZlIE9ORVJFRyAlIiBQUkl1NjQgIiBmcm9tIEtWTTogJXMi
DQo+ID4gICBrdm1fZmFpbGVkX3JlZ19zZXQodWludDY0X3QgaWQsIGNvbnN0IGNoYXIgKm1zZykg
Ildhcm5pbmc6IFVuYWJsZSB0byBzZXQgT05FUkVHICUiIFBSSXU2NCAiIHRvIEtWTTogJXMiDQo+
ID4gICBrdm1faW5pdF92Y3B1KGludCBjcHVfaW5kZXgsIHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVf
aWQpICJpbmRleDogJWQgaWQ6ICVsdSINCj4gPiAra3ZtX2NyZWF0ZV92Y3B1KGludCBjcHVfaW5k
ZXgsIHVuc2lnbmVkIGxvbmcgYXJjaF9jcHVfaWQpICJjcmVhdGluZyBLVk0gY3B1OiBjcHVfaW5k
ZXg6ICVkIGFyY2ggdmNwdS1pZDogJWx1Ig0KPiA+ICtrdm1fZ2V0X3ZjcHUodW5zaWduZWQgbG9u
ZyBhcmNoX2NwdV9pZCkgInVucGFya2luZyBLVk0gdmNwdTogYXJjaCB2Y3B1LWlkOiAlbHUiDQo+
ID4gK2t2bV9kZXN0cm95X3ZjcHUoaW50IGNwdV9pbmRleCwgdW5zaWduZWQgbG9uZyBhcmNoX2Nw
dV9pZCkgImRlc3Ryb3kgdmNwdTogY3B1X2luZGV4OiAlZCBhcmNoIHZjcHUtaWQ6ICVsdSINCj4g
PiAra3ZtX3BhcmtfdmNwdShpbnQgY3B1X2luZGV4LCB1bnNpZ25lZCBsb25nIGFyY2hfY3B1X2lk
KSAicGFya2luZyBLVk0gdmNwdTogY3B1X2luZGV4OiAlZCBhcmNoIHZjcHUtaWQ6ICVsdSINCj4g
DQo+IEl0J3MgYSBiaXQgY29uZnVzaW5nIHRoYXQgdGhlcmUgaXMgbm93DQo+IA0KPiAxKSBjcmVh
dGUgKGNyZWF0ZSBuZXcgb3IgcmV0dXJuIHBhcmtlZCkNCj4gMikgZGVzdHJveSAoY2xlYW51cCAr
IHBhcmspDQo+IDMpIHBhcmsgKHBhcmsgb25seSkNCj4gDQo+IFdoeSB3b3VsZCBvbmUgdXNlIDIp
IGluc3RlYWQgb2YgMykgb3IgdGhlIG90aGVyIHdheSBhcm91bmQ/IEJ1dCBJDQo+IHN1c3BlY3Qg
dGhhdCBrdm1fZGVzdHJveV92Y3B1KCkgaXMgb25seSBzdXBwb3NlZCB0byBiZSBhIEtWTS1pbnRl
cm5hbA0KPiBoZWxwZXIgLi4uDQoNCmt2bV9kZXN0cm95X3ZjcHUgaXMgbW9yZSB0aGFuIGp1c3Qg
cGFya2luZzoNCg0KMS4gQXJjaCBkZXN0cm95IHZjcHUNCjIuIFVubWFwIGNwdS0+a3ZtX3J1bg0K
My4gUGFya2luZyBsb2dpYw0KDQpUbyBzdXBwb3J0IHZpcnR1YWwgQ1BVIEhvdHBsdWcgb24gQVJN
IHBsYXRmb3JtcyB3ZSBwcmUtY3JlYXRlIGFsbA0KdGhlIEtWTSB2Q1BVcyBidXQgdGhlaXIgY29y
cmVzcG9uZGluZyBRZW11IHRocmVhZHMgYXJlIG5vdCBzcGF3bmVkDQooYW5kIGhlbmNlIGNwdS0+
a3ZtX3J1biBpcyBub3QgbWFwcGVkKS4gVW5wbHVnZ2VkIHZDUFVzIHJlbWFpbnMNCnBhcmtlZCBp
biB0aGUgbGlzdC4gSGVuY2UsIG9ubHkgc3RlcC0zIGlzIHJlcXVpcmVkLg0KDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsL2I5ZGQ4NTY5LWU5NWQtMjA4NS05OTY1LTA4Njg2Y2U2
NjY2ZEByZWRoYXQuY29tLw0KDQpXaGVuIGEgdmlydHVhbCBDUFUgaXMgcGx1Z2dlZC4gUU9NIENQ
VSBvYmplY3QgaXMgcmVhbGl6ZWQgYW5kDQpjb3JyZXNwb25kaW5nIHRocmVhZCBpcyBzcGF3bmVk
LiBrdm1faW5pdF92Y3B1IGVuZHMgdXAgaW4gdW5hcHJraW5nDQp0aGUgS1ZNIHZDUFUsIG1hcHBp
bmcgb2YgY3B1LT5rdm1fcnVuIGFuZCBrdm1fYXJjaF9pbml0X3ZjcHUuDQoNCldoZW4gYSB2aXJ0
dWwgQ1BVIGlzIHVuLXBsdWdnZWQsIHJldmVyc2Ugb2Ygc3RlcC0xLCAyIGFuZCAzIGlzDQpyZXF1
aXJlZCBkdXJpbmcgdW4tcmVhbGl6YXRpb24gb2YgUU9NIENQVSBvYmplY3QuIFdlIGRvIG5vdCBk
ZXN0cm95DQp2Q1BVIGluc2lkZSB0aGUgS1ZNLg0KDQoNCg0KPiA+ICAga3ZtX2lycWNoaXBfY29t
bWl0X3JvdXRlcyh2b2lkKSAiIg0KPiA+ICAga3ZtX2lycWNoaXBfYWRkX21zaV9yb3V0ZShjaGFy
ICpuYW1lLCBpbnQgdmVjdG9yLCBpbnQgdmlycSkgImRldiAlcyB2ZWN0b3IgJWQgdmlycSAlZCIN
Cj4gPiAgIGt2bV9pcnFjaGlwX3VwZGF0ZV9tc2lfcm91dGUoaW50IHZpcnEpICJVcGRhdGluZyBN
U0kgcm91dGUgdmlycT0lZCINCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUva3ZtLmgg
Yi9pbmNsdWRlL3N5c2VtdS9rdm0uaA0KPiA+IGluZGV4IGVlOTAyNWY4ZTkuLjU3YmQ4ZjhmZDYg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9zeXNlbXUva3ZtLmgNCj4gPiArKysgYi9pbmNsdWRl
L3N5c2VtdS9rdm0uaA0KPiA+IEBAIC00NjQsNiArNDY0LDIwIEBAIHZvaWQga3ZtX3NldF9zaWdt
YXNrX2xlbihLVk1TdGF0ZSAqcywgdW5zaWduZWQgaW50IHNpZ21hc2tfbGVuKTsNCj4gPg0KPiA+
ICAgaW50IGt2bV9waHlzaWNhbF9tZW1vcnlfYWRkcl9mcm9tX2hvc3QoS1ZNU3RhdGUgKnMsIHZv
aWQgKnJhbV9hZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaHdhZGRyICpwaHlzX2FkZHIpOw0KPiA+ICsvKioNCj4gPiArICoga3ZtX2NyZWF0ZV92Y3B1
IC0gR2V0cyBhIHBhcmtlZCBLVk0gdkNQVSBvciBjcmVhdGVzIGEgS1ZNIHZDUFUNCj4gPiArICog
QGNwdTogUU9NIENQVVN0YXRlIG9iamVjdCBmb3Igd2hpY2ggS1ZNIHZDUFUgaGFzIHRvIGJlIGZl
dGNoZWQvY3JlYXRlZC4NCj4gPiArICoNCj4gPiArICogQHJldHVybnM6IDAgd2hlbiBzdWNjZXNz
LCBlcnJubyAoPDApIHdoZW4gZmFpbGVkLg0KPiA+ICsgKi8NCj4gPiAraW50IGt2bV9jcmVhdGVf
dmNwdShDUFVTdGF0ZSAqY3B1KTsNCj4gPiArLyoqDQo+ID4gKyAqIGt2bV9wYXJrX3ZjcHUgLSBH
ZXRzIGEgcGFya2VkIEtWTSB2Q1BVIGlmIGl0IGV4aXN0cw0KPiANCj4gDQo+IF4gSSBzdXNwZWN0
IHRoYXQgZGVzY3JpcHRpb24gaXMgd3JvbmcuDQoNCkdvb2QgY2F0Y2guIEkgdGhpbmsgbWFudWFs
IG1lcmdlIGVycm9yIHdoaWxlIGNvcHlpbmcgdGhlIGNoYW5nZS4NCldpbGwgZml4Lg0KDQpUaGFu
a3MNClNhbGlsLg0KDQoNCg==

