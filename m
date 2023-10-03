Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BF7B683F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 13:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qndqM-00068m-SW; Tue, 03 Oct 2023 07:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndpy-0005eS-Oc; Tue, 03 Oct 2023 07:45:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qndpw-0006Dw-QM; Tue, 03 Oct 2023 07:45:14 -0400
Received: from lhrpeml100002.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0GG53PW8z6K7jp;
 Tue,  3 Oct 2023 19:45:01 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 3 Oct 2023 12:45:10 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 3 Oct 2023 12:45:10 +0100
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
Subject: RE: [PATCH V2 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Topic: [PATCH V2 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Index: AQHZ8zQvM2IN4l39W0uWcRE2hMPQGbA3JTEAgADScvA=
Date: Tue, 3 Oct 2023 11:45:09 +0000
Message-ID: <2af8fbd7523a4545ab733895ac81454a@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-8-salil.mehta@huawei.com>
 <4134b7ab-7a76-77b9-e8c0-7e6d75e0ad50@redhat.com>
In-Reply-To: <4134b7ab-7a76-77b9-e8c0-7e6d75e0ad50@redhat.com>
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

PiBGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDMsIDIwMjMgMToxMiBBTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1
YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtDQo+IGFybUBub25nbnUub3Jn
DQo+IENjOiBtYXpAa2VybmVsLm9yZzsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOyBKb25hdGhh
biBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZzsNCj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgYW5kcmV3LmpvbmVzQGxpbnV4LmRl
djsgZGF2aWRAcmVkaGF0LmNvbTsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgb2xpdmVyLnVwdG9uQGxpbnV4LmRldjsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsg
bXN0QHJlZGhhdC5jb207IHdpbGxAa2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGFycmVuQG9z
LmFtcGVyZWNvbXB1dGluZy5jb207IGlsa2thQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+IHZp
c2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBrYXJsLmhldWJhdW1Ab3JhY2xlLmNvbTsNCj4g
bWlndWVsLmx1aXNAb3JhY2xlLmNvbTsgc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgemh1a2VxaWFu
DQo+IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nIChDKSA8d2FuZ3hpb25n
ZmVuZzJAaHVhd2VpLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5hbjU1QGh1YXdlaS5j
b20+OyBqaWFrZXJuZWwyQGdtYWlsLmNvbTsNCj4gbWFvYmlib0Bsb29uZ3Nvbi5jbjsgbGl4aWFu
Z2xhaUBsb29uZ3Nvbi5jbjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjIgMDcvMTBdIGh3L2FjcGk6IFVwZGF0ZSBBQ1BJIEdFRCBmcmFtZXdv
cmsgdG8gc3VwcG9ydA0KPiB2Q1BVIEhvdHBsdWcNCj4gDQo+IE9uIDkvMzAvMjMgMTA6MTksIFNh
bGlsIE1laHRhIHdyb3RlOg0KPiA+IEFDUEkgR0VEIHNoYWxsIGJlIHVzZWQgdG8gY29udmV5IHRv
IHRoZSBndWVzdCBrZXJuZWwgYWJvdXQgYW55IENQVSBob3QtDQo+ICh1bilwbHVnDQo+ID4gZXZl
bnRzLiBUaGVyZWZvcmUsIGV4aXN0aW5nIEFDUEkgR0VEIGZyYW1ld29yayBpbnNpZGUgUUVNVSBu
ZWVkcyB0byBiZQ0KPiBlbmhhbmNlZA0KPiA+IHRvIHN1cHBvcnQgQ1BVIGhvdHBsdWcgc3RhdGUg
YW5kIGV2ZW50cy4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogS2VxaWFuIFpodSA8emh1a2Vx
aWFuMUBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlh
bjFAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZp
Y2UuYyB8IDEwICsrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspDQo+ID4NCj4gDQo+IFJldmlld2VkLWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29t
Pg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg==

