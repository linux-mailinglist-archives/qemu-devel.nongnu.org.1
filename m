Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D6773B5B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOwh-0007ra-Iz; Tue, 08 Aug 2023 11:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTOwd-0007rF-JF
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:48:27 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTOwb-0001xh-79
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:48:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A13DFC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691509702; bh=57sunM9hMsuzz44Sm5bCfiWLQ+/ZEenBOMRMC3MeWVQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=L0Vcu5wVmpfrFEwqcfhAifIx7vDLHw81giFo5Oisc8hzU7XOCPpcrA6kV+eYJIsJe
 IuSraOnJ1cLY5WXfEJ5Z7x3EVFLaoo7zzhR81bPOziS6xZABIsZV7YaG0Ylbr7WfnA
 uX7Bt138Z3CAByKeWGUF8kcr3A9J68vxFsrPpGd+3ov5HTfhXEvp3fT3t867NxLg1r
 SJxQNLp4VrKwIV2QJQtQEhRI62CKAilACdJMqsskEkMtN8eBSbwEVsYyxyLH5ApHp4
 5z/PRncpfJtv8idb+OKBhYHqGJrnxHh/a0z30UvomqeX24oCIAIJPajWOx0m2L8JOm
 H4aRmXzxSoKbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691509702; bh=57sunM9hMsuzz44Sm5bCfiWLQ+/ZEenBOMRMC3MeWVQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=f4D5sQpwfyigxmgnySEW/JwcFLiVL5FoiF+O9Mft2EDex5N1zAwnOURUUKmDTm/gJ
 OMriyhu0aDmish3BoKjEYdshdzbyxSCuddF9PgNRZDkdfrr7jVnuQTS0UEPLLzWlOF
 DkELq0nmv7mtX+sbDYE3EK7Kt5rX5F855UivW3iUAeODIJq3e5bUThpcqzurbelmU6
 Jw7fkQxl/nn9Zb36Mtf7KWh8xIkg+4TH8yn0Dl9r2OWe0DjEzxCcHyPb0Ab5dKZ4xb
 FaBZ5FUuN/EW3fdfzPuJOFhve6+rSJTeOhu6dieCQ24rkc1yyNXrvYH8Wc42jM5DD0
 E/YYiUQi3uq7g==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: Richard Henderson <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>
Subject: RE: [PATCH] Add support of callbacks after instructions to plugin api
Thread-Topic: [PATCH] Add support of callbacks after instructions to plugin api
Thread-Index: AQHZyf6J5QVoOC9LUkCHTqZHvV9etq/gSCmAgAA531A=
Date: Tue, 8 Aug 2023 15:48:21 +0000
Message-ID: <7561dee652b94712bfe73643d23ec345@yadro.com>
References: <20230808134435.2719-1-m.tyutin@yadro.com>
 <2cdaf4c5-2151-0acf-8bc9-55ab719e874f@linaro.org>
In-Reply-To: <2cdaf4c5-2151-0acf-8bc9-55ab719e874f@linaro.org>
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

PiBPbiA4LzgvMjMgMDY6NDQsIE1pa2hhaWwgVHl1dGluIHdyb3RlOg0KPiA+IEluaXRpYWxseSwg
d2UgY2FuIG9ubHkgY2FsbCB0aGUgY2FsbGJhY2sgQkVGT1JFIGluc3RydWN0aW9ucy4gVGhpcyBj
b21taXQgYWRkcyB0aGUgYWJpbGl0eSB0byBpbnNlcnQgdGhlIGNhbGxiYWNrIEFGVEVSIGluc3Ry
dWN0aW9ucy4NCj4gPg0KPiA+IE5vIGNhbGxiYWNrIGNhbGwgZm9yIGNvbnRyb2wtZmxvdyBpbnN0
cnVjdGlvbnMuDQo+IA0KPiBZb3UncmUgZ29pbmcgdG8gbWlzcyB3aG9sZSBjYXRlZ29yaWVzIG9m
IGluc3RydWN0aW9ucywgbm90IGp1c3QgY29udHJvbC1mbG93LiAgWW91J3JlDQo+IGdvaW5nIHRv
IG1pc3MgYW55dGhpbmcgdGhhdCByYWlzZXMgYW4gZXhjZXB0aW9uLiAgVGhlIGxpc3QgZ29lcyBv
biBhbmQgb24uICBUaGlzIGlzIHdoeSB3ZQ0KPiBkaWRuJ3QgaW1wbGVtZW50IHRoaXMgImFmdGVy
IiBob29rIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gDQoNClRvIGJlIGZhaXIgaXQgd29ya3MgcXVp
dGUgd2VsbCBmb3IgY29kZSB0cmFuc2xhdGlvbnMgaW4gdXNlci1tb2RlIGFuZCBiYXJlbWV0YWwg
YXBwbGljYXRpb25zLiBBdCBsZWFzdCB3ZSBjYW4gaW50ZXJjZXB0IGEgc2V0IG9mIGluc3RydWN0
aW9ucyB0aGF0IGhhdmUgcmVnaXN0ZXJzIGFzIG9wZXJhbmRzIGFuZCBldmVuIHN5c2NhbGwtbGlr
ZSBpbnN0cnVjdGlvbnMuIExvZ2ljYWxseSBpdCBoYWQgdG8gd29yayBpZGVudGljYWxseSB0byBt
ZW1vcnkgJ3N0b3JlJyBjYWxsYmFja3MsIGJ1dCB3ZSBoYWQgdG8gYWRkIGEgc2hvcnRjdXQgdG8g
Zml4IHByb2JsZW0gd2hlbiBzb21lIG9mIGNvZGUgdHJhbnNsYXRvcnMgaW5zZXJ0cyBleGl0X3Ri
IG9wZXJhdGlvbiBleHBsaWNpdGx5LiBNYXliZSB0aGVyZSBpcyBiZXR0ZXIgd2F5IHRvIGRvIGl0
Lg0KDQpXZSB1c2Ugc3VjaCBBRlRFUiBjYWxsYmFjayBpbiBwbHVnaW5zIHRvIGNhcHR1cmUgQ1BV
IHN0YXRlIGNoYW5nZXMgaW4gZ2VuZXJpYyB3YXkgKHVzaW5nIHJlZ2lzdGVycyBBUEkgcGF0Y2gg
SSBwb3N0ZWQgZWFybGllcikuIFdpdGhvdXQgaXQsIEJFRk9SRSBjYWxsYmFjayBoYXMgdG8gYmUg
YWRkZWQgdG8gJ2N1cnJlbnQnIGFuZCAnZm9sbG93aW5nJyBpbnN0cnVjdGlvbnMgdG8gYWNoaWV2
ZSB0aGUgc2FtZSBlZmZlY3QuIEhhdmluZyBjYWxsYmFja3Mgb24gZGlmZmVyZW50IGluc3RydWN0
aW9ucyBhZGRzIGNvbXBsZXhpdHkgdG8gdGhlIGNhbGxiYWNrcyBpdHNlbGYgdG8gcGVyZm9ybXMg
c3RhdGUgZHVtcHMgYXQgYXBwcm9wcmlhdGUgY29uZGl0aW9ucyAoZS5nLiB3YXMgJ3ByZXZpb3Vz
JyBpbnN0cnVjdGlvbiB0aGUgb25lIHdlIGluc3RydW1lbnRlZCBvciBpdCB3YXMgc29tZSBqdW1w
KS4NCg==

