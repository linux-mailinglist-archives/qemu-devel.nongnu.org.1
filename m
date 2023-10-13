Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D87C82EC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFIz-0002g2-0s; Fri, 13 Oct 2023 06:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qrFIt-0002NV-RJ; Fri, 13 Oct 2023 06:22:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qrFIr-0001Lb-0U; Fri, 13 Oct 2023 06:21:59 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6Mx24PHcz688p7;
 Fri, 13 Oct 2023 18:21:26 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 13 Oct 2023 11:21:49 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Fri, 13 Oct 2023 11:21:49 +0100
To: lixianglai <lixianglai@loongson.cn>, "qemu-devel@nongnu.org"
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
 <maobibo@loongson.cn>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V5 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V5 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHZ/HtfLWuY6i1N0k+WjJbW2iez6rBHCU2AgAB6juA=
Date: Fri, 13 Oct 2023 10:21:49 +0000
Message-ID: <42792608ae1f4eecb13c43c06197a837@huawei.com>
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <34927805-a968-271f-16c2-17c8d90693d9@loongson.cn>
In-Reply-To: <34927805-a968-271f-16c2-17c8d90693d9@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.32]
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

SGkgWGlhbmdsYWksDQoNCj4gRnJvbTogbGl4aWFuZ2xhaSA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5j
bj4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDEzLCAyMDIzIDQ6NTggQU0NCj4gVG86IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBx
ZW11LQ0KPiBhcm1Abm9uZ251Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlw
cGVAbGluYXJvLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3
ZWkuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc7IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207
IGFuZHJldy5qb25lc0BsaW51eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5h
cm8ub3JnOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IG9saXZlci51cHRvbkBsaW51eC5kZXY7DQo+
IHBib256aW5pQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGdz
aGFuQHJlZGhhdC5jb207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnOyBsaW51eEBhcm1saW51eC5vcmcudWs7DQo+IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcu
Y29tOyBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiB2aXNobnVAb3MuYW1wZXJlY29t
cHV0aW5nLmNvbTsga2FybC5oZXViYXVtQG9yYWNsZS5jb207DQo+IG1pZ3VlbC5sdWlzQG9yYWNs
ZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7IHpodWtlcWlhbg0KPiA8emh1a2VxaWFuMUBo
dWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+
Ow0KPiB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgamlha2VybmVsMkBn
bWFpbC5jb207DQo+IG1hb2JpYm9AbG9vbmdzb24uY247IExpbnV4YXJtIDxsaW51eGFybUBodWF3
ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDAvOV0gQWRkIGFyY2hpdGVjdHVyZSBh
Z25vc3RpYyBjb2RlIHRvIHN1cHBvcnQgdkNQVQ0KPiBIb3RwbHVnDQo+IA0KPiBIaSBTYWxpbCBN
ZWh0YSB2aWE6DQo+IA0KPiA+IFZpcnR1YWwgQ1BVIGhvdHBsdWcgc3VwcG9ydCBpcyBiZWluZyBh
ZGRlZCBhY3Jvc3MgdmFyaW91cw0KPiBhcmNoaXRlY3R1cmVzWzFdWzNdLg0KDQpbLi4uXQ0KDQoN
Cj4gSSByZWJhc2UgeW91ciBwYXRjaCB2NSBvbiBsb29uZ2FyY2ggdGNnLCB0aGVyZSBpcyBubyBw
cm9ibGVtIHdpdGggY3B1DQo+IGhvdHBsdWcvdW5wbHVnLg0KPiANCj4gVGhhbmsgeW91IHNvIG11
Y2ggZm9yIHlvdXIgY29udHJpYnV0aW9uIHRvIHRoZSBjb21tdW5pdHkuDQoNCk1hbnkgdGhhbmtz
IGZvciB0ZXN0aW5nIGFuZCB0aGlzIGNvbmZpcm1hdGlvbiENCg0KU2luY2UgeW91IGhhdmUgc2hh
cmVkIFRlc3RlZC1ieSB0YWcgb24gVjUgaW4gcHJpdmF0ZSBJIHdpbGwNCmFkZCBpdCBpbiBWNi4N
Cg0KQnV0IGNhbiBJIHJlcXVlc3QgeW91ciBUZXN0ZWQtYnkgdGFnIGhlcmUgYXMgd2VsbCBzbyB0
aGF0DQppdCBpcyB2aXNpYmxlIHRvIHRoZSBtYWludGFpbmVycyBhcyB3ZWxsPw0KDQoNClRoYW5r
cw0KU2FsaWwuDQoNCg0KDQo+IA0KPiBUaGFua3MsDQo+IFhpYW5nbGFpLg0KPiANCg0K

