Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03137F4912
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5oK9-0001d6-Ur; Wed, 22 Nov 2023 09:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <duchao@eswincomputing.com>)
 id 1r5iPu-0003cM-2q
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 03:17:02 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <duchao@eswincomputing.com>) id 1r5iPr-0001np-Qk
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 03:17:01 -0500
Received: from duchao$eswincomputing.com ( [112.46.135.130] ) by
 ajax-webmail-app1 (Coremail) ; Wed, 22 Nov 2023 16:15:41 +0800 (GMT+08:00)
X-Originating-IP: [112.46.135.130]
Date: Wed, 22 Nov 2023 16:15:41 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chao Du" <duchao@eswincomputing.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH] target/arm: kvm64: remove a redundant
 KVM_CAP_SET_GUEST_DEBUG probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20220420(169d3f8c)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20231025070726.22689-1-duchao@eswincomputing.com>
References: <20231025070726.22689-1-duchao@eswincomputing.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3c895935.1233.18bf6196456.Coremail.duchao@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID: TAJkCgB3Un+uuF1l5_4AAA--.786W
X-CM-SenderInfo: xgxfxt3r6h245lqf0zpsxwx03jof0z/1tbiAgEDDGVchN4ezwAGs4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: permerror client-ip=129.150.39.64;
 envelope-from=duchao@eswincomputing.com; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Nov 2023 09:35:22 -0500
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

SGksCgpLaW5kbHkgcGluZy4gOikKClRoYW5rcywKQ2hhbwoKCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlcy0tLS0tRnJvbToiQ2hhbyBEdSIgPGR1Y2hhb0Blc3dpbmNvbXB1dGluZy5jb20+U2VudCBU
aW1lOjIwMjMtMTAtMjUgMTU6MDc6MjYgKFdlZG5lc2RheSlUbzpxZW11LWRldmVsQG5vbmdudS5v
cmcsIHFlbXUtYXJtQG5vbmdudS5vcmdDYzpTdWJqZWN0OltQQVRDSF0gdGFyZ2V0L2FybToga3Zt
NjQ6IHJlbW92ZSBhIHJlZHVuZGFudCBLVk1fQ0FQX1NFVF9HVUVTVF9ERUJVRyBwcm9iZQo+IAo+
IFRoZSBLVk1fQ0FQX1NFVF9HVUVTVF9ERUJVRyBpcyBwcm9iZWQgZHVyaW5nIGt2bV9pbml0KCku
Cj4gZ2Ric2VydmVyIHdpbGwgZmFpbCB0byBzdGFydCBpZiB0aGUgQ0FQIGlzIG5vdCBzdXBwb3J0
ZWQuCj4gU28gbm8gbmVlZCB0byBtYWtlIGFub3RoZXIgcHJvYmUgaGVyZSwgbGlrZSBvdGhlciB0
YXJnZXRzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENoYW8gRHUgPGR1Y2hhb0Blc3dpbmNvbXB1dGlu
Zy5jb20+Cj4gLS0tCj4gIHRhcmdldC9hcm0va3ZtNjQuYyB8IDI4ICsrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0va3ZtNjQuYyBiL3RhcmdldC9hcm0v
a3ZtNjQuYwo+IGluZGV4IDRiYjY4NjQ2ZTQuLmIwYmY1OWI1YTEgMTAwNjQ0Cj4gLS0tIGEvdGFy
Z2V0L2FybS9rdm02NC5jCj4gKysrIGIvdGFyZ2V0L2FybS9rdm02NC5jCj4gQEAgLTMxLDEzICsz
MSw5IEBACj4gICNpbmNsdWRlICJody9hY3BpL2FjcGkuaCIKPiAgI2luY2x1ZGUgImh3L2FjcGkv
Z2hlcy5oIgo+ICAKPiAtc3RhdGljIGJvb2wgaGF2ZV9ndWVzdF9kZWJ1ZzsKPiAgCj4gIHZvaWQg
a3ZtX2FybV9pbml0X2RlYnVnKEtWTVN0YXRlICpzKQo+ICB7Cj4gLSAgICBoYXZlX2d1ZXN0X2Rl
YnVnID0ga3ZtX2NoZWNrX2V4dGVuc2lvbihzLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgS1ZNX0NBUF9TRVRfR1VFU1RfREVCVUcpOwo+IC0KPiAgICAgIG1h
eF9od193cHMgPSBrdm1fY2hlY2tfZXh0ZW5zaW9uKHMsIEtWTV9DQVBfR1VFU1RfREVCVUdfSFdf
V1BTKTsKPiAgICAgIGh3X3dhdGNocG9pbnRzID0gZ19hcnJheV9zaXplZF9uZXcodHJ1ZSwgdHJ1
ZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKEhXV2F0
Y2hwb2ludCksIG1heF9od193cHMpOwo+IEBAIC0xMTQwLDMzICsxMTM2LDIzIEBAIHN0YXRpYyBj
b25zdCB1aW50MzJfdCBicmtfaW5zbiA9IDB4ZDQyMDAwMDA7Cj4gIAo+ICBpbnQga3ZtX2FyY2hf
aW5zZXJ0X3N3X2JyZWFrcG9pbnQoQ1BVU3RhdGUgKmNzLCBzdHJ1Y3Qga3ZtX3N3X2JyZWFrcG9p
bnQgKmJwKQo+ICB7Cj4gLSAgICBpZiAoaGF2ZV9ndWVzdF9kZWJ1Zykgewo+IC0gICAgICAgIGlm
IChjcHVfbWVtb3J5X3J3X2RlYnVnKGNzLCBicC0+cGMsICh1aW50OF90ICopJmJwLT5zYXZlZF9p
bnNuLCA0LCAwKSB8fAo+IC0gICAgICAgICAgICBjcHVfbWVtb3J5X3J3X2RlYnVnKGNzLCBicC0+
cGMsICh1aW50OF90ICopJmJya19pbnNuLCA0LCAxKSkgewo+IC0gICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsKPiAtICAgICAgICB9Cj4gLSAgICAgICAgcmV0dXJuIDA7Cj4gLSAgICB9IGVsc2Ug
ewo+IC0gICAgICAgIGVycm9yX3JlcG9ydCgiZ3Vlc3QgZGVidWcgbm90IHN1cHBvcnRlZCBvbiB0
aGlzIGtlcm5lbCIpOwo+ICsgICAgaWYgKGNwdV9tZW1vcnlfcndfZGVidWcoY3MsIGJwLT5wYywg
KHVpbnQ4X3QgKikmYnAtPnNhdmVkX2luc24sIDQsIDApIHx8Cj4gKyAgICAgICAgY3B1X21lbW9y
eV9yd19kZWJ1ZyhjcywgYnAtPnBjLCAodWludDhfdCAqKSZicmtfaW5zbiwgNCwgMSkpIHsKPiAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiAgICAgIH0KPiArICAgIHJldHVybiAwOwo+ICB9Cj4g
IAo+ICBpbnQga3ZtX2FyY2hfcmVtb3ZlX3N3X2JyZWFrcG9pbnQoQ1BVU3RhdGUgKmNzLCBzdHJ1
Y3Qga3ZtX3N3X2JyZWFrcG9pbnQgKmJwKQo+ICB7Cj4gICAgICBzdGF0aWMgdWludDMyX3QgYnJr
Owo+ICAKPiAtICAgIGlmIChoYXZlX2d1ZXN0X2RlYnVnKSB7Cj4gLSAgICAgICAgaWYgKGNwdV9t
ZW1vcnlfcndfZGVidWcoY3MsIGJwLT5wYywgKHVpbnQ4X3QgKikmYnJrLCA0LCAwKSB8fAo+IC0g
ICAgICAgICAgICBicmsgIT0gYnJrX2luc24gfHwKPiAtICAgICAgICAgICAgY3B1X21lbW9yeV9y
d19kZWJ1ZyhjcywgYnAtPnBjLCAodWludDhfdCAqKSZicC0+c2F2ZWRfaW5zbiwgNCwgMSkpIHsK
PiAtICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gLSAgICAgICAgfQo+IC0gICAgICAgIHJl
dHVybiAwOwo+IC0gICAgfSBlbHNlIHsKPiAtICAgICAgICBlcnJvcl9yZXBvcnQoImd1ZXN0IGRl
YnVnIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBrZXJuZWwiKTsKPiArICAgIGlmIChjcHVfbWVtb3J5
X3J3X2RlYnVnKGNzLCBicC0+cGMsICh1aW50OF90ICopJmJyaywgNCwgMCkgfHwKPiArICAgICAg
ICBicmsgIT0gYnJrX2luc24gfHwKPiArICAgICAgICBjcHVfbWVtb3J5X3J3X2RlYnVnKGNzLCBi
cC0+cGMsICh1aW50OF90ICopJmJwLT5zYXZlZF9pbnNuLCA0LCAxKSkgewo+ICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+ICAgICAgfQo+ICsgICAgcmV0dXJuIDA7Cj4gIH0KPiAgCj4gIC8qIFNl
ZSB2OCBBUk0gQVJNIEQ3LjIuMjcgRVNSX0VMeCwgRXhjZXB0aW9uIFN5bmRyb21lIFJlZ2lzdGVy
Cj4gLS0gCj4gMi4xNy4xCg==

