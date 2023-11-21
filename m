Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414057F3401
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 17:40:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Tmj-0001sh-Hu; Tue, 21 Nov 2023 11:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5Tmh-0001sT-0y
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:39:35 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5Tmc-0004PR-UL
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 11:39:33 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com EB0DCC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1700584766; bh=GksfeuwZ6O2l1HeLGqbjonNHhEt81RYtwSUjpVF4P38=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=Tj9QEIF5Z5OZiECnKKzRw1wcDe98c7J1PbNviZew1AlYhbNa9fmQUr+ZrHiKrl8i7
 EEQBq1ZZOeDsvcmj2+Qiqrwjbarr4udbJx4YlE0FIRD1pXR5MXbI5oe2V521WrVWt1
 ISnIqPcw6tKq3DWNvyc+mvf37zbE6KeGBIG+6yzvJOom/2zpZQwLm6G5PyZ39n8t5d
 hfHrH0GP7k4hXQl0QHMyDipbnaZcOg6OajzJYlnPDzS9YTuxsGiSU1gVxX9oUWZrg8
 YgPFalQVJ2+XGMwzigzJk6uq9rf/vCiAn0DPAy97ZB+d0czjOll5Uea0yyCYhX/fan
 oOHpsP/iCnIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1700584766; bh=GksfeuwZ6O2l1HeLGqbjonNHhEt81RYtwSUjpVF4P38=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=byFhtMvA2eDKKmhWXCar232JB20Nos5csRv5UEmo1adQR4INFHphTAtwPExcwDSru
 LDU1/OcDYfFZgkPhaZXZrmHehfRqacn7kDJOkFO77BKa4DACI1KAHVCKd00MiwGPdj
 A4E3y5QV2xIZr63ontQGEZXf2oqdPJ9QtLKPuMq1uUbX/4c50vyF8F6GoKWzaj7lS2
 MYrYEWHQE5pxG+iuLU6kBFPY/CBIdZioq+cxFxpS+gJ6HABiPNAk8hQ6V03TsQ7afO
 HhfKoMlVHZQ+4wDfcvGOSZjLfwISVIKJw/2bA47GaHeDzNHNkFPrLmqEdT73SbhLrj
 /Sja6QPSMwBtQ==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: RE: Instruction virtual address in TCG Plugins
Thread-Topic: Instruction virtual address in TCG Plugins
Thread-Index: AdoWXsbya+HqTrueTiqiLf6nDJCNngAFWYevABh5pFAABM9ShQFrwMgg
Date: Tue, 21 Nov 2023 16:39:25 +0000
Message-ID: <f79fe2c0d7e5457ca7172862e96fd886@yadro.com>
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
 <87leb1xtdx.fsf@draig.linaro.org>
 <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com>
 <874jhoy54t.fsf@draig.linaro.org>
In-Reply-To: <874jhoy54t.fsf@draig.linaro.org>
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

PiA+PiA+IEkgc3VzcGVjdCBpdCBpcyBiZWNhdXNlIG9mIG1lbW9yeSBtYXBwaW5ncyBieSBndWVz
dCBPUyB0aGF0IGNoYW5nZXMgdmlydHVhbCBhZGRyZXNzZXMgZm9yIHRoYXQgYmxvY2suDQo+ID4+
ID4NCj4gPj4gPiBJIGFsc28gbG9va2VkIGF0IGdlbl9lbXB0eV91ZGF0YV9jYigpIGZ1bmN0aW9u
IGFuZCBjb25zaWRlcmVkIHRvIGV4dGVuZCBwbHVnaW4gQVBJIHRvIHBhc3MgYSBwcm9ncmFtIGNv
dW50ZXINCj4gPj4gPiB2YWx1ZSBhcyBhZGRpdGlvbmFsIGNhbGxiYWNrIGFyZ3VtZW50LiBJIHRo
b3VnaHQgaXQgd291bGQgYWx3YXlzIGdpdmUgbWUgdmFsaWQgdmlydHVhbCBhZGRyZXNzIG9mIGFu
IGluc3RydWN0aW9uLg0KPiA+PiA+IFVuZm9ydHVuYXRlbHksIEkgZGlkbid0IGZpbmQgYSB3YXkg
dG8gZ2V0IHZhbHVlIG9mIHRoYXQgcmVnaXN0ZXIgaW4gYXJjaGl0ZWN0dXJlIGFnbm9zdGljIHdh
eSAoaXQgaXMgJ3BjJyBtZW1iZXIgaW4NCj4gPj4gPiBDUFVBcmNoU3RhdGUgc3RydWN0dXJlKS4N
Cj4gPj4NCj4gPj4gV2hlbiB3ZSBtZXJnZSB0aGUgcmVnaXN0ZXIgYXBpIHlvdSBzaG91bGQgYmUg
YWJsZSB0byBkbyB0aGF0LiBBbHRob3VnaA0KPiA+PiBkdXJpbmcgdGVzdGluZyBJIHJlYWxpc2Vk
IHRoYXQgUEMgYWN0ZWQgZnVubnkgY29tcGFyZWQgdG8gZXZlcnl0aGluZw0KPiA+PiBlbHNlIGJl
Y2F1c2Ugd2UgZG9uJ3QgYWN0dWFsbHkgdXBkYXRlIHRoZSBzaGFkb3cgcmVnaXN0ZXIgZXZlcnkN
Cj4gPj4gaW5zdHJ1Y3Rpb24uDQo+ID4NCj4gPiBXZSBpbXBsZW1lbnRlZCBzaW1pbGFyIEFQSSB0
byByZWFkIHJlZ2lzdGVycyAoYnkgY29pbmNpZGVuY2UsIEkgcG9zdGVkIHRoaXMgcGF0Y2ggYXQg
dGhlIHNhbWUgdGltZSBhcyB0aGUgQVBJIHlvdQ0KPiA+IG1lbnRpb25lZCkgYW5kIEkgb2JzZXJ2
ZSBzaW1pbGFyIGJlaGF2aW9yLiBBcyBmYXIgYXMgSSBzZWUsIENQVSBzdGF0ZSBpcyBvbmx5IHVw
ZGF0ZWQgaW4gYmV0d2VlbiBvZiBleGVjdXRlZCB0cmFuc2xhdGlvbg0KPiA+IGJsb2Nrcy4gU3dp
dGNoaW5nIHRvICdzaW5nbGVzdGVwJyBtb2RlIGhlbHBzIHRvIGZpeCB0aGF0LCBidXQgZXhlY3V0
aW9uIG92ZXJoZWFkIGlzIGh1Z2UuDQo+ID4NCj4gPiBUaGVyZSBpcyBhbHNvIGJsb2NrcyAnY2hh
aW5pbmcnIG1lY2hhbmlzbSB3aGljaCBpcyBsaWtlbHkgY29udHJpYnV0ZXMgdG8gY29ycnVwdGVk
IGJsb2NrcyB2YWRkciBpbnNpZGUgb2YgY2FsbGJhY2tzLg0KPiA+IE15IGd1ZXNzIGlzIHRoYXQg
J3BjJyB2YWx1ZSBmb3IgdGhvc2UgY2hhaW5lZCBibG9ja3MgcG9pbnRzIHRvIHRoZSBmaXJzdCBi
bG9jayBvZiBlbnRpcmUgY2hhaW4uIFVuZm9ydHVuYXRlbHksIEl0IGlzIHZlcnkNCj4gPiBoYXJk
IHRvIGRlYnVnLCBiZWNhdXNlIEkgY2FuIG9ubHkgc2VlIGJsb2NrIGNoYWlucyB3aGVuIEkgcnVu
IHdob2xlIExpbnV4IGd1ZXN0IE9TLiBEb2VzIFFlbXUgaGFzIHNtYWxsIHRlc3QNCj4gPiBhcHBs
aWNhdGlvbiB0byB0cmlnZ2VyIGxvbmcgZW5vdWdoIGNoYWluIG9mIHRyYW5zbGF0aW9uIGJsb2Nr
cz8NCj4gDQo+IE5vIGFsbCByZWdpc3RlcnMgc2hvdWxkIGJlIHJlc29sdmVkIGJ5IHRoZSBlbmQg
b2YgYW55IGJsb2NrLiBUaGVyZSBpcw0KPiBjdXJyZW50bHkgbm8gb3B0aW1pc2F0aW9uIG9mIHJl
Z2lzdGVyIHVzYWdlIGJldHdlZW4gVEJzLiBJZiB5b3UgYXJlDQo+IHNlZWluZyBQQyBjb3JydXB0
aW9uIHRoYXQgd291bGQgYmUgYSBidWcgLSBidXQgZnVuZGFtZW50YWxseSB0aGluZ3MNCj4gd291
bGQgYnJlYWsgcHJldHR5IHF1aWNrIGlmIHRiX2xvb2t1cCgpIGFuZCBmcmllbmRzIGRpZG4ndCBo
YXZlIGFuDQo+IGFjY3VyYXRlIFBDLg0KDQpJIG1hbmFnZWQgdG8gcm9vdCBjYXVzZSBzb3VyY2Ug
b2YgY29ycnVwdGVkIGFkZHJlc3NlcyBpbiBwbHVnaW4gY2FsbGJhY2tzLg0KVGhlcmUgd2VyZSBi
YXNpY2FsbHkgMiBwcm9ibGVtczoNCg0KMS4gTWVtb3J5IElPIG9wZXJhdGlvbnMgZm9yY2UgVENH
IHRvIGNyZWF0ZSBzcGVjaWFsIHRyYW5zbGF0aW9uIGJsb2NrcyB0bw0KcHJvY2VzcyB0aGF0IG1l
bW9yeSBsb2FkL3N0b3JlIG9wZXJhdGlvbi4gVGhlIHBsdWdpbiBnZXRzIG5vdGlmaWNhdGlvbiBm
b3INCnRoaXMgdHJhbnNsYXRpb24gYmxvY2sgYXMgd2VsbCwgYnV0IGluc3RydW1lbnRhdGlvbiBj
YWxsYmFja3Mgb3RoZXIgdGhhbg0KbWVtb3J5IG9uZXMgYXJlIHNpbGVudGx5IGlnbm9yZWQuIFRv
IG1ha2UgaXQgY29ycmVjdCwgdGhlIHBsdWdpbiBoYXMgdG8gbWF0Y2gNCmluc3RydWN0aW9uIGV4
ZWN1dGlvbiBjYWxsYmFjayBmcm9tIHByZXZpb3VzIFRCIHRvIG1lbW9yeSBjYWxsYmFjayBmcm9t
IHRoYXQNCnNwZWNpYWwgVEIuIFRoZSBmaXggd2FzIHRvIGV4cG9zZSBpbnRlcm5hbCDigJhtZW1P
bmx54oCZIFRCIGZsYWcgdG8gdGhlIHBsdWdpbiB0bw0KaGFuZGxlIHN1Y2ggVEJzIGRpZmZlcmVu
dGx5Lg0KDQoyLiBBbm90aGVyIHByb2JsZW0gaXMgcmVsYXRlZCB0byBpbnRlcnJ1cHRzIGhhbmRs
aW5nLiBTaW5jZSB3ZSBjYW4gaW5zZXJ0IHByZS0NCmNhbGxiYWNrIG9uIGluc3RydWN0aW9ucyBv
bmx5LCB0aGUgcGx1Z2luIGlzIG5vdCBhd2FyZSBpZiBpbnN0cnVjdGlvbiBpcw0KYWN0dWFsbHkg
ZXhlY3V0ZWQgb3IgaW50ZXJydXB0ZWQgYnkgYW4gaW50ZXJydXB0IG9yIGV4Y2VwdGlvbi4gSW4g
ZmFjdCwgaXQNCm1pc3Rha2VubHkgaW50ZXJwcmV0cyBhbGwgaW50ZXJydXB0ZWQgaW5zdHJ1Y3Rp
b25zIGFzIGV4ZWN1dGVkLiBBZGRpbmcgQVBJDQp0byByZWNlaXZlIGludGVycnVwdCBub3RpZmlj
YXRpb24gYW5kIGFwcHJvcHJpYXRlIGhhbmRsaW5nIG9mIGl0IGZpeGVzDQp0aGUgcHJvYmxlbS4N
Cg0KSSB3aWxsIHNlbmQgdGhvc2UgcGF0Y2hlcyBmb3IgcmV2aWV3IHNob3J0bHkgYW5kIHRoYW5r
IHlvdSBmb3IgZGlzc3VhZGluZyBtZQ0KZnJvbSBnb2luZyB0byB3cm9uZyBkaXJlY3Rpb24hDQo=

