Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2777B67CA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndWE-0000kN-EY; Tue, 03 Oct 2023 07:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndW8-0000du-Bj; Tue, 03 Oct 2023 07:24:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndW4-0001bX-Ky; Tue, 03 Oct 2023 07:24:44 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0FpP1hqQz6K6gZ;
 Tue,  3 Oct 2023 19:24:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:24:37 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:24:37 +0100
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
Subject: RE: [PATCH V2 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Thread-Topic: [PATCH V2 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len
 macro to common header file
Thread-Index: AQHZ8zP1LrysHzRY/k+39C2qQDqLGrA3FqMAgADbPOA=
Date: Tue, 3 Oct 2023 11:24:37 +0000
Message-ID: <3c6acfadf8ef4f5792125153feb6c3d5@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-3-salil.mehta@huawei.com>
 <64ecbf50-2287-6bd4-d2bd-e37a793ed6a9@redhat.com>
In-Reply-To: <64ecbf50-2287-6bd4-d2bd-e37a793ed6a9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.138]
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
dDogVHVlc2RheSwgT2N0b2JlciAzLCAyMDIzIDEyOjIwIEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8
c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS0NCj4g
YXJtQG5vbmdudS5vcmcNCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFy
by5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBpbWFtbWVkb0ByZWRoYXQuY29tOyBhbmRyZXcu
am9uZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsg
ZXJpYy5hdWdlckByZWRoYXQuY29tOyBvbGl2ZXIudXB0b25AbGludXguZGV2Ow0KPiBwYm9uemlu
aUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyByYWZhZWxAa2Vy
bmVsLm9yZzsNCj4gYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgbGludXhAYXJtbGludXgub3JnLnVr
Ow0KPiBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgaWxra2FAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbTsNCj4gdmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb207IGthcmwuaGV1YmF1bUBv
cmFjbGUuY29tOw0KPiBtaWd1ZWwubHVpc0BvcmFjbGUuY29tOyBzYWxpbC5tZWh0YUBvcG5zcmMu
bmV0OyB6aHVrZXFpYW4NCj4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4aW9uZ2Zlbmcg
KEMpIDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsNCj4gd2FuZ3lhbmFuIChZKSA8d2FuZ3lh
bmFuNTVAaHVhd2VpLmNvbT47IGppYWtlcm5lbDJAZ21haWwuY29tOw0KPiBtYW9iaWJvQGxvb25n
c29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAwMi8xMF0gaHcvYWNwaTogTW92ZSBDUFUg
Y3RybC1kZXYgTU1JTyByZWdpb24gbGVuDQo+IG1hY3JvIHRvIGNvbW1vbiBoZWFkZXIgZmlsZQ0K
PiANCj4gT24gOS8zMC8yMyAxMDoxOSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gQ1BVIGN0cmwt
ZGV2IE1NSU8gcmVnaW9uIGxlbmd0aCBjb3VsZCBiZSB1c2VkIGluIEFDUEkgR0VEIGFuZCB2YXJp
b3VzDQo+IG90aGVyDQo+ID4gYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBsYWNlcy4gTW92ZSBBQ1BJ
X0NQVV9IT1RQTFVHX1JFR19MRU4gbWFjcm8gdG8gbW9yZQ0KPiA+IGFwcHJvcHJpYXRlIGNvbW1v
biBoZWFkZXIgZmlsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXgu
YmVubmVlQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+ID4gICBody9hY3BpL2NwdS5jICAgICAgICAg
ICAgICAgICB8IDIgKy0NCj4gPiAgIGluY2x1ZGUvaHcvYWNwaS9jcHVfaG90cGx1Zy5oIHwgMiAr
Kw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQoN
ClRoYW5rcw0KU2FsaWwuDQo=

