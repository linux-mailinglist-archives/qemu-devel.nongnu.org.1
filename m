Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A47CA490
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKHh-0002e3-Gl; Mon, 16 Oct 2023 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsKHd-0002dq-KB; Mon, 16 Oct 2023 05:53:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsKHa-0004ow-Is; Mon, 16 Oct 2023 05:53:09 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8C4x4jVpz6J9yf;
 Mon, 16 Oct 2023 17:49:37 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 10:52:53 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 10:52:53 +0100
To: Miguel Luis <miguel.luis@oracle.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, Karl Heubaum
 <karl.heubaum@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, 
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHZ/cNQxAxt9PC9FEqdNAxyY88QobBH2dQAgARWpIA=
Date: Mon, 16 Oct 2023 09:52:53 +0000
Message-ID: <187d0a24a81b4f1abbb23795325073ea@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
In-Reply-To: <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.147.12]
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

SGkgTWlndWVsLA0KDQo+IEZyb206IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29t
Pg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMTMsIDIwMjMgNTozNCBQTQ0KPiBUbzogU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5v
cmc7IHFlbXUtYXJtQG5vbmdudS5vcmc7IE1hcmMgWnluZ2llcg0KPiA8bWF6QGtlcm5lbC5vcmc+
OyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsgUGV0ZXIgTWF5ZGVs
bA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBpbWFtbWVkb0ByZWRoYXQuY29tOw0KPiBhbmRy
ZXcuam9uZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJvLm9yZzsN
Cj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBvbGl2ZXIudXB0b25AbGludXguZGV2OyBwYm9uemlu
aUByZWRoYXQuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBnc2hhbkBy
ZWRoYXQuY29tOyByYWZhZWxAa2VybmVsLm9yZzsNCj4gYWxleC5iZW5uZWVAbGluYXJvLm9yZzsg
bGludXhAYXJtbGludXgub3JnLnVrOw0KPiBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsg
aWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4gdmlzaG51QG9zLmFtcGVyZWNvbXB1dGlu
Zy5jb207IEthcmwgSGV1YmF1bSA8a2FybC5oZXViYXVtQG9yYWNsZS5jb20+Ow0KPiBzYWxpbC5t
ZWh0YUBvcG5zcmMubmV0OyB6aHVrZXFpYW4gPHpodWtlcWlhbjFAaHVhd2VpLmNvbT47IHdhbmd4
aW9uZ2ZlbmcNCj4gKEMpIDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuIChZ
KSA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47DQo+IGppYWtlcm5lbDJAZ21haWwuY29tOyBtYW9i
aWJvQGxvb25nc29uLmNuOyBsaXhpYW5nbGFpQGxvb25nc29uLmNuOyBMaW51eGFybQ0KPiA8bGlu
dXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNiAwLzldIEFkZCBhcmNo
aXRlY3R1cmUgYWdub3N0aWMgY29kZSB0byBzdXBwb3J0IHZDUFUNCj4gSG90cGx1Zw0KPiANCj4g
SGkgU2FsaWwsDQo+IA0KPiA+IE9uIDEzIE9jdCAyMDIzLCBhdCAxMDo1MSwgU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVmlydHVhbCBDUFUgaG90
cGx1ZyBzdXBwb3J0IGlzIGJlaW5nIGFkZGVkIGFjcm9zcyB2YXJpb3VzDQo+IGFyY2hpdGVjdHVy
ZXNbMV1bM10uDQo+ID4gVGhpcyBzZXJpZXMgYWRkcyB2YXJpb3VzIGNvZGUgYml0cyBjb21tb24g
YWNyb3NzIGFsbCBhcmNoaXRlY3R1cmVzOg0KDQoNClsuLi5dDQoNCg0KPiBJIHRlc3RlZCBpdCBm
b3IgQXJtNjQsIG1ha2UgY2hlY2ssIGJvb3QvcmVib290LCBsaXZlIG1pZ3JhdGlvbiBhbmQgZm91
bmQgbm8NCj4gaXNzdWVzLA0KPiBzbyBmb3IgdGhpcywgcGxlYXNlIGZlZWwgZnJlZSB0byBhZGQ6
DQo+IA0KPiBUZXN0ZWQtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0K
DQpHcmVhdC4gTWFueSB0aGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24uIA0KDQpJIGd1ZXNzIHlv
dSBhcmUgcmVwZWF0aW5nIHRoZSBzYW1lIGZvciB4ODYgYXMgd2VsbD8NCg0KU2FsaWwuDQo=

