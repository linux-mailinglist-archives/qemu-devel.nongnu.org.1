Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB17741C1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQTo-0001KT-RY; Tue, 08 Aug 2023 13:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qTQTh-0001K3-DA
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:26:41 -0400
Received: from m1368.mail.163.com ([220.181.13.68])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qTQTc-000845-Mo
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=dwEfattEIT+YZK3kfDIf6QLX0sqUidrsfqBbypS5LVE=; b=J
 lMQuKWdGv33ailSo57/sKFkhnfg7QNAy4rLQHLH+GKg6cQqsNnx1RIqUsH/OIJoG
 blrxxE0Rw0mPaFoOrTJb4+vnH7plnHYC3iVDaS7IyvF+xr/VJ1IPtDgVDOikhRIa
 yS9PoEv+6JVD8IBQYcV5ygceA20OKtT4Xkk/UwuocA=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr68 (Coremail) ; Wed, 9 Aug 2023 01:26:17 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Wed, 9 Aug 2023 01:26:17 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, 
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>
Subject: Re:[PATCH v1 0/3] softmmu/physmem: file_ram_open() readonly
 improvements
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230807190736.572665-1-david@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
X-NTES-SC: AL_QuySA/mauk0s4SmdYOkXnk4Shuc2XMu4u/gu34JTP5E0mSrT8wwyRXBkOFTYwtKwIQOivxeeaT5NwOliYrBdT60JdfLfQddk6Vha2xCJtyPL
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <19a4115f.867a.189d62f6665.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowAAn7rC6etJkalAQAA--.7146W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBawvEnlet92VRkQACsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.68; envelope-from=logoerthiner1@163.com;
 helo=m1368.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

CkF0IDIwMjMtMDgtMDggMDM6MDc6MzEsICJEYXZpZCBIaWxkZW5icmFuZCIgPGRhdmlkQHJlZGhh
dC5jb20+IHdyb3RlOgo+UGF0Y2ggIzEgaXMgdGhlIHJlc3VsdCBvZiB0aGUgZGlzY3Vzc2lvbiBv
ZjoKPiAgICAiW1BBVENIIHYyXSBzb2Z0bW11L3BoeXNtZW06IHRyeSBvcGVuaW5nIGZpbGUgcmVh
ZG9ubHkgYmVmb3JlIGZhaWx1cmUKPiAgICAgaW4gZmlsZV9yYW1fb3BlbiIgWzFdCj4KPkluc3Rl
YWQgb2YgaGFuZGxpbmcgaXQgaW5zaWRlIGZpbGVfcmFtX29wZW4oKSwgaGFuZGxlIGl0IGluIHRo
ZSBjYWxsZXIKPmFuZCBvbmx5IGZhbGxiYWNrIHRvIHJlYWRvbmx5IGluIGEgTUFQX1BSSVZBVEUg
bWFwcGluZy4KPgo+UGF0Y2ggIzIgcmVmdXNlcyB0byBjcmVhdGUgcmVhZG9ubHkgZmlsZXMgaW5z
dGVhZCBvZiBjcmVhdGluZyBhIG5ldyBmaWxlCj5hbmQgb3BlbmluZyBpdCB3cml0YWJsZS4gUGF0
Y2ggIzMgbm8gbG9uZ2VyIHJldHVybnMKPmRpcmVjdG9yaWVzIGZyb20gZmlsZV9yYW1fb3Blbigp
LCByZXN1bHRpbmcgaW4gYSBiZXR0ZXIgZXJyb3IgbWVzc2FnZSB3aGVuCj50cnlpbmcgdG8gb3Bl
biBhIHJlYWRvbmx5IGZpbGUgYnV0IHNwZWNpZnlpbmcgYSBkaXJlY3RvcnkuCj4KPlsxXSBodHRw
czovL2xrbWwua2VybmVsLm9yZy9yLzIwMjMwNzI2MTQ1OTEyLjg4NTQ1LTEtbG9nb2VydGhpbmVy
MUAxNjMuY29tCj4KPkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgo+Q2M6
IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4KPkNjOiBJZ29yIE1hbW1lZG92IDxpbWFtbWVk
b0ByZWRoYXQuY29tPgo+Q2M6IFRoaW5lciBMb2dvZXIgPGxvZ29lcnRoaW5lcjFAMTYzLmNvbT4K
PkNjOiAiUGhpbGlwcGUgTWF0aGlldS1EYXVkqKYiIDxwaGlsbWRAbGluYXJvLm9yZz4KPgo+RGF2
aWQgSGlsZGVuYnJhbmQgKDIpOgo+ICBzb2Z0bW11L3BoeXNtZW06IGZhaWwgY3JlYXRpb24gb2Yg
bmV3IGZpbGVzIGluIGZpbGVfcmFtX29wZW4oKSB3aXRoCj4gICAgcmVhZG9ubHk9dHJ1ZQo+ICBz
b2Z0bW11L3BoeXNtZW06IG5ldmVyIHJldHVybiBkaXJlY3RvcmllcyBmcm9tIGZpbGVfcmFtX29w
ZW4oKQo+Cj5UaGluZXIgTG9nb2VyICgxKToKPiAgc29mdG1tdS9waHlzbWVtOiBmYWxsYmFjayB0
byBvcGVuaW5nIGd1ZXN0IFJBTSBmaWxlIGFzIHJlYWRvbmx5IGluIGEKPiAgICBNQVBfUFJJVkFU
RSBtYXBwaW5nCj4KPiBzb2Z0bW11L3BoeXNtZW0uYyB8IDUyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pCj4KPi0tIAo+Mi40MS4wCgpJIGhhdmUgdGVzdGVkIHRoZSBw
YXRjaCBvbiBteSBjb21waWxhdGlvbiBlbnZpcm9ubWVudC4gVGhlc2UgcGF0Y2hlcyBkb2VzIG5v
dApoYXZlIHByb2JsZW0gb24gbXkgc2V0dXAuIEdyZWF0IGpvYiBvbiBoYW5kbGluZyBtb3JlIGNh
c2VzIGFib3V0IGZpbGUKb3BlbmluZyBoZXJlIQoKLS0KClJlZ2FyZHMsCgpsb2dvZXJ0aGluZXIK


