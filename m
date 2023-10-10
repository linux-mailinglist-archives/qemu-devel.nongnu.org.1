Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDAB7BF7DF
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9O0-0006mC-Mv; Tue, 10 Oct 2023 05:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qq9Ny-0006aV-Na; Tue, 10 Oct 2023 05:50:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qq9Nw-000428-TX; Tue, 10 Oct 2023 05:50:42 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S4WKQ30LNz6D8cV;
 Tue, 10 Oct 2023 17:47:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 10:50:38 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 10 Oct 2023 10:50:38 +0100
To: Shaoqin Huang <shahuang@redhat.com>, "qemu-devel@nongnu.org"
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
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V4 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Topic: [PATCH V4 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Index: AQHZ+vCtAkAWKYXgr0OuLtDfoazlJ7BCnfiAgAAqeOA=
Date: Tue, 10 Oct 2023 09:50:38 +0000
Message-ID: <9cf277f61c4b401fa39cbc88109e1db1@huawei.com>
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-8-salil.mehta@huawei.com>
 <d9fdeb5b-5da2-8411-7940-e64ad7ebf91b@redhat.com>
In-Reply-To: <d9fdeb5b-5da2-8411-7940-e64ad7ebf91b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.234]
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

PiBGcm9tOiBTaGFvcWluIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDEwLCAyMDIzIDk6MTggQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5t
ZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiBhcm1Abm9u
Z251Lm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsg
Sm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgbHBpZXJh
bGlzaUBrZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0Bs
aW51eC5kZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IG9saXZlci51cHRvbkBsaW51eC5kZXY7DQo+IHBib256aW5pQHJlZGhh
dC5jb207IG1zdEByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGdzaGFuQHJlZGhhdC5jb207
DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBsaW51eEBhcm1s
aW51eC5vcmcudWs7DQo+IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBpbGtrYUBvcy5h
bXBlcmVjb21wdXRpbmcuY29tOw0KPiB2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsga2Fy
bC5oZXViYXVtQG9yYWNsZS5jb207DQo+IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1l
aHRhQG9wbnNyYy5uZXQ7IHpodWtlcWlhbg0KPiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2Fu
Z3hpb25nZmVuZyAoQykgPHdhbmd4aW9uZ2ZlbmcyQGh1YXdlaS5jb20+Ow0KPiB3YW5neWFuYW4g
KFkpIDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgamlha2VybmVsMkBnbWFpbC5jb207DQo+IG1h
b2JpYm9AbG9vbmdzb24uY247IGxpeGlhbmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtIDxsaW51
eGFybUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDA3LzEwXSBody9hY3Bp
OiBVcGRhdGUgQUNQSSBHRUQgZnJhbWV3b3JrIHRvIHN1cHBvcnQNCj4gdkNQVSBIb3RwbHVnDQo+
IA0KPiBPbiAxMC8xMC8yMyAwNDozNSwgU2FsaWwgTWVodGEgdmlhIHdyb3RlOg0KPiA+IEFDUEkg
R0VEIHNoYWxsIGJlIHVzZWQgdG8gY29udmV5IHRvIHRoZSBndWVzdCBrZXJuZWwgYWJvdXQgYW55
IENQVSBob3QtDQo+ICh1bilwbHVnDQo+ID4gZXZlbnRzLiBUaGVyZWZvcmUsIGV4aXN0aW5nIEFD
UEkgR0VEIGZyYW1ld29yayBpbnNpZGUgUUVNVSBuZWVkcyB0byBiZQ0KPiBlbmhhbmNlZA0KPiA+
IHRvIHN1cHBvcnQgQ1BVIGhvdHBsdWcgc3RhdGUgYW5kIGV2ZW50cy4NCj4gPg0KPiA+IENvLWRl
dmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1i
eTogU2hhb3FpbiBIdWFuZyA8c2hhaHVhbmdAcmVkaGF0LmNvbT4NCg0KVGhhbmtzDQo=

