Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09D7B376A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 18:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmFvS-0008H7-T2; Fri, 29 Sep 2023 12:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qmFvG-00080S-2S; Fri, 29 Sep 2023 12:01:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qmFvD-0002oS-Bv; Fri, 29 Sep 2023 12:00:57 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rxw5T2jwjz67m28;
 Fri, 29 Sep 2023 23:59:25 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 29 Sep 2023 17:00:48 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Fri, 29 Sep 2023 17:00:48 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Subject: RE: [PATCH 8/9] physmem,gdbstub: Add helper functions to help
 *unrealize* vCPU object
Thread-Topic: [PATCH 8/9] physmem,gdbstub: Add helper functions to help
 *unrealize* vCPU object
Thread-Index: AQHZ8tMMOwkmxwsxs0Gb5rPc9gI8TLAxzbwAgAAoBzA=
Date: Fri, 29 Sep 2023 16:00:48 +0000
Message-ID: <3aede191f7a34a11afda348495580ed8@huawei.com>
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-9-salil.mehta@huawei.com> <87ttrdnj0t.fsf@linaro.org>
In-Reply-To: <87ttrdnj0t.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.153]
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

PiBGcm9tOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDI5LCAyMDIzIDM6MzUgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWFy
bUBub25nbnUub3JnOyBtYXpAa2VybmVsLm9yZzsgamVhbi0NCj4gcGhpbGlwcGVAbGluYXJvLm9y
ZzsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gbHBp
ZXJhbGlzaUBrZXJuZWwub3JnOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+IHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc7IGltYW1tZWRvQHJlZGhhdC5jb207IGFuZHJldy5qb25lc0Bs
aW51eC5kZXY7DQo+IGRhdmlkQHJlZGhhdC5jb207IHBoaWxtZEBsaW5hcm8ub3JnOyBlcmljLmF1
Z2VyQHJlZGhhdC5jb207DQo+IG9saXZlci51cHRvbkBsaW51eC5kZXY7IHBib256aW5pQHJlZGhh
dC5jb207IG1zdEByZWRoYXQuY29tOw0KPiB3aWxsQGtlcm5lbC5vcmc7IGdzaGFuQHJlZGhhdC5j
b207IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IGRhcnJlbkBv
cy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiBpbGtrYUBvcy5hbXBlcmVjb21wdXRpbmcuY29tOyB2
aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj4ga2FybC5oZXViYXVtQG9yYWNsZS5jb207
IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb207IHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ7DQo+IHpodWtl
cWlhbiA8emh1a2VxaWFuMUBodWF3ZWkuY29tPjsgd2FuZ3hpb25nZmVuZyAoQykNCj4gPHdhbmd4
aW9uZ2ZlbmcyQGh1YXdlaS5jb20+OyB3YW5neWFuYW4gKFkpIDx3YW5neWFuYW41NUBodWF3ZWku
Y29tPjsNCj4gamlha2VybmVsMkBnbWFpbC5jb207IG1hb2JpYm9AbG9vbmdzb24uY247IGxpeGlh
bmdsYWlAbG9vbmdzb24uY247IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDgvOV0gcGh5c21lbSxnZGJzdHViOiBBZGQgaGVscGVyIGZ1bmN0
aW9ucyB0byBoZWxwDQo+ICp1bnJlYWxpemUqIHZDUFUgb2JqZWN0DQo+IA0KPiANCj4gU2FsaWwg
TWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyaXRlczoNCj4gDQo+ID4gdkNQVSBIb3Qt
dW5wbHVnIHJlcXVpcmVzIHNvbWUgaGVscGVyIGZ1bmN0aW9ucyB0byB1bnJvbGwgd2hhdCBoYXMg
aGFwcGVuZWQNCj4gPiBkdXJpbmcgcmVhbGl6YXRpb24gb2YgYSBDUFUgb2JqZWN0Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+
ID4gLS0tDQo+ID4gIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgfCAxMyArKysrKysrKysrKysr
DQo+ID4gIGluY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmggfCAgOCArKysrKysrKw0KPiA+ICBpbmNs
dWRlL2V4ZWMvZ2Ric3R1Yi5oICAgIHwgIDEgKw0KPiA+ICBpbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
ICAgIHwgIDEgKw0KPiA+ICBzb2Z0bW11L3BoeXNtZW0uYyAgICAgICAgIHwgMjUgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9nZGJzdHViL2dkYnN0dWIuYyBiL2dkYnN0dWIvZ2Ric3R1
Yi5jDQo+ID4gaW5kZXggMzQ5ZDM0OGM3Yi4uYTA2ZWEzYWRhZCAxMDA2NDQNCj4gPiAtLS0gYS9n
ZGJzdHViL2dkYnN0dWIuYw0KPiA+ICsrKyBiL2dkYnN0dWIvZ2Ric3R1Yi5jDQo+ID4gQEAgLTQ5
MSw2ICs0OTEsMTkgQEAgdm9pZCBnZGJfcmVnaXN0ZXJfY29wcm9jZXNzb3IoQ1BVU3RhdGUgKmNw
dSwNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gK3ZvaWQgZ2RiX3VucmVnaXN0ZXJfY29w
cm9jZXNzb3JfYWxsKENQVVN0YXRlICpjcHUpDQo+ID4gK3sNCj4gPiArICAgIEdEQlJlZ2lzdGVy
U3RhdGUgKnMsICpwOw0KPiA+ICsNCj4gPiArICAgIHAgPSBjcHUtPmdkYl9yZWdzOw0KPiA+ICsg
ICAgd2hpbGUgKHApIHsNCj4gPiArICAgICAgICBzID0gcDsNCj4gPiArICAgICAgICBwID0gcC0+
bmV4dDsNCj4gDQo+IE1heWJlIGFkZDoNCj4gDQo+ICAgICAgIC8qIHMtPnhtbCBpcyBzdGF0aWMg
Y29uc3QgY2hhciBzbyBpc24ndCBmcmVlZCAqLw0KDQoNClN1cmUuDQoNCj4gPiArICAgICAgICBn
X2ZyZWUocyk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICBjcHUtPmdkYl9yZWdzID0gTlVMTDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgZ2RiX3Byb2Nlc3NfYnJlYWtwb2ludF9yZW1v
dmVfYWxsKEdEQlByb2Nlc3MgKnApDQo+ID4gIHsNCj4gPiAgICAgIENQVVN0YXRlICpjcHUgPSBn
ZGJfZ2V0X2ZpcnN0X2NwdV9pbl9wcm9jZXNzKHApOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2V4ZWMvY3B1LWNvbW1vbi5oIGIvaW5jbHVkZS9leGVjL2NwdS1jb21tb24uaA0KPiA+IGluZGV4
IDQxNzg4YzBiZGQuLmViNTZhMjI4YTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9leGVjL2Nw
dS1jb21tb24uaA0KPiA+ICsrKyBiL2luY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmgNCj4gPiBAQCAt
MTIwLDYgKzEyMCwxNCBAQCBzaXplX3QgcWVtdV9yYW1fcGFnZXNpemVfbGFyZ2VzdCh2b2lkKTsN
Cj4gPiAgICovDQo+ID4gIHZvaWQgY3B1X2FkZHJlc3Nfc3BhY2VfaW5pdChDUFVTdGF0ZSAqY3B1
LCBpbnQgYXNpZHgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFy
ICpwcmVmaXgsIE1lbW9yeVJlZ2lvbiAqbXIpOw0KPiA+ICsvKioNCj4gPiArICogY3B1X2FkZHJl
c3Nfc3BhY2VfZGVzdHJveToNCj4gPiArICogQGNwdTogQ1BVIGZvciB3aGljaCBhZGRyZXNzIHNw
YWNlIG5lZWRzIHRvIGJlIGRlc3Ryb3llZA0KPiA+ICsgKiBAYXNpZHg6IGludGVnZXIgaW5kZXgg
b2YgdGhpcyBhZGRyZXNzIHNwYWNlDQo+ID4gKyAqDQo+ID4gKyAqIE5vdGUgdGhhdCB3aXRoIEtW
TSBvbmx5IG9uZSBhZGRyZXNzIHNwYWNlIGlzIHN1cHBvcnRlZC4NCj4gPiArICovDQo+ID4gK3Zv
aWQgY3B1X2FkZHJlc3Nfc3BhY2VfZGVzdHJveShDUFVTdGF0ZSAqY3B1LCBpbnQgYXNpZHgpOw0K
PiA+DQo+ID4gIHZvaWQgY3B1X3BoeXNpY2FsX21lbW9yeV9ydyhod2FkZHIgYWRkciwgdm9pZCAq
YnVmLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGxlbiwgYm9vbCBp
c193cml0ZSk7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9nZGJzdHViLmggYi9pbmNs
dWRlL2V4ZWMvZ2Ric3R1Yi5oDQo+ID4gaW5kZXggMTZhMTM5MDQzZi4uOTg2ZDhkMmZhNSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2V4ZWMvZ2Ric3R1Yi5oDQo+ID4gKysrIGIvaW5jbHVkZS9l
eGVjL2dkYnN0dWIuaA0KPiA+IEBAIC0yNyw2ICsyNyw3IEBAIHR5cGVkZWYgaW50ICgqZ2RiX3Nl
dF9yZWdfY2IpKENQVUFyY2hTdGF0ZSAqZW52LCB1aW50OF90ICpidWYsIGludCByZWcpOw0KPiA+
ICB2b2lkIGdkYl9yZWdpc3Rlcl9jb3Byb2Nlc3NvcihDUFVTdGF0ZSAqY3B1LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnZGJfZ2V0X3JlZ19jYiBnZXRfcmVnLCBnZGJfc2V0
X3JlZ19jYiBzZXRfcmVnLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
bnVtX3JlZ3MsIGNvbnN0IGNoYXIgKnhtbCwgaW50IA0KPiA+ICBnX3Bvcyk7DQo+IA0KPiBDYW4g
d2UgaGF2ZSBhIGtkb2MgY29tbWVudCBoZXJlIGRlc2NyaWJpbmcgdGhlIGZ1bmN0aW9uLg0KDQpP
ay4NCg0KPiANCj4gSSBzdXNwZWN0IHRoaXMgc2hvdWxkIGJlIHNwbGl0IGludG8gdHdvIHBhdGNo
ZXMsIG9uZSBmb3IgZ2Ric3R1YiBhbmQgb25lDQo+IGZvciBwaHlzbWVtLg0KDQoNCk5vIGlzc3Vl
cy4gQ2FuIGRvIHRoYXQuDQoNCg0KPiA+ICt2b2lkIGdkYl91bnJlZ2lzdGVyX2NvcHJvY2Vzc29y
X2FsbChDUFVTdGF0ZSAqY3B1KTsNCj4gPg0KPiA+ICAvKioNCj4gPiAgICogZ2Ric2VydmVyX3N0
YXJ0OiBzdGFydCB0aGUgZ2RiIHNlcnZlcg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2Nv
cmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gPiBpbmRleCA2NDhiNWIzNTg2Li42
NWQyYWU0NTgxIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiA+IEBAIC0zNTUsNiArMzU1LDcgQEAgc3RydWN0
IENQVVN0YXRlIHsNCj4gPiAgICAgIFFTSU1QTEVRX0hFQUQoLCBxZW11X3dvcmtfaXRlbSkgd29y
a19saXN0Ow0KPiA+DQo+ID4gICAgICBDUFVBZGRyZXNzU3BhY2UgKmNwdV9hc2VzOw0KPiA+ICsg
ICAgaW50IGNwdV9hc2VzX2NvdW50Ow0KPiA+ICAgICAgaW50IG51bV9hc2VzOw0KPiA+ICAgICAg
QWRkcmVzc1NwYWNlICphczsNCj4gPiAgICAgIE1lbW9yeVJlZ2lvbiAqbWVtb3J5Ow0KPiA+IGRp
ZmYgLS1naXQgYS9zb2Z0bW11L3BoeXNtZW0uYyBiL3NvZnRtbXUvcGh5c21lbS5jDQo+ID4gaW5k
ZXggNGY2Y2E2NTNiMy4uNGRmYTBjYTY2ZiAxMDA2NDQNCj4gPiAtLS0gYS9zb2Z0bW11L3BoeXNt
ZW0uYw0KPiA+ICsrKyBiL3NvZnRtbXUvcGh5c21lbS5jDQo+ID4gQEAgLTc2MSw2ICs3NjEsNyBA
QCB2b2lkIGNwdV9hZGRyZXNzX3NwYWNlX2luaXQoQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4LA0K
PiA+DQo+ID4gICAgICBpZiAoIWNwdS0+Y3B1X2FzZXMpIHsNCj4gPiAgICAgICAgICBjcHUtPmNw
dV9hc2VzID0gZ19uZXcwKENQVUFkZHJlc3NTcGFjZSwgY3B1LT5udW1fYXNlcyk7DQo+ID4gKyAg
ICAgICAgY3B1LT5jcHVfYXNlc19jb3VudCA9IGNwdS0+bnVtX2FzZXM7DQo+ID4gICAgICB9DQo+
ID4NCj4gPiAgICAgIG5ld2FzID0gJmNwdS0+Y3B1X2FzZXNbYXNpZHhdOw0KPiA+IEBAIC03NzQs
NiArNzc1LDMwIEBAIHZvaWQgY3B1X2FkZHJlc3Nfc3BhY2VfaW5pdChDUFVTdGF0ZSAqY3B1LCBp
bnQNCj4gYXNpZHgsDQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIGNwdV9hZGRy
ZXNzX3NwYWNlX2Rlc3Ryb3koQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4KQ0KPiA+ICt7DQo+ID4g
KyAgICBDUFVBZGRyZXNzU3BhY2UgKmNwdWFzOw0KPiA+ICsNCj4gPiArICAgIGFzc2VydChhc2lk
eCA8IGNwdS0+bnVtX2FzZXMpOw0KPiA+ICsgICAgYXNzZXJ0KGFzaWR4ID09IDAgfHwgIWt2bV9l
bmFibGVkKCkpOw0KPiA+ICsgICAgYXNzZXJ0KGNwdS0+Y3B1X2FzZXMpOw0KPiA+ICsNCj4gPiAr
ICAgIGNwdWFzID0gJmNwdS0+Y3B1X2FzZXNbYXNpZHhdOw0KPiA+ICsgICAgaWYgKHRjZ19lbmFi
bGVkKCkpIHsNCj4gPiArICAgICAgICBtZW1vcnlfbGlzdGVuZXJfdW5yZWdpc3RlcigmY3B1YXMt
PnRjZ19hc19saXN0ZW5lcik7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgYWRkcmVzc19z
cGFjZV9kZXN0cm95KGNwdWFzLT5hcyk7DQo+ID4gKyAgICBnX2ZyZWVfcmN1KGNwdWFzLT5hcywg
cmN1KTsNCj4gPiArDQo+ID4gKyAgICBpZiAoY3B1LT5jcHVfYXNlc19jb3VudCA9PSAxKSB7DQo+
ID4gKyAgICAgICAgZ19mcmVlKGNwdS0+Y3B1X2FzZXMpOw0KPiA+ICsgICAgICAgIGNwdS0+Y3B1
X2FzZXMgPSBOVUxMOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGNwdS0+Y3B1X2FzZXNf
Y291bnQtLTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgQWRkcmVzc1NwYWNlICpjcHVfZ2V0X2FkZHJl
c3Nfc3BhY2UoQ1BVU3RhdGUgKmNwdSwgaW50IGFzaWR4KQ0KPiA+ICB7DQo+ID4gICAgICAvKiBS
ZXR1cm4gdGhlIEFkZHJlc3NTcGFjZSBjb3JyZXNwb25kaW5nIHRvIHRoZSBzcGVjaWZpZWQgaW5k
ZXggKi8NCj4gDQo+IA0KPiAtLQ0KPiBBbGV4IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVj
aCBMZWFkIEAgTGluYXJvDQoNCg==

