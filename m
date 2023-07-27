Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BD76577C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2nv-00016p-4E; Thu, 27 Jul 2023 11:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qP2ns-00015I-Pq
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:21:24 -0400
Received: from m1328.mail.163.com ([220.181.13.28])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qP2nl-0006ND-8a
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=yttBTVdueZWRhj4MlJl9t7TU6tV5+kp2yv+gr65b3Cc=; b=j
 CUkUqTDev0tSKIgJVq6gEHAkmpKN2KzqMgCmINam27TY6zo9aPIGij5VUTYYRfu/
 hVbTsUj/wUUDnE4ouoWUFl65jR+mo3TuivD3Idjli4iuOikCqqV4y+x4qJEXVcrJ
 3EogRlyM4lQe+fzQUR15XzIO3QUp8MlgbiG8iDeZc0=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr28 (Coremail) ; Thu, 27 Jul 2023 23:20:59 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Thu, 27 Jul 2023 23:20:59 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
Subject: Re:Re: [PATCH v2] softmmu/physmem: try opening file readonly before
 failure in file_ram_open
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
X-NTES-SC: AL_QuySAvicvkou7yeZY+kXnk4Shuc2XMu4u/gu34JTP5E0lSnK5S4YUlR9DUnu0duNFg2cmzOObiNU2N5wT5ZVeolPcCCl3O2teyCPixY5TuPP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HMGowAAHfdtci8JktCkFAA--.55562W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBoRy5nmI0ZjXhaAADsV
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.28; envelope-from=logoerthiner1@163.com;
 helo=m1328.mail.163.com
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

CkF0IDIwMjMtMDctMjcgMjE6MTg6NDQsICJEYXZpZCBIaWxkZW5icmFuZCIgPGRhdmlkQHJlZGhh
dC5jb20+IHdyb3RlOgo+T24gMjYuMDcuMjMgMTY6NTksIFRoaW5lciBMb2dvZXIgd3JvdGU6Cj4+
IFVzZXJzIG1heSBnaXZlICItbWVtLXBhdGgiIGEgcmVhZCBvbmx5IGZpbGUgYW5kIGV4cGVjdCB0
aGUgZmlsZQo+PiB0byBiZSBtYXBwZWQgcmVhZC13cml0ZSBwcml2YXRlbHkuIEFsbG93IHRoaXMg
YnV0IGdpdmUgYSB3YXJuaW5nCj4+IHNpbmNlIG90aGVyIHVzZXJzIG1heSBzdXJwcmlzZSB3aGVu
IHRoZSByYW0gZmlsZSBpcyByZWFkb25seSBhbmQKPj4gcWVtdSBzdWRkZW5seSBhYm9ydHMgZWxz
ZXdoZXJlLgo+PiAKPj4gU3VnZ2VzdGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogVGhpbmVyIExvZ29lciA8bG9nb2VydGhpbmVyMUAx
NjMuY29tPgo+PiAtLS0KPj4gCj4+IFNlZSB0aGUgcHJldmlvdXMgdmVyc2lvbiBhdDoKPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC85NmE0NjJlYy02ZjlkLWZkODMtZjY5Ny03
M2UxMzI0MzJjYTRAcmVkaGF0LmNvbS9ULwo+PiAKPj4gdmVyaWZpZWQsIHRoaXMgcGF0Y2ggd29y
a3MgZm9yIG15IHNldHVwLCBib3RoIGZ1bmN0aW9uYWxpdHkgYW5kIHRoZSB3YXJuaW5nCj4+IGFy
ZSBleHBlY3RlZCBiZWhhdmlvci4KPj4gCj4+IEFsc28gYW5vdGhlciBwcm9ibGVtIHdoZW4gSSBs
b29rIGF0IHRoZSBmaWxlX3JhbV9vcGVuCj4+IAo+PiBXaGVuIHJlYWRvbmx5IGlzIHRydWUgYW5k
IHRoZSBwYXRoIGlzIGEgZGlyZWN0b3J5LCB0aGUgb3BlbiB3aWxsIHN1Y2NlZWQgYnV0Cj4+IGFu
eSBsYXRlciBvcGVyYXRpb25zIHdpbGwgZmFpbCBzaW5jZSBpdCBpcyBhIGRpcmVjdG9yeSBmZC4g
VGhpcyBtYXkgcmVxdWlyZQo+PiBhZGRpdGlvbmFsIGNvbW1pdHMgd2hpY2ggaXMgb3V0IG9mIG15
IHNjb3BlLiBNZXJlbHkgcmVjb3JkIHRoZSBxdWVzdGlvbiBoZXJlLgoKTWF5YmUgeW91IGNhbiBu
b3RpY2UgdGhpcyBlZGdlIGNhc2U/IEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzCmNhc2UgaXMg
b24geW91ciB0b2RvIGxpc3Q/Cgo+PiAKPj4gICBzb2Z0bW11L3BoeXNtZW0uYyB8IDE0ICsrKysr
KysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKPj4gCj4+IGRp
ZmYgLS1naXQgYS9zb2Z0bW11L3BoeXNtZW0uYyBiL3NvZnRtbXUvcGh5c21lbS5jCj4+IGluZGV4
IDNkZjczNTQyZTEuLmU4Mjc5ZDY5ZDQgMTAwNjQ0Cj4+IC0tLSBhL3NvZnRtbXUvcGh5c21lbS5j
Cj4+ICsrKyBiL3NvZnRtbXUvcGh5c21lbS5jCj4+IEBAIC0xMjk2LDYgKzEyOTYsNyBAQCBzdGF0
aWMgaW50IGZpbGVfcmFtX29wZW4oY29uc3QgY2hhciAqcGF0aCwKPj4gICAgICAgY2hhciAqc2Fu
aXRpemVkX25hbWU7Cj4+ICAgICAgIGNoYXIgKmM7Cj4+ICAgICAgIGludCBmZCA9IC0xOwo+PiAr
ICAgIGJvb2wgZmlyc3RfdHJpYWwgPSB0cnVlOwo+PiAgIAo+PiAgICAgICAqY3JlYXRlZCA9IGZh
bHNlOwo+PiAgICAgICBmb3IgKDs7KSB7Cj4+IEBAIC0xMzMyLDYgKzEzMzMsMTggQEAgc3RhdGlj
IGludCBmaWxlX3JhbV9vcGVuKGNvbnN0IGNoYXIgKnBhdGgsCj4+ICAgICAgICAgICAgICAgICAg
IGJyZWFrOwo+PiAgICAgICAgICAgICAgIH0KPj4gICAgICAgICAgICAgICBnX2ZyZWUoZmlsZW5h
bWUpOwo+PiArICAgICAgICB9IGVsc2UgaWYgKGZpcnN0X3RyaWFsICYmICFyZWFkb25seSAmJiBl
cnJubyA9PSBFQUNDRVMpIHsKPgo+SSBndWVzcyBpdCdzIGJldHRlciB0byBvbmx5IHJldHJ5IG9u
IHByaXZhdGUgbWFwcGluZ3MsIGZvciBzaGFyZWQgCj5tYXBwaW5ncyB0aGF0IGNhbm5vdCBwb3Nz
aWJseSB3b3JrLgoKSSBmZWVsIHRoYXQgdGhlIHJldHJ5IGNhbiBiZSBhcHBsaWVkIGluIGdlbmVy
YWwgLSBmb3Igc2hhcmVkIG1hcHBpbmdzLAppdCB3aWxsIG1lcmVseSBmYWlsIG9uIHRoZSBtbWFw
IHN0ZXAgYW5kIHNob3VsZCBiZSBvaz8KClRob3VnaCwgdG8gcmV0cnkgb25seSBvbiBwcml2YXRl
IG1hcHBpbmcgc2VlbXMgc3RyYWlnaHRmb3J3YXJkcyAtCnRoaXMgZnVuY3Rpb24gaXMgY2FsbGVk
IG9ubHkgb25jZSwgYW5kIHdoZXRoZXIgdGhlIG1hcHBpbmcgaXMgcHJpdmF0ZQpjYW4gYmUgcGFz
c2VkIGhlcmUgd2l0aCBhIGJvb2xlYW4gZmxhZyBhcyBhcmd1bWVudC4gTm9uZXRoZWxlc3MKaXQg
bWF5IG1ha2UgdGhlIGxvZ2ljIG9mIHRoZSBmdW5jdGlvbiBtb3JlIGNvbXBsZXggYW5kIGxlc3Mg
aW50dWl0aXZlLgoKLS0tCgpSZWdhcmRzLAoKbG9nb2VydGhpbmVy

