Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A1779D38
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 07:21:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUh2Q-0006Jx-I2; Sat, 12 Aug 2023 01:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qUh2J-0006Ji-6y
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 01:19:39 -0400
Received: from m13139.mail.163.com ([220.181.13.139])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qUh2D-0007I6-Sc
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 01:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=/DWefoMZ8vdbmXHc+fe2Xy3bElFDSD7QurqY4pS2UXo=; b=V
 HlrYseyRFd6cpLw+VAQQWVe+5pFCSFN4Px9Dd2s0w+OPVgnxHstxjRkcUoJNMb4i
 w/ir+bg9v1uXOVkTROB70nRrWPTEoBgcC355C+NwgnTN5pEypyyecpzk6cDVA+WF
 GJjL+tL7nYDFILBqbg0seSVRgRN5Onq5KYdGu3cPZI=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr139 (Coremail) ; Sat, 12 Aug 2023 13:18:55 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Sat, 12 Aug 2023 13:18:55 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, 
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>
Subject: Re:Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest
 RAM file as readonly in a MAP_PRIVATE mapping
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
X-NTES-SC: AL_QuySA/SauE0o4yGaZ+kXnk4Shuc2XMu4u/gu34JTP5E0uyvD2i85X11+BlvH1+uKAC6Bkjq3ehdAyOpTR7FXfr5HviQMtagi5pIATZCRZa+i
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: i8GowACXp78_FtdkPqoBAA--.12368W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/1tbiKQrJnlXl6yzAmgABsY
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.139;
 envelope-from=logoerthiner1@163.com; helo=m13139.mail.163.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QXQgMjAyMy0wOC0xMiAwMzowMDo1NCwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6Cj5PbiAxMS4wOC4yMyAwNzo0OSwgVGhpbmVyTG9nb2VyIHdyb3RlOgo+PiBB
dCAyMDIzLTA4LTExIDA1OjI0OjQzLCAiUGV0ZXIgWHUiIDxwZXRlcnhAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+PiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCAwMTowNjoxMkFNICswODAwLCBUaGluZXJM
b2dvZXIgd3JvdGU6Cj4+Pj4+IEkgdGhpbmsgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIG9wdGlvbnMg
KHRoZXJlIG1pZ2h0IGJlIG1vcmUpCj4+Pj4+Cj4+Pj4+IDEpIFRoaXMgcGF0Y2guCj4+Pj4+Cj4+
Pj4+IDIpIE5ldyBmbGFnIGZvciBtZW1vcnktYmFja2VuZC1maWxlLiBXZSBhbHJlYWR5IGhhdmUg
InJlYWRvbmx5IiBhbmQKPj4+Pj4gInNoYXJlPSIuIEknbSBoYXZpbmcgYSBoYXJkIHRpbWUgY29t
aW5nIHVwIHdpdGggYSBnb29kIG5hbWUgdGhhdCByZWFsbHkKPj4+Pj4gZGVzY3JpYmVzIHRoZSBz
dWJ0bGUgZGlmZmVyZW5jZS4KPj4+Pj4KPj4+Pj4gMykgR2x1ZSBiZWhhdmlvciB0byB0aGUgUUVN
VSBtYWNoaW5lCj4+Pj4+Cj4+Pj4KPj4+PiA0KSAnLWRlbnktcHJpdmF0ZS1kaXNjYXJkJyBhcmd2
LCBvciBlbnZpcm9ubWVudCB2YXJpYWJsZSwgb3IgYm90aAo+Pj4KPj4+IEknZCBwZXJzb25hbGx5
IHZvdGUgZm9yICgyKS4gIEhvdyBhYm91dCAiZmRwZXJtIj8gIFRvIGRlc2NyaWJlIHdoZW4gd2Ug
d2FudAo+Pj4gdG8gdXNlIGRpZmZlcmVudCBydyBwZXJtaXNzaW9ucyBvbiB0aGUgZmlsZSAoYmVz
aWRlcyB0aGUgYWNjZXNzIHBlcm1pc3Npb24KPj4+IG9mIHRoZSBtZW1vcnkgd2UgYWxyZWFkeSBw
cm92aWRlZCB3aXRoICJyZWFkb25seSI9WFhYKS4gIElJVUMgdGhlIG9ubHkgc2FuZQo+Pj4gdmFs
dWUgd2lsbCBiZSByby9ydy9kZWZhdWx0LCB3aGVyZSAiZGVmYXVsdCIgc2hvdWxkIGp1c3QgdXNl
IHRoZSBzYW1lIHJ3Cj4+PiBwZXJtaXNzaW9uIGFzIHRoZSBtZW1vcnkgKCJyZWFkb25seSI9WFhY
KS4KPj4+Cj4+PiBXb3VsZCB0aGF0IGJlIHJlbGF0aXZlbHkgY2xlYW4gYW5kIGFsc28gd29yayBp
biB0aGlzIHVzZSBjYXNlPwo+Pj4KPj4+ICh0aGUgb3RoZXIgdGhpbmcgSSdkIHdpc2ggd2UgZG9u
J3QgaGF2ZSB0aGF0IGZhbGxiYWNrIGlzLCBhcyBsb25nIGFzIHdlCj4+PiBoYXZlIGFueSBvZiB0
aGF0ICJmYWxsYmFjayIgd2UnbGwgbmVlZCB0byBiZSBjb21wYXRpYmxlIHdpdGggaXQgc2luY2UK
Pj4+IHRoZW4sIGFuZCBmb3IgZXZlci4uLikKPj4gCj4+IElmIGl0IG11c3QgYmUgKDIpLCBJIHdv
dWxkIHZvdGUgKDIpICsgKDQpLCB3aXRoICg0KSBhZGp1c3QgdGhlIGRlZmF1bHQgYmVoYXZpb3Ig
b2Ygc2FpZCBgZmRwZXJtYC4KPj4gTWFpbmx5IGJlY2F1c2UgKHByaXZhdGUrZGlzY2FyZCkgaXMg
aXRzZWxmIG5vdCBhIGdvb2QgcHJhY3RpY2UgYW5kICg0KSBzZXJ2ZXMKPj4gYXMgYSBnb29kIHRv
b2wgdG8gaGVscCBjYXRjaCBleGlzdGluZyAocHJpdmF0ZStkaXNjYXJkKSBwcm9ibGVtcy4KPgo+
SW5zdGVhZCBvZiBmZHBlcm0sIG1heWJlIHdlIGNvdWxkIGZpbmQgYSBiZXR0ZXIgbmFtZS4KPgo+
VGhlIG1hbiBwYWdlIG9mICJvcGVuIiBzYXlzOiBUaGUgYXJndW1lbnQgZmxhZ3MgbXVzdCBpbmNs
dWRlIG9uZSBvZiB0aGUgCj5mb2xsb3dpbmcgYWNjZXNzIG1vZGVzOiBPX1JET05MWSwgT19XUk9O
TFksIG9yIE9fUkRXUi4gIFRoZXNlIHJlcXVlc3QgCj5vcGVuaW5nIHRoZSBmaWxlIHJlYWQtb25s
eSwgd3JpdGUtb25seSwgb3IgcmVhZC93cml0ZSwgcmVzcGVjdGl2ZWx5Lgo+Cj5TbyBtYXliZSBz
b21ldGhpbmcgYSBiaXQgbW9yZSBtb3V0aGZ1bCBsaWtlICJmaWxlLWFjY2Vzcy1tb2RlIiB3b3Vs
ZCBiZSAKPmJldHRlci4KCk1heWJlICJmZC1tb2RlIm9yICJvcGVuLW1vZGUiIHRvIG1ha2UgaXQg
c2hvcnRlciBhbmQgYWxzbyBub24gYW1iaWd1b3VzLgoKIm9wZW4tYWNjZXNzLW1vZGUiIGNhbiBh
bHNvIGJlIGNvbnNpZGVyZWQuCgpCdHcgbXkgY2hhdGdwdCBhZ2VudCBzdWdnZXN0ZWQgMTAgbmFt
ZXMgdG8gbWUsIGluIGNhc2UgeW91IGZlZWwgaGFyZCB0bwpkZWNpZGUgYSBuYW1lOgoKICAgIGFj
Y2Vzcy1tb2RlCiAgICBmaWxlLW1vZGUKICAgIG9wZW4tbW9kZQogICAgZmlsZS1wZXJtaXNzaW9u
CiAgICBmaWxlLWFjY2Vzcy1tb2RlIChhaGEhKQogICAgZmlsZS1hY2Nlc3MtcGVybWlzc2lvbgog
ICAgZmlsZS1pby1hY2Nlc3MtbW9kZQogICAgZmlsZS1vcGVuLXBlcm1pc3Npb24KICAgIGZpbGUt
b3BlcmF0aW9uLW1vZGUKICAgIGZpbGUtcmVhZC13cml0ZS1tb2RlCgoKPgo+V2UgY291bGQgaGF2
ZSB0aGUgb3B0aW9ucwo+KnJlYWR3cml0ZQo+KnJlYWRvbmx5Cj4qYXV0bwo+Cj5XaGVyZWJ5ICJh
dXRvIiBpcyB0aGUgZGVmYXVsdC4KCkkgbGlrZSB0aGUgImF1dG8iIGhlcmUuCgo+Cj5TcGVjaWZ5
aW5nOgo+Cj4qICJyZWFkb25seT10cnVlLGZpbGUtYWNjZXNzLW1vZGU9cmVhZHdyaXRlIiB3b3Vs
ZCBmYWlsLgo+KiAic2hhcmVkPXRydWUscmVhZG9ubHk9ZmFsc2UsZmlsZS1hY2Nlc3MtbW9kZT1y
ZWFkb25seSIgd291bGQgZmFpbC4KPiogInNoYXJlZD1mYWxzZSxyZWFkb25seT1mYWxzZSxmaWxl
LWFjY2Vzcy1tb2RlPXJlYWRvbmx5IiB3b3VsZCB3b3JrLgoKWWVhaCwgc2FuaXRpemluZyB0aGUg
YXJndW1lbnRzIGhlcmUgaXMgd2lzZS4KCj4KPkluIHRoZW9yeSwgd2UgY291bGQgYWRqdXN0IHRo
ZSBtb2RlIG9mICJhdXRvIiB3aXRoIGNvbXBhdCBtYWNoaW5lcy4gQnV0IAo+bWF5YmUgaXQgd291
bGQgYmUgc3VmZmljaWVudCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nCj4KPjEp
IHNoYXJlZD10cnVlLHJlYWRvbmx5PWZhbHNlCj4JLT4gcmVhZHdyaXRlCj4yKSBzaGFyZWQ9dHJ1
ZSxyZWFkb25seT10cnVlCj4JPiByZWFkb25seQo+Mikgc2hhcmVkPWZhbHNlLHJlYWRvbmx5PXRy
dWUKPgktPiByZWFkb25seQo+Mykgc2hhcmVkPWZhbHNlLHJlYWRvbmx5PXRydWUKPglodWdldGxi
PyAtPiByZWFkd3JpdGUKPglvdGhlcndpc2UgLT4gcmVhZG9ubHkKCkxvb2tzIGxpa2UgdGhlcmUg
aXMgc29tZSB0eXBvIGhlcmUuIEkgYXNzdW1lIGl0IHdhczoKCjEpIHNoYXJlZD10cnVlLHJlYWRv
bmx5PWZhbHNlCgktPiByZWFkd3JpdGUKMikgc2hhcmVkPXRydWUscmVhZG9ubHk9dHJ1ZQoJLT4g
cmVhZG9ubHkKMykgc2hhcmVkPWZhbHNlLHJlYWRvbmx5PXRydWUKCS0+IHJlYWRvbmx5CjQpIHNo
YXJlZD1mYWxzZSxyZWFkb25seT1mYWxzZQoJaHVnZXRsYj8gLT4gcmVhZHdyaXRlCglvdGhlcndp
c2UgLT4gcmVhZG9ubHkKCgo+UmVhc29uIGJlaW5nIHRoZSB0cmFkaXRpb25hbCB1c2FnZSBvZiBo
dWdldGxiIHdpdGggTUFQX1BSSVZBVEUgd2hlcmUgSSAKPmNhbiBzZWUgcG9zc2libGUgdXNlcnMg
d2l0aCBwb3N0Y29weS4gRnVydGhlciwgVk0gdGVtcGxhdGluZyB3aXRoIAo+aHVnZXRsYiBtaWdo
dCBub3QgYmUgdGhhdCBjb21tb24gLi4uIHVzZXJzIGNvdWxkIHN0aWxsIG1vZGlmeSB0aGUgCj5i
ZWhhdmlvciBpZiB0aGV5IHJlYWxseSBoYXZlIHRvLgo+Cj5UaGF0IHdvdWxkIG1ha2UgeW91ciB1
c2UgY2FzZSB3b3JrIGF1dG9tYXRpY2FsbHkgd2l0aCBmaWxlLWJhY2tlZCBtZW1vcnkuCgpUaGlz
IHNlZW1zIGEgZ29vZCBpZGVhLiBJIGFtIGdvb2Qgd2l0aCB0aGUgc29sdXRpb24geW91IHByb3Bv
c2VkCmhlcmUgYXMgd2VsbC4KCgotLQoKUmVnYXJkcywKCmxvZ29lcnRoaW5lcgo=

