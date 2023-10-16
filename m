Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B07CB5CD
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVY2-0003fe-6x; Mon, 16 Oct 2023 17:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVXy-0003et-U3; Mon, 16 Oct 2023 17:54:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsVXw-0006aj-JT; Mon, 16 Oct 2023 17:54:46 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8W8v4sR7z67LyQ;
 Tue, 17 Oct 2023 05:54:07 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 22:54:36 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 22:54:36 +0100
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
Subject: RE: [PATCH RFC V2 15/37] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Topic: [PATCH RFC V2 15/37] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
Thread-Index: AQHZ8GGfIj1MOTEJk0aTnKJqOI89BrAvXvUAgB21WzA=
Date: Mon, 16 Oct 2023 21:54:36 +0000
Message-ID: <2522f2dfb57c4796bab685dc87b21906@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-16-salil.mehta@huawei.com>
 <37064f7b-1ad5-b636-3cdb-97208d995c95@redhat.com>
In-Reply-To: <37064f7b-1ad5-b636-3cdb-97208d995c95@redhat.com>
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
U2VwdGVtYmVyIDI4LCAyMDIzIDI6MDggQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiBhcm1Abm9uZ251
Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgSm9u
YXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0BsaW51
eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgYXJkYkBrZXJuZWwub3JnOw0KPiBvbGl2ZXIu
dXB0b25AbGludXguZGV2OyBwYm9uemluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj4g
cmFmYWVsQGtlcm5lbC5vcmc7IGJvcm50cmFlZ2VyQGxpbnV4LmlibS5jb207IGFsZXguYmVubmVl
QGxpbmFyby5vcmc7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgZGFycmVuQG9zLmFtcGVyZWNv
bXB1dGluZy5jb207DQo+IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IHZpc2hudUBvcy5h
bXBlcmVjb21wdXRpbmcuY29tOw0KPiBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsgbWlndWVsLmx1
aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsNCj4gemh1a2VxaWFuIDx6aHVr
ZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKQ0KPiA8d2FuZ3hpb25nZmVuZzJA
aHVhd2VpLmNvbT47IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+Ow0KPiBq
aWFrZXJuZWwyQGdtYWlsLmNvbTsgbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFuZ2xhaUBsb29u
Z3Nvbi5jbg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyBWMiAxNS8zN10gYXJtL3ZpcnQ6IENy
ZWF0ZSBHRUQgZGV2IGJlZm9yZQ0KPiAqZGlzYWJsZWQqIENQVSBPYmpzIGFyZSBkZXN0cm95ZWQN
Cj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAyMDowNCwgU2FsaWwgTWVodGEgd3Jv
dGU6DQo+ID4gQUNQSSBDUFUgaG90cGx1ZyBzdGF0ZSAoaXNfcHJlc2VudD1fU1RBLlBSRVNFTlQs
IGlzX2VuYWJsZWQ9X1NUQS5FTkFCTEVEKSBmb3INCj4gPiBhbGwgdGhlIHBvc3NpYmxlIHZDUFVz
IE1VU1QgYmUgaW5pdGlhbGl6ZWQgZHVyaW5nIG1hY2hpbmUgaW5pdC4gVGhpcyBpcyBkb25lDQo+
ID4gZHVyaW5nIHRoZSBjcmVhdGlvbiBvZiB0aGUgR0VEIGRldmljZS4gVk1NL1FlbXUgTVVTVCBl
eHBvc2UvZmFrZSB0aGUgQUNQSSBzdGF0ZQ0KPiA+IG9mIHRoZSBkaXNhYmxlZCB2Q1BVcyB0byB0
aGUgR3Vlc3Qga2VybmVsIGFzICdwcmVzZW50JyAoX1NUQS5QUkVTRU5UKSBhbHdheXMNCj4gPiBp
LmUuIEFDUEkgcGVyc2lzdGVudC4gaWYgdGhlICdkaXNhYmxlZCcgdkNQVSBvYmplY3RlcyBhcmUg
ZGVzdHJveWVkIGJlZm9yZSB0aGUNCj4gPiBHRUQgZGV2aWNlIGhhcyBiZWVuIGNyZWF0ZWQgdGhl
biB0aGVpciBBQ1BJIGhvdHBsdWcgc3RhdGUgbWlnaHQgbm90IGdldA0KPiA+IGluaXRpYWxpemVk
IGNvcnJlY3RseSBhcyBhY3BpX3BlcnNpc3RlbnQgZmxhZyBpcyBwYXJ0IG9mIHRoZSBDUFVTdGF0
ZS4gVGhpcyB3aWxsDQo+ID4gZXhwb3NlIHdyb25nIHN0YXR1cyBvZiB0aGUgdW5wbHVnZ2VkIHZD
UFVzIHRvIHRoZSBHdWVzdCBrZXJuZWwuDQo+ID4NCj4gPiBIZW5jZSwgbW92aW5nIHRoZSBHRUQg
ZGV2aWNlIGNyZWF0aW9uIGJlZm9yZSBkaXNhYmxlZCB2Q1BVIG9iamVjdHMgZ2V0IGRlc3Ryb3ll
ZA0KPiA+IGFzIHBhcnQgb2YgdGhlIHBvc3QgQ1BVIGluaXQgcm91dGluZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgaHcvYXJtL3ZpcnQuYyB8IDEwICsrKysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4gPiBpbmRleCA1YzhhMDY3MmRjLi5j
YmI2MTk5ZWM2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gPiArKysgYi9ody9h
cm0vdmlydC5jDQo+ID4gQEAgLTIzNzYsNiArMjM3NiwxMiBAQCBzdGF0aWMgdm9pZCBtYWNodmly
dF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gPg0KPiA+ICAgICAgIGNyZWF0ZV9naWMo
dm1zLCBzeXNtZW0pOw0KPiA+DQo+ID4gKyAgICBoYXNfZ2VkID0gaGFzX2dlZCAmJiBhYXJjaDY0
ICYmIGZpcm13YXJlX2xvYWRlZCAmJg0KPiA+ICsgICAgICAgICAgICAgIHZpcnRfaXNfYWNwaV9l
bmFibGVkKHZtcyk7DQo+ID4gKyAgICBpZiAoaGFzX2dlZCkgew0KPiA+ICsgICAgICAgIHZtcy0+
YWNwaV9kZXYgPSBjcmVhdGVfYWNwaV9nZWQodm1zKTsNCj4gPiArICAgIH0NCj4gPiArDQo+IA0K
PiBJIHByZWZlciB0aGUgb2xkIHN0eWxlLiBTcXVlZXppbmcgYWxsIGNvbmRpdGlvbnMgdG8gQGhh
c19nZWQgY2hhbmdlcyB3aGF0J3MNCj4gdG8gYmUgbWVhbnQgYnkgQGhhc19nZWQgaXRzZWxmLg0K
DQpUaGUgY2hlY2sgaXMgdG9vIGxvbmcgYW5kIGEgc2ltaWxhciBwaWVjZSBvZiBjb2RlIGhhcyB0
byB1c2VkIGFnYWluDQpkb3duIGJlbG93LiBIZW5jZSwgdG8gcmV1c2UgdGhlIHJlc3VsdCwgaXQn
cyBiZXR0ZXIgdG8gc3RvcmUgdGhlIGZpcnN0DQpyZXN1bHQgaW4gYSB2YXJpYWJsZS4NCg0KSSBj
YW4gc2VlIHlvdSBwb2ludCB0aG91Z2guIFRvIG1pdGlnYXRlIHRoYXQgSSBjYW4gdXNlIGEgbmV3
IHZhcmlhYmxlDQpmb3IgdGhpcz8NCg0KDQpUaGFua3MNClNhbGlsLg0KDQoNCj4gDQo+ICAgICAg
ICAgaWYgKGhhc19nZWQgJiYgYWFyY2g2NCAmJiBmaXJtd2FyZV9sb2FkZWQgJiYNCj4gdmlydF9p
c19hY3BpX2VuYWJsZWQodm1zKSkgew0KPiAgICAgICAgICAgICA6DQo+ICAgICAgICAgfQ0KPiAN
Cj4gPiAgICAgICB2aXJ0X2NwdV9wb3N0X2luaXQodm1zLCBzeXNtZW0pOw0KPiA+DQo+ID4gICAg
ICAgZmR0X2FkZF9wbXVfbm9kZXModm1zKTsNCj4gPiBAQCAtMjM5OCw5ICsyNDA0LDcgQEAgc3Rh
dGljIHZvaWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4NCj4gPiAg
ICAgICBjcmVhdGVfcGNpZSh2bXMpOw0KPiA+DQo+ID4gLSAgICBpZiAoaGFzX2dlZCAmJiBhYXJj
aDY0ICYmIGZpcm13YXJlX2xvYWRlZCAmJg0KPiB2aXJ0X2lzX2FjcGlfZW5hYmxlZCh2bXMpKSB7
DQo+ID4gLSAgICAgICAgdm1zLT5hY3BpX2RldiA9IGNyZWF0ZV9hY3BpX2dlZCh2bXMpOw0KPiA+
IC0gICAgfSBlbHNlIHsNCj4gPiArICAgIGlmICghaGFzX2dlZCkgew0KPiA+ICAgICAgICAgICBj
cmVhdGVfZ3Bpb19kZXZpY2VzKHZtcywgVklSVF9HUElPLCBzeXNtZW0pOw0KPiA+ICAgICAgIH0N
Cj4gPg0KPiANCj4gVGhhbmtzLA0KPiBHYXZpbg0KDQo=

