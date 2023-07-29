Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B0767C46
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 07:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPbvc-0006kY-1O; Sat, 29 Jul 2023 00:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qPbvW-0006kM-HS
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 00:51:39 -0400
Received: from m13102.mail.163.com ([220.181.13.102])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qPbvQ-0007hx-12
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 00:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=hDQMFvO4FdfAv/+YAbIC9R2H/ofXhtdQVd4Dk1Ln8c0=; b=h
 pG6LPWmkMbYcxmufh7HKMd8xg4yWi6WLJHmHU4ncronws11Op6PUrER1x5s75Htu
 a8dQvEGT+UZxkZEFfz0Ge6RDy0GEYeZ7RT/KQBIFJItBany1kJQprVvH+TIenmY2
 qCztc9HtaBR/zGPz8nBtjORfmN61gF0NBO22se67a8=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr102 (Coremail) ; Sat, 29 Jul 2023 12:51:10 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Sat, 29 Jul 2023 12:51:10 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
Subject: Re:Re: [PATCH v2] softmmu/physmem: try opening file readonly before
 failure in file_ram_open
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
 <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
 <e908495c-252c-745c-036b-1b19778435d9@redhat.com>
 <615091df.3495.1899b089fc8.Coremail.logoerthiner1@163.com>
 <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
X-NTES-SC: AL_QuySAvqbuUos5iCaYOkXnk4Shuc2XMu4u/gu34JTP5E0kSv86zkmb0FoGWvEyt+hLDigjia3WRhfydhKUpNBQK5SS+HLdkzt9Y4sTJHY89zm
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <36da060e.fd2.1899ffc764b.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZsGowAAn6i6+msRkWvgKAA--.28750W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBoQq6nmI0ZkNm7AACs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.102;
 envelope-from=logoerthiner1@163.com; helo=m13102.mail.163.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

QXQgMjAyMy0wNy0yOCAxODo0NToyMCwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+PiBRdWljayB1bnRlc3RlZCBhdHRlbXB0IHRvIG1vdmUgcmV0cnkgaGFu
ZGxpbmcgdG8gdGhlIGNhbGxlcjoKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvc29mdG1tdS9waHlzbWVt
LmMgYi9zb2Z0bW11L3BoeXNtZW0uYwo+Pj4gaW5kZXggM2RmNzM1NDJlMS4uYzgyNmJiNzhmYyAx
MDA2NDQKPj4+IC0tLSBhL3NvZnRtbXUvcGh5c21lbS5jCj4+PiArKysgYi9zb2Z0bW11L3BoeXNt
ZW0uYwo+Pj4gQEAgLTEyODksOCArMTI4OSw3IEBAIHN0YXRpYyBpbnQ2NF90IGdldF9maWxlX2Fs
aWduKGludCBmZCkKPj4+ICAgc3RhdGljIGludCBmaWxlX3JhbV9vcGVuKGNvbnN0IGNoYXIgKnBh
dGgsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpyZWdpb25fbmFt
ZSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcmVhZG9ubHksCj4+IAo+PiBG
b3Igc29tZSByZWFzb24gdGhpcyBwcmVyZXEgcGFydCBvZiBwYXRjaCBoYXMgb25lIGFkZGl0aW9u
YWwgc3BhY2UsCj4+IHdoaWNoIGNhdXNlcyBteSBgcGF0Y2hgIHRvIHJlamVjdCB0aGUgcGF0Y2gu
IEkgaGF2ZSB0byBtYW51YWxseQo+PiBmaXggaXQgdG8gdGVzdCBsYXRlci4KPgo+WWVzLCB0byBi
ZSBleHBlY3RlZC4gUGFzdGluZyBhICJnaXQgc2hvdyIgZGlmZiBhbHdheXMgbWVzc2VzIHVwIAo+
d2hpdGVzcGFjZSBmb3IgbWUuIEl0IHdhcyBvbmx5IG1lYW50IGFzIGEgUE9DLgo+Cj4+IAo+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICBib29sICpjcmVhdGVkLAo+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICBFcnJvciAqKmVycnApCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgKmNyZWF0ZWQpCj4+PiAgIHsKPj4+ICAgICAgIGNoYXIgKmZpbGVuYW1lOwo+Pj4gICAg
ICAgY2hhciAqc2FuaXRpemVkX25hbWU7Cj4+PiBAQCAtMTMzNCwxMCArMTMzMyw3IEBAIHN0YXRp
YyBpbnQgZmlsZV9yYW1fb3Blbihjb25zdCBjaGFyICpwYXRoLAo+Pj4gICAgICAgICAgICAgICBn
X2ZyZWUoZmlsZW5hbWUpOwo+Pj4gICAgICAgICAgIH0KPj4+ICAgICAgICAgICBpZiAoZXJybm8g
IT0gRUVYSVNUICYmIGVycm5vICE9IEVJTlRSKSB7Cj4+PiAtICAgICAgICAgICAgZXJyb3Jfc2V0
Z19lcnJubyhlcnJwLCBlcnJubywKPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICJj
YW4ndCBvcGVuIGJhY2tpbmcgc3RvcmUgJXMgZm9yIGd1ZXN0IFJBTSIsCj4+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwYXRoKTsKPj4+IC0gICAgICAgICAgICByZXR1cm4gLTE7Cj4+
PiArICAgICAgICAgICAgcmV0dXJuIC1lcnJubzsKPj4+ICAgICAgICAgICB9Cj4+PiAgICAgICAg
ICAgLyoKPj4+ICAgICAgICAgICAgKiBUcnkgYWdhaW4gb24gRUlOVFIgYW5kIEVFWElTVC4gIFRo
ZSBsYXR0ZXIgaGFwcGVucyB3aGVuCj4+PiBAQCAtMTk0Niw5ICsxOTQyLDIzIEBAIFJBTUJsb2Nr
ICpxZW11X3JhbV9hbGxvY19mcm9tX2ZpbGUocmFtX2FkZHJfdCBzaXplLCBNZW1vcnlSZWdpb24g
Km1yLAo+Pj4gICAgICAgYm9vbCBjcmVhdGVkOwo+Pj4gICAgICAgUkFNQmxvY2sgKmJsb2NrOwo+
Pj4gICAKPj4+IC0gICAgZmQgPSBmaWxlX3JhbV9vcGVuKG1lbV9wYXRoLCBtZW1vcnlfcmVnaW9u
X25hbWUobXIpLCByZWFkb25seSwgJmNyZWF0ZWQsCj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICBlcnJwKTsKPj4+ICsgICAgZmQgPSBmaWxlX3JhbV9vcGVuKG1lbV9wYXRoLCBtZW1vcnlfcmVn
aW9uX25hbWUobXIpLCByZWFkb25seSwgJmNyZWF0ZWQpOwo+Pj4gKyAgICBpZiAoZmQgPT0gLUVB
Q0NFUyAmJiAhKHJhbV9mbGFncyAmIFJBTV9TSEFSRUQpICYmIHJlYWRvbmx5KSB7Cj4+IAo+PiAi
cmVhZG9ubHkiIHNob3VsZCBiZSAiIXJlYWRvbmx5IiBoZXJlPyBUaGUgcmVhZG9ubHkgdmFyaWFi
bGUgaW4gdGhpcyBmdW5jdGlvbiBpcwo+PiBhYm91dCB3aGV0aGVyIHRoZSBtYXBwaW5nIGlzIHJl
YWRvbmx5LiBJbiBvdXIgY2FzZSB0aGUgbWFwcGluZyBpcyBwcml2YXRlCj4+IHdyaXRhYmxlLCBz
byByZWFkb25seSB3aWxsIGJlIGZhbHNlLgo+Cj5ZZXMsIGluZGVlZCEKPgo+PiAKPj4gQWZ0ZXIg
bWFudWFsbHkgZml4IHRoaXMgdXAsIHRoaXMgcGF0Y2ggYWxzbyB3b3JrcyBpbiBteSBlbnZpcm9u
bWVudCwgYm90aAo+PiBmdW5jdGlvbmFsaXR5IGFuZCB0aGUgd2FybmluZy4KPj4gCj4+IE1heWJl
IHlvdSBjYW4gZGlyZWN0bHkgZm9ybWF0IHRoZSBwYXRjaCBhbmQgc3RhcnQgYSBuZXcgdGhyZWFk
IHRoZXJlPwo+Cj4KPldoYXRldmVyIHlvdSBwcmVmZXIhIElmIEkgcmVzZW5kIHRoZSBwYXRjaCwg
SSB3b3VsZCBrZWVwIHlvdSB0aGUgYXV0aG9yIAo+YW5kIG9ubHkgYWRkIG15IENvLWF1dGhvcmVk
LWJ5OiBTaWduZWQtb2ZmLWJ5Oi4KPgo+SnVzdCBsZXQgbWUga25vdy4KCkV2ZXJ5dGhpbmcgaXMg
Z29vZCBhbmQgY2xlYXIgbm93LiBJIHRoaW5rIGl0IGlzIGJldHRlciB0aGF0IHlvdSBkbyB0aGUg
cGF0Y2gKaGVyZS4gV2FpdGluZyBmb3IgdGhlIGZpbmFsIHZlcnNpb24gb2YgcGF0Y2guCgo+Cj4t
LSAKPkNoZWVycywKPgo+RGF2aWQgLyBkaGlsZGVuYgo=

