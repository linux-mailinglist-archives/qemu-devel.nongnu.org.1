Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9ED7D67A3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaan-0006jq-6j; Wed, 25 Oct 2023 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qvaad-0006ik-V8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:54:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qvaaZ-00072Z-JA
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:54:15 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SFkhq50FJz67MSg;
 Wed, 25 Oct 2023 17:51:23 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 10:54:07 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Wed, 25 Oct 2023 10:54:07 +0100
To: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Salil Mehta <salil.mehta@opnsrc.net>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Topic: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Thread-Index: AQHaAdYd7aTyirD0h0OdEs9gK4EV+LBPnpeAgAAS2QCACNvyAIABtJPA///1ywCAABS9gA==
Date: Wed, 25 Oct 2023 09:54:07 +0000
Message-ID: <1358aadeade14623a90284d188fbce31@huawei.com>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org> <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
 <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
 <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
 <1055386d-2706-4ce2-b190-106510bee52c@redhat.com>
In-Reply-To: <1055386d-2706-4ce2-b190-106510bee52c@redhat.com>
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

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBPY3RvYmVyIDI1LCAyMDIzIDEwOjMyIEFNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2Fs
aWwubWVodGFAaHVhd2VpLmNvbT47IElnb3IgTWFtbWVkb3YNCj4gPGltYW1tZWRvQHJlZGhhdC5j
b20+OyBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAb3Buc3JjLm5ldD4NCj4gDQo+IE9uIDI1LjEw
LjIzIDExOjE2LCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPiBIaSBJZ29yLA0KPiA+DQo+ID4+IEZy
b206IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNk
YXksIE9jdG9iZXIgMjQsIDIwMjMgOTowNiBBTQ0KPiA+PiBUbzogU2FsaWwgTWVodGEgPHNhbGls
Lm1laHRhQG9wbnNyYy5uZXQ+DQo+ID4+DQo+ID4+IE9uIFdlZCwgMTggT2N0IDIwMjMgMTc6NDg6
MzYgKzAxMDANCj4gPj4gU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+IHdyb3Rl
Og0KPiA+Pg0KPiA+Pj4gSGkgQWxleCwNCj4gPj4+DQo+ID4+PiBPbiAxOC8xMC8yMDIzIDE2OjQx
LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAb3Buc3JjLm5ldD4gd3JpdGVzOg0KPiA+Pj4+DQo+ID4+Pj4+IEhlbGxvLA0KPiA+Pj4+
Pg0KPiA+Pj4+PiBDYW1lIGFjcm9zcyBiZWxvdyBjb2RlIGV4Y2VycHQgaW4geDg2L21pY3Jvdm0g
Y29kZSBhbmQgd2FudGVkIHRvIGtub3cNCj4gPj4+Pj4gd2h5ICdoYXNfaG90cGx1Z2dhYmxlX2Nw
dXMnIGZsYWcgaGFzIGJlZW4gc2V0IHRvICdmYWxzZScgd2hpbGUgdmFyaW91cw0KPiA+Pj4+PiBo
b3QodW4pcGx1ZyBBUElzIGhhdmUgYmVlbiBkZWZpbmVkPw0KPiA+Pj4+Pg0KPiA+Pj4+PiBzdGF0
aWMgdm9pZCBtaWNyb3ZtX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0K
PiA+Pj4+PiB7DQo+ID4+Pj4+ICAgICAgIFg4Nk1hY2hpbmVDbGFzcyAqeDg2bWMgPSBYODZfTUFD
SElORV9DTEFTUyhvYyk7DQo+ID4+Pj4+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5F
X0NMQVNTKG9jKTsNCj4gPj4+Pj4gICAgICAgSG90cGx1Z0hhbmRsZXJDbGFzcyAqaGMgPSBIT1RQ
TFVHX0hBTkRMRVJfQ0xBU1Mob2MpOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAgICAgICBtYy0+aW5pdCA9
IG1pY3Jvdm1fbWFjaGluZV9zdGF0ZV9pbml0Ow0KPiA+Pj4+Pg0KPiA+Pj4+PiAgICAgICBtYy0+
ZmFtaWx5ID0gIm1pY3Jvdm1faTM4NiI7DQo+ID4+Pj4+ICAgICAgIFsuLi5dDQo+ID4+Pj4+ICAg
ICAgIG1jLT5tYXhfY3B1cyA9IDI4ODsNCj4gPj4+Pj4gICAgICAgbWMtPmhhc19ob3RwbHVnZ2Fi
bGVfY3B1cyA9IGZhbHNlOyAgLS0tLS0tLS0+IFRoaXMgb25lDQo+ID4+Pj4+ICAgICAgIFsuLi5d
DQo+ID4+Pj4NCj4gPj4+PiAgIEZyb20gdGhlIG9yaWdpbmFsIGNvbW1pdCB0aGF0IGFkZGVkIGl0
Og0KPiA+Pj4+DQo+ID4+Pj4gICAgIEl0J3MgYSBtaW5pbWFsaXN0IG1hY2hpbmUgdHlwZSB3aXRo
b3V0IFBDSSBub3IgQUNQSSBzdXBwb3J0LCBkZXNpZ25lZA0KPiA+Pj4+ICAgICBmb3Igc2hvcnQt
bGl2ZWQgZ3Vlc3RzLiBtaWNyb3ZtIGFsc28gZXN0YWJsaXNoZXMgYSBiYXNlbGluZSBmb3INCj4g
Pj4+PiAgICAgYmVuY2htYXJraW5nIGFuZCBvcHRpbWl6aW5nIGJvdGggUUVNVSBhbmQgZ3Vlc3Qg
b3BlcmF0aW5nIHN5c3RlbXMsDQo+ID4+Pj4gICAgIHNpbmNlIGl0IGlzIG9wdGltaXplZCBmb3Ig
Ym90aCBib290IHRpbWUgYW5kIGZvb3RwcmludC4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gQWdyZWVk
LiBJdCBsb29rcyBsaWtlIEFDUEkgaXMgc3VwcG9ydGVkIGJ1dCBuZWl0aGVyIENQVS9NZW1vcnkg
SG90cGx1Zw0KPiA+Pj4gaXMgc3VwcG9ydGVkIGZvciB0aGlzIG1pbmltYWxpc3QgbWFjaGluZSB0
eXBlLg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBzdGF0aWMgdm9pZCBtaWNyb3ZtX2RldmljZXNfaW5p
dChNaWNyb3ZtTWFjaGluZVN0YXRlICptbXMpDQo+ID4+PiB7DQo+ID4+PiAgICAgICBjb25zdCBj
aGFyICpkZWZhdWx0X2Zpcm13YXJlOw0KPiA+Pj4gICAgICAgWDg2TWFjaGluZVN0YXRlICp4ODZt
cyA9IFg4Nl9NQUNISU5FKG1tcyk7DQo+ID4+Pg0KPiA+Pj4gICAgICBbLi4uXQ0KPiA+Pj4NCj4g
Pj4+ICAgICAgIC8qIE9wdGlvbmFsIGFuZCBsZWdhY3kgZGV2aWNlcyAqLw0KPiA+Pj4gICAgICAg
aWYgKHg4Nl9tYWNoaW5lX2lzX2FjcGlfZW5hYmxlZCh4ODZtcykpIHsNCj4gPj4+ICAgICAgICAg
ICBEZXZpY2VTdGF0ZSAqZGV2ID0gcWRldl9uZXcoVFlQRV9BQ1BJX0dFRF9YODYpOw0KPiA+Pj4g
ICAgICAgICAgIHFkZXZfcHJvcF9zZXRfdWludDMyKGRldiwgImdlZC1ldmVudCIsIEFDUElfR0VE
X1BXUl9ET1dOX0VWVCk7DQo+ID4+PiAgICAgICAgICAgc3lzYnVzX21taW9fbWFwKFNZU19CVVNf
REVWSUNFKGRldiksIDAsIEdFRF9NTUlPX0JBU0UpOw0KPiA+Pj4gICAgICAgIC8qIHN5c2J1c19t
bWlvX21hcChTWVNfQlVTX0RFVklDRShkZXYpLCAxLCBHRURfTU1JT19CQVNFX01FTUhQKTsNCj4g
Ki8NCj4gPj4+DQo+ID4+PiAgICAgICAgICAgWy4uLl0NCj4gPj4+DQo+ID4+PiAgICAgICAgICAg
c3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoZGV2KSwgJmVycm9yX2ZhdGFsKTsNCj4gPj4+
ICAgICAgICAgICB4ODZtcy0+YWNwaV9kZXYgPSBIT1RQTFVHX0hBTkRMRVIoZGV2KTsNCj4gPj4+
ICAgICAgIH0NCj4gPj4+ICAgICAgWy4uLl0NCj4gPj4+IH0NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+
PiBHZW5lcmFsbHkgaG90cGx1ZyByZXF1aXJlcyBhIGRhbmNlIGJldHdlZW4gdGhlIFZNTSBhbmQg
dGhlIGZpcm13YXJlIHRvDQo+ID4+Pj4gcHJvcGVybHkgc2h1dGRvd24gYW5kIHJlc3RhcnQgaG90
cGx1ZyBkZXZpY2VzLiBUaGUgcHJpbmNpcGxlDQo+ID4+Pj4gY29tbXVuaWNhdGlvbiBtZWNoYW5p
c20gZm9yIHRoaXMgaXMgQUNQSS4NCj4gPj4NCj4gPj4gZmlybXdhcmUgcGFydCBpbiBjcHUvbWVt
IGhvcHRsdWcgdXN1YWxseSBwcm92aWRlZCBieSBRRU1VIGJ5IHRoZSB3YXkgb2YNCj4gPj4gQUNQ
SSB0YWJsZXMgKHdoaWNoIG1heSBjb250YWluIEFNTCBjb2RlIHRoYXQgaGFuZGxlcyBkYW5jZSB3
aXRoIFFFTVUNCj4gPj4gd2hpbGUgZXhwb3Npbmcgc3RhbmRhcmQgaW50ZXJmYWNlIHRvIGd1ZXN0
IE9TIHRvIGhhbmRsZSBob3RwbHVnKQ0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEFncmVlZC4NCj4gPj4+
DQo+ID4+Pj4+ICAgICAgIC8qIGhvdHBsdWcgKGZvciBjcHUgY29sZHBsdWcpICovDQo+ID4+Pj4+
ICAgICAgIG1jLT5nZXRfaG90cGx1Z19oYW5kbGVyID0gbWljcm92bV9nZXRfaG90cGx1Z19oYW5k
bGVyOw0KPiA+Pj4+PiAgICAgICBoYy0+cHJlX3BsdWcgPSBtaWNyb3ZtX2RldmljZV9wcmVfcGx1
Z19jYjsNCj4gPj4+Pj4gICAgICAgaGMtPnBsdWcgPSBtaWNyb3ZtX2RldmljZV9wbHVnX2NiOw0K
PiA+Pj4+PiAgICAgICBoYy0+dW5wbHVnX3JlcXVlc3QgPSBtaWNyb3ZtX2RldmljZV91bnBsdWdf
cmVxdWVzdF9jYjsNCj4gPj4+Pj4gICAgICAgaGMtPnVucGx1ZyA9IG1pY3Jvdm1fZGV2aWNlX3Vu
cGx1Z19jYjsNCj4gPj4+DQo+ID4+PiBzb3JyeSwgSSBhbHNvIG1pc3NlZCB0aGUgZGVmaW5pdGlv
bnMgb2YgdGhlIGxhc3QgMiBmdW5jdGlvbnMgd2hpY2ggc2F5cw0KPiA+Pj4gdGhhdCB1bnBsdWcg
aXMgbm90IHN1cHBvcnRlZCBzbyBwZXJoYXBzIHRoZXNlIGZ1bmN0aW9ucyBhcmUgb25seQ0KPiA+
Pj4gcmVxdWlyZWQgdG8gc3VwcG9ydCBjb2xkIHBsdWdnaW5nIHdoaWNoIGNvcnJvYm9yYXRlcyB3
aXRoIHRoZSBjb21tZW50IGFzDQo+ID4+PiB3ZWxsLg0KPiA+Pg0KPiA+PiB0aGlzIGZ1bmN0aW9u
IGFyZSB1c3VhbGx5IHVzZWQgZm9yIGJvdGggY29sZCBhbmQgaG90cGx1ZyBvZiBidXMtbGVzcyBk
ZXZpY2VzLg0KPiA+PiBUaGV5IHByb3ZpZGUgYW4gb3B0LWluIHdheSBmb3IgYm9hcmQgdG8gd2ly
ZSB1cCBzdWNoIGRldmljZXMgKGluY2wuIENQVSkuDQo+ID4NCj4gPg0KPiA+IFN1cmUuIEkgdW5k
ZXJzdGFuZCBidXQgbWljcm92bSBkb2VzIG5vdCBzdXBwb3J0IGhvdHBsdWcgc28gcHJlc2VuY2Ug
b2YNCj4gPiB1bnBsdWd7X3JlcXVlc3R9IHZlcnNpb25zIGJyb3VnaHQgYSBkb3VidCBpbiBteSBt
aW5kIGJ1dCBJIHJlYWxpemVkIGxhdGVyDQo+ID4gdGhhdCB0aGVpciBkZWZpbml0aW9ucyB3ZXJl
IGVtcHR5LiBDb2xkLXBsdWcgZG9lcyBub3QgcmVxdWlyZSB1bnBsdWcNCj4gPiB2ZXJzaW9ucy4N
Cj4gPg0KPiA+IFdhcyB0aGVyZSBhbnkgcGxhbiB0byBzdXBwb3J0IGhvdC1wbHVnIHdpdGggbWlj
cm92bSBpbiBmdXR1cmU/DQo+IA0KPiBBdCBsZWFzdCB2aXJ0aW8tbWVtIGZvciBtZW1vcnkgaG90
cGx1ZyBzaG91bGQgYmUgZmFpcmx5IHN0cmFpZ2h0LWZvcndhcmQNCj4gdG8gd2lyZS11cCBJIGd1
ZXNzLiBUaGUgcmVsYXRpb24gdG8gQUNQSSBhcmUgbWluaW1hbDogd2UgY3VycmVudGx5IG9ubHkN
Cj4gdXNlIEFDUEkgU1JBVCB0byBleHBvc2UgdGhlIG1heGltdW0gR1BBIHJhbmdlIHRoYXQgZS5n
LiwgTGludXggcmVxdWlyZXMNCj4gZWFybHkgZHVyaW5nIGJvb3QgdG8gcHJvcGVybHkgcHJlcGFy
ZSBmb3IgbWVtb3J5IGhvdHBsdWcgKHNpemUgdGhlDQo+IHZpcnR1YWwgbWVtb3J5IHNwYWNlIGZv
ciB0aGUga2VybmVsIGFjY29yZGluZ2x5KS4gT25lIGNvdWxkIHVzZQ0KPiBhbHRlcm5hdGl2ZSAo
cGFyYXZpcnR1YWxpemVkKSBpbnRlcmZhY2VzIGZvciB0aGF0Lg0KDQpPay4gTGlnaHQgd2VpZ2h0
IFZNIG1vcmUgaW4gbGluZXMgb2YgRmlyZWNyYWNrZXIgdG8gaW1wcm92ZSBib290LXVwIHRpbWVz
Pw0KDQpBbHNvLCBwcmVzZW5jZSBvZiB1bnBsdWcgdmVyc2lvbnMgZ2l2ZXMgYSB3cm9uZyBpbXBy
ZXNzaW9uIGFib3V0IGNvZGU/DQoNCj4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgYW55IGZvcm0g
b2YgaG90cGx1ZyBpcyAiaW4gdGhlIHNwaXJpdCIgb2YgbWljcm92bS4NCg0KVW5kZXJzdGFuZCB0
aGF0LiBCVFcsIHdhcyBpdCBldmVyIG1hZGUgdG8gYmUgdXNlZCB3aXRoIGthdGEtY29udGFpbmVy
cz8NCg0KVGhhbmtzDQpTYWxpbC4NCg==

