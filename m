Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C10187F4621
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:29:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mLb-0006ZE-FO; Wed, 22 Nov 2023 07:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mLY-0006Yp-Ky
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:28:48 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mLV-0000jt-Oj
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:28:48 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com C5809C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1700656121; bh=Ot8PHiojizOLELZKfSYO7D2o0GDtLyZAkuMPR+dULtc=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=TPMFKQ6WmCPJsBaU5YyIGBJgN8WrXA+b9OuHcdZX3LkFwKXZ9BlxMKWUSqnRnr5wA
 aQHWAH23zGj9TFBXAEALj4VzsmlSeDjHMlM0Pajvd425hkn2i8mal4IdA2cVQYOTch
 12F7erkwEfm+R9cg681Wd0+SsyfgNnqIe3uX8b86ZR6zwRpBDAy/XRbvRFjDHeQCNb
 S2PJWhcqkh7lJ5ZBFo48XHtpRbA7T9u9hDhwPu7lz5VBWl5Yl4hDTOzC9mb4Prm5jQ
 0kNspppipwhfJfRUDL6/rBXInRePJaBGlUTHldhiSOZSg5ctjjji13nNR3kZeDPI1L
 G0OzIJWHRqx4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1700656121; bh=Ot8PHiojizOLELZKfSYO7D2o0GDtLyZAkuMPR+dULtc=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=FWCZsmDbSsTiV5ltT14s2j+zMYd40d2bY9IKsoGcafftQXm5P9h6082y3ucSOwdcg
 CC9N2sdDv5lUi+Y9X12xsIzAgxg91Zt+erZbpL1Dw4p17F1f02wLX9KAB/ZIFmH9tB
 B8SlLl46Xkl5fcOuywNgrHAM927iA1y6nblbRn/HOPKfP0kAq7poS3o3yp4nM1NZka
 5+hRKSoQzKruZhzWAGuY+D58KqbTzigARJk6D0N+tKI66jUQh/1n+uOQYspl8rWVn1
 ZimOIvlKRufhni0f1XJwCCWuLCq5X7UdJWXTiqaYI7nSjmY10qOtxdMPQv8ilC1e9f
 n59hsPiyHaKlg==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: RE: Instruction virtual address in TCG Plugins
Thread-Topic: Instruction virtual address in TCG Plugins
Thread-Index: AdoWXsbya+HqTrueTiqiLf6nDJCNngAFWYevABh5pFAABM9ShQFrwMggAAHUSSsAJ6hdoA==
Date: Wed, 22 Nov 2023 12:28:40 +0000
Message-ID: <882447aa33ba409cb3da47c61ddba9a2@yadro.com>
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
 <87leb1xtdx.fsf@draig.linaro.org>
 <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com>
 <874jhoy54t.fsf@draig.linaro.org>
 <f79fe2c0d7e5457ca7172862e96fd886@yadro.com>
 <878r6rf28r.fsf@draig.linaro.org>
In-Reply-To: <878r6rf28r.fsf@draig.linaro.org>
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

PiA+IDEuIE1lbW9yeSBJTyBvcGVyYXRpb25zIGZvcmNlIFRDRyB0byBjcmVhdGUgc3BlY2lhbCB0
cmFuc2xhdGlvbiBibG9ja3MgdG8NCj4gPiBwcm9jZXNzIHRoYXQgbWVtb3J5IGxvYWQvc3RvcmUg
b3BlcmF0aW9uLiBUaGUgcGx1Z2luIGdldHMgbm90aWZpY2F0aW9uIGZvcg0KPiA+IHRoaXMgdHJh
bnNsYXRpb24gYmxvY2sgYXMgd2VsbCwgYnV0IGluc3RydW1lbnRhdGlvbiBjYWxsYmFja3Mgb3Ro
ZXIgdGhhbg0KPiA+IG1lbW9yeSBvbmVzIGFyZSBzaWxlbnRseSBpZ25vcmVkLiBUbyBtYWtlIGl0
IGNvcnJlY3QsIHRoZSBwbHVnaW4gaGFzIHRvIG1hdGNoDQo+ID4gaW5zdHJ1Y3Rpb24gZXhlY3V0
aW9uIGNhbGxiYWNrIGZyb20gcHJldmlvdXMgVEIgdG8gbWVtb3J5IGNhbGxiYWNrIGZyb20gdGhh
dA0KPiA+IHNwZWNpYWwgVEIuIFRoZSBmaXggd2FzIHRvIGV4cG9zZSBpbnRlcm5hbCDigJhtZW1P
bmx54oCZIFRCIGZsYWcgdG8gdGhlIHBsdWdpbiB0bw0KPiA+IGhhbmRsZSBzdWNoIFRCcyBkaWZm
ZXJlbnRseS4NCj4gDQo+IEFyZSB5b3UgdGFsa2luZyBhYm91dCB0aGUgQ0ZfTUVNSV9PTkxZIGNv
bXBpbGUgZmxhZz8gV2UgYWRkZWQgdGhpcyB0bw0KPiBhdm9pZCBkb3VibGUgY291bnRpbmcgZXhl
Y3V0ZWQgaW5zdHJ1Y3Rpb25zLiBIYXMgdGhlcmUgYmVlbiBhIGNsYXNoIHdpdGgNCj4gdGhlIG90
aGVyIGNoYW5nZXMgdG8gYWx3YXlzIGNwdV9yZWNvbXBpbGVfaW8/IFRoaXMgd2FzIGEgY2hhbmdl
IGFkZGVkIHRvDQo+IGZpeDogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0v
aXNzdWVzLzE4NjYNCg0KWWVzLCB0aGF0J3MgaXQuIHFlbXVfcGx1Z2luX3RiIHN0cnVjdHVyZSBo
YXMgJ21lbV9vbmx5JyBmaWVsZCBmb3IgdGhvc2UgYmxvY2suDQpJIG9ubHkgYWRkZWQgQVBJIHRv
IHJlYWQgdGhpcyBmbGFnIGJ5IGEgcGx1Z2luLg0KDQogDQo+ID4gMi4gQW5vdGhlciBwcm9ibGVt
IGlzIHJlbGF0ZWQgdG8gaW50ZXJydXB0cyBoYW5kbGluZy4gU2luY2Ugd2UgY2FuIGluc2VydCBw
cmUtDQo+ID4gY2FsbGJhY2sgb24gaW5zdHJ1Y3Rpb25zIG9ubHksIHRoZSBwbHVnaW4gaXMgbm90
IGF3YXJlIGlmIGluc3RydWN0aW9uIGlzDQo+ID4gYWN0dWFsbHkgZXhlY3V0ZWQgb3IgaW50ZXJy
dXB0ZWQgYnkgYW4gaW50ZXJydXB0IG9yIGV4Y2VwdGlvbi4gSW4gZmFjdCwgaXQNCj4gPiBtaXN0
YWtlbmx5IGludGVycHJldHMgYWxsIGludGVycnVwdGVkIGluc3RydWN0aW9ucyBhcyBleGVjdXRl
ZC4gQWRkaW5nIEFQSQ0KPiA+IHRvIHJlY2VpdmUgaW50ZXJydXB0IG5vdGlmaWNhdGlvbiBhbmQg
YXBwcm9wcmlhdGUgaGFuZGxpbmcgb2YgaXQgZml4ZXMNCj4gPiB0aGUgcHJvYmxlbS4NCj4gDQo+
IFdlIGRvbid0IHByb2Nlc3MgYW55IGludGVycnVwdHMgdW50aWwgdGhlIHN0YXJ0IG9mIGVhY2gg
YmxvY2sgc28gbm8NCj4gYXN5bmNocm9ub3VzIElSUXMgc2hvdWxkIGludGVycnVwdCBleGVjdXRp
b24uIEhvd2V2ZXIgaXQgaXMgcG9zc2libGUNCj4gdGhhdCBhbnkgZ2l2ZW4gaW5zdHJ1Y3Rpb24g
Y291bGQgZ2VuZXJhdGUgYSBzeW5jaHJvbm91cyBleGNlcHRpb24gc28gaWYNCj4geW91IG5lZWQg
YSBwcmVjaXNlIGNvdW50IG9mIGV4ZWN1dGlvbiB5b3UgbmVlZCB0byBpbnN0cnVtZW50IGV2ZXJ5
DQo+IHNpbmdsZSBpbnN0cnVjdGlvbi4gV2l0aCBlbm91Z2gga25vd2xlZGdlIHRoZSBwbHVnaW4g
Y291bGQgYXZvaWQNCj4gaW5zdHJ1bWVudGluZyBzdHVmZiB0aGF0IHdpbGwgbmV2ZXIgZmF1bHQg
YnV0IHRoYXQgcmVsaWVzIG9uIGJha2luZw0KPiBhZGRpdGlvbmFsIGtub3dsZWRnZSBpbnRvIHRo
ZSBwbHVnaW4uDQo+IA0KPiBHZW5lcmFsbHkgaXRzIG9ubHkgbWVtb3J5IG9wZXJhdGlvbnMgdGhh
dCBjYW4gZmF1bHQgKGFsdGhvdWdoIEkgZ3Vlc3MNCj4gRlBVIGFuZCBzb21lIG1vcmUgZXNvdGVy
aWMgaW50ZWdlciBvcHMgY2FuKS4NCg0KVGhhdCBtYXRjaGVzIG15IG9ic2VydmF0aW9uLiBJIGRv
IHNlZSBpbnRlcnJ1cHRzIGVpdGhlciBvbiBUQiBib3VuZGFyeQ0KKGUuZy4gdGltZXJzKSBvciBt
ZW1vcnkgbG9hZCBpbnN0cnVjdGlvbnMuDQo=

