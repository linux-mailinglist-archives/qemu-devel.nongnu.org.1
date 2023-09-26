Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7877AEAF2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5lq-0003Fz-Le; Tue, 26 Sep 2023 06:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5ld-0003B1-By
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:58:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5la-0005aK-J7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:58:13 -0400
Received: from dggpemm100023.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvxTY1vwWzVk76;
 Tue, 26 Sep 2023 18:54:57 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm100023.china.huawei.com (7.185.36.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 18:58:03 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 11:58:01 +0100
To: xianglai li <lixianglai@loongson.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao
 <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v3 7/7] Update the ACPI table for the Loongarch CPU
Thread-Topic: [PATCH v3 7/7] Update the ACPI table for the Loongarch CPU
Thread-Index: AQHZ8F9+ZTKBH1a/P0SqmSpslHNiurAs72zQ
Date: Tue, 26 Sep 2023 10:58:01 +0000
Message-ID: <fb85e363198c40e89583296f8ab0d9a5@huawei.com>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <eb15eaa49c27beb7918a0dbaf4ba53ad6f3cd805.1695697701.git.lixianglai@loongson.cn>
In-Reply-To: <eb15eaa49c27beb7918a0dbaf4ba53ad6f3cd805.1695697701.git.lixianglai@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=szxga02-in.huawei.com
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

SGkgWGlhbmdsYWksDQoNCj4gRnJvbTogeGlhbmdsYWkgbGkgPGxpeGlhbmdsYWlAbG9vbmdzb24u
Y24+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNiwgMjAyMyAxMDo1NSBBTQ0KPiBUbzog
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdt
YWlsLmNvbT47IFNhbGlsIE1laHRhDQo+IDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0PjsgU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBYaWFvanVhbg0KPiBZYW5nIDx5YW5neGlh
b2p1YW5AbG9vbmdzb24uY24+OyBTb25nIEdhbyA8Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1pY2hh
ZWwgUy4NCj4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPjsgQW5pIFNpbmhhDQo+IDxhbmlzaW5oYUByZWRoYXQuY29tPjsgUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gSGVuZGVyc29uIDxyaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+IDxlZHVhcmRvQGhh
Ymtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+
Ow0KPiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyB3YW5neWFu
YW4gKFkpDQo+IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT47IFBldGVyDQo+IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IERh
dmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPjsgQmlibyBNYW8NCj4gPG1hb2JpYm9A
bG9vbmdzb24uY24+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyA3LzddIFVwZGF0ZSB0aGUgQUNQSSB0
YWJsZSBmb3IgdGhlIExvb25nYXJjaCBDUFUNCj4gDQo+IEFkZCBuZXcgdHlwZXMgb2YgR0VEIGRl
dmljZXMgZm9yIExvb25nYXJjaCBtYWNoaW5lcywNCj4gYWRkIENQVSBob3QtKHVuKXBsdWcgZXZl
bnQgcmVzcG9uc2UgYW5kIGFkZHJlc3Mgc3BhY2VzLA0KPiBhbmQgdXBkYXRlIHRoZSBBQ1BJIHRh
YmxlLg0KPiANCj4gQ2M6ICJCZXJuaGFyZCBCZXNjaG93IiA8c2hlbnRleUBnbWFpbC5jb20+DQo+
IENjOiAiU2FsaWwgTWVodGEiIDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0Pg0KPiBDYzogIlNhbGls
IE1laHRhIiA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gQ2M6IFhpYW9qdWFuIFlhbmcgPHlh
bmd4aWFvanVhbkBsb29uZ3Nvbi5jbj4NCj4gQ2M6IFNvbmcgR2FvIDxnYW9zb25nQGxvb25nc29u
LmNuPg0KPiBDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPg0KPiBDYzog
SWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4NCj4gQ2M6IEFuaSBTaW5oYSA8YW5p
c2luaGFAcmVkaGF0LmNvbT4NCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+DQo+IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
Zz4NCj4gQ2M6IEVkdWFyZG8gSGFia29zdCA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD4NCj4gQ2M6IE1h
cmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPg0KPiBDYzogIlBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIiA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IENjOiBZYW5hbiBXYW5n
IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPg0KPiBDYzogIkRhbmllbCBQLiBCZXJyYW5nw6kiIDxi
ZXJyYW5nZUByZWRoYXQuY29tPg0KPiBDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0K
PiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IENjOiBCaWJvIE1h
byA8bWFvYmlib0Bsb29uZ3Nvbi5jbj4NCj4gU2lnbmVkLW9mZi1ieTogeGlhbmdsYWkgbGkgPGxp
eGlhbmdsYWlAbG9vbmdzb24uY24+DQo+IC0tLQ0KPiAgaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVn
LXN0dWIuYyB8ICA5ICsrKysrKysrKw0KPiAgaHcvbG9vbmdhcmNoL2FjcGktYnVpbGQuYyAgICAg
ICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaHcvbG9vbmdhcmNo
L3ZpcnQuYyAgICAgICAgICAgICB8ICAzICsrLQ0KPiAgaW5jbHVkZS9ody9sb29uZ2FyY2gvdmly
dC5oICAgICB8ICAxICsNCj4gIDQgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9hY3BpL2FjcGktY3B1LWhvdHBsdWct
c3R1Yi5jIGIvaHcvYWNwaS9hY3BpLWNwdS1ob3RwbHVnLQ0KPiBzdHViLmMNCj4gaW5kZXggMmFl
YzkwZDk2OC4uYjNhYzdhMWUzMSAxMDA2NDQNCj4gLS0tIGEvaHcvYWNwaS9hY3BpLWNwdS1ob3Rw
bHVnLXN0dWIuYw0KPiArKysgYi9ody9hY3BpL2FjcGktY3B1LWhvdHBsdWctc3R1Yi5jDQo+IEBA
IC0xOSw2ICsxOSwxNSBAQCB2b2lkIGxlZ2FjeV9hY3BpX2NwdV9ob3RwbHVnX2luaXQoTWVtb3J5
UmVnaW9uICpwYXJlbnQsDQo+IE9iamVjdCAqb3duZXIsDQo+ICAgICAgcmV0dXJuOw0KPiAgfQ0K
PiANCj4gK3ZvaWQgYnVpbGRfY3B1c19hbWwoQW1sICp0YWJsZSwgTWFjaGluZVN0YXRlICptYWNo
aW5lLCBDUFVIb3RwbHVnRmVhdHVyZXMNCj4gb3B0cywNCj4gKyAgICAgICAgICAgICAgICAgICAg
YnVpbGRfbWFkdF9jcHVfZm4gYnVpbGRfbWFkdF9jcHUsIGh3YWRkciBtbWFwX2lvX2Jhc2UsDQo+
ICsgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnJlc19yb290LA0KPiArICAgICAgICAg
ICAgICAgICAgICBjb25zdCBjaGFyICpldmVudF9oYW5kbGVyX21ldGhvZCwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgQW1sUmVnaW9uU3BhY2UgcnMpDQo+ICt7DQo+ICsgICAgcmV0dXJuOw0KPiAr
fQ0KPiArDQo+ICB2b2lkIGFjcGlfY3B1X29zcG1fc3RhdHVzKENQVUhvdHBsdWdTdGF0ZSAqY3B1
X3N0LCBBQ1BJT1NUSW5mb0xpc3QNCj4gKioqbGlzdCkNCj4gIHsNCj4gICAgICByZXR1cm47DQoN
Cg0KQWJvdmUgY2hhbmdlIGlzIGFscmVhZHkgcGFydCBvZiB0aGUgYXJjaGl0ZWN0dXJlIGFnbm9z
dGljIHBhdGNoLXNldC4NCk5vdCByZXF1aXJlZCBoZXJlIQ0KDQpUaGFua3MNClNhbGlsLg0K

