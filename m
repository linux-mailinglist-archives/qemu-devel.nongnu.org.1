Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AFB776077
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTj4I-0002M1-1w; Wed, 09 Aug 2023 09:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTj4F-0002Lj-SL
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:17:40 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTj4C-0005hC-Vf
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:17:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4C521C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691587051; bh=y35q9b17nAnioeuCBvuKYLFUp05dPCev6gAMN7TaJUk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=Oj+oqhRyl1BHZPj9iVHfe6zt+dhv9ZhQ/QOm1x3UIsqMpkJV2bKxR3KZeNU9BgTgU
 M+6XE1aR/mZup+5hO6I/j8/4aoFh1OgPWtzODBsaRc/9XR0K47gR6O/vq9KDZddCio
 gcNcFsufE0ijV/3A2QXNtNvO70jpvHR/iXprpLHTDP62hkiVL2N8lxMSWGu3RwS1ZO
 b7DLPq2gHH7xGtCjENpP0KWu+xOoEJGJaPRJ9YlCC3kARcgRmYFE5c1MBI/OFoI0mN
 Ej67s1F5vRnKuIYIS5KTSA9RDpR0wgtgBFzukg1muy/s3nRsntqFJ1uJ50ApYP2svD
 OQrlU7K5C/uUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691587051; bh=y35q9b17nAnioeuCBvuKYLFUp05dPCev6gAMN7TaJUk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=HITSKhwsVKGG+9fGDlneQvVudRv3//79IGOf3C4yAwOLEyHtMMde+OJXjlAWIKnIP
 0wypeUbAcSUVjU3OwMntzLnWQ+Wt5esvj9IKMcTQiF6JIJE7QNjRAlf4ppDuWGHw5q
 vpcSKwgaIE70ZnfQxxAeBm72HoTfTLZ4luC1Kyd8Lrbdtn8Kc5EbnyhJKyOenZsKdw
 IL6PYPboXIMhpqcsoLLPNIsziM+sTLoHGosTqEz4F7fSeBkcaKvFBqBnaFJnRz554T
 4DhGeLQvN+LvvbJ256uQgumSe5KISeeRTR8GQBcjGTAYzlaO2GldEwFOB1Imklrxne
 mv0zseBZ0xKBA==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Dmitriy Solovev <d.solovev@yadro.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
Thread-Topic: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
Thread-Index: AQHZxUJ9uWdHfTvY/E+smozUO/WhN6/W+rwAgArzYkA=
Date: Wed, 9 Aug 2023 13:17:29 +0000
Message-ID: <7c2d7791b1af4d54919c51ea6b666dfd@yadro.com>
References: <bf8ae2fd-158a-57b6-6270-2e56b6506421@yadro.com>
 <ffcb690c-91d2-60f5-3e65-e0be204de7b8@linaro.org>
In-Reply-To: <ffcb690c-91d2-60f5-3e65-e0be204de7b8@linaro.org>
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

PiBPbiA4LzIvMjMgMDY6MDgsIE1pa2hhaWwgVHl1dGluIHdyb3RlOg0KPiA+IFRoZSBmaXggaXMg
dG8gY2xlYXIgVExCX0lOVkFMSURfTUFTSyBiaXQgaW4gdGxiX2FkZHIsIGFzIGl0IGhhcHBlbnMg
aW4gb3RoZXIgcGxhY2VzIGUuZy4NCj4gPiBsb2FkX2hlbHBlcigpLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRG1pdHJpeSBTb2xvdmV2IDxkLnNvbG92ZXZAeWFkcm8uY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pa2hhaWwgVHl1dGluIDxtLnR5dXRpbkB5YWRyby5jb20+DQo+ID4gLS0tDQo+
ID4gICBhY2NlbC90Y2cvY3B1dGxiLmMgfCAyICstDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IFRoZSBvdGhlciBwbGFjZXMgaW4gbG9h
ZF9oZWxwZXIgaGFwcGVuIG9ubHkgZGlyZWN0bHkgYWZ0ZXIgdGxiX2ZpbGwgaGFzIHN1Y2NlZWRl
ZC4gIEhlcmUNCj4geW91IGhhdmUgbm8gc3VjaCBndWFyYW50ZWUuDQo+IA0KPiBJIHRoaW5rIHBl
cmhhcHMgdGhlIHNhdmVfaW90bGJfZGF0YSgpIGNhbGwgc2hvdWxkIGJlIGFwcGxpZWQgdG8gbG9h
ZHMgYXMgd2VsbCwgYW5kIHRoZW4NCj4gdGxiX3BsdWdpbl9sb29rdXAgc2ltcGxpZmllZC4NCj4g
DQoNCkhlbGxvIFJpY2hhcmQsDQoNCldlIHBlcmZvcm1lZCB0ZXN0aW5nIG9uIG1vcmUgc2NlbmFy
aW9zIGFuZCBub3RpY2VkIHRoYXQgcGF0Y2ggd2hlbiBzYXZlX2lvdGxiX2RhdGEoKSBjYWxsIGlz
IGFkZGVkIHRvIGlvX3JlYWR4DQooaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjMwODA0MTEw
OTAzLjE5OTY4LTEtbS50eXV0aW5AeWFkcm8uY29tLykuIEl0IGRvZXNuJ3Qgd29yayBmb3IgYWRk
cmVzc2VzDQppbiBPQ1JBTSByZWdpb24uIFRob3NlIGFjY2Vzc2VkIGJ5cGFzcyBpb193cml0ZXgv
aW9fcmVhZHggZnVuY3Rpb24gYW5kIHRoZXJlZm9yZSBkb27igJl0IGludm9rZSBzYXZlX2lvdGxi
X2RhdGEoKS4NClNvIHdlIG9ic2VydmUgdGhlIHdyb25nIHZhbHVlIG9mIGNwdS0+c2F2ZWRfaW90
bGIgZm9yIGl0Lg0KDQpXb3VsZCBub3QgYmUgYmV0dGVyIHRvIGdldCBiYWNrIHRvIGluaXRpYWwg
djEgYXBwcm9hY2ggd2hlbiB3ZSBjbGVhbiBUTEJfSU5WQUxJRF9NQVNLIGZsYWcgaW4NCnRsYl9w
bHVnaW5fbG9va3VwKCk/IEl0IHdvcmtzIHdlbGwgZm9yIHRob3NlIHJlZ2lvbnMuDQooaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9RRU1VL2JmOGFlMmZkLTE1OGEtNTdiNi02MjcwLTJlNTZiNjUwNjQyMUB5
YWRyby5jb20pDQo=

