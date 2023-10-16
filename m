Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D9B7CB700
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsX11-00009y-Kl; Mon, 16 Oct 2023 19:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsX0z-00009H-6W; Mon, 16 Oct 2023 19:28:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsX0w-0004tt-4H; Mon, 16 Oct 2023 19:28:48 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8YFP4cZqz67LSb;
 Tue, 17 Oct 2023 07:28:09 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 00:28:38 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 00:28:38 +0100
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
Subject: RE: [PATCH RFC V2 23/37] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Thread-Topic: [PATCH RFC V2 23/37] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Thread-Index: AQHZ8GH3uKSBC8JNcEOBqZloz+FgALAw3a4AgBxPx4A=
Date: Mon, 16 Oct 2023 23:28:38 +0000
Message-ID: <ba75d503d2794131a5888ec186b89d6d@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-24-salil.mehta@huawei.com>
 <c45acbe4-f454-f6a0-923b-75ca1e790c03@redhat.com>
In-Reply-To: <c45acbe4-f454-f6a0-923b-75ca1e790c03@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTI6NTggQU0NCj4gVG86IFNhbGlsIE1laHRh
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
bGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDIzLzM3XSBhcm0v
dmlydDogUmVsZWFzZSBvYmplY3RzIGZvciAqZGlzYWJsZWQqDQo+IHBvc3NpYmxlIHZDUFVzIGFm
dGVyIGluaXQNCj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAyMDowNCwgU2FsaWwg
TWVodGEgd3JvdGU6DQo+ID4gRHVyaW5nIG1hY2h2aXJ0X2luaXQoKSwgUU9NIEFSTUNQVSBvYmpl
Y3RzIGFyZSBhbHNvIHByZS1jcmVhdGVkIGFsb25nDQo+IHdpdGggdGhlDQo+ID4gY29ycmVzcG9u
ZGluZyBLVk0gdkNQVXMgaW4gdGhlIGhvc3QgZm9yIGFsbCBwb3NzaWJsZSB2Q1BVcy4gVGhpcyBu
ZWNlc3NhcnkNCj4gPiBiZWNhdXNlIG9mIHRoZSBhcmNoaXRlY3R1cmFsIGNvbnN0cmFpbnQsIEtW
TSByZXN0cmljdHMgdGhlIGRlZmVycmVkIGNyZWF0aW9uIG9mDQo+ID4gdGhlIEtWTSB2Q1BVcyBh
bmQgVkdJQyBpbml0aWFsaXphdGlvbi9zaXppbmcgYWZ0ZXIgVk0gaW5pdC4gSGVuY2UsIFZHSUMg
aXMNCj4gPiBwcmUtc2l6ZWQgd2l0aCBwb3NzaWJsZSB2Q1BVcy4NCj4gPg0KPiA+IEFmdGVyIGlu
aXRpYWxpemF0aW9uIG9mIHRoZSBtYWNoaW5lIGlzIGNvbXBsZXRlIGRpc2FibGVkIHBvc3NpYmxl
IEtWTSB2Q1BVcyBhcmUNCj4gPiB0aGVuIHBhcmtlZCBhdCB0aGUgcGVyLXZpcnQtbWFjaGluZSBs
aXN0ICJrdm1fcGFya2VkX3ZjcHVzIiBhbmQgd2UgcmVsZWFzZSB0aGUNCj4gPiBRT00gQVJNQ1BV
IG9iamVjdHMgZm9yIHRoZSBkaXNhYmxlZCB2Q1BVcy4gVGhlc2Ugc2hhbGwgYmUgcmUtY3JlYXRl
ZCBhdCB0aGUgdGltZQ0KPiA+IHdoZW4gdkNQVSBpcyBob3RwbHVnZ2VkIGFnYWluLiBRT00gQVJN
Q1BVIG9iamVjdCBpcyB0aGVuIHJlLWF0dGFjaGVkIHdpdGgNCj4gPiBjb3JyZXNwb25kaW5nIHBh
cmtlZCBLVk0gdkNQVS4NCj4gPg0KPiA+IEFsdGVybmF0aXZlbHksIHdlIGNvdWxkJ3ZlIG5ldmVy
IHJlbGVhc2VkIHRoZSBRT00gQ1BVIG9iamVjdHMgYW5kIGtlcHQgb24NCj4gPiByZXVzaW5nLiBU
aGlzIGFwcHJvYWNoIG1pZ2h0IHJlcXVpcmUgc29tZSBtb2RpZmljYXRpb25zIG9mIHFkZXZpY2Vf
YWRkKCkNCj4gPiBpbnRlcmZhY2UgdG8gZ2V0IG9sZCBBUk1DUFUgb2JqZWN0IGluc3RlYWQgb2Yg
Y3JlYXRpbmcgYSBuZXcgb25lIGZvciB0aGUgaG90cGx1Zw0KPiA+IHJlcXVlc3QuDQo+ID4NCj4g
PiBFYWNoIG9mIHRoZSBhYm92ZSBhcHByb2FjaGVzIGNvbWUgd2l0aCB0aGVpciBvd24gcHJvcyBh
bmQgY29ucy4gVGhpcyBwcm90b3R5cGUNCj4gPiB1c2VzIHRoZSAxc3QgYXBwcm9hY2guKHN1Z2dl
c3Rpb25zIGFyZSB3ZWxjb21lISkNCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBLZXFpYW4g
Wmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VxaWFuIFpo
dSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQuYyB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMg
Yi9ody9hcm0vdmlydC5jDQo+ID4gaW5kZXggZjFiZWU1NjlkNS4uM2IwNjg1MzRhOCAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ID4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiA+IEBA
IC0xOTY1LDYgKzE5NjUsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV9wb3N0X2luaXQoVmlydE1h
Y2hpbmVTdGF0ZQ0KPiAqdm1zLCBNZW1vcnlSZWdpb24gKnN5c21lbSkNCj4gPiAgIHsNCj4gPiAg
ICAgICBDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9jcHVzID0gdm1zLT5wYXJlbnQucG9zc2libGVf
Y3B1czsNCj4gPiAgICAgICBpbnQgbWF4X2NwdXMgPSBNQUNISU5FKHZtcyktPnNtcC5tYXhfY3B1
czsNCj4gPiArICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5FKHZtcyk7DQo+ID4gICAgICAg
Ym9vbCBhYXJjaDY0LCBzdGVhbF90aW1lOw0KPiA+ICAgICAgIENQVVN0YXRlICpjcHU7DQo+ID4g
ICAgICAgaW50IG47DQo+ID4gQEAgLTIwMjUsNiArMjAyNiwzNyBAQCBzdGF0aWMgdm9pZCB2aXJ0
X2NwdV9wb3N0X2luaXQoVmlydE1hY2hpbmVTdGF0ZQ0KPiAqdm1zLCBNZW1vcnlSZWdpb24gKnN5
c21lbSkNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgfQ0KPiA+ICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICBpZiAoa3ZtX2VuYWJsZWQoKSB8fCB0Y2dfZW5hYmxlZCgpKSB7DQo+
ID4gKyAgICAgICAgZm9yIChuID0gMDsgbiA8IHBvc3NpYmxlX2NwdXMtPmxlbjsgbisrKSB7DQo+
ID4gKyAgICAgICAgICAgIGNwdSA9IHFlbXVfZ2V0X3Bvc3NpYmxlX2NwdShuKTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAqIE5vdywgR0lDIGhhcyBiZWVu
IHNpemVkIHdpdGggcG9zc2libGUgQ1BVcyBhbmQgd2UgZG9u4oCZdCByZXF1aXJlDQo+ID4gKyAg
ICAgICAgICAgICAqIGRpc2FibGVkIHZDUFUgb2JqZWN0cyB0byBiZSByZXByZXNlbnRlZCBpbiB0
aGUgUU9NLiBSZWxlYXNlIHRoZQ0KPiA+ICsgICAgICAgICAgICAgKiBkaXNhYmxlZCBBUk1DUFUg
b2JqZWN0cyBlYXJsaWVyIHVzZWQgZHVyaW5nIGluaXQgZm9yIHByZS1zaXppbmcuDQo+ID4gKyAg
ICAgICAgICAgICAqDQo+ID4gKyAgICAgICAgICAgICAqIFdlIGZha2UgdG8gdGhlIGd1ZXN0IHRo
cm91Z2ggQUNQSSBhYm91dCB0aGUgcHJlc2VuY2UoX1NUQS5QUkVTPTEpDQo+ID4gKyAgICAgICAg
ICAgICAqIG9mIHRoZXNlIG5vbi1leGlzdGVudCB2Q1BVcyBhdCBWTU0vcWVtdSBhbmQgcHJlc2Vu
dCB0aGVzZSBhcw0KPiA+ICsgICAgICAgICAgICAgKiBkaXNhYmxlZCB2Q1BVcyhfU1RBLkVOQT0w
KSBzbyB0aGF0IHRoZXkgY2FudCBiZSB1c2VkLiBUaGVzZSB2Q1BVcw0KPiA+ICsgICAgICAgICAg
ICAgKiBjYW4gYmUgbGF0ZXIgYWRkZWQgdG8gdGhlIGd1ZXN0IHRocm91Z2ggaG90cGx1ZyBleGNo
YW5nZXMgd2hlbg0KPiA+ICsgICAgICAgICAgICAgKiBBUk1DUFUgb2JqZWN0cyBhcmUgY3JlYXRl
ZCBiYWNrIGFnYWluIHVzaW5nICdkZXZpY2VfYWRkJyBRTVANCj4gPiArICAgICAgICAgICAgICog
Y29tbWFuZC4NCj4gPiArICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgIC8qDQo+ID4g
KyAgICAgICAgICAgICAqIFJGQzogUXVlc3Rpb246IE90aGVyIGFwcHJvYWNoIGNvdWxkJ3ZlIGJl
ZW4gdG8ga2VlcCB0aGVtIGZvcmV2ZXINCj4gPiArICAgICAgICAgICAgICogYW5kIHJlbGVhc2Ug
aXQgb25seSBvbmNlIHdoZW4gcWVtdSBleGl0cyBhcyBwYXJ0IG9mIGZpbmFsaXplIG9yDQo+ID4g
KyAgICAgICAgICAgICAqIHdoZW4gbmV3IHZDUFUgaXMgaG90cGx1Z2dlZC4gSW4gdGhlIGxhdGVy
IG9sZCBjb3VsZCBiZSByZWxlYXNlZA0KPiA+ICsgICAgICAgICAgICAgKiBmb3IgdGhlIG5ld2x5
IGNyZWF0ZWQgb2JqZWN0IGZvciB0aGUgc2FtZSB2Q1BVPw0KPiA+ICsgICAgICAgICAgICAgKi8N
Cj4gPiArICAgICAgICAgICAgaWYgKCFxZW11X2VuYWJsZWRfY3B1KGNwdSkpIHsNCj4gPiArICAg
ICAgICAgICAgICAgIENQVUFyY2hJZCAqY3B1X3Nsb3Q7DQo+ID4gKyAgICAgICAgICAgICAgICBj
cHVfc2xvdCA9IHZpcnRfZmluZF9jcHVfc2xvdChtcywgY3B1LT5jcHVfaW5kZXgpOw0KPiA+ICsg
ICAgICAgICAgICAgICAgY3B1X3Nsb3QtPmNwdSA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgICAg
ICBvYmplY3RfdW5yZWYoT0JKRUNUKGNwdSkpOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICAgfQ0KPiA+DQo+IA0KPiBOZWVkbid0IHdlIHJlbGVh
c2UgdGhvc2UgQ1BVIGluc3RhbmNlcyBmb3IgaHZlIGFuZCBxdGVzdD8gQmVzaWRlcywgSSB0aGlu
ayBpdCdzDQo+IGhhcmQgZm9yIHJldXNlIHRob3NlIG9iamVjdHMgYmVjYXVzZSB0aGV5J3JlIG1h
bmFnZWQgYnkgUU9NLCB3aGljaCBpcyBhbG1vc3QNCj4gdHJhbnNwYXJlbnQgdG8gdXMsIGNvcnJl
Y3Q/DQoNCkZvciBub3csIHRoaXMgY29kZSBsZWcgd29uJ3QgaGl0IGZvciBUQ0csIEhWRSBvciBx
dGVzdC4gVGhlc2UgYXJlIG5vdCBzdXBwb3J0ZWQNCmluIHRoaXMgcmVsZWFzZS4gSSBtaWdodCBl
bmFibGUgc3VwcG9ydCBvZiBUQ0cgaW4gY29taW5nIG1vbnRocy4gU29tZSBmaXhpbmcgYW5kDQp0
ZXN0aW5nIGlzIHJlcXVpcmVkLg0KDQpJIGhhZCBjcmVhdGVkIDIgd29ya2luZyBwcm90b3R5cGVz
IGVhcmxpZXIgaW4gdGhlIHllYXIgMjAyMC4gT25lIGRpZCBub3QgcmVsZWFzZQ0KdGhlIENQVSBv
YmplY3RzLiBIZW5jZSwgdGhlIEFDUEkgQ1BVIEhvdHBsdWcgc3RhdGUgd2FzIGFsd2F5cyBpbiBz
eW5jIHdpdGggUU9NDQpDUFVTdGF0ZS4gQnV0IGl0IHJlcXVpcmVkIHNvbWUgY2hhbmdlcyBpbiB0
aGUgcWRldiBjcmVhdGlvbiBsZWcgZm9yIHRoZSByZXVzZSBvZg0KdGhlIGV4aXN0aW5nIENQVSBv
YmplY3QgLSB3aGljaCBJZ29yIHdhcyBub3QgaW4gZmF2b3Igb2YuIFBsdXMsIGl0IGhhZCBzb21l
IGlzc3Vlcw0Kd2l0aCBMaXZlIG1pZ3JhdGlvbiAod2hpY2ggd2VyZSBsZWZ0IHVucmVzb2x2ZWQg
YXQgdGhhdCB0aW1lKS4gIEhlbmNlLCB1c2VkIHRoZQ0KY3VycmVudCBhcHByb2FjaCBhcyB0aGUg
cHJpbWFyeSBvbmUuDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0KDQoNCg0KDQo=

