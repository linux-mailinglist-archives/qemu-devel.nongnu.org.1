Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B34179EE776
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 14:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiwx-000055-Js; Thu, 12 Dec 2024 08:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLiwn-0008WF-2b; Thu, 12 Dec 2024 08:09:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tLiwk-0000ez-1m; Thu, 12 Dec 2024 08:09:40 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8CNr1b6mz6K6hd;
 Thu, 12 Dec 2024 21:04:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id CA57F140A86;
 Thu, 12 Dec 2024 21:09:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 14:09:23 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 12 Dec 2024 14:09:23 +0100
To: Eric Auger <eauger@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
CC: "shahuang@redhat.com" <shahuang@redhat.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Topic: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
Thread-Index: AQHbR9ExiwFvWbARik6RGTWin+st0LLiOsqAgAAIRoCAAFdCwA==
Date: Thu, 12 Dec 2024 13:09:23 +0000
Message-ID: <4fb49b5b02bb417399ee871b2c85bb35@huawei.com>
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <38604260-6f92-4f16-9a4d-c310cbc52d77@redhat.com>
In-Reply-To: <38604260-6f92-4f16-9a4d-c310cbc52d77@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.145.115]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlYXVnZXJAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDEyLCAy
MDI0IDg6NDIgQU0NCj4gVG86IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgQ29ybmVsaWEgSHVjayA8
Y29odWNrQHJlZGhhdC5jb20+Ow0KPiBlcmljLmF1Z2VyLnByb0BnbWFpbC5jb207IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IGt2bWFybUBsaXN0cy5saW51
eC5kZXY7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gcmljaGFyZC5oZW5kZXJzb25AbGlu
YXJvLm9yZzsgYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgbWF6QGtlcm5lbC5vcmc7DQo+IG9saXZl
ci51cHRvbkBsaW51eC5kZXY7IHNlYm90dEByZWRoYXQuY29tOyBTaGFtZWVyYWxpIEtvbG90aHVt
IFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBhcm1icnVA
cmVkaGF0LmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgYWJvbG9nbmFAcmVkaGF0LmNvbTsg
amRlbmVtYXJAcmVkaGF0LmNvbQ0KPiBDYzogc2hhaHVhbmdAcmVkaGF0LmNvbTsgbWFyay5ydXRs
YW5kQGFybS5jb207IHBoaWxtZEBsaW5hcm8ub3JnOw0KPiBwYm9uemluaUByZWRoYXQuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDdjIgMDAvMjBdIGt2bS9hcm06IEludHJvZHVjZSBhIGN1
c3RvbWl6YWJsZQ0KPiBhYXJjaDY0IEtWTSBob3N0IG1vZGVsDQo+IA0KPiBTaGFtZWVyLA0KPiAN
Cj4gT24gMTIvMTIvMjQgMDk6MTIsIEVyaWMgQXVnZXIgd3JvdGU6DQo+ID4gQ29ubmllLA0KPiA+
DQo+ID4gT24gMTIvNi8yNCAxMjoyMSwgQ29ybmVsaWEgSHVjayB3cm90ZToNCj4gPj4gQSByZXNw
aW4vdXBkYXRlIG9uIHRoZSBhYXJjaDY0IEtWTSBjcHUgbW9kZWxzLiBBbHNvIGF2YWlsYWJsZSBh
dA0KPiA+PiBnaXRsYWIuY29tL2NvaHVjay9xZW11IGFybS1jcHUtbW9kZWwtcmZjdjINCj4gPj4N
Cj4gPj4gRmluZCBFcmljJ3Mgb3JpZ2luYWwgY292ZXIgbGV0dGVyIGJlbG93LCBzbyB0aGF0IEkg
ZG8gbm90IG5lZWQgdG8NCj4gPj4gcmVwZWF0IG15c2VsZiBvbiB0aGUgYXNwZWN0cyB0aGF0IGhh
dmUgbm90IGNoYW5nZWQgc2luY2UgUkZDdjEgOikNCj4gPj4NCj4gPj4gQ2hhbmdlcyBmcm9tIFJG
Q3YxOg0KPiA+Pg0KPiA+PiBSZWJhc2VkIG9uIG1vcmUgcmVjZW50IFFFTVUgKHNvbWUgYWRhcHRp
b25zIGluIHRoZSByZWdpc3Rlcg0KPiBjb252ZXJzaW9ucw0KPiA+PiBvZiB0aGUgZmlyc3QgZmV3
IHBhdGNoZXMuKQ0KPiA+Pg0KPiA+PiBCYXNlZCBvbiBmZWVkYmFjaywgSSBoYXZlIHJlbW92ZWQg
dGhlICJjdXN0b20iIGNwdSBtb2RlbDsgaW5zdGVhZCwgSQ0KPiA+PiBoYXZlIGFkZGVkIHRoZSBu
ZXcgU1lTUkVHXzxSRUc+XzxGSUVMRD4gcHJvcGVydGllcyB0byB0aGUgImhvc3QiDQo+IG1vZGVs
Lg0KPiA+PiBUaGlzIHdvcmtzIHdlbGwgaWYgeW91IHdhbnQgdG8gdHdlYWsgYW55dGhpbmcgdGhh
dCBkb2VzIG5vdCBjb3JyZXNwb25kDQo+ID4+IHRvIHRoZSBleGlzdGluZyBwcm9wZXJ0aWVzIGZv
ciB0aGUgaG9zdCBtb2RlbDsgaG93ZXZlciwgaWYgeW91IGUuZy4NCj4gPj4gd2FudGVkIHRvIHR3
ZWFrIHN2ZSwgeW91IGhhdmUgdHdvIHdheXMgdG8gZG8gc28gLS0gd2UnZCBwcm9iYWJseSBlaXRo
ZXINCj4gPj4gd2FudCB0byBjaGVjayBmb3IgY29uZmxpY3RzLCBvciBqdXN0IGRlY2xhcmUgcHJl
Y2VkZW5jZS4gVGhlIGt2bS1zcGVjaWZpYw0KPiA+PiBwcm9wcyByZW1haW4gdW5jaGFuZ2VkLCBh
cyB0aGV5IGFyZSBvcnRob2dvbmFsIHRvIHRoaXMgY29uZmlndXJhdGlvbi4NCj4gPj4NCj4gPj4g
VGhlIGNwdSBtb2RlbCBleHBhbnNpb24gZm9yIHRoZSAiaG9zdCIgbW9kZWwgbm93IGR1bXBzIHRo
ZSBuZXcNCj4gU1lTUkVHXw0KPiA+PiBwcm9wZXJ0aWVzIGluIGFkZGl0aW9uIHRvIHRoZSBleGlz
dGluZyBob3N0IG1vZGVsIHByb3BlcnRpZXM7IHRoaXMgaXMgYQ0KPiA+PiBiaXQgdWdseSwgYnV0
IEkgZG9uJ3Qgc2VlIGEgZ29vZCB3YXkgb24gaG93IHRvIHNwbGl0IHRoaXMgdXAuDQo+ID4+DQo+
ID4+IFNvbWUgbW9yZSBhZGFwdGlvbnMgZHVlIHRvIHRoZSByZW1vdmFsIG9mIHRoZSAiY3VzdG9t
IiBtb2RlbC4NCj4gPj4NCj4gPj4gVGhpbmdzICpub3QqIGNoYW5nZWQgZnJvbSBSRkN2MToNCj4g
Pj4NCj4gPj4gU1lTUkVHXyBwcm9wZXJ0eSBuYW1pbmcgKGNhbiBiZSB0d2Vha2VkIGVhc2lseSwg
b25jZSB3ZSBhcmUgY2xlYXIgb24NCj4gd2hhdA0KPiA+PiB0aGUgaW50ZXJmYWNlIHNob3VsZCBs
b29rIGxpa2UuKQ0KPiA+Pg0KPiA+PiBTeXNyZWcgZ2VuZXJhdGlvbiBzY3JpcHRzLCBhbmQgdGhl
IGdlbmVyYXRlZCBmaWxlcyAoSSBoYXZlIG5vdCB1cGRhdGVkDQo+ID4+IGFueXRoaW5nIHRoZXJl
LikgSSB0aGluayBnZW5lcmF0aW5nIHRoZSB2YXJpb3VzIGRlZmluaXRpb25zIG1ha2VzIHNlbnNl
LA0KPiA+PiBhcyBsb25nIGFzIHdlIGRvdWJsZS1jaGVjayB0aGUgZ2VuZXJhdGVkIGZpbGVzIG9u
IGVhY2ggdXBkYXRlICh3aGljaA0KPiB3b3VsZA0KPiA+PiBiZSBzb21ldGhpbmcgdG8gdHJpZ2dl
ciBtYW51YWxseSBhbnl3YXkuKQ0KPiA+Pg0KPiA+PiBXaGF0IEkgd291bGQgbGlrZSB1cyB0byBy
ZWFjaCBzb21lIGtpbmQgb2YgY29uc2Vuc3VzIG9uOg0KPiA+Pg0KPiA+PiBIb3cgdG8gY29udGlu
dWUgd2l0aCB0aGUgcGF0Y2hlcyBtb3ZpbmcgdGhlIElEIHJlZ2lzdGVycyBmcm9tIHRoZSBpc2Fy
DQo+ID4+IHN0cnVjdCBpbnRvIHRoZSBpZHJlZ3MgYXJyYXkuIFRoZXNlIGFyZSBhIGJpdCBvZiBj
aHVybiB0byBkcmFnIGFsb25nOw0KPiA+PiBpZiB0aGV5IG1ha2Ugc2Vuc2UsIG1heWJlIHRoZXkg
Y2FuIGJlIHBpY2tlZCBpbmRlcGVuZGVudGx5IG9mIHRoaXMNCj4gc2VyaWVzPw0KPiA+Pg0KPiA+
PiBXaGV0aGVyIGl0IG1ha2Ugc2Vuc2UgdG8gY29udGludWUgd2l0aCB0aGUgYXBwcm9hY2ggb2Yg
dHdlYWtpbmcNCj4gdmFsdWVzIGluDQo+ID4+IHRoZSBJRCByZWdpc3RlcnMgaW4gZ2VuZXJhbC4g
SWYgd2Ugd2FudCB0byBiZSBhYmxlIHRvIG1pZ3JhdGUgYmV0d2Vlbg0KPiBjcHVzDQo+ID4+IHRo
YXQgZG8gbm90IGRpZmZlciB3aWxkbHksIHdlJ2xsIGVuY291bnRlciBkaWZmZXJlbmNlcyB0aGF0
IGNhbm5vdCBiZQ0KPiA+PiBleHByZXNzZWQgdmlhIEZFQVRfeHh4IC0tIGUuZy4gd2hlbiBjb21w
YXJpbmcgdmFyaW91cyBBbXBlcmVBbHRyYSBNYXgNCj4gc3lzdGVtcywNCj4gPj4gdGhleSBvbmx5
IGRpZmZlciBpbiBwYXJ0cyBvZiBDVFJfRUwwIC0tIHdoaWNoIGlzIG5vdCBhIGZlYXR1cmUgcmVn
aXN0ZXIsIGJ1dA0KPiA+PiBhIHdyaXRhYmxlIHJlZ2lzdGVyLg0KPiA+IEluIHYxIG1vc3Qgb2Yg
dGhlIGNvbW1lbnRlcnMgc2FpZCB0aGV5IHdvdWxkIHByZWZlciB0byBzZWUgRkVBVCBwcm9wcw0K
PiA+IGluc3RlYWQgb2YgSURSRUcgZmllbGQgcHJvcHMuIEkgdGhpbmsgd2Ugc2hhbGwgdHJ5IHRv
IGdvIGluIHRoaXMNCj4gPiBkaXJlY3Rpb24gYW55d2F5LiBBcyB5b3UgcG9pbnRlZCBvdXQgdGhl
cmUgd2lsbCBiZSBzb21lIGNhc2VzIHdoZXJlDQo+IEZFQVQNCj4gPiB3b24ndCBiZSBlbm91Z2gg
KENUUl9FTDAgaXMgYSBnb29kIGV4YW1wbGUpLiBTbyBJIHRlbmQgdG8gdGhpbmsgdGhlIGVuZA0K
PiA+IHNvbHV0aW9uIHdpbGwgYmUgYSBtaXggb2YgRkVBVCBhbmQgSUQgcmVnIGZpZWxkIHByb3Bz
Lg0KPiA+DQo+ID4gUGVyc29uYWxseSBJIHdvdWxkIHNtb290aGx5IG1pZ3JhdGUgd2hhdCB3ZSBj
YW4gZnJvbSBJRCByZWcgZmllbGQgcHJvcHMNCj4gPiB0byBGRUFUIHByb3BzIChtYXliZSB1c2lu
ZyBwcm9wIGFsaWFzZXM/KSwgc3RhcnRpbmcgZnJvbSB0aGUgZWFzaWVzdCAxLTENCj4gPiBtYXBw
aW5ncyBhbmQgdGhlbiBhZHJlc3NpbmcgdGhlIEZFQVQgdGhhdCBhcmUgbW9yZSBjb21wbGV4IGJ1
dCBhcmUNCj4gPiBleHBsaWN0bHkgbmVlZGVkIHRvIGVuYWJsZSB0aGUgdXNlIGNhc2VzIHdlIGFy
ZSBpbnRlcmVzdGVkIGluLCBhdCBSZWRIYXQ6DQo+ID4gbWlncmF0aW9uIHdpdGhpbiBBbXBlcmUg
QWx0cmFNYXggZmFtaWx5LCBtaWdyYXRpb24gd2l0aGluIE5WaWRpYSBHcmFjZQ0KPiA+IGZhbWls
eSwgbWlncmF0aW9uIHdpdGhpbiBBbXBlcmVPbmUgZmFtaWx5IGFuZCBtaWdyYXRpb24gYmV0d2Vl
bg0KPiBHcmF2aXRvbjMvNC4NCj4gPg0KPiA+IFdlIGhhdmUgbm8gaW5mbyBhYm91dCBvdGhlcidz
IHVzZSBjYXNlcy4gSWYgc29tZSBvZiB5b3Ugd2FudCB0byBzZWUgc29tZQ0KPiA+IG90aGVyIGxp
dmUgbWlncmF0aW9uIGNvbWJpbmF0aW9ucyBhZGRyZXNzZWQsIHBsZWFzZSByYWlzZSB5b3VyIHZv
aWNlLg0KPiBJbiByZWxhdGlvbiB0byBbMV0geW91IHNlZW0gdG8gYmUgYWxzbyBpbnRlcmVzdGVk
IGluIHRoZSBtaWdyYXRpb24NCj4gYmV0d2VlbiBoZXRlcm9nZW5lb3VzIHN5c3RlbXMgd2l0aCBx
ZW11Lg0KDQpZZXMuIFRoYXQgaXMgY29ycmVjdC4NCg0KPiBEbyB5b3UgdGhpbmsgdGFyZ2V0aW5n
IG1pZ3JhdGlvbiB3aXRoaW4gYSBjcHUgZmFtaWx5IGlzIGVub3VnaCBmb3IgeW91cg0KPiB1c2Ug
Y2FzZXMuIEhvdyBkaWZmZXJlbnQgYXJlIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGhvc3Qg
b24geW91cg0KPiBjYXNlcy4gRG8geW91IHRoaW5nIGZlYXQgcHJvcHMgYXJlIHJlbGV2YW50IGlu
IHlvdXIgY2FzZSBvciB3b3VsZCB5b3UNCj4gbmVlZCBsb3dlciBncmFudWxhcml0eSBhdCBpZHJl
ZyBmaWVsZCBsZXZlbHRvIHBhc3MgdGhlIG1pZ3JhdGlvbj8NCg0KSSB0aGluaywgZnJvbSB0aGUg
Y3VycmVudCByZXF1aXJlbWVudCB3ZSBoYXZlIGZvciBtaWdyYXRpb24sIHRoZSBzb3VyY2UgYW5k
DQpkZXN0aW5hdGlvbiBtb3N0bHkgY2FuIGJlIGhhbmRsZWQgYnkgRkVBVF9YWFguIEJ1dCBsaWtl
IEFtcGVyZSwgd2UgZG8gbmVlZA0KdG8gbWFuYWdlIHRoZSBDVFJfRUwwIGRpZmZlcmVuY2VzWzFd
Lg0KDQpBbHNvIHdlIGRvIGhhdmUgZGlmZmVyZW5jZXMgaW4gR0lDIHN1cHBvcnQgYXMgd2VsbChB
QTY0UEZSMF9FTDEuR0lDKSB3aGljaCANCkkgYW0gbm90IHN1cmUgaG93IHRvIG1hbmFnZSB3aXRo
IEZFQVRfWFhYLg0KDQpBbmQgd2UgYXJlIGNoZWNraW5nIHdpdGggb3VyIFByb2R1Y3QgdGVhbSB3
aGV0aGVyIHdlIG5lZWQgdG8gc3VwcG9ydCBtaWdyYXRpb24NCmZyb20gYW4gb2xkIENQVSB0eXBl
IGluIHdoaWNoIGNhc2Ugd2UgaGF2ZSB0byBkbyBhIGJpdCBtb3JlIGFuYWx5c2lzLg0KDQpUaGFu
a3MsDQpTaGFtZWVyDQoNCjEuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bWFybS8yMDI0MTAy
MjA3Mzk0My4zNTc2NC0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8NCg0K
DQoNCiANCiANCg==

