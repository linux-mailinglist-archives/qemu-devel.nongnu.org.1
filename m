Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED6778715
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 07:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUL2m-00008S-6b; Fri, 11 Aug 2023 01:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qUL2c-0008Dr-7I
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 01:50:32 -0400
Received: from m1368.mail.163.com ([220.181.13.68])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qUL2X-0001x1-3k
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 01:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=sHbYF8ijOvqkMGldUWHKMSfDfvygZmNBE384tiOMJ4s=; b=l
 KM08SrfRo7EiOn6Q3jpQmvHs9FGdK+7UivJxImyQGOJxV2VkLSi7OqrgF0a1gV2Y
 jf9I7chQ0l+Z5dHao0ia+54CdjVMXilfikLfVBIIzlC5YbRyBVlWcEkyiD3Vd4HP
 NMCvaRMlpcZRl9d5m/TRhBaZltvSOgSZSkpb/eTBwk=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr68 (Coremail) ; Fri, 11 Aug 2023 13:49:52 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Fri, 11 Aug 2023 13:49:52 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "Peter Xu" <peterx@redhat.com>
Cc: "David Hildenbrand" <david@redhat.com>, qemu-devel@nongnu.org, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, 
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>
Subject: Re:Re: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening
 guest RAM file as readonly in a MAP_PRIVATE mapping
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZNVVmxuQAsSEHqZq@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
X-NTES-SC: AL_QuySA/uYvUEi5CKbYukXnk4Shuc2XMu4u/gu34JTP5E0mSrywQoHRXBiFlDfwtK1KDCBvxexWSNMxPREXbNkba7g3P4lwCAE/0pOed0VVHmc
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowACndbAAzNVk91wSAA--.21119W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/1tbiKRfInlXl6yCRGQABsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.68; envelope-from=logoerthiner1@163.com;
 helo=m1368.mail.163.com
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

QXQgMjAyMy0wOC0xMSAwNToyNDo0MywgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5jb20+IHdy
b3RlOgo+T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDE6MDY6MTJBTSArMDgwMCwgVGhpbmVyTG9n
b2VyIHdyb3RlOgo+PiA+SSB0aGluayB3ZSBoYXZlIHRoZSBmb2xsb3dpbmcgb3B0aW9ucyAodGhl
cmUgbWlnaHQgYmUgbW9yZSkKPj4gPgo+PiA+MSkgVGhpcyBwYXRjaC4KPj4gPgo+PiA+MikgTmV3
IGZsYWcgZm9yIG1lbW9yeS1iYWNrZW5kLWZpbGUuIFdlIGFscmVhZHkgaGF2ZSAicmVhZG9ubHki
IGFuZCAKPj4gPiJzaGFyZT0iLiBJJ20gaGF2aW5nIGEgaGFyZCB0aW1lIGNvbWluZyB1cCB3aXRo
IGEgZ29vZCBuYW1lIHRoYXQgcmVhbGx5IAo+PiA+ZGVzY3JpYmVzIHRoZSBzdWJ0bGUgZGlmZmVy
ZW5jZS4KPj4gPgo+PiA+MykgR2x1ZSBiZWhhdmlvciB0byB0aGUgUUVNVSBtYWNoaW5lCj4+ID4K
Pj4gCj4+IDQpICctZGVueS1wcml2YXRlLWRpc2NhcmQnIGFyZ3YsIG9yIGVudmlyb25tZW50IHZh
cmlhYmxlLCBvciBib3RoCj4KPkknZCBwZXJzb25hbGx5IHZvdGUgZm9yICgyKS4gIEhvdyBhYm91
dCAiZmRwZXJtIj8gIFRvIGRlc2NyaWJlIHdoZW4gd2Ugd2FudAo+dG8gdXNlIGRpZmZlcmVudCBy
dyBwZXJtaXNzaW9ucyBvbiB0aGUgZmlsZSAoYmVzaWRlcyB0aGUgYWNjZXNzIHBlcm1pc3Npb24K
Pm9mIHRoZSBtZW1vcnkgd2UgYWxyZWFkeSBwcm92aWRlZCB3aXRoICJyZWFkb25seSI9WFhYKS4g
IElJVUMgdGhlIG9ubHkgc2FuZQo+dmFsdWUgd2lsbCBiZSByby9ydy9kZWZhdWx0LCB3aGVyZSAi
ZGVmYXVsdCIgc2hvdWxkIGp1c3QgdXNlIHRoZSBzYW1lIHJ3Cj5wZXJtaXNzaW9uIGFzIHRoZSBt
ZW1vcnkgKCJyZWFkb25seSI9WFhYKS4KPgo+V291bGQgdGhhdCBiZSByZWxhdGl2ZWx5IGNsZWFu
IGFuZCBhbHNvIHdvcmsgaW4gdGhpcyB1c2UgY2FzZT8KPgo+KHRoZSBvdGhlciB0aGluZyBJJ2Qg
d2lzaCB3ZSBkb24ndCBoYXZlIHRoYXQgZmFsbGJhY2sgaXMsIGFzIGxvbmcgYXMgd2UKPiBoYXZl
IGFueSBvZiB0aGF0ICJmYWxsYmFjayIgd2UnbGwgbmVlZCB0byBiZSBjb21wYXRpYmxlIHdpdGgg
aXQgc2luY2UKPiB0aGVuLCBhbmQgZm9yIGV2ZXIuLi4pCgpJZiBpdCBtdXN0IGJlICgyKSwgSSB3
b3VsZCB2b3RlICgyKSArICg0KSwgd2l0aCAoNCkgYWRqdXN0IHRoZSBkZWZhdWx0IGJlaGF2aW9y
IG9mIHNhaWQgYGZkcGVybWAuCk1haW5seSBiZWNhdXNlIChwcml2YXRlK2Rpc2NhcmQpIGlzIGl0
c2VsZiBub3QgYSBnb29kIHByYWN0aWNlIGFuZCAoNCkgc2VydmVzCmFzIGEgZ29vZCB0b29sIHRv
IGhlbHAgY2F0Y2ggZXhpc3RpbmcgKHByaXZhdGUrZGlzY2FyZCkgcHJvYmxlbXMuCgpBY3R1YWxs
eSAocmVhZG9ubHkrcHJpdmF0ZSkgaXMgbW9yZSByZWFzb25hYmxlIHRoYW4gKHByaXZhdGUrZGlz
Y2FyZCksIHNvIEkKd2FudCBhdCBsZWFzdCBvbmUgcm9vbSBmb3IgYSBkZWZhdWx0IChyZWFkb25s
eStwcml2YXRlKSBiZWhhdmlvci4KCkFsc28gaW4gbXkgY2FzZSBJIGtpbmQgb2YgaGF2ZSB0byB1
c2UgIi1tZW0tcGF0aCIgZGVzcGl0ZSBpdCBiZWluZyBjb25zaWRlcmVkCnRvIGJlIGNsb3NlIHRv
IGRlcHJlY2F0ZWQuIE9ubHkgd2l0aCB0aGlzIEkgY2FuIGF2b2lkIGtub3dsZWRnZSBvZiBtZW1v
cnkKYmFja2VuZCBiZWZvcmUgbWlncmF0aW9uLiBBY3R1YWxseSB0aGVyZSBzZWVtcyB0byBiZSBu
byBlcXVpdmFsZW50IHdvcmtpbmcgYWZ0ZXItbWlncmF0aW9uCnNldHVwIG9mICItb2JqZWN0IG1l
bW9yeS1iYWNrZW5kLWZpbGUsLi4uIC1tYWNoaW5lIHEzNSxtZW09Li4uIiB0aGF0IGNhbiBtYXRj
aApiZWZvcmUtbWlncmF0aW9uIHNldHVwIG9mICItbWFjaGluZSBxMzUiIChzcGVjaWZ5aW5nIG5v
dGhpbmcpLiBUaGVyZWZvcmUKSSBtdXN0IG1ha2UgYSBwbGFuIGFuZCBjaG9vc2UgYSBtaWdyYXRp
b24gbWV0aG9kIEJFRk9SRSBJIGJvb3QgdGhlCm1hY2hpbmUgYW5kIHByZXBhcmUgdG8gbWlncmF0
ZSwgcmVkdWNpbmcgdGhlIG9wZXJhdGlvbiBmcmVlZG9tLgpDb25zaWRlcmluZyB0aGF0LCBJIGhh
dmUgdG8gdXNlICItbWVtLXBhdGgiIHdoaWNoIGtlZXBzIHRoZSBmcmVlZG9tIGJ1dApoYXMgbm8g
Y29uZmlndXJhYmxlIGFyZ3VtZW50IGFuZCBJIGhhdmUgdG8gcmVseSBvbiBkZWZhdWx0IGNvbmZp
Zy4KCkFyZSB0aGVyZSBhbnkgIi1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZS4uLiIgc2V0dXAg
ZXF1aXZhbGVudCB0byAiLW1hY2hpbmUgcTM1Igp0aGF0IGNhbiBtaWdyYXRlIGZyb20gYW5kIHRv
IGVhY2ggb3RoZXI/IElmIHRoZXJlIGlzLCBJIHdhbnQgdG8gdHJ5IGl0IG91dC4KQnkgdGhlIHdh
eSAiLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPXBjLnJhbSIgaGFzIGp1c3QgYmVlbiBr
aWxsZWQgYnkgYW4gZWFybGllcgpjb21taXQuCgpFaXRoZXIgKDQpIG9yIGZpeGluZyB0aGlzIHNo
b3VsZCBoZWxwIG15IGNvbmZpZy4gSG9wZSB5b3UgY2FuIGNvbnNpZGVyIHRoaXMKZGVlcGVyIGFu
ZCBmaWd1cmUgb3V0IGEgbW9yZSBzeXN0ZW1hdGljIHNvbHV0aW9uIHRoYXQgaGVscHMgbW9yZSB1
c2VyPwoKLS0KClJlZ2FyZHMsCmxvZ29lcnRoaW5lcg==

