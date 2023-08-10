Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0A777E65
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8du-0005kW-Po; Thu, 10 Aug 2023 12:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qU8ds-0005kH-J9
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:08 -0400
Received: from m131.mail.163.com ([220.181.13.1])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qU8dn-0007TH-5u
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=6bqZ1umCd14tFfZvuy68ZVfMis45CD++Y4vWiW5M4xA=; b=f
 VFh60rDWOg9eIsC7PqdYhIkkabc74mKvPgf89kH1j55k+VR1chaqCm1fzf2y9F9T
 VRp6sfZdb/kwtpjIMeX3H0QoqtHZES0CzdEhhlEePG7ooO7uoxMGExxNQSMfn5uy
 W60QKb4XthE0UKT0O6QciIg/4fXYRA2WghpH2zMkTI=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr1 (Coremail) ; Fri, 11 Aug 2023 00:35:26 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Fri, 11 Aug 2023 00:35:26 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: "David Hildenbrand" <david@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>
Subject: Re:Re: [PATCH v1 0/3] softmmu/physmem: file_ram_open() readonly
 improvements
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <f7774c34-64eb-893c-5533-d0746d10eedd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <19a4115f.867a.189d62f6665.Coremail.logoerthiner1@163.com>
 <f7774c34-64eb-893c-5533-d0746d10eedd@linaro.org>
X-NTES-SC: AL_QuySA/qTuksp4COeZukXnk4Shuc2XMu4u/gu34JTP5E0tCno/Sowe3lHJXHx4PCSOwORth69TCRCweteQYxyYLI82876uLgiPLYo8IUNwEgd
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4a01dbe4.6a11.189e04d8e1e.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcGowABnbzvOEdVkkZcAAA--.5993W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBawzHnlet94nj2QACsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.1; envelope-from=logoerthiner1@163.com;
 helo=m131.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

QXQgMjAyMy0wOC0xMCAxOToxMTowMywgIlBoaWxpcHBlIE1hdGhpZXUtRGF1ZKimIiA8cGhpbG1k
QGxpbmFyby5vcmc+IHdyb3RlOgo+SGksCj4KPk9uIDgvOC8yMyAxOToyNiwgVGhpbmVyTG9nb2Vy
IHdyb3RlOgo+PiAKPj4gQXQgMjAyMy0wOC0wOCAwMzowNzozMSwgIkRhdmlkIEhpbGRlbmJyYW5k
IiA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4+IEluc3RlYWQgb2YgaGFuZGxpbmcgaXQg
aW5zaWRlIGZpbGVfcmFtX29wZW4oKSwgaGFuZGxlIGl0IGluIHRoZSBjYWxsZXIKPj4+IGFuZCBv
bmx5IGZhbGxiYWNrIHRvIHJlYWRvbmx5IGluIGEgTUFQX1BSSVZBVEUgbWFwcGluZy4KPgo+PiBJ
IGhhdmUgdGVzdGVkIHRoZSBwYXRjaCBvbiBteSBjb21waWxhdGlvbiBlbnZpcm9ubWVudC4gVGhl
c2UgcGF0Y2hlcyBkb2VzIG5vdAo+PiBoYXZlIHByb2JsZW0gb24gbXkgc2V0dXAuIEdyZWF0IGpv
YiBvbiBoYW5kbGluZyBtb3JlIGNhc2VzIGFib3V0IGZpbGUKPj4gb3BlbmluZyBoZXJlIQo+Cj5E
b2VzIHRoYXQgbWVhbiB3ZSBjYW4gYWRkIHlvdXIgdGFnIG9uIHRoaXMgc2VyaWVzPwo+Cj5UZXN0
ZWQtYnk6IFRoaW5lciBMb2dvZXIgPGxvZ29lcnRoaW5lcjFAMTYzLmNvbT4KClRoaXMgdGFnIGlz
IE9LLCBkZXNwaXRlIHRoYXQgSSBoaWdobHkgc3VzcGVjdCB3aGV0aGVyIG15IHRlc3RpbmcgaXMg
c3VmZmljaWVudC4KTXkgdGVzdGluZyBpcyB2ZXJ5IHJvdWdoIGFuZCBvbmx5IGZvY3VzIG9uIHRo
ZSBmdW5jdGlvbmFsaXRpZXMgSSBjYXJlIGFib3V0LgpJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2
ZSBhIG1vcmUgcHJvZmVzc2lvbmFsIHRlc3Rlci4KCi0tCgpSZWdhcmRzLAoKbG9nb2VydGhpbmVy


