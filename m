Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FD7CB69B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsW9d-0001Pk-Ir; Mon, 16 Oct 2023 18:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsW9Z-0001PC-I4; Mon, 16 Oct 2023 18:33:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsW9V-0004al-J8; Mon, 16 Oct 2023 18:33:37 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8X1j2FCDz67cSV;
 Tue, 17 Oct 2023 06:32:57 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 23:33:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 23:33:26 +0100
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
Subject: RE: [PATCH RFC V2 18/37] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
Thread-Topic: [PATCH RFC V2 18/37] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
Thread-Index: AQHZ8GHAnla8Z9z7eEClVl2X9T+5z7Aw0oyAgBxHs+A=
Date: Mon, 16 Oct 2023 22:33:25 +0000
Message-ID: <d2479495683f4c1d9337914b451e2282@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-19-salil.mehta@huawei.com>
 <550271cb-c415-f98e-afb4-d62df70c3ffb@redhat.com>
In-Reply-To: <550271cb-c415-f98e-afb4-d62df70c3ffb@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgMTI6MTggQU0NCj4gVG86IFNhbGlsIE1laHRh
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
bGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDE4LzM3XSBhcm0v
dmlydDogTWFrZSBBUk0gdkNQVSAqcHJlc2VudCogc3RhdHVzDQo+IEFDUEkgKnBlcnNpc3RlbnQq
DQo+IA0KPiBIaSBTYWxpbCwNCj4gDQo+IE9uIDkvMjYvMjMgMjA6MDQsIFNhbGlsIE1laHRhIHdy
b3RlOg0KPiA+IEFSTSBhcmNoIGRvZXMgbm90IGFsbG93IENQVXMgcHJlc2VuY2UgdG8gYmUgY2hh
bmdlZCBbMV0gYWZ0ZXIga2VybmVsIGhhcyBib290ZWQuDQo+ID4gSGVuY2UsIGZpcm13YXJlL0FD
UEkvUWVtdSBtdXN0IGVuc3VyZSBwZXJzaXN0ZW50IHZpZXcgb2YgdGhlIHZDUFVzIHRvIHRoZSBH
dWVzdA0KPiA+IGtlcm5lbCBldmVuIHdoZW4gdGhleSBhcmUgbm90IHByZXNlbnQgaW4gdGhlIFFv
TSBpLmUuIGFyZSB1bnBsdWdnZWQgb3IgYXJlDQo+ID4geWV0LXRvLWJlLXBsdWdnZWQNCj4gPg0K
PiA+IFJlZmVyZW5jZXM6DQo+ID4gWzFdIENoZWNrIGNvbW1lbnQgNSBpbiB0aGUgYnVnemlsbGEg
ZW50cnkNCj4gPiAgICAgTGluazogaHR0cHM6Ly9idWd6aWxsYS50aWFub2NvcmUub3JnL3Nob3df
YnVnLmNnaT9pZD00NDgxI2M1DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8
c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGNwdXMtY29tbW9uLmMgICAg
ICAgICB8ICA2ICsrKysrKw0KPiA+ICAgaHcvYXJtL3ZpcnQuYyAgICAgICAgIHwgIDcgKysrKysr
Kw0KPiA+ICAgaW5jbHVkZS9ody9jb3JlL2NwdS5oIHwgMjAgKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBobW0s
IGl0J3MgYW5vdGhlciBDUFUgc3RhdGUuIFRoZXJlIGFyZSA0IENQVSBzdGF0ZXMsIHBsdXMgb3Ro
ZXIgMyBDUFUgc3RhdGVzOg0KPiBwb3NzaWJsZSwgcHJlc2VudCwgZW5hYmxlZC4gTm93IHdlJ3Jl
IGhhdmluZyBhbHdheXMtcHJlc2VudCBzdGF0ZS4NCg0KUG9zc2libGUgdkNQVSBpcyBub3QgYSBR
T00gQ1BVU3RhdGUuIE5laXRoZXIgaXQgZ2V0cyByZXByZXNlbnRlZCB0aHJvdWdoDQpBQ1BJIHRv
IHRoZSBndWVzdCBPUyB0aHJvdWdoIF9TVEEgbWV0aG9kLiBBIGRldmljZSB3aGljaCBpbiB0aGlz
IGNhc2UgaXMNCmEgQ1BVIGNhbiBiZSBpbiBFTkFCTEVEIHN0YXRlIG9yIGNhbiBqdXN0IGJlIFBS
RVNFTlQgYnV0IG5vdCBFTkFCTEVELg0KDQpBbGwgcG9zc2libGUgdkNQVXMgZ2V0IGRldGVjdGVk
IGJ5IGd1ZXN0IE9TIGJ5IHRoZSBtZXJlIHByZXNlbmNlIG9mIEdJQ0MNCkVudHJ5IChFbmFibGVk
L29ubGluZS1jYXBhYmxlKSBpbiB0aGUgQUNQSSBNQURUIFRhYmxlLg0KDQpBIHBsdWdnZWQgdkNQ
VSB3aWxsIGJlICdwcmVzZW50JyBpbiBRT00gYW5kIHdpbGwgYmUgQUNQSSBfU1RBLlBSRVNFTlQg
YXMNCndlbGwuIEEgdW4tcGx1Z2dlZCB2Q1BVIHdpbGwgYmUgJ25vdC1wcmVzZW50JyBpbiBRT00g
aS5lLiBpdHMgQ1BVU3RhdGUNCm9iamVjdCB3aWxsIGJlIE5VTEwuIFRoaXMgaXMgYWtpbiB0byB4
ODYgb3IgYW55IG90aGVyIGFyY2hpdGVjdHVyZSBhbmQNCndlIGFyZSBub3QgY2hhbmdpbmcgYW55
IG9mIHRoaXMgYXQgUU9NIGxldmVsLg0KDQpXaGF0IGNoYW5nZXMgaXMgdGhlIHJlcHJlc2VudGF0
aW9uIG9mIHVuLXBsdWdnZWQgdkNQVSB0byBHdWVzdCBPUyB2aWENCkFDUEkgX1NUQSBtZXRob2Qu
IEZvciBBUk0sIHdlICpmYWtlKiBRT00gdW4tcGx1Z2dlZCB2Q1BVIHByZXNlbmNlIHRvIHRoZQ0K
R3Vlc3QgT1MgdGhyb3VnaCB0aGUgQUNQSSBfU1RBIG1ldGhvZC4gVG8gZGV0ZWN0IHRoaXMgd2Ug
Y2hlY2sgdGhlIGJvb2wNCidhY3BpX3BlcnNpc3RlbnQnIHBhcnQgb2YgQ1BVU3RhdGUuIFRoaXMg
aGFzIHRvIGJlIHNldCBleHBsaWNpdGx5IGJ5DQpBcmNoaXRlY3R1cmVzIGxpa2UgQVJNIHdoaWNo
IGRvIG5vdCBzdXBwb3J0IGhvdC1wbHVnLiBIZW5jZSwgQ1BVcyBhcmUNCmluICdhbHdheXMgcHJl
c2VudCcgc3RhdGUgQUNQSSB3aXNlIGJ1dCBjYW5ub3QgYmUgdXNlZCBhcyB0aGV5IGFyZSANCkFD
UEkgZGlzYWJsZWQgaS5lLiBBQ1BJIF9TVEEuRU5BQkxFRD0wLg0KDQoNCj4gSSB0aGluaw0KPiB0
aG9zZSBDUFUgc3RhdGVzIGNhbiBiZSBzcXVlZXplZCBpbnRvIHRoZSBwcmV2aW91cyBwcmVzZW50
IHN0YXRlLiBXaGF0IHdlDQo+IG5lZWQgaXMgdG8gZW5zdXJlIGFsbCBwb3NzaWJsZSB2Q1BVcyBh
cmUgcHJlc2VudCBmcm9tIHRoZSBiZWdpbm5pbmcuDQoNCkFsbCBvZiB0aGlzIGlzIHVubmVjZXNz
YXJ5LCByZWFsbHkuDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQoNCg0KDQo=

