Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C67CA4E8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:12:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKXk-0006WZ-MX; Mon, 16 Oct 2023 06:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsKXH-00050d-3T; Mon, 16 Oct 2023 06:09:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsKXB-0007tb-Cc; Mon, 16 Oct 2023 06:09:17 -0400
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8CVw3jyxz6K8tb;
 Mon, 16 Oct 2023 18:08:40 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 11:09:08 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 16 Oct 2023 11:09:08 +0100
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
Thread-Index: AQHZ/cNQxAxt9PC9FEqdNAxyY88QobBH2dQAgARWpID///LWgIAAEfmw
Date: Mon, 16 Oct 2023 10:09:08 +0000
Message-ID: <5e838e6c4f454e08a0077c99262be846@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
 <187d0a24a81b4f1abbb23795325073ea@huawei.com>
 <D78AD548-0934-48E3-957A-E5123D9E7F4C@oracle.com>
In-Reply-To: <D78AD548-0934-48E3-957A-E5123D9E7F4C@oracle.com>
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

PiBGcm9tOiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDE2LCAyMDIzIDExOjAyIEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAaHVhd2VpLmNvbT4NCj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gPiBPbiAxNiBPY3QgMjAy
MywgYXQgMDk6NTIsIFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEhpIE1pZ3VlbCwNCj4gPg0KPiA+PiBGcm9tOiBNaWd1ZWwgTHVpcyA8bWlndWVs
Lmx1aXNAb3JhY2xlLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDEzLCAyMDIzIDU6
MzQgUE0NCj4gPj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KDQpb
Li4uXQ0KDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjYgMC85XSBBZGQgYXJjaGl0ZWN0dXJl
IGFnbm9zdGljIGNvZGUgdG8gc3VwcG9ydCB2Q1BVDQo+ID4+IEhvdHBsdWcNCj4gPj4NCj4gPj4g
SGkgU2FsaWwsDQo+ID4+DQo+ID4+PiBPbiAxMyBPY3QgMjAyMywgYXQgMTA6NTEsIFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+PiBWaXJ0dWFs
IENQVSBob3RwbHVnIHN1cHBvcnQgaXMgYmVpbmcgYWRkZWQgYWNyb3NzIHZhcmlvdXMNCj4gPj4g
YXJjaGl0ZWN0dXJlc1sxXVszXS4NCj4gPj4+IFRoaXMgc2VyaWVzIGFkZHMgdmFyaW91cyBjb2Rl
IGJpdHMgY29tbW9uIGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlczoNCj4gPg0KPiA+IFsuLi5dDQo+
ID4NCj4gPj4gSSB0ZXN0ZWQgaXQgZm9yIEFybTY0LCBtYWtlIGNoZWNrLCBib290L3JlYm9vdCwg
bGl2ZSBtaWdyYXRpb24gYW5kIGZvdW5kIG5vDQo+ID4+IGlzc3VlcywNCj4gPj4gc28gZm9yIHRo
aXMsIHBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkOg0KPiA+Pg0KPiA+PiBUZXN0ZWQtYnk6IE1pZ3Vl
bCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPiA+DQo+ID4gR3JlYXQuIE1hbnkgdGhh
bmtzIGZvciB0aGUgY29uZmlybWF0aW9uLg0KPiA+DQo+ID4gSSBndWVzcyB5b3UgYXJlIHJlcGVh
dGluZyB0aGUgc2FtZSBmb3IgeDg2IGFzIHdlbGw/DQo+ID4NCj4gDQo+IFlvdSBhcmUgd2VsY29t
ZSENCj4gDQo+IEFic29sdXRlbHksIEnigJltIHJlcGVhdGluZyB0aG9zZSBzYW1lIHRlc3RzIGZv
ciB4ODYuDQoNCkJyaWxsaWFudC4gVGhhbmtzIGZvciBwcm9hY3RpdmVseSB0YWtpbmcgdGhpcyB1
cC4NCg0KU2FsaWwuDQoNCg==

