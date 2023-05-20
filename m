Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3070A485
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 04:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Brk-0000CZ-WA; Fri, 19 May 2023 21:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1q0Bri-0000BS-MJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 21:58:38 -0400
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1q0Brg-0005LL-0U
 for qemu-devel@nongnu.org; Fri, 19 May 2023 21:58:38 -0400
Received: from mail.maildlp.com ([172.25.15.155])
 by h3cspam01-ex.h3c.com with ESMTP id 34K1vxRI017956;
 Sat, 20 May 2023 09:57:59 +0800 (GMT-8)
 (envelope-from yu.chen@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com (unknown [172.20.54.131])
 by mail.maildlp.com (Postfix) with ESMTP id 580462007260;
 Sat, 20 May 2023 10:02:00 +0800 (CST)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) by
 DAG2EX08-IDC.srv.huawei-3com.com (172.20.54.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Sat, 20 May 2023 09:57:58 +0800
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b])
 by DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b%10])
 with mapi id 15.01.2507.021; Sat, 20 May 2023 09:57:59 +0800
From: Yuchen <yu.chen@h3c.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gdGFyZ2V0L2kzODY6IENsZWFyIHhz?=
 =?utf-8?Q?ave_pkru_bit_when_KVM_XCR0_not_support?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDbGVhciB4c2F2ZSBwa3J1?=
 =?utf-8?Q?_bit_when_KVM_XCR0_not_support?=
Thread-Index: AdmH10nRMdIv88FeTxmtO8yhX/g2MgAx9MSAADk09OAALF7qAAAhFRMg
Date: Sat, 20 May 2023 01:57:58 +0000
Message-ID: <26ad17ab26ea43d1a5ef97c0a4c8c7bd@h3c.com>
References: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
 <0a734157-778b-8d33-3999-b374a68a3c39@redhat.com>
 <6c64f1b84cbf4dd1a75301fc4615f351@h3c.com>
 <e7c5d527-2461-332e-638f-38c95ff2602d@redhat.com>
In-Reply-To: <e7c5d527-2461-332e-638f-38c95ff2602d@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.196.41]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: h3cspam01-ex.h3c.com 34K1vxRI017956
Received-SPF: pass client-ip=60.191.123.56; envelope-from=yu.chen@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

UGFvbG8sIHRoYW5rcywgDQpUaGUga2VybmVsIHBhdGNoIGNhbiBzb2x2ZSB0aGlzIHByb2JsZW0u
IEJ1dCBpdCBpcyBkaWZmaWN1bHQgdG8gdXBncmFkZSB0aGUga2VybmVsIGluIHNvbWUgcHJvZHVj
dGlvbiBlbnZpcm9ubWVudHMsIA0KYW5kIHVwZ3JhZGluZyBxZW11IGlzIGVhc3kuIFRoaXMgcGF0
Y2ggaXMganVzdCB0byBzeW5jIHFlbXUgd2l0aCBrdm0gWFNBVkUgZmVhdHVyZXMsIG5vIG5lZ2F0
aXZlIGltcGFjdC4gDQpBdCB0aGUgc2FtZSB0aW1lLCBpdCBpbmNyZWFzZXMgdGhlIGNvbXBhdGli
aWxpdHkgb2YgcWVtdSB0byBrZXJuZWwgYW5kIGltcHJvdmVzIHRoZSByb2J1c3RuZXNzIG9mIHFl
bXUuDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFBhb2xvIEJvbnpp
bmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyM+W5tDXmnIgyMOaX
pSAxOjM3DQo+IOaUtuS7tuS6ujogeXVjaGVuIChDbG91ZCkgPHl1LmNoZW5AaDNjLmNvbT4NCj4g
5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDbGVhciB4c2F2ZSBwa3J1
IGJpdCB3aGVuIEtWTQ0KPiBYQ1IwIG5vdCBzdXBwb3J0DQo+IA0KPiBPbiA1LzE4LzIzIDE0OjM3
LCBZdWNoZW4gd3JvdGU6DQo+ID4gWWVzLCBiZWNhdXNlIHg4Nl9jcHVfeHNhdmVfYWxsX2FyZWFz
KCkgY2FuIGdldCB0aGUgY29ycmVjdCBYU0FWRQ0KPiBmZWF0dXJlcy4NCj4gDQo+IElmIHlvdSB0
ZXN0ZWQgaXQsIEkgY2FuIHBvc3QgdGhlIHBhdGNoIGFzIGEgd29ya2Fyb3VuZC4gIEhvd2V2ZXIs
IHRoZQ0KPiBrZXJuZWwgYnVnIGhhcyBiZWVuIGZpeGVkIHRvby4NCj4gDQo+IFBhb2xvDQo+IA0K
PiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujogUGFvbG8gQm9uemlu
aSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPj4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0NeaciDE4
5pelIDE6MDgNCj4gPj4g5pS25Lu25Lq6OiB5dWNoZW4gKENsb3VkKSA8eXUuY2hlbkBoM2MuY29t
PjsNCj4gcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IOaKhOmAgTogcnRoQHR3aWRkbGUubmV0
OyBlaGFia29zdEByZWRoYXQuY29tOyBjaGVuZ2NoaXdlbiAoQ2xvdWQpDQo+ID4+IDxjaGVuZ2No
aXdlbkBoM2MuY29tPg0KPiA+PiDkuLvpopg6IFJlOiBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDbGVh
ciB4c2F2ZSBwa3J1IGJpdCB3aGVuIEtWTSBYQ1IwDQo+IG5vdA0KPiA+PiBzdXBwb3J0DQo+ID4+
DQo+ID4+IE9uIDUvMTcvMjMgMTI6NTUsIFl1Y2hlbiB3cm90ZToNCj4gPj4+IE1pZ3JhdGluZyBn
dWVzdCBmcm9tIEludGVsIG5ldyBDUFUgKGFzIEdvbGQgNjIzMCkgdG8gb2xkIENQVSAoYXMNCj4g
Pj4+IEU1LTI2NTAgdjQpIHdpbGwgcGF1c2Ugb24gdGhlIGRlc3RpbmF0aW9uIGhvc3QuIEJlY2F1
c2Ugb2xkIENQVSBub3QNCj4gPj4+IHN1cHBvcnQgeHNhdmUgcGtydSBmZWF0dXJlLCBhbmQgS1ZN
IEtWTV9TRVRfWFNBVkUgaW9jdGwgcmV0dXJuDQo+ID4+IEVJTlZBTC4NCj4gPj4+DQo+ID4+PiBU
aGlzIGtlcm5lbCBjb21taXQgaW50cm9kdWNlcyB0aGUgcHJvYmxlbToNCj4gPj4+DQo+ID4+PiBl
YTRkNjkzOGQ0YzAgeDg2L2ZwdTogUmVwbGFjZSBLVk1zIGhvbWUgYnJld2VkIEZQVSBjb3B5IGZy
b20NCj4gPj4gdXNlcg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFl1Q2hlbiA8eXUuY2hl
bkBoM2MuY29tPg0KPiA+Pg0KPiA+PiBXb3VsZCB0aGlzIHdvcmsgaW5zdGVhZD8NCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L3hzYXZlX2hlbHBlci5jIGIvdGFyZ2V0L2kzODYv
eHNhdmVfaGVscGVyLmMNCj4gPj4gaW5kZXggOTk2ZTlmM2JmZWY1Li5kM2U1ZWRhZDJlY2QgMTAw
NjQ0DQo+ID4+IC0tLSBhL3RhcmdldC9pMzg2L3hzYXZlX2hlbHBlci5jDQo+ID4+ICsrKyBiL3Rh
cmdldC9pMzg2L3hzYXZlX2hlbHBlci5jDQo+ID4+IEBAIC00Nyw3ICs0Nyw3IEBAIHZvaWQgeDg2
X2NwdV94c2F2ZV9hbGxfYXJlYXMoWDg2Q1BVICpjcHUsDQo+IHZvaWQNCj4gPj4gKmJ1ZiwgdWlu
dDMyX3QgYnVmbGVuKQ0KPiA+PiAgICAgICAgICAgIHN0cV9wKHhtbSArIDgsIGVudi0+eG1tX3Jl
Z3NbaV0uWk1NX1EoMSkpOw0KPiA+PiAgICAgICAgfQ0KPiA+Pg0KPiA+PiAtICAgIGhlYWRlci0+
eHN0YXRlX2J2ID0gZW52LT54c3RhdGVfYnY7DQo+ID4+ICsgICAgaGVhZGVyLT54c3RhdGVfYnYg
PSBlbnYtPnhzdGF0ZV9idiAmDQo+ID4+ICsgeDg2X2NwdV94c2F2ZV94Y3IwX2NvbXBvbmVudHMo
Y3B1KTsNCj4gPj4NCj4gPj4gICAgICAgIGUgPSAmeDg2X2V4dF9zYXZlX2FyZWFzW1hTVEFURV9Z
TU1fQklUXTsNCj4gPj4gICAgICAgIGlmIChlLT5zaXplICYmIGUtPm9mZnNldCkgew0KPiA+Pg0K
PiA+PiBQYW9sbw0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IOacrOmC
ruS7tuWPiuWFtumZhOS7tuWQq+acieaWsOWNjuS4iembhuWboueahOS/neWvhuS/oeaBr++8jOS7
hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgA0KPiDkuK3liJflh7oNCj4gPiDnmoTkuKrkurrm
iJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjl
jIXmi6zkvYbkuI3pmZDkuo7lhajpg6gNCj4g5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB
DQo+ID4g5oiW5pWj5Y+R77yJ5pys6YKu5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS2
5LqG5pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKuDQo+IOS7tumAmuefpeWPkeS7
tuS6uuW5tuWIoOmZpOacrA0KPiA+IOmCruS7tu+8gQ0KPiA+IFRoaXMgZS1tYWlsIGFuZCBpdHMg
YXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbQ0KPiA+IE5l
dyBIM0MsIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdo
b3NlIGFkZHJlc3MNCj4gPiBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0
aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55DQo+ID4gd2F5IChpbmNsdWRpbmcsIGJ1dCBub3Qg
bGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLA0KPiA+IHJlcHJvZHVjdGlv
biwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZA0K
PiA+IHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFp
bCBpbiBlcnJvciwNCj4gPiBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1h
aWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg0K

