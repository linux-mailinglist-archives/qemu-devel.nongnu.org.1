Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997D7B504E
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnG9l-0002ka-UW; Mon, 02 Oct 2023 06:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnG9h-0002kL-Ko; Mon, 02 Oct 2023 06:28:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qnG9Z-00020P-22; Mon, 02 Oct 2023 06:27:56 -0400
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzcbF2NH4z67kqq;
 Mon,  2 Oct 2023 18:27:37 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 2 Oct 2023 11:27:44 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 2 Oct 2023 11:27:44 +0100
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
Subject: RE: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
 change common to vCPU {cold|hot}-plug
Thread-Topic: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
 change common to vCPU {cold|hot}-plug
Thread-Index: AQHZ8GEl17RFLqukJ0mxgmcKIPSj3bAuJqCAgAguIcA=
Date: Mon, 2 Oct 2023 10:27:44 +0000
Message-ID: <aaed4b2e463840e9b41e07c27efedbcd@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-5-salil.mehta@huawei.com>
 <41003807-062f-1121-956e-72e0444e048f@redhat.com>
In-Reply-To: <41003807-062f-1121-956e-72e0444e048f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjMgNzozMCBBTQ0KPiBUbzogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
DQo+IGFybUBub25nbnUub3JnDQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBs
aW5hcm8ub3JnOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5j
b20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5k
cmV3LmpvbmVzQGxpbnV4LmRldjsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5v
cmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBhcmRiQGtlcm5lbC5v
cmc7DQo+IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhhdC5jb207IG1zdEBy
ZWRoYXQuY29tOw0KPiByYWZhZWxAa2VybmVsLm9yZzsgYm9ybnRyYWVnZXJAbGludXguaWJtLmNv
bTsgYWxleC5iZW5uZWVAbGluYXJvLm9yZzsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBkYXJy
ZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4gaWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNv
bTsgdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IGthcmwuaGV1YmF1bUBvcmFjbGUu
Y29tOyBtaWd1ZWwubHVpc0BvcmFjbGUuY29tOyBzYWxpbC5tZWh0YUBvcG5zcmMubmV0Ow0KPiB6
aHVrZXFpYW4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4aW9uZ2ZlbmcgKEMpDQo+IDx3
YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuIChZKSA8d2FuZ3lhbmFuNTVAaHVh
d2VpLmNvbT47DQo+IGppYWtlcm5lbDJAZ21haWwuY29tOyBtYW9iaWJvQGxvb25nc29uLmNuOyBs
aXhpYW5nbGFpQGxvb25nc29uLmNuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIFYyIDA0LzM3
XSBhcm0vdmlydCx0YXJnZXQvYXJtOiBNYWNoaW5lIGluaXQgdGltZQ0KPiBjaGFuZ2UgY29tbW9u
IHRvIHZDUFUge2NvbGR8aG90fS1wbHVnDQo+IA0KPiBPbiA5LzI2LzIzIDIwOjA0LCBTYWxpbCBN
ZWh0YSB3cm90ZToNCj4gPiBSZWZhY3RvciBhbmQgaW50cm9kdWNlIHRoZSBjb21tb24gbG9naWMg
cmVxdWlyZWQgZHVyaW5nIHRoZQ0KPiBpbml0aWFsaXphdGlvbiBvZg0KPiA+IGJvdGggY29sZCBh
bmQgaG90IHBsdWdnZWQgdkNQVXMuIEFsc28gaW5pdGlhbGl6ZSB0aGUgKmRpc2FibGVkKiBzdGF0
ZSBvZiB0aGUNCj4gPiB2Q1BVcyB3aGljaCBzaGFsbCBiZSB1c2VkIGZ1cnRoZXIgZHVyaW5nIGlu
aXQgcGhhc2VzIG9mIHZhcmlvdXMgb3RoZXIgY29tcG9uZW50cw0KPiA+IGxpa2UgR0lDLCBQTVUs
IEFDUEkgZXRjIGFzIHBhcnQgb2YgdGhlIHZpcnQgbWFjaGluZSBpbml0aWFsaXphdGlvbi4NCg0K
Wy4uLl0NCg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlh
bjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4x
QGh1YXdlaS5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IEdhdmluIFNoYW4gPGdhdmluLnNoYW5AcmVk
aGF0LmNvbT4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5e
Xl5eXg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxnc2hhbkByZWRoYXQuY29t
Pg0KDQoNCkFoLiBHcm9zcy4gU29ycnkgYWJvdXQgdGhpcy4gV2lsbCBmaXguDQoNClRoYW5rcw0K
U2FsaWwuDQoNCj4gDQo+ID4gW0dTOiBwb2ludGVkIHRoZSBhc3NlcnRpb24gZHVlIHRvIHdyb25n
IHJhbmdlIGNoZWNrXQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQuYyAgICAgIHwgMTQ5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgdGFyZ2V0
L2FybS9jcHUuYyAgIHwgICA3ICsrKw0KPiA+ICAgdGFyZ2V0L2FybS9jcHU2NC5jIHwgIDE0ICsr
KysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE1NiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkNCj4gPg0KDQo=

