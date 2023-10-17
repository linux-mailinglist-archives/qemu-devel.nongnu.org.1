Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F37CB74C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 02:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsXiP-0005T6-6s; Mon, 16 Oct 2023 20:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXiM-0005Rq-8r; Mon, 16 Oct 2023 20:13:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qsXiI-0003wG-T1; Mon, 16 Oct 2023 20:13:38 -0400
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8ZF56zR0z67bhG;
 Tue, 17 Oct 2023 08:12:57 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 01:13:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 17 Oct 2023 01:13:26 +0100
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
Subject: RE: [PATCH RFC V2 35/37] hw/arm: Support hotplug capability check
 using _OSC method
Thread-Topic: [PATCH RFC V2 35/37] hw/arm: Support hotplug capability check
 using _OSC method
Thread-Index: AQHZ8GWWD9qAgswRkUi3UDlvJ7X5crAxJ8yAgBwSPrA=
Date: Tue, 17 Oct 2023 00:13:26 +0000
Message-ID: <c2d8a144e9e5409d97ae2c72272ea5b7@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
 <20230926103654.34424-4-salil.mehta@huawei.com>
 <ddbc526e-bba3-6b93-753f-6ba3de183755@redhat.com>
In-Reply-To: <ddbc526e-bba3-6b93-753f-6ba3de183755@redhat.com>
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjMgNToyMyBBTQ0KPiBUbzogU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtYXJt
QG5vbmdudS5vcmcNCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5v
cmc7IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyByaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBpbWFtbWVkb0ByZWRoYXQuY29tOyBhbmRyZXcuam9u
ZXNAbGludXguZGV2OyBkYXZpZEByZWRoYXQuY29tOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgZXJp
Yy5hdWdlckByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGFyZGJAa2VybmVsLm9yZzsNCj4g
b2xpdmVyLnVwdG9uQGxpbnV4LmRldjsgcGJvbnppbmlAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5j
b207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBib3JudHJhZWdlckBsaW51eC5pYm0uY29tOyBhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhcnJlbkBvcy5h
bXBlcmVjb21wdXRpbmcuY29tOw0KPiBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyB2aXNo
bnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4ga2FybC5oZXViYXVtQG9yYWNsZS5jb207IG1p
Z3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7DQo+IHpodWtlcWlh
biA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4aW9u
Z2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWkuY29t
PjsNCj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlhbmds
YWlAbG9vbmdzb24uY24NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgVjIgMzUvMzddIGh3L2Fy
bTogU3VwcG9ydCBob3RwbHVnIGNhcGFiaWxpdHkgY2hlY2sNCj4gdXNpbmcgX09TQyBtZXRob2QN
Cj4gDQo+IEhpIFNhbGlsLA0KPiANCj4gT24gOS8yNi8yMyAyMDozNiwgU2FsaWwgTWVodGEgd3Jv
dGU6DQo+ID4gUGh5c2ljYWwgQ1BVIGhvdHBsdWcgcmVzdWx0cyBpbiAodW4pc2V0dGluZyBvZiBB
Q1BJIF9TVEEuUHJlc2VudCBiaXQuIEFBUkNINjQNCj4gPiBwbGF0Zm9ybXMgZG8gbm90IHN1cHBv
cnQgcGh5c2ljYWwgQ1BVIGhvdHBsdWcuIFZpcnR1YWwgQ1BVIEhvdHBsdWcgc3VwcG9ydCBiZWlu
Zw0KPiA+IGltcGxlbWVudGVkIHRvZ2dsZXMgQUNQSSBfU1RBLkVuYWJsZWQgQml0IHRvIGFjaGll
dmUgSG90cGx1ZyBmdW5jdGlvbmFsaXR5LiBUaGlzDQo+ID4gaXMgbm90IHNhbWUgYXMgcGh5c2lj
YWwgQ1BVIGhvdHBsdWcgc3VwcG9ydC4NCj4gPg0KPiA+IEluIGZ1dHVyZSwgaWYgQVJNIGFyY2hp
dGVjdHVyZSBzdXBwb3J0cyBwaHlzaWNhbCBDUFUgaG90cGx1ZyB0aGVuIHRoZSBjdXJyZW50DQo+
ID4gZGVzaWduIG9mIHZpcnR1YWwgQ1BVIGhvdHBsdWcgY2FuIGJlIHVzZWQgdW5jaGFuZ2VkLiBI
ZW5jZSwgdGhlcmUgaXMgYSBuZWVkIGZvcg0KPiA+IGZpcm13YXJlL1ZNTS9RZW11IHRvIHN1cHBv
cnQgZXZhbHVhdGlvbiBvZiBwbGF0Zm9ybSB3aWRlIGNhcGFiaWxpdGl5IHJlbGF0ZWQgdG8NCj4g
PiB0aGUgKnR5cGUqIG9mIENQVSBob3RwbHVnIHN1cHBvcnQgcHJlc2VudCBvbiB0aGUgcGxhdGZv
cm0uIE9TUE0gbWlnaHQgbmVlZCB0aGlzDQo+ID4gZHVyaW5nIGJvb3QgdGltZSB0byBjb3JyZWN0
bHkgaW5pdGlhbGl6ZSB0aGUgQ1BVcyBhbmQgb3RoZXIgcmVsYXRlZCBjb21wb25lbnRzDQo+ID4g
aW4gdGhlIGtlcm5lbC4NCj4gPg0KPiA+IE5PVEU6IFRoaXMgaW1wbGVtZW50YXRpb24gd2lsbCBi
ZSBpbXByb3ZlZCB0byBhZGQgdGhlIHN1cHBvcnQgb2YgKnF1ZXJ5KiBpbiB0aGUNCj4gPiBzdWJz
ZXF1ZW50IHZlcnNpb25zLiBUaGlzIGlzIHZlcnkgbWluaW1hbCBzdXBwb3J0IHRvIGFzc2lzdCBr
ZXJuZWwuDQo+ID4NCj4gPiBBU0wgZm9yIHRoZSBpbXBsZW1lbnRlZCBfT1NDIG1ldGhvZDoNCj4g
Pg0KPiA+IE1ldGhvZCAoX09TQywgNCwgTm90U2VyaWFsaXplZCkgIC8vIF9PU0M6IE9wZXJhdGlu
ZyBTeXN0ZW0gQ2FwYWJpbGl0aWVzDQo+ID4gew0KPiA+ICAgICAgQ3JlYXRlRFdvcmRGaWVsZCAo
QXJnMywgWmVybywgQ0RXMSkNCj4gPiAgICAgIElmICgoQXJnMCA9PSBUb1VVSUQgKCIwODExYjA2
ZS00YTI3LTQ0ZjktOGQ2MC0zY2JiYzIyZTdiNDgiKSAvKiBQbGF0Zm9ybS13aWRlIENhcGFiaWxp
dGllcyAqLykpDQo+ID4gICAgICB7DQo+ID4gICAgICAgICAgQ3JlYXRlRFdvcmRGaWVsZCAoQXJn
MywgMHgwNCwgQ0RXMikNCj4gPiAgICAgICAgICBMb2NhbDAgPSBDRFcyIC8qIFxfU0JfLl9PU0Mu
Q0RXMiAqLw0KPiA+ICAgICAgICAgIElmICgoQXJnMSAhPSBPbmUpKQ0KPiA+ICAgICAgICAgIHsN
Cj4gPiAgICAgICAgICAgICAgQ0RXMSB8PSAweDA4DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICAgTG9jYWwwICY9IDB4MDA4MDAwMDANCj4gPiAgICAgICAgICBJZiAoKENEVzIgIT0g
TG9jYWwwKSkNCj4gPiAgICAgICAgICB7DQo+ID4gICAgICAgICAgICAgIENEVzEgfD0gMHgxMA0K
PiA+ICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgIENEVzIgPSBMb2NhbDANCj4gPiAgICAg
IH0NCj4gPiAgICAgIEVsc2UNCj4gPiAgICAgIHsNCj4gPiAgICAgICAgICBDRFcxIHw9IDB4MDQN
Cj4gPiAgICAgIH0NCj4gPg0KPiA+ICAgICAgUmV0dXJuIChBcmczKQ0KPiA+IH0NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jIHwgNTIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMg
Yi9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMNCj4gPiBpbmRleCBjYmNjZDJjYTJkLi4zNzc0NTBk
ZDE2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYw0KPiA+ICsrKyBi
L2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYw0KPiA+IEBAIC04NjEsNiArODYxLDU1IEBAIHN0YXRp
YyB2b2lkIGJ1aWxkX2ZhZHRfcmV2NihHQXJyYXkgKnRhYmxlX2RhdGEsIEJJT1NMaW5rZXIgKmxp
bmtlciwNCj4gPiAgICAgICBidWlsZF9mYWR0KHRhYmxlX2RhdGEsIGxpbmtlciwgJmZhZHQsIHZt
cy0+b2VtX2lkLCB2bXMtDQo+ID5vZW1fdGFibGVfaWQpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyB2b2lkIGJ1aWxkX3ZpcnRfb3NjX21ldGhvZChBbWwgKnNjb3BlLCBWaXJ0TWFjaGluZVN0
YXRlICp2bXMpDQo+ID4gK3sNCj4gPiArICAgIEFtbCAqaWZfdXVpZCwgKmVsc2VfdXVpZCwgKmlm
X3JldiwgKmlmX2NhcHNfbWFza2VkLCAqbWV0aG9kOw0KPiA+ICsgICAgQW1sICphX2NkdzEgPSBh
bWxfbmFtZSgiQ0RXMSIpOw0KPiA+ICsgICAgQW1sICphX2NkdzIgPSBhbWxfbG9jYWwoMCk7DQo+
ID4gKw0KPiA+ICsgICAgbWV0aG9kID0gYW1sX21ldGhvZCgiX09TQyIsIDQsIEFNTF9OT1RTRVJJ
QUxJWkVEKTsNCj4gPiArICAgIGFtbF9hcHBlbmQobWV0aG9kLCBhbWxfY3JlYXRlX2R3b3JkX2Zp
ZWxkKGFtbF9hcmcoMyksIGFtbF9pbnQoMCksICJDRFcxIikpOw0KPiA+ICsNCj4gPiArICAgIC8q
IG1hdGNoIFVVSUQgKi8NCj4gPiArICAgIGlmX3V1aWQgPSBhbWxfaWYoYW1sX2VxdWFsKA0KPiA+
ICsgICAgICAgIGFtbF9hcmcoMCksIGFtbF90b3V1aWQoIjA4MTFCMDZFLTRBMjctNDRGOS04RDYw
LTNDQkJDMjJFN0I0OCIpKSk7DQo+ID4gKw0KPiA+ICsgICAgYW1sX2FwcGVuZChpZl91dWlkLCBh
bWxfY3JlYXRlX2R3b3JkX2ZpZWxkKGFtbF9hcmcoMyksIGFtbF9pbnQoNCksICJDRFcyIikpOw0K
PiA+ICsgICAgYW1sX2FwcGVuZChpZl91dWlkLCBhbWxfc3RvcmUoYW1sX25hbWUoIkNEVzIiKSwg
YV9jZHcyKSk7DQo+ID4gKw0KPiA+ICsgICAgLyogY2hlY2sgdW5rbm93biByZXZpc2lvbiBpbiBh
cmcoMSkgKi8NCj4gPiArICAgIGlmX3JldiA9IGFtbF9pZihhbWxfbG5vdChhbWxfZXF1YWwoYW1s
X2FyZygxKSwgYW1sX2ludCgxKSkpKTsNCj4gPiArICAgIC8qIHNldCByZXZpc2lvbiBlcnJvciBi
aXRzLCAgRFdPUkQxIEJpdFszXSAqLw0KPiA+ICsgICAgYW1sX2FwcGVuZChpZl9yZXYsIGFtbF9v
cihhX2NkdzEsIGFtbF9pbnQoMHgwOCksIGFfY2R3MSkpOw0KPiA+ICsgICAgYW1sX2FwcGVuZChp
Zl91dWlkLCBpZl9yZXYpOw0KPiA+ICsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBjaGVjayBz
dXBwb3J0IGZvciB2Q1BVIGhvdHBsdWcgdHlwZSg9ZW5hYmxlZCkgcGxhdGZvcm0td2lkZSBjYXBh
YmlsaXR5DQo+ID4gKyAgICAgKiBpbiBEV09SRDIgYXMgc2VwY2lmaWVkIGluIHRoZSBiZWxvdyBB
Q1BJIFNwZWNpZmljYXRpb24gRUNSLA0KPiA+ICsgICAgICogICMgaHR0cHM6Ly9idWd6aWxsYS50
aWFub2NvcmUub3JnL3Nob3dfYnVnLmNnaT9pZD00NDgxDQo+ID4gKyAgICAgKi8NCj4gPiArICAg
IGlmICh2bXMtPmFjcGlfZGV2KSB7DQo+ID4gKyAgICAgICAgYW1sX2FwcGVuZChpZl91dWlkLCBh
bWxfYW5kKGFfY2R3MiwgYW1sX2ludCgweDgwMDAwMCksIGFfY2R3MikpOw0KPiA+ICsgICAgICAg
IC8qIGNoZWNrIGlmIE9TUE0gc3BlY2lmaWVkIGhvdHBsdWcgY2FwYWJpbGl0eSBiaXRzIHdlcmUg
bWFza2VkICovDQo+ID4gKyAgICAgICAgaWZfY2Fwc19tYXNrZWQgPSBhbWxfaWYoYW1sX2xub3Qo
YW1sX2VxdWFsKGFtbF9uYW1lKCJDRFcyIiksIGFfY2R3MikpKTsNCj4gPiArICAgICAgICBhbWxf
YXBwZW5kKGlmX2NhcHNfbWFza2VkLCBhbWxfb3IoYV9jZHcxLCBhbWxfaW50KDB4MTApLCBhX2Nk
dzEpKTsNCj4gPiArICAgICAgICBhbWxfYXBwZW5kKGlmX3V1aWQsIGlmX2NhcHNfbWFza2VkKTsN
Cj4gPiArICAgIH0NCj4gPiArICAgIGFtbF9hcHBlbmQoaWZfdXVpZCwgYW1sX3N0b3JlKGFfY2R3
MiwgYW1sX25hbWUoIkNEVzIiKSkpOw0KPiA+ICsNCj4gPiArICAgIGFtbF9hcHBlbmQobWV0aG9k
LCBpZl91dWlkKTsNCj4gPiArICAgIGVsc2VfdXVpZCA9IGFtbF9lbHNlKCk7DQo+ID4gKw0KPiA+
ICsgICAgLyogc2V0IHVucmVjb2duaXplZCBVVUlEIGVycm9yIGJpdHMsIERXT1JEMSBCaXRbMl0g
Ki8NCj4gPiArICAgIGFtbF9hcHBlbmQoZWxzZV91dWlkLCBhbWxfb3IoYV9jZHcxLCBhbWxfaW50
KDQpLCBhX2NkdzEpKTsNCj4gPiArICAgIGFtbF9hcHBlbmQobWV0aG9kLCBlbHNlX3V1aWQpOw0K
PiA+ICsNCj4gPiArICAgIGFtbF9hcHBlbmQobWV0aG9kLCBhbWxfcmV0dXJuKGFtbF9hcmcoMykp
KTsNCj4gPiArICAgIGFtbF9hcHBlbmQoc2NvcGUsIG1ldGhvZCk7DQo+ID4gKw0KPiA+ICsgICAg
cmV0dXJuOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gVGhlIGNoZWNrIG9uIHZtcy0+YWNwaV9kZXYg
c2VlbXMgbm90IGVub3VnaC4gV2UgbWF5IHN0aWxsIG5lZWQgdG8gY2hlY2sNCj4gbWMtPmhhc19o
b3RwbHVnZ2FibGVfY3B1cyBhbmQgdm1zLT5naWNfdmVyc2lvbiBldGMuIEJlc2lkZXMsIHRoZSAi
cmV0dXJuIg0KPiBhdCBlbmQgb2YgdGhlIGZ1bmN0aW9uIGlzbid0IG5lZWRlZC4NCg0KQWdyZWVk
LiBXZSBqdXN0IG5lZWQgdG8gY2hlY2sgJ21jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMnLiBJdCB3
aWxsIGNvdmVyDQpldmVyeXRoaW5nLg0KDQpBIGxlZ2FjeSBjb3B5IGFuZCBwYXN0ZSBtaXN0YWtl
IGV2ZXJ5d2hlcmUuIFRoYW5rcyBmb3IgcG9pbnRpbmcuDQoNCkNoZWVycw0KU2FsaWwuDQoNCg==

