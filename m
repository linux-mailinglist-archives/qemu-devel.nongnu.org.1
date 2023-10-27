Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652F7D9504
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJsd-0007yu-71; Fri, 27 Oct 2023 06:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qwJsY-0007yR-4h
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:15:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qwJsU-0005Wd-IW
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:15:45 -0400
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SGz6n0vVmz6K918;
 Fri, 27 Oct 2023 18:14:41 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 11:15:25 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Fri, 27 Oct 2023 11:15:25 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Topic: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Index: AQHaAdYd7aTyirD0h0OdEs9gK4EV+LBPnpeAgAAS2QCACNvyAIABtJPA///1ywCAABS9gIABqZiAgAF9UHA=
Date: Fri, 27 Oct 2023 10:15:25 +0000
Message-ID: <608f895b8c2b446c97997c57d79c6b39@huawei.com>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org>	<cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
 <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
 <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
 <1055386d-2706-4ce2-b190-106510bee52c@redhat.com>
 <1358aadeade14623a90284d188fbce31@huawei.com>
 <20231026140925.541e2b45@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231026140925.541e2b45@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.245]
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

DQo+IEZyb206IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBPY3RvYmVyIDI2LCAyMDIzIDE6MDkgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiANCj4gT24gV2VkLCAyNSBPY3QgMjAyMyAwOTo1NDowNyAr
MDAwMA0KPiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0K
PiA+ID4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjUsIDIwMjMgMTA6MzIgQU0NCj4gPiA+IFRvOiBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IElnb3IgTWFtbWVkb3YNCj4gPiA+IDxp
bWFtbWVkb0ByZWRoYXQuY29tPjsgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+
DQo+ID4gPg0KPiA+ID4gT24gMjUuMTAuMjMgMTE6MTYsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiA+
ID4gPiBIaSBJZ29yLA0KPiA+ID4gPg0KPiA+ID4gPj4gRnJvbTogSWdvciBNYW1tZWRvdiA8aW1h
bW1lZG9AcmVkaGF0LmNvbT4NCj4gPiA+ID4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQsIDIw
MjMgOTowNiBBTQ0KPiA+ID4gPj4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBvcG5zcmMu
bmV0Pg0KPiA+ID4gPj4NCj4gPiA+ID4+IE9uIFdlZCwgMTggT2N0IDIwMjMgMTc6NDg6MzYgKzAx
MDANCj4gPiA+ID4+IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0PiB3cm90ZToN
Cj4gPiA+ID4+DQo+ID4gPiA+Pj4gSGkgQWxleCwNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IE9uIDE4
LzEwLzIwMjMgMTY6NDEsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gPiA+ID4+Pj4NCj4gPiA+ID4+
Pj4gU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+IHdyaXRlczoNCj4gPiA+ID4+
Pj4NCj4gPiA+ID4+Pj4+IEhlbGxvLA0KPiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+IENhbWUgYWNy
b3NzIGJlbG93IGNvZGUgZXhjZXJwdCBpbiB4ODYvbWljcm92bSBjb2RlIGFuZCB3YW50ZWQgdG8g
a25vdw0KPiA+ID4gPj4+Pj4gd2h5ICdoYXNfaG90cGx1Z2dhYmxlX2NwdXMnIGZsYWcgaGFzIGJl
ZW4gc2V0IHRvICdmYWxzZScgd2hpbGUgdmFyaW91cw0KPiA+ID4gPj4+Pj4gaG90KHVuKXBsdWcg
QVBJcyBoYXZlIGJlZW4gZGVmaW5lZD8NCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBzdGF0aWMg
dm9pZCBtaWNyb3ZtX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPiA+
ID4gPj4+Pj4gew0KPiA+ID4gPj4+Pj4gICAgICAgWDg2TWFjaGluZUNsYXNzICp4ODZtYyA9IFg4
Nl9NQUNISU5FX0NMQVNTKG9jKTsNCj4gPiA+ID4+Pj4+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMg
PSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiA+ID4+Pj4+ICAgICAgIEhvdHBsdWdIYW5kbGVyQ2xh
c3MgKmhjID0gSE9UUExVR19IQU5ETEVSX0NMQVNTKG9jKTsNCj4gPiA+ID4+Pj4+DQo+ID4gPiA+
Pj4+PiAgICAgICBtYy0+aW5pdCA9IG1pY3Jvdm1fbWFjaGluZV9zdGF0ZV9pbml0Ow0KPiA+ID4g
Pj4+Pj4NCj4gPiA+ID4+Pj4+ICAgICAgIG1jLT5mYW1pbHkgPSAibWljcm92bV9pMzg2IjsNCj4g
PiA+ID4+Pj4+ICAgICAgIFsuLi5dDQo+ID4gPiA+Pj4+PiAgICAgICBtYy0+bWF4X2NwdXMgPSAy
ODg7DQo+ID4gPiA+Pj4+PiAgICAgICBtYy0+aGFzX2hvdHBsdWdnYWJsZV9jcHVzID0gZmFsc2U7
ICAtLS0tLS0tLT4gVGhpcyBvbmUNCj4gPiA+ID4+Pj4+ICAgICAgIFsuLi5dDQo+ID4gPiA+Pj4+
DQo+ID4gPiA+Pj4+ICAgRnJvbSB0aGUgb3JpZ2luYWwgY29tbWl0IHRoYXQgYWRkZWQgaXQ6DQo+
ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+ICAgICBJdCdzIGEgbWluaW1hbGlzdCBtYWNoaW5lIHR5cGUg
d2l0aG91dCBQQ0kgbm9yIEFDUEkgc3VwcG9ydCwgZGVzaWduZWQNCj4gPiA+ID4+Pj4gICAgIGZv
ciBzaG9ydC1saXZlZCBndWVzdHMuIG1pY3Jvdm0gYWxzbyBlc3RhYmxpc2hlcyBhIGJhc2VsaW5l
IGZvcg0KPiA+ID4gPj4+PiAgICAgYmVuY2htYXJraW5nIGFuZCBvcHRpbWl6aW5nIGJvdGggUUVN
VSBhbmQgZ3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMsDQo+ID4gPiA+Pj4+ICAgICBzaW5jZSBpdCBp
cyBvcHRpbWl6ZWQgZm9yIGJvdGggYm9vdCB0aW1lIGFuZCBmb290cHJpbnQuDQo+ID4gPiA+Pj4N
Cj4gPiA+ID4+Pg0KPiA+ID4gPj4+IEFncmVlZC4gSXQgbG9va3MgbGlrZSBBQ1BJIGlzIHN1cHBv
cnRlZCBidXQgbmVpdGhlciBDUFUvTWVtb3J5IEhvdHBsdWcNCj4gPiA+ID4+PiBpcyBzdXBwb3J0
ZWQgZm9yIHRoaXMgbWluaW1hbGlzdCBtYWNoaW5lIHR5cGUuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+
Pg0KPiA+ID4gPj4+IHN0YXRpYyB2b2lkIG1pY3Jvdm1fZGV2aWNlc19pbml0KE1pY3Jvdm1NYWNo
aW5lU3RhdGUgKm1tcykNCj4gPiA+ID4+PiB7DQo+ID4gPiA+Pj4gICAgICAgY29uc3QgY2hhciAq
ZGVmYXVsdF9maXJtd2FyZTsNCj4gPiA+ID4+PiAgICAgICBYODZNYWNoaW5lU3RhdGUgKng4Nm1z
ID0gWDg2X01BQ0hJTkUobW1zKTsNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAgICAgWy4uLl0NCj4g
PiA+ID4+Pg0KPiA+ID4gPj4+ICAgICAgIC8qIE9wdGlvbmFsIGFuZCBsZWdhY3kgZGV2aWNlcyAq
Lw0KPiA+ID4gPj4+ICAgICAgIGlmICh4ODZfbWFjaGluZV9pc19hY3BpX2VuYWJsZWQoeDg2bXMp
KSB7DQo+ID4gPiA+Pj4gICAgICAgICAgIERldmljZVN0YXRlICpkZXYgPSBxZGV2X25ldyhUWVBF
X0FDUElfR0VEX1g4Nik7DQo+ID4gPiA+Pj4gICAgICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMy
KGRldiwgImdlZC1ldmVudCIsIEFDUElfR0VEX1BXUl9ET1dOX0VWVCk7DQo+ID4gPiA+Pj4gICAg
ICAgICAgIHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklDRShkZXYpLCAwLCBHRURfTU1JT19C
QVNFKTsNCj4gPiA+ID4+PiAgICAgICAgLyogc3lzYnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNF
KGRldiksIDEsIEdFRF9NTUlPX0JBU0VfTUVNSFApOw0KPiA+ID4gKi8NCj4gPiA+ID4+Pg0KPiA+
ID4gPj4+ICAgICAgICAgICBbLi4uXQ0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gICAgICAgICAgIHN5
c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKGRldiksICZlcnJvcl9mYXRhbCk7DQo+ID4gPiA+
Pj4gICAgICAgICAgIHg4Nm1zLT5hY3BpX2RldiA9IEhPVFBMVUdfSEFORExFUihkZXYpOw0KPiA+
ID4gPj4+ICAgICAgIH0NCj4gPiA+ID4+PiAgICAgIFsuLi5dDQo+ID4gPiA+Pj4gfQ0KPiA+ID4g
Pj4+DQo+ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+IEdlbmVyYWxseSBob3RwbHVnIHJlcXVpcmVzIGEg
ZGFuY2UgYmV0d2VlbiB0aGUgVk1NIGFuZCB0aGUgZmlybXdhcmUgdG8NCj4gPiA+ID4+Pj4gcHJv
cGVybHkgc2h1dGRvd24gYW5kIHJlc3RhcnQgaG90cGx1ZyBkZXZpY2VzLiBUaGUgcHJpbmNpcGxl
DQo+ID4gPiA+Pj4+IGNvbW11bmljYXRpb24gbWVjaGFuaXNtIGZvciB0aGlzIGlzIEFDUEkuDQo+
ID4gPiA+Pg0KPiA+ID4gPj4gZmlybXdhcmUgcGFydCBpbiBjcHUvbWVtIGhvcHRsdWcgdXN1YWxs
eSBwcm92aWRlZCBieSBRRU1VIGJ5IHRoZSB3YXkgb2YNCj4gPiA+ID4+IEFDUEkgdGFibGVzICh3
aGljaCBtYXkgY29udGFpbiBBTUwgY29kZSB0aGF0IGhhbmRsZXMgZGFuY2Ugd2l0aCBRRU1VDQo+
ID4gPiA+PiB3aGlsZSBleHBvc2luZyBzdGFuZGFyZCBpbnRlcmZhY2UgdG8gZ3Vlc3QgT1MgdG8g
aGFuZGxlIGhvdHBsdWcpDQo+ID4gPiA+Pg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gQWdyZWVkLg0K
PiA+ID4gPj4+DQo+ID4gPiA+Pj4+PiAgICAgICAvKiBob3RwbHVnIChmb3IgY3B1IGNvbGRwbHVn
KSAqLw0KPiA+ID4gPj4+Pj4gICAgICAgbWMtPmdldF9ob3RwbHVnX2hhbmRsZXIgPSBtaWNyb3Zt
X2dldF9ob3RwbHVnX2hhbmRsZXI7DQo+ID4gPiA+Pj4+PiAgICAgICBoYy0+cHJlX3BsdWcgPSBt
aWNyb3ZtX2RldmljZV9wcmVfcGx1Z19jYjsNCj4gPiA+ID4+Pj4+ICAgICAgIGhjLT5wbHVnID0g
bWljcm92bV9kZXZpY2VfcGx1Z19jYjsNCj4gPiA+ID4+Pj4+ICAgICAgIGhjLT51bnBsdWdfcmVx
dWVzdCA9IG1pY3Jvdm1fZGV2aWNlX3VucGx1Z19yZXF1ZXN0X2NiOw0KPiA+ID4gPj4+Pj4gICAg
ICAgaGMtPnVucGx1ZyA9IG1pY3Jvdm1fZGV2aWNlX3VucGx1Z19jYjsNCj4gPiA+ID4+Pg0KPiA+
ID4gPj4+IHNvcnJ5LCBJIGFsc28gbWlzc2VkIHRoZSBkZWZpbml0aW9ucyBvZiB0aGUgbGFzdCAy
IGZ1bmN0aW9ucyB3aGljaCBzYXlzDQo+ID4gPiA+Pj4gdGhhdCB1bnBsdWcgaXMgbm90IHN1cHBv
cnRlZCBzbyBwZXJoYXBzIHRoZXNlIGZ1bmN0aW9ucyBhcmUgb25seQ0KPiA+ID4gPj4+IHJlcXVp
cmVkIHRvIHN1cHBvcnQgY29sZCBwbHVnZ2luZyB3aGljaCBjb3Jyb2JvcmF0ZXMgd2l0aCB0aGUg
Y29tbWVudCBhcw0KPiA+ID4gPj4+IHdlbGwuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gdGhpcyBmdW5j
dGlvbiBhcmUgdXN1YWxseSB1c2VkIGZvciBib3RoIGNvbGQgYW5kIGhvdHBsdWcgb2YgYnVzLWxl
c3MgZGV2aWNlcy4NCj4gPiA+ID4+IFRoZXkgcHJvdmlkZSBhbiBvcHQtaW4gd2F5IGZvciBib2Fy
ZCB0byB3aXJlIHVwIHN1Y2ggZGV2aWNlcyAoaW5jbC4gQ1BVKS4NCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gU3VyZS4gSSB1bmRlcnN0YW5kIGJ1dCBtaWNyb3ZtIGRvZXMgbm90IHN1cHBvcnQg
aG90cGx1ZyBzbyBwcmVzZW5jZSBvZg0KPiA+ID4gPiB1bnBsdWd7X3JlcXVlc3R9IHZlcnNpb25z
IGJyb3VnaHQgYSBkb3VidCBpbiBteSBtaW5kIGJ1dCBJIHJlYWxpemVkIGxhdGVyDQo+ID4gPiA+
IHRoYXQgdGhlaXIgZGVmaW5pdGlvbnMgd2VyZSBlbXB0eS4gQ29sZC1wbHVnIGRvZXMgbm90IHJl
cXVpcmUgdW5wbHVnDQo+ID4gPiA+IHZlcnNpb25zLg0KPiA+ID4gPg0KPiA+ID4gPiBXYXMgdGhl
cmUgYW55IHBsYW4gdG8gc3VwcG9ydCBob3QtcGx1ZyB3aXRoIG1pY3Jvdm0gaW4gZnV0dXJlPw0K
PiA+ID4NCj4gPiA+IEF0IGxlYXN0IHZpcnRpby1tZW0gZm9yIG1lbW9yeSBob3RwbHVnIHNob3Vs
ZCBiZSBmYWlybHkgc3RyYWlnaHQtIGZvcndhcmQNCj4gPiA+IHRvIHdpcmUtdXAgSSBndWVzcy4g
VGhlIHJlbGF0aW9uIHRvIEFDUEkgYXJlIG1pbmltYWw6IHdlIGN1cnJlbnRseSBvbmx5DQo+ID4g
PiB1c2UgQUNQSSBTUkFUIHRvIGV4cG9zZSB0aGUgbWF4aW11bSBHUEEgcmFuZ2UgdGhhdCBlLmcu
LCBMaW51eCByZXF1aXJlcw0KPiA+ID4gZWFybHkgZHVyaW5nIGJvb3QgdG8gcHJvcGVybHkgcHJl
cGFyZSBmb3IgbWVtb3J5IGhvdHBsdWcgKHNpemUgdGhlDQo+ID4gPiB2aXJ0dWFsIG1lbW9yeSBz
cGFjZSBmb3IgdGhlIGtlcm5lbCBhY2NvcmRpbmdseSkuIE9uZSBjb3VsZCB1c2UNCj4gPiA+IGFs
dGVybmF0aXZlIChwYXJhdmlydHVhbGl6ZWQpIGludGVyZmFjZXMgZm9yIHRoYXQuDQo+ID4NCj4g
PiBPay4gTGlnaHQgd2VpZ2h0IFZNIG1vcmUgaW4gbGluZXMgb2YgRmlyZWNyYWNrZXIgdG8gaW1w
cm92ZSBib290LXVwIHRpbWVzPw0KPiA+DQo+ID4gQWxzbywgcHJlc2VuY2Ugb2YgdW5wbHVnIHZl
cnNpb25zIGdpdmVzIGEgd3JvbmcgaW1wcmVzc2lvbiBhYm91dCBjb2RlPw0KPiANCj4gdW5wbHVn
IGhhbmRsZXJzIGNvdWxkIGJlIHRoZW9yZXRpY2FsbHkgdXNlZCB0byB1bmRvIHdoYXQgKHByZSlw
bHVnIGRpZA0KPiBkdXJpbmcgVk0gZGVjb25zdHJ1Y3Rpb24uICh0aG91Z2ggaXQncyBub3QgdXNl
ZCB0aGlzIHdheSB0b2RheSB1bmxlc3MNCj4gaG90cGx1ZyBjb250cm9sbGVyIHJlcXVlc3RlZCBp
dCkuDQoNCg0KSSB1bmRlcnN0YW5kIHRoZSBpbnRlbnQgYnV0IGl0IHdvdWxkIGJlIGJldHRlciB0
byByZW1vdmUgdGhlc2UgYW5kIGJyaW5nDQp0aGVuIGJhY2sgYWdhaW4gaWYgdGhleSBhcmUgcmVx
dWlyZWQgaW4gZnV0dXJlLiANCg0KICAiLyogaG90cGx1ZyAoZm9yIGNwdSBjb2xkcGx1ZykgKi8i
DQoNCkFib3ZlIGNvbW1lbnQgYW5kIHRoZSBjb2RlIGFyZSBub3QgZXhhY3RseSBjb25zaXN0ZW50
IGV2ZW4gdGhvdWdoDQpkZWZpbml0aW9ucyBvZiB0aGUge3JlcXVlc3RffXVucGx1ZyBhcmUgZW1w
dHkuDQoNCg0KPiBXaGF0IGlzIGNvbmZ1c2luZyBpcyBpbnRlcmZhY2UgbmFtaW5nIChIb3RwbHVn
SGFuZGxlcikgd2hpY2ggaXMgbm90DQo+IGhvdHBsdWcgbGltaXRlZCBhbnltb3JlLg0KDQp7cHJl
X31wbHVnIHJvdXRpbmVzIGFyZSBjb21tb24gdG8ge2hvdCxjb2xkfS1wbHVnZ2VkIENQVXMsIHRo
ZXJlZm9yZSwgaXQNCm1ha2VzIHNlbnNlIHRvIGhhdmUgdGhlbSBoZXJlIGJ1dCBJIGFtIG5vdCBz
dXJlIGl0IGlzIG5lY2Vzc2FyeSB0byBoYXZlDQp7cmVxdWVzdF99dW5wbHVnIHJvdXRpbmVzIGFz
IHBhcnQgb2YgdGhpcyBpbXBsZW1lbnRhdGlvbi4gQWJzb2x1dGVseSwgaXQNCm1ha2VzIHNlbnNl
IHRvIGhhdmUgdGhlbSBwYXJ0IG9mIHRoZSBkZXNpZ24vZnJhbWV3b3JrIGZvciBmdXR1cmUNCmV4
dGVuc2liaWxpdHkgaW4gY2FzZSBldmVuIHVuLWluaXRpYWxpemF0aW9uIG9mIFZNIGRlY2lkZXMg
dG8gdXNlIHRoZXNlLg0KDQoNCj4gPiA+IFRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIGFueSBmb3Jt
IG9mIGhvdHBsdWcgaXMgImluIHRoZSBzcGlyaXQiIG9mIG1pY3Jvdm0uDQo+ID4NCj4gPiBVbmRl
cnN0YW5kIHRoYXQuIEJUVywgd2FzIGl0IGV2ZXIgbWFkZSB0byBiZSB1c2VkIHdpdGgga2F0YS1j
b250YWluZXJzPw0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gU2FsaWwuDQoNCg==

