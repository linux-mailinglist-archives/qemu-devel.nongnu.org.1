Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B270A5EE
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 08:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FyO-0000YX-KX; Sat, 20 May 2023 02:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1q0FyK-0000YP-Lg
 for qemu-devel@nongnu.org; Sat, 20 May 2023 02:21:44 -0400
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1q0FyH-0004vk-Ps
 for qemu-devel@nongnu.org; Sat, 20 May 2023 02:21:44 -0400
Received: from mail.maildlp.com ([172.25.15.155])
 by h3cspam01-ex.h3c.com with ESMTP id 34K6LRVE020464;
 Sat, 20 May 2023 14:21:27 +0800 (GMT-8)
 (envelope-from yu.chen@h3c.com)
Received: from DAG2EX05-BASE.srv.huawei-3com.com (unknown [10.69.0.53])
 by mail.maildlp.com (Postfix) with ESMTP id E2357222E3C7;
 Sat, 20 May 2023 14:25:29 +0800 (CST)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.69.0.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 20 May 2023 14:21:27 +0800
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b])
 by DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b%10])
 with mapi id 15.01.2507.021; Sat, 20 May 2023 14:21:27 +0800
From: Yuchen <yu.chen@h3c.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gdGFyZ2V0L2kzODY6IENsZWFyIHhz?=
 =?utf-8?Q?ave_pkru_bit_when_KVM_XCR0_not_support?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDbGVhciB4c2F2ZSBwa3J1?=
 =?utf-8?Q?_bit_when_KVM_XCR0_not_support?=
Thread-Index: AdmH10nRMdIv88FeTxmtO8yhX/g2MgAx9MSAADk09OAALF7qAAAhFRMgAAoPOtA=
Date: Sat, 20 May 2023 06:21:27 +0000
Message-ID: <0530c2ed26094739baa9eed6439ac0bf@h3c.com>
References: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
 <0a734157-778b-8d33-3999-b374a68a3c39@redhat.com>
 <6c64f1b84cbf4dd1a75301fc4615f351@h3c.com>
 <e7c5d527-2461-332e-638f-38c95ff2602d@redhat.com>
 <26ad17ab26ea43d1a5ef97c0a4c8c7bd@h3c.com>
In-Reply-To: <26ad17ab26ea43d1a5ef97c0a4c8c7bd@h3c.com>
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
X-MAIL: h3cspam01-ex.h3c.com 34K6LRVE020464
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

UGFvbG8sDQpJIGRlYnVnZ2VkIGFuZCBmb3VuZCwgeDg2X2NwdV94c2F2ZV94Y3IwX2NvbXBvbmVu
dHMoKSByZXR1ZW4gMCwgYWx0aG91Z2ggaXQgY2FuIHNvbHZlIHByb2JsZW0sIGJ1dCBYQ1IwIGJp
dCAwIGFsc28gaXMgMCwgDQp0aGlzIGlzIG5vdCBjb3JyZWN0LiBCZWNhdXNlIEludGVsIG1hbnVh
bCBSZXF1aXJlbWVudHMgOiAiIFhDUjAuWDg3IChiaXQgMCk6IFRoaXMgYml0IDAgbXVzdCBiZSAx
LiBBbiBhdHRlbXB0IHRvIHdyaXRlIDAgdG8gdGhpcyBiaXQgY2F1c2VzIGEgI0dQIGV4Y2VwdGlv
bi4gIiAoMi42IEVYVEVOREVEIENPTlRST0wgUkVHSVNURVJTIChJTkNMVURJTkcgWENSMCkpLg0K
DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiB5dWNoZW4gKENsb3VkKQ0K
PiDlj5HpgIHml7bpl7Q6IDIwMjPlubQ15pyIMjDml6UgOTo1OA0KPiDmlLbku7bkuro6ICdQYW9s
byBCb256aW5pJyA8cGJvbnppbmlAcmVkaGF0LmNvbT47DQo+ICdxZW11LWRldmVsQG5vbmdudS5v
cmcnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IOaKhOmAgTogJ3J0aEB0d2lkZGxlLm5ldCcg
PHJ0aEB0d2lkZGxlLm5ldD47ICdlaGFia29zdEByZWRoYXQuY29tJw0KPiA8ZWhhYmtvc3RAcmVk
aGF0LmNvbT47ICdEb25nbGkgWmhhbmcnIDxkb25nbGkuemhhbmdAb3JhY2xlLmNvbT4NCj4g5Li7
6aKYOiDlm57lpI06IOWbnuWkjTogW1BBVENIXSB0YXJnZXQvaTM4NjogQ2xlYXIgeHNhdmUgcGty
dSBiaXQgd2hlbiBLVk0NCj4gWENSMCBub3Qgc3VwcG9ydA0KPiANCj4gUGFvbG8sIHRoYW5rcywN
Cj4gVGhlIGtlcm5lbCBwYXRjaCBjYW4gc29sdmUgdGhpcyBwcm9ibGVtLiBCdXQgaXQgaXMgZGlm
ZmljdWx0IHRvIHVwZ3JhZGUgdGhlDQo+IGtlcm5lbCBpbiBzb21lIHByb2R1Y3Rpb24gZW52aXJv
bm1lbnRzLCBhbmQgdXBncmFkaW5nIHFlbXUgaXMgZWFzeS4NCj4gVGhpcyBwYXRjaCBpcyBqdXN0
IHRvIHN5bmMgcWVtdSB3aXRoIGt2bSBYU0FWRSBmZWF0dXJlcywgbm8gbmVnYXRpdmUNCj4gaW1w
YWN0Lg0KPiBBdCB0aGUgc2FtZSB0aW1lLCBpdCBpbmNyZWFzZXMgdGhlIGNvbXBhdGliaWxpdHkg
b2YgcWVtdSB0byBrZXJuZWwgYW5kDQo+IGltcHJvdmVzIHRoZSByb2J1c3RuZXNzIG9mIHFlbXUu
DQo+IA0KPiA+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4gPiDlj5Hku7bkuro6IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+ID4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0Neac
iDIw5pelIDE6MzcNCj4gPiDmlLbku7bkuro6IHl1Y2hlbiAoQ2xvdWQpIDx5dS5jaGVuQGgzYy5j
b20+DQo+ID4g5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDbGVhciB4
c2F2ZSBwa3J1IGJpdCB3aGVuIEtWTQ0KPiA+IFhDUjAgbm90IHN1cHBvcnQNCj4gPg0KPiA+IE9u
IDUvMTgvMjMgMTQ6MzcsIFl1Y2hlbiB3cm90ZToNCj4gPiA+IFllcywgYmVjYXVzZSB4ODZfY3B1
X3hzYXZlX2FsbF9hcmVhcygpIGNhbiBnZXQgdGhlIGNvcnJlY3QgWFNBVkUNCj4gPiBmZWF0dXJl
cy4NCj4gPg0KPiA+IElmIHlvdSB0ZXN0ZWQgaXQsIEkgY2FuIHBvc3QgdGhlIHBhdGNoIGFzIGEg
d29ya2Fyb3VuZC4gIEhvd2V2ZXIsIHRoZQ0KPiA+IGtlcm5lbCBidWcgaGFzIGJlZW4gZml4ZWQg
dG9vLg0KPiA+DQo+ID4gUGFvbG8NCj4gPg0KPiA+ID4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0N
Cj4gPiA+PiDlj5Hku7bkuro6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+
ID4gPj4g5Y+R6YCB5pe26Ze0OiAyMDIz5bm0NeaciDE45pelIDE6MDgNCj4gPiA+PiDmlLbku7bk
uro6IHl1Y2hlbiAoQ2xvdWQpIDx5dS5jaGVuQGgzYy5jb20+Ow0KPiA+IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KPiA+ID4+IOaKhOmAgTogcnRoQHR3aWRkbGUubmV0OyBlaGFia29zdEByZWRoYXQu
Y29tOyBjaGVuZ2NoaXdlbg0KPiAoQ2xvdWQpDQo+ID4gPj4gPGNoZW5nY2hpd2VuQGgzYy5jb20+
DQo+ID4gPj4g5Li76aKYOiBSZTogW1BBVENIXSB0YXJnZXQvaTM4NjogQ2xlYXIgeHNhdmUgcGty
dSBiaXQgd2hlbiBLVk0gWENSMA0KPiA+IG5vdA0KPiA+ID4+IHN1cHBvcnQNCj4gPiA+Pg0KPiA+
ID4+IE9uIDUvMTcvMjMgMTI6NTUsIFl1Y2hlbiB3cm90ZToNCj4gPiA+Pj4gTWlncmF0aW5nIGd1
ZXN0IGZyb20gSW50ZWwgbmV3IENQVSAoYXMgR29sZCA2MjMwKSB0byBvbGQgQ1BVIChhcw0KPiA+
ID4+PiBFNS0yNjUwIHY0KSB3aWxsIHBhdXNlIG9uIHRoZSBkZXN0aW5hdGlvbiBob3N0LiBCZWNh
dXNlIG9sZCBDUFUNCj4gPiA+Pj4gbm90IHN1cHBvcnQgeHNhdmUgcGtydSBmZWF0dXJlLCBhbmQg
S1ZNIEtWTV9TRVRfWFNBVkUgaW9jdGwNCj4gcmV0dXJuDQo+ID4gPj4gRUlOVkFMLg0KPiA+ID4+
Pg0KPiA+ID4+PiBUaGlzIGtlcm5lbCBjb21taXQgaW50cm9kdWNlcyB0aGUgcHJvYmxlbToNCj4g
PiA+Pj4NCj4gPiA+Pj4gZWE0ZDY5MzhkNGMwIHg4Ni9mcHU6IFJlcGxhY2UgS1ZNcyBob21lIGJy
ZXdlZCBGUFUgY29weQ0KPiBmcm9tDQo+ID4gPj4gdXNlcg0KPiA+ID4+Pg0KPiA+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZdUNoZW4gPHl1LmNoZW5AaDNjLmNvbT4NCj4gPiA+Pg0KPiA+ID4+IFdvdWxk
IHRoaXMgd29yayBpbnN0ZWFkPw0KPiA+ID4+DQo+ID4gPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9p
Mzg2L3hzYXZlX2hlbHBlci5jDQo+ID4gPj4gYi90YXJnZXQvaTM4Ni94c2F2ZV9oZWxwZXIuYyBp
bmRleCA5OTZlOWYzYmZlZjUuLmQzZTVlZGFkMmVjZA0KPiA+ID4+IDEwMDY0NA0KPiA+ID4+IC0t
LSBhL3RhcmdldC9pMzg2L3hzYXZlX2hlbHBlci5jDQo+ID4gPj4gKysrIGIvdGFyZ2V0L2kzODYv
eHNhdmVfaGVscGVyLmMNCj4gPiA+PiBAQCAtNDcsNyArNDcsNyBAQCB2b2lkIHg4Nl9jcHVfeHNh
dmVfYWxsX2FyZWFzKFg4NkNQVSAqY3B1LA0KPiA+IHZvaWQNCj4gPiA+PiAqYnVmLCB1aW50MzJf
dCBidWZsZW4pDQo+ID4gPj4gICAgICAgICAgICBzdHFfcCh4bW0gKyA4LCBlbnYtPnhtbV9yZWdz
W2ldLlpNTV9RKDEpKTsNCj4gPiA+PiAgICAgICAgfQ0KPiA+ID4+DQo+ID4gPj4gLSAgICBoZWFk
ZXItPnhzdGF0ZV9idiA9IGVudi0+eHN0YXRlX2J2Ow0KPiA+ID4+ICsgICAgaGVhZGVyLT54c3Rh
dGVfYnYgPSBlbnYtPnhzdGF0ZV9idiAmDQo+ID4gPj4gKyB4ODZfY3B1X3hzYXZlX3hjcjBfY29t
cG9uZW50cyhjcHUpOw0KPiA+ID4+DQo+ID4gPj4gICAgICAgIGUgPSAmeDg2X2V4dF9zYXZlX2Fy
ZWFzW1hTVEFURV9ZTU1fQklUXTsNCj4gPiA+PiAgICAgICAgaWYgKGUtPnNpemUgJiYgZS0+b2Zm
c2V0KSB7DQo+ID4gPj4NCj4gPiA+PiBQYW9sbw0KPiA+ID4NCj4gPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gPiAtLQ0KPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiDmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInm
lrDljY7kuInpm4blm6LnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLl
nLANCj4g5Z2ADQo+ID4g5Lit5YiX5Ye6DQo+ID4gPiDnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHm
raLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDk
uo7lhagNCj4g6YOoDQo+ID4g5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CBDQo+ID4gPiDm
iJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzp
gq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJYNCj4g6YKuDQo+ID4g5Lu26YCa55+l5Y+R5Lu2
5Lq65bm25Yig6Zmk5pysDQo+ID4gPiDpgq7ku7bvvIENCj4gPiA+IFRoaXMgZS1tYWlsIGFuZCBp
dHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24NCj4gPiA+IGZy
b20gTmV3IEgzQywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRp
dHkgd2hvc2UNCj4gPiA+IGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBp
bmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluDQo+ID4gPiBpbiBhbnkgd2F5IChpbmNsdWRpbmcs
IGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbA0KPiA+ID4gZGlzY2xvc3VyZSwg
cmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4NCj4g
PiA+IHRoZSBpbnRlbmRlZA0KPiA+ID4gcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlv
dSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLA0KPiA+ID4gcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhDQoNCg==

