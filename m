Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D59829902
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWj7-0006Lk-D0; Wed, 10 Jan 2024 06:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1rNWj0-0006KZ-QJ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:26:23 -0500
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1rNWiw-0003uA-24
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:26:22 -0500
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com"
 <mtosatti@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] kvm: limit the maximum CPUID.0xA.edx[0..4] to 3
Thread-Topic: [PATCH] kvm: limit the maximum CPUID.0xA.edx[0..4] to 3
Thread-Index: AQHZlSVPiltb1wEK5Ue4tpzTEkfwMrDTqtuAgACacYA=
Date: Wed, 10 Jan 2024 11:26:03 +0000
Message-ID: <35A93E08-3407-4815-A574-56BC5AFD0805@baidu.com>
References: <20230602073857.96790-1-gaoshiyuan@baidu.com>
 <20240110101317.46344-1-gaoshiyuan@baidu.com>
In-Reply-To: <20240110101317.46344-1-gaoshiyuan@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.140]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F0368F29CB0274C8CB81DAB78E803FB@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.58
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.202.115.85; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

PiBBbnlvbmUgaGFzIHN1Z2dlc3Rpb24/DQo+DQo+IFdoZW4gdGhlIGhvc3Qga2VybmVsIGJlZm9y
ZSB0aGlzIGNvbW1pdCAyZThjZDdhM2I4MjggKCJrdm06IHg4NjogbGltaXQgdGhlIG1heGltdW0g
bnVtYmVyIG9mIHZQTVUNCj4gZml4ZWQgY291bnRlcnMgdG8gMyIpIG9uIGljZWxha2UgbWljcm9h
cmNoaXRlY3R1cmUgYW5kIG5ld2VyLCBleGVjdXRlIGNwdWlkIGluIHRoZSBHdWVzdDoNCj4NCj4g
QXJjaGl0ZWN0dXJlIFBlcmZvcm1hbmNlIE1vbml0b3JpbmcgRmVhdHVyZXMgKDB4YS9lZHgpOg0K
PiAgICAgbnVtYmVyIG9mIGZpeGVkIGNvdW50ZXJzICAgID0gMHg0ICg0KQ0KPg0KPiBUaGlzIGlz
IG5vdCBpbmNvbnNpc3RlbnQgd2l0aCBudW1fYXJjaGl0ZWN0dXJhbF9wbXVfZml4ZWRfY291bnRl
cnMgaW4gUUVNVS4NCg0KVGhpcyBpcyB0aGUgb3JnaW5hbCBwYXRjaC4NCg0Ka3ZtOiBsaW1pdCB0
aGUgbWF4aW11bSBDUFVJRC4weEEuZWR4WzAuLjRdIHRvIDMNCg0KTm93LCB0aGUgQ1BVSUQuMHhB
IGRlcGVuZHMgb24gdGhlIEtWTSByZXBvcnQuIFRoZSB2YWx1ZSBvZiBDUFVJRC4weEEuZWR4WzAu
LjRdDQphbmQgbnVtX2FyY2hpdGVjdHVyYWxfcG11X2ZpeGVkX2NvdW50ZXJzIGFyZSBpbmNvbnNp
c3RlbnQgd2hlbiB0aGUgaG9zdCBrZXJuZWwNCmJlZm9yZSB0aGlzIGNvbW1pdCAyZThjZDdhM2I4
MjggKCJrdm06IHg4NjogbGltaXQgdGhlIG1heGltdW0gbnVtYmVyIG9mIHZQTVUNCmZpeGVkIGNv
dW50ZXJzIHRvIDMiKSBvbiBpY2VsYWtlIG1pY3JvYXJjaGl0ZWN0dXJlLg0KDQpUaGlzIGFsc28g
YnJlYWsgdGhlIGxpdmUtbWlncmF0aW9uIGJldHdlZW4gc291cmNlIGhvc3Qga2VybmVsIGJlZm9y
ZSBjb21taXQNCjJlOGNkN2EzYjgyOCBhbmQgZGVzdCBob3N0IGtlcm5lbCBhZnRlciB0aGUgY29t
bWl0IG9uIGljZWxha2UgbWljcm9hcmNoaXRlY3R1cmUuDQoNClNpZ25lZC1vZmYtYnk6IFNoaXl1
YW4gR2FvIDxnYW9zaGl5dWFuQGJhaWR1LmNvbT4NCi0tLQ0KIHRhcmdldC9pMzg2L2t2bS9rdm0u
YyB8IDEzICsrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2t2bS9rdm0uYyBiL3Rh
cmdldC9pMzg2L2t2bS9rdm0uYw0KaW5kZXggZGU1MzE4NDJmNi4uZTc3MTI5YjczNyAxMDA2NDQN
Ci0tLSBhL3RhcmdldC9pMzg2L2t2bS9rdm0uYw0KKysrIGIvdGFyZ2V0L2kzODYva3ZtL2t2bS5j
DQpAQCAtMTc2MSw3ICsxNzYxLDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVTdGF0ZSAq
Y3MpDQoNCiAgICAgWDg2Q1BVICpjcHUgPSBYODZfQ1BVKGNzKTsNCiAgICAgQ1BVWDg2U3RhdGUg
KmVudiA9ICZjcHUtPmVudjsNCi0gICAgdWludDMyX3QgbGltaXQsIGksIGosIGNwdWlkX2k7DQor
ICAgIHVpbnQzMl90IGxpbWl0LCBpLCBqLCBjcHVpZF9pLCBjcHVpZF8weGE7DQogICAgIHVpbnQz
Ml90IHVudXNlZDsNCiAgICAgc3RydWN0IGt2bV9jcHVpZF9lbnRyeTIgKmM7DQogICAgIHVpbnQz
Ml90IHNpZ25hdHVyZVszXTsNCkBAIC0xNzczLDYgKzE3NzMsNyBAQCBpbnQga3ZtX2FyY2hfaW5p
dF92Y3B1KENQVVN0YXRlICpjcykNCiAgICAgbWVtc2V0KCZjcHVpZF9kYXRhLCAwLCBzaXplb2Yo
Y3B1aWRfZGF0YSkpOw0KDQogICAgIGNwdWlkX2kgPSAwOw0KKyAgICBjcHVpZF8weGEgPSAwOw0K
DQogICAgIGhhc194c2F2ZTIgPSBrdm1fY2hlY2tfZXh0ZW5zaW9uKGNzLT5rdm1fc3RhdGUsIEtW
TV9DQVBfWFNBVkUyKTsNCg0KQEAgLTIwNDUsNiArMjA0Niw5IEBAIGludCBrdm1fYXJjaF9pbml0
X3ZjcHUoQ1BVU3RhdGUgKmNzKQ0KICAgICAgICAgICAgIGMtPmZ1bmN0aW9uID0gaTsNCiAgICAg
ICAgICAgICBjLT5mbGFncyA9IDA7DQogICAgICAgICAgICAgY3B1X3g4Nl9jcHVpZChlbnYsIGks
IDAsICZjLT5lYXgsICZjLT5lYngsICZjLT5lY3gsICZjLT5lZHgpOw0KKyAgICAgICAgICAgIGlm
ICgweDBhID09IGkpIHsNCisgICAgICAgICAgICAgICAgY3B1aWRfMHhhID0gY3B1aWRfaSAtIDE7
DQorICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIGlmICghYy0+ZWF4ICYmICFjLT5lYnggJiYg
IWMtPmVjeCAmJiAhYy0+ZWR4KSB7DQogICAgICAgICAgICAgICAgIC8qDQogICAgICAgICAgICAg
ICAgICAqIEtWTSBhbHJlYWR5IHJldHVybnMgYWxsIHplcm9lcyBpZiBhIENQVUlEIGVudHJ5IGlz
IG1pc3NpbmcsDQpAQCAtMjA1OSw3ICsyMDYzLDExIEBAIGludCBrdm1fYXJjaF9pbml0X3ZjcHUo
Q1BVU3RhdGUgKmNzKQ0KICAgICBpZiAobGltaXQgPj0gMHgwYSkgew0KICAgICAgICAgdWludDMy
X3QgZWF4LCBlZHg7DQoNCi0gICAgICAgIGNwdV94ODZfY3B1aWQoZW52LCAweDBhLCAwLCAmZWF4
LCAmdW51c2VkLCAmdW51c2VkLCAmZWR4KTsNCisgICAgICAgIGFzc2VydChjcHVpZF8weGEgPj0g
MHgwYSk7DQorDQorICAgICAgICBjID0gJmNwdWlkX2RhdGEuZW50cmllc1tjcHVpZF8weGFdOw0K
KyAgICAgICAgZWF4ID0gYy0+ZWF4Ow0KKyAgICAgICAgZWR4ID0gYy0+ZWR4Ow0KDQogICAgICAg
ICBoYXNfYXJjaGl0ZWN0dXJhbF9wbXVfdmVyc2lvbiA9IGVheCAmIDB4ZmY7DQogICAgICAgICBp
ZiAoaGFzX2FyY2hpdGVjdHVyYWxfcG11X3ZlcnNpb24gPiAwKSB7DQpAQCAtMjA3OCw2ICsyMDg2
LDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVTdGF0ZSAqY3MpDQoNCiAgICAgICAgICAg
ICAgICAgaWYgKG51bV9hcmNoaXRlY3R1cmFsX3BtdV9maXhlZF9jb3VudGVycyA+IE1BWF9GSVhF
RF9DT1VOVEVSUykgew0KICAgICAgICAgICAgICAgICAgICAgbnVtX2FyY2hpdGVjdHVyYWxfcG11
X2ZpeGVkX2NvdW50ZXJzID0gTUFYX0ZJWEVEX0NPVU5URVJTOw0KKyAgICAgICAgICAgICAgICAg
ICAgYy0+ZWR4ID0gKGVkeCAmIH4weDFmKSB8IG51bV9hcmNoaXRlY3R1cmFsX3BtdV9maXhlZF9j
b3VudGVyczsNCiAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIH0NCiAgICAgICAgIH0N
Cg0K

