Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB37D668D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qva17-00073F-Ac; Wed, 25 Oct 2023 05:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qva0v-00072z-RX
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:17:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qva0f-0007mo-JP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:17:14 -0400
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SFjsq2q1Sz6K6Cr;
 Wed, 25 Oct 2023 17:14:07 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 10:16:51 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 25 Oct 2023 10:16:51 +0100
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@redhat.com>> David Hildenbrand" <david@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Topic: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Index: AQHaAdYd7aTyirD0h0OdEs9gK4EV+LBPnpeAgAAS2QCACNvyAIABtJPA
Date: Wed, 25 Oct 2023 09:16:51 +0000
Message-ID: <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org>	<cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
 <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.88]
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

SGkgSWdvciwNCg0KPiBGcm9tOiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPg0K
PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI0LCAyMDIzIDk6MDYgQU0NCj4gVG86IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0Pg0KPiANCj4gT24gV2VkLCAxOCBPY3QgMjAyMyAx
Nzo0ODozNiArMDEwMA0KPiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAb3Buc3JjLm5ldD4gd3Jv
dGU6DQo+IA0KPiA+IEhpIEFsZXgsDQo+ID4NCj4gPiBPbiAxOC8xMC8yMDIzIDE2OjQxLCBBbGV4
IEJlbm7DqWUgd3JvdGU6DQo+ID4gPg0KPiA+ID4gU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9w
bnNyYy5uZXQ+IHdyaXRlczoNCj4gPiA+DQo+ID4gPj4gSGVsbG8sDQo+ID4gPj4NCj4gPiA+PiBD
YW1lIGFjcm9zcyBiZWxvdyBjb2RlIGV4Y2VycHQgaW4geDg2L21pY3Jvdm0gY29kZSBhbmQgd2Fu
dGVkIHRvIGtub3cNCj4gPiA+PiB3aHkgJ2hhc19ob3RwbHVnZ2FibGVfY3B1cycgZmxhZyBoYXMg
YmVlbiBzZXQgdG8gJ2ZhbHNlJyB3aGlsZSB2YXJpb3VzDQo+ID4gPj4gaG90KHVuKXBsdWcgQVBJ
cyBoYXZlIGJlZW4gZGVmaW5lZD8NCj4gPiA+Pg0KPiA+ID4+IHN0YXRpYyB2b2lkIG1pY3Jvdm1f
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ID4gPj4gew0KPiA+ID4+
ICAgICAgWDg2TWFjaGluZUNsYXNzICp4ODZtYyA9IFg4Nl9NQUNISU5FX0NMQVNTKG9jKTsNCj4g
PiA+PiAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiA+PiAg
ICAgIEhvdHBsdWdIYW5kbGVyQ2xhc3MgKmhjID0gSE9UUExVR19IQU5ETEVSX0NMQVNTKG9jKTsN
Cj4gPiA+Pg0KPiA+ID4+ICAgICAgbWMtPmluaXQgPSBtaWNyb3ZtX21hY2hpbmVfc3RhdGVfaW5p
dDsNCj4gPiA+Pg0KPiA+ID4+ICAgICAgbWMtPmZhbWlseSA9ICJtaWNyb3ZtX2kzODYiOw0KPiA+
ID4+ICAgICAgWy4uLl0NCj4gPiA+PiAgICAgIG1jLT5tYXhfY3B1cyA9IDI4ODsNCj4gPiA+PiAg
ICAgIG1jLT5oYXNfaG90cGx1Z2dhYmxlX2NwdXMgPSBmYWxzZTsgIC0tLS0tLS0tPiBUaGlzIG9u
ZQ0KPiA+ID4+ICAgICAgWy4uLl0NCj4gPiA+DQo+ID4gPiAgRnJvbSB0aGUgb3JpZ2luYWwgY29t
bWl0IHRoYXQgYWRkZWQgaXQ6DQo+ID4gPg0KPiA+ID4gICAgSXQncyBhIG1pbmltYWxpc3QgbWFj
aGluZSB0eXBlIHdpdGhvdXQgUENJIG5vciBBQ1BJIHN1cHBvcnQsIGRlc2lnbmVkDQo+ID4gPiAg
ICBmb3Igc2hvcnQtbGl2ZWQgZ3Vlc3RzLiBtaWNyb3ZtIGFsc28gZXN0YWJsaXNoZXMgYSBiYXNl
bGluZSBmb3INCj4gPiA+ICAgIGJlbmNobWFya2luZyBhbmQgb3B0aW1pemluZyBib3RoIFFFTVUg
YW5kIGd1ZXN0IG9wZXJhdGluZyBzeXN0ZW1zLA0KPiA+ID4gICAgc2luY2UgaXQgaXMgb3B0aW1p
emVkIGZvciBib3RoIGJvb3QgdGltZSBhbmQgZm9vdHByaW50Lg0KPiA+DQo+ID4NCj4gPiBBZ3Jl
ZWQuIEl0IGxvb2tzIGxpa2UgQUNQSSBpcyBzdXBwb3J0ZWQgYnV0IG5laXRoZXIgQ1BVL01lbW9y
eSBIb3RwbHVnDQo+ID4gaXMgc3VwcG9ydGVkIGZvciB0aGlzIG1pbmltYWxpc3QgbWFjaGluZSB0
eXBlLg0KPiA+DQo+ID4NCj4gPiBzdGF0aWMgdm9pZCBtaWNyb3ZtX2RldmljZXNfaW5pdChNaWNy
b3ZtTWFjaGluZVN0YXRlICptbXMpDQo+ID4gew0KPiA+ICAgICAgY29uc3QgY2hhciAqZGVmYXVs
dF9maXJtd2FyZTsNCj4gPiAgICAgIFg4Nk1hY2hpbmVTdGF0ZSAqeDg2bXMgPSBYODZfTUFDSElO
RShtbXMpOw0KPiA+DQo+ID4gICAgIFsuLi5dDQo+ID4NCj4gPiAgICAgIC8qIE9wdGlvbmFsIGFu
ZCBsZWdhY3kgZGV2aWNlcyAqLw0KPiA+ICAgICAgaWYgKHg4Nl9tYWNoaW5lX2lzX2FjcGlfZW5h
YmxlZCh4ODZtcykpIHsNCj4gPiAgICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9uZXco
VFlQRV9BQ1BJX0dFRF9YODYpOw0KPiA+ICAgICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGRl
diwgImdlZC1ldmVudCIsIEFDUElfR0VEX1BXUl9ET1dOX0VWVCk7DQo+ID4gICAgICAgICAgc3lz
YnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNFKGRldiksIDAsIEdFRF9NTUlPX0JBU0UpOw0KPiA+
ICAgICAgIC8qIHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklDRShkZXYpLCAxLCBHRURfTU1J
T19CQVNFX01FTUhQKTsgKi8NCj4gPg0KPiA+ICAgICAgICAgIFsuLi5dDQo+ID4NCj4gPiAgICAg
ICAgICBzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRShkZXYpLCAmZXJyb3JfZmF0YWwpOw0K
PiA+ICAgICAgICAgIHg4Nm1zLT5hY3BpX2RldiA9IEhPVFBMVUdfSEFORExFUihkZXYpOw0KPiA+
ICAgICAgfQ0KPiA+ICAgICBbLi4uXQ0KPiA+IH0NCj4gPg0KPiA+ID4NCj4gPiA+IEdlbmVyYWxs
eSBob3RwbHVnIHJlcXVpcmVzIGEgZGFuY2UgYmV0d2VlbiB0aGUgVk1NIGFuZCB0aGUgZmlybXdh
cmUgdG8NCj4gPiA+IHByb3Blcmx5IHNodXRkb3duIGFuZCByZXN0YXJ0IGhvdHBsdWcgZGV2aWNl
cy4gVGhlIHByaW5jaXBsZQ0KPiA+ID4gY29tbXVuaWNhdGlvbiBtZWNoYW5pc20gZm9yIHRoaXMg
aXMgQUNQSS4NCj4gDQo+IGZpcm13YXJlIHBhcnQgaW4gY3B1L21lbSBob3B0bHVnIHVzdWFsbHkg
cHJvdmlkZWQgYnkgUUVNVSBieSB0aGUgd2F5IG9mDQo+IEFDUEkgdGFibGVzICh3aGljaCBtYXkg
Y29udGFpbiBBTUwgY29kZSB0aGF0IGhhbmRsZXMgZGFuY2Ugd2l0aCBRRU1VDQo+IHdoaWxlIGV4
cG9zaW5nIHN0YW5kYXJkIGludGVyZmFjZSB0byBndWVzdCBPUyB0byBoYW5kbGUgaG90cGx1ZykN
Cj4gDQo+ID4NCj4gPiBBZ3JlZWQuDQo+ID4NCj4gPiA+PiAgICAgIC8qIGhvdHBsdWcgKGZvciBj
cHUgY29sZHBsdWcpICovDQo+ID4gPj4gICAgICBtYy0+Z2V0X2hvdHBsdWdfaGFuZGxlciA9IG1p
Y3Jvdm1fZ2V0X2hvdHBsdWdfaGFuZGxlcjsNCj4gPiA+PiAgICAgIGhjLT5wcmVfcGx1ZyA9IG1p
Y3Jvdm1fZGV2aWNlX3ByZV9wbHVnX2NiOw0KPiA+ID4+ICAgICAgaGMtPnBsdWcgPSBtaWNyb3Zt
X2RldmljZV9wbHVnX2NiOw0KPiA+ID4+ICAgICAgaGMtPnVucGx1Z19yZXF1ZXN0ID0gbWljcm92
bV9kZXZpY2VfdW5wbHVnX3JlcXVlc3RfY2I7DQo+ID4gPj4gICAgICBoYy0+dW5wbHVnID0gbWlj
cm92bV9kZXZpY2VfdW5wbHVnX2NiOw0KPiA+DQo+ID4gc29ycnksIEkgYWxzbyBtaXNzZWQgdGhl
IGRlZmluaXRpb25zIG9mIHRoZSBsYXN0IDIgZnVuY3Rpb25zIHdoaWNoIHNheXMNCj4gPiB0aGF0
IHVucGx1ZyBpcyBub3Qgc3VwcG9ydGVkIHNvIHBlcmhhcHMgdGhlc2UgZnVuY3Rpb25zIGFyZSBv
bmx5DQo+ID4gcmVxdWlyZWQgdG8gc3VwcG9ydCBjb2xkIHBsdWdnaW5nIHdoaWNoIGNvcnJvYm9y
YXRlcyB3aXRoIHRoZSBjb21tZW50IGFzDQo+ID4gd2VsbC4NCj4gDQo+IHRoaXMgZnVuY3Rpb24g
YXJlIHVzdWFsbHkgdXNlZCBmb3IgYm90aCBjb2xkIGFuZCBob3RwbHVnIG9mIGJ1cy1sZXNzIGRl
dmljZXMuDQo+IFRoZXkgcHJvdmlkZSBhbiBvcHQtaW4gd2F5IGZvciBib2FyZCB0byB3aXJlIHVw
IHN1Y2ggZGV2aWNlcyAoaW5jbC4gQ1BVKS4NCg0KDQpTdXJlLiBJIHVuZGVyc3RhbmQgYnV0IG1p
Y3Jvdm0gZG9lcyBub3Qgc3VwcG9ydCBob3RwbHVnIHNvIHByZXNlbmNlIG9mDQp1bnBsdWd7X3Jl
cXVlc3R9IHZlcnNpb25zIGJyb3VnaHQgYSBkb3VidCBpbiBteSBtaW5kIGJ1dCBJIHJlYWxpemVk
IGxhdGVyDQp0aGF0IHRoZWlyIGRlZmluaXRpb25zIHdlcmUgZW1wdHkuIENvbGQtcGx1ZyBkb2Vz
IG5vdCByZXF1aXJlIHVucGx1Zw0KdmVyc2lvbnMuIA0KDQpXYXMgdGhlcmUgYW55IHBsYW4gdG8g
c3VwcG9ydCBob3QtcGx1ZyB3aXRoIG1pY3Jvdm0gaW4gZnV0dXJlPw0KDQoNClRoYW5rcw0KU2Fs
aWwuDQoNCg0KDQoNCg0K

