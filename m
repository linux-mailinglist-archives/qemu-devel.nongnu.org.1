Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3157EACC4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:15:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2pV7-000358-Lz; Tue, 14 Nov 2023 04:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r2pV5-00034w-9c
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:14:27 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r2pUy-0003Vv-WF
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:14:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com BB1F7C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1699953256; bh=+SxEPp5QXIpHfCi5LXfi0MWzo7DV/USYqt8FGK+afNA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=m7dFyOnmayZnj445ey08tR5qMcj66JLPCO5YiBbIwk2tnq3h3qzLO6Mtek3CbjPqw
 7t4S7FLa+4EjBYooFjZP+0k/NzssThZ+sfsgB1vyatdd2gropFc8O3ELF94mQ4qKru
 ibeo9jE12ETY2ld8FcEUHx1Fe8wb5GdGYKVukkTo5ziofmqnsNrPBhShSqyCu/eNI/
 oxW1Bk4JK7imwViJOh/0rDYyi+JK0zV5W7lomYVDF3HlM4wV4ksg+tJ3ylxKqAxGY1
 zKv9HS2XxSPCUsGWNGdlcazsbhhLQDX2opwiFfo7xdeujvvRiaHK3K5Hb/FKWpDSXh
 x2FKYZY1bCh7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1699953256; bh=+SxEPp5QXIpHfCi5LXfi0MWzo7DV/USYqt8FGK+afNA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=qfpXCiCOIpZQMQ6XVaU3HswJFpV954He+4UAzjFt59Ic9Vf4PrjDP+/n8HJk6GdnL
 nr92GgUMWJVTpwzdhicC9O0h0al365g61GpW6bYV3B5FucNP3tWOUN2aKmOHg9Pz/u
 ZVnJS7M236aeze8F3TGFX7Xvt/l7W30kKanlwAzaDCUIxsnH/WX48B/uQ7AuDLb125
 zvXTenJTTJXP6EYkoI4Us/cC33fs8P8jloBfgTRNA/JXQskT9kvHXx8tCTYN0DtqsW
 XxbKmL44AsctqgjV2v8DAbNDoBqFdMigPLjEUCaCMFxyQAxuAPD9Ytb4awUw6dTkEk
 +xNfpZ+gvmAGQ==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: RE: Instruction virtual address in TCG Plugins
Thread-Topic: Instruction virtual address in TCG Plugins
Thread-Index: AdoWXsbya+HqTrueTiqiLf6nDJCNngAFWYevABh5pFA=
Date: Tue, 14 Nov 2023 09:14:15 +0000
Message-ID: <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com>
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
 <87leb1xtdx.fsf@draig.linaro.org>
In-Reply-To: <87leb1xtdx.fsf@draig.linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PiA+IFdoYXQgaXMgdGhlIHJpZ2h0IHdheSB0byBnZXQgdmlydHVhbCBhZGRyZXNzIG9mIGVpdGhl
ciB0cmFuc2xhdGlvbiBibG9jayBvciBpbnN0cnVjdGlvbiBpbnNpZGUgb2YgVENHIHBsdWdpbj8g
RG9lcw0KPiA+IHBsdWdpbiBBUEkgYWxsb3cgdGhhdCBvciBpdCBuZWVkcyBzb21lIGV4dGVuc2lv
bj8NCj4gPg0KPiA+IFNvIGZhciBJIHVzZSBxZW11X3BsdWdpbl90Yl92YWRkcigpIGluc2lkZSBv
ZiBteSBibG9jayB0cmFuc2xhdGlvbiBjYWxsYmFjayB0byBnZXQgYmxvY2sgdmlydHVhbCBhZGRy
ZXNzIGFuZCB0aGVuDQo+ID4gcGFzcyBpdCBhcyAndXNlcmRhdGEnIGFyZ3VtZW50IGludG8gcWVt
dV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV90Yl9leGVjX2NiKCkuIEkgdXNlIGl0IGxhdGVyIGR1cmlu
ZyBjb2RlIGV4ZWN1dGlvbi4NCj4gPiBJdCB3b3JrcyB3ZWxsIGZvciB1c2VyLW1vZGUgZW11bGF0
aW9uLCBidXQgc29tZXRpbWVzIGxlYWRzIHRvDQo+ID4gaW5jb3JyZWN0IGFkZHJlc3NlcyBpbiBz
eXN0ZW0tbW9kZSBlbXVsYXRpb24uDQo+IA0KPiBZb3UgY2FuIHVzZSBxZW11X3BsdWdpbl9pbnNu
X3ZhZGRyIGFuZCBxZW11X3BsdWdpbl9pbnNuX2hhZGRyLiBCdXQgeW91cg0KPiByaWdodCBzb21l
dGhpbmcgdW5kZXIgb25lIHZhZGRyIGFuZCBiZSBleGVjdXRlZCB1bmRlciBhbm90aGVyIHdpdGgN
Cj4gb3ZlcmxhcHBpbmcgbWFwcGluZ3MuIFRoZSBoYWRkciBzaG91bGQgYmUgc3RhYmxlIHRob3Vn
aCBJIHRoaW5rLg0KDQpBcyBmYXIgYXMgSSBzZWUgaGFkZHIgaXMgb2sgYW5kIGNhbiBiZSB1c2Vk
IHRvIGlkZW50aWZ5IGJsb2Nrcy4gSG93ZXZlciwgaWYgSSBoYXZlIGhhZGRyIGF0IGJsb2NrIGV4
ZWN1dGlvbiBwaGFzZSBhbmQNCkkgd2FudCB0byBrbm93IHZhZGRyLCB0aGVyZSBpcyBubyBBUEkg
dG8gZ2V0IHN1Y2ggbWFwcGluZy4gTWF5YmUgaXQgaXMgcG9zc2libGUgdG8gZXh0cmFjdCBmcm9t
IHNvZnR3YXJlIE1NVSwgYnV0IEkNCmhhdmUgbm8gY2x1ZSB3aGVyZSB0byBzdGFydCB3aXRoLg0K
DQoNCj4gPiBJIHN1c3BlY3QgaXQgaXMgYmVjYXVzZSBvZiBtZW1vcnkgbWFwcGluZ3MgYnkgZ3Vl
c3QgT1MgdGhhdCBjaGFuZ2VzIHZpcnR1YWwgYWRkcmVzc2VzIGZvciB0aGF0IGJsb2NrLg0KPiA+
DQo+ID4gSSBhbHNvIGxvb2tlZCBhdCBnZW5fZW1wdHlfdWRhdGFfY2IoKSBmdW5jdGlvbiBhbmQg
Y29uc2lkZXJlZCB0byBleHRlbmQgcGx1Z2luIEFQSSB0byBwYXNzIGEgcHJvZ3JhbSBjb3VudGVy
DQo+ID4gdmFsdWUgYXMgYWRkaXRpb25hbCBjYWxsYmFjayBhcmd1bWVudC4gSSB0aG91Z2h0IGl0
IHdvdWxkIGFsd2F5cyBnaXZlIG1lIHZhbGlkIHZpcnR1YWwgYWRkcmVzcyBvZiBhbiBpbnN0cnVj
dGlvbi4NCj4gPiBVbmZvcnR1bmF0ZWx5LCBJIGRpZG4ndCBmaW5kIGEgd2F5IHRvIGdldCB2YWx1
ZSBvZiB0aGF0IHJlZ2lzdGVyIGluIGFyY2hpdGVjdHVyZSBhZ25vc3RpYyB3YXkgKGl0IGlzICdw
YycgbWVtYmVyIGluDQo+ID4gQ1BVQXJjaFN0YXRlIHN0cnVjdHVyZSkuDQo+IA0KPiBXaGVuIHdl
IG1lcmdlIHRoZSByZWdpc3RlciBhcGkgeW91IHNob3VsZCBiZSBhYmxlIHRvIGRvIHRoYXQuIEFs
dGhvdWdoDQo+IGR1cmluZyB0ZXN0aW5nIEkgcmVhbGlzZWQgdGhhdCBQQyBhY3RlZCBmdW5ueSBj
b21wYXJlZCB0byBldmVyeXRoaW5nDQo+IGVsc2UgYmVjYXVzZSB3ZSBkb24ndCBhY3R1YWxseSB1
cGRhdGUgdGhlIHNoYWRvdyByZWdpc3RlciBldmVyeQ0KPiBpbnN0cnVjdGlvbi4NCg0KV2UgaW1w
bGVtZW50ZWQgc2ltaWxhciBBUEkgdG8gcmVhZCByZWdpc3RlcnMgKGJ5IGNvaW5jaWRlbmNlLCBJ
IHBvc3RlZCB0aGlzIHBhdGNoIGF0IHRoZSBzYW1lIHRpbWUgYXMgdGhlIEFQSSB5b3UNCm1lbnRp
b25lZCkgYW5kIEkgb2JzZXJ2ZSBzaW1pbGFyIGJlaGF2aW9yLiBBcyBmYXIgYXMgSSBzZWUsIENQ
VSBzdGF0ZSBpcyBvbmx5IHVwZGF0ZWQgaW4gYmV0d2VlbiBvZiBleGVjdXRlZCB0cmFuc2xhdGlv
bg0KYmxvY2tzLiBTd2l0Y2hpbmcgdG8gJ3NpbmdsZXN0ZXAnIG1vZGUgaGVscHMgdG8gZml4IHRo
YXQsIGJ1dCBleGVjdXRpb24gb3ZlcmhlYWQgaXMgaHVnZS4NCg0KVGhlcmUgaXMgYWxzbyBibG9j
a3MgJ2NoYWluaW5nJyBtZWNoYW5pc20gd2hpY2ggaXMgbGlrZWx5IGNvbnRyaWJ1dGVzIHRvIGNv
cnJ1cHRlZCBibG9ja3MgdmFkZHIgaW5zaWRlIG9mIGNhbGxiYWNrcy4NCk15IGd1ZXNzIGlzIHRo
YXQgJ3BjJyB2YWx1ZSBmb3IgdGhvc2UgY2hhaW5lZCBibG9ja3MgcG9pbnRzIHRvIHRoZSBmaXJz
dCBibG9jayBvZiBlbnRpcmUgY2hhaW4uIFVuZm9ydHVuYXRlbHksIEl0IGlzIHZlcnkNCmhhcmQg
dG8gZGVidWcsIGJlY2F1c2UgSSBjYW4gb25seSBzZWUgYmxvY2sgY2hhaW5zIHdoZW4gSSBydW4g
d2hvbGUgTGludXggZ3Vlc3QgT1MuIERvZXMgUWVtdSBoYXMgc21hbGwgdGVzdA0KYXBwbGljYXRp
b24gdG8gdHJpZ2dlciBsb25nIGVub3VnaCBjaGFpbiBvZiB0cmFuc2xhdGlvbiBibG9ja3M/DQoN
CkhhdmluZyB0aG9zZSBjb21wbGV4aXRpZXMgbWFrZXMgbWUgdGhpbmsgdG8gaW5qZWN0IGFwcHJv
cHJpYXRlIGNvZGUgaW50byB0cmFuc2xhdGlvbiBibG9ja3MgdG8gY29tcHV0ZSBhY3R1YWwgYmxv
Y2sNCnZhZGRyIGF0IGV4ZWN1dGlvbiBzdGFnZS4gVGhlIHByb2JsZW0gaGVyZSBpcyB0byBmaW5k
IGEgdmFyaWFibGUgd2hlcmUgSSBjYW4gbG9hZCAncGMnIGF0IHN0YXJ0IG9mIHRyYW5zbGF0aW9u
IGJsb2NrLg0K

