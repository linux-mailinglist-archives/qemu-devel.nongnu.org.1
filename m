Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E02917B67EB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndbZ-0003cN-AT; Tue, 03 Oct 2023 07:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndbQ-0003Xb-Nj; Tue, 03 Oct 2023 07:30:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndbL-0003B4-D5; Tue, 03 Oct 2023 07:30:12 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0Fv11dDpz6K63Q;
 Tue,  3 Oct 2023 19:28:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:30:04 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:30:04 +0100
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
Subject: RE: [PATCH V2 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
Thread-Topic: [PATCH V2 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
Thread-Index: AQHZ8zQN9sMvHl8IPkGIhb6MBPCp2bA3GT4AgADaL0A=
Date: Tue, 3 Oct 2023 11:30:04 +0000
Message-ID: <07c35f510f1e484e9f600b4418cc49ee@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-5-salil.mehta@huawei.com>
 <2e4705a5-3c24-ae6a-e030-b3d5f4f2e37a@redhat.com>
In-Reply-To: <2e4705a5-3c24-ae6a-e030-b3d5f4f2e37a@redhat.com>
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
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDMsIDIwMjMgMTI6MjkgQU0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBo
dWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LQ0KPiBhcm1Abm9uZ251Lm9y
Zw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsgSm9uYXRo
YW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgbHBpZXJhbGlzaUBr
ZXJuZWwub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc7DQo+IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0BsaW51eC5k
ZXY7IGRhdmlkQHJlZGhhdC5jb207DQo+IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1Z2VyQHJl
ZGhhdC5jb207IG9saXZlci51cHRvbkBsaW51eC5kZXY7DQo+IHBib256aW5pQHJlZGhhdC5jb207
IG1zdEByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBsaW51eEBhcm1saW51eC5vcmcudWs7DQo+IGRhcnJlbkBv
cy5hbXBlcmVjb21wdXRpbmcuY29tOyBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiB2
aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsga2FybC5oZXViYXVtQG9yYWNsZS5jb207DQo+
IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7IHpodWtlcWlh
bg0KPiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykgPHdhbmd4aW9u
Z2ZlbmcyQGh1YXdlaS5jb20+Ow0KPiB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWku
Y29tPjsgamlha2VybmVsMkBnbWFpbC5jb207DQo+IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlh
bmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIFYyIDA0LzEwXSBody9hY3BpOiBJbml0IEdFRCBmcmFtZXdvcmsgd2l0
aCBjcHUgaG90cGx1Zw0KPiBldmVudHMNCj4gDQo+IE9uIDkvMzAvMjMgMTA6MTksIFNhbGlsIE1l
aHRhIHdyb3RlOg0KPiA+IEFDUEkgR0VEKGFzIGRlc2NyaWJlZCBpbiB0aGUgQUNQSSA2LjIgc3Bl
YykgY2FuIGJlIHVzZWQgdG8gZ2VuZXJhdGUgQUNQSQ0KPiBldmVudHMNCj4gPiB3aGVuIE9TUE0v
Z3Vlc3QgcmVjZWl2ZXMgYW4gaW50ZXJydXB0IGxpc3RlZCBpbiB0aGUgX0NSUyBvYmplY3Qgb2Yg
R0VELg0KPiBPU1BNDQo+ID4gdGhlbiBtYXBzIG9yIGRlbXVsdGlwbGV4ZXMgdGhlIGV2ZW50IGJ5
IGV2YWx1YXRpbmcgX0VWVCBtZXRob2QuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBhZGRzIHRoZSBz
dXBwb3J0IG9mIGNwdSBob3RwbHVnIGV2ZW50IGluaXRpYWxpemF0aW9uIGluIHRoZQ0KPiA+IGV4
aXN0aW5nIEdFRCBmcmFtZXdvcmsuDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBa
aHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZXFpYW4gWmh1
IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hY3BpL2dlbmVyaWNf
ZXZlbnRfZGV2aWNlLmMgICAgICAgICB8IDggKysrKysrKysNCj4gPiAgIGluY2x1ZGUvaHcvYWNw
aS9nZW5lcmljX2V2ZW50X2RldmljZS5oIHwgNSArKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gDQo+IFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIDxn
c2hhbkByZWRoYXQuY29tPg0KDQpUaGFua3MNClNhbGlsLg0KDQo=

