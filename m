Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42517AEB74
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6CC-00060A-OK; Tue, 26 Sep 2023 07:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql6CA-0005xp-2k
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:25:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql6Bz-0004eh-L3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:25:37 -0400
Received: from dggpemm100022.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvy4D64lxzNnMc;
 Tue, 26 Sep 2023 19:21:32 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm100022.china.huawei.com (7.185.36.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 19:25:21 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 12:25:19 +0100
To: David Hildenbrand <david@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, lixianglai
 <lixianglai@loongson.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, "wangyanan (Y)"
 <wangyanan55@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Topic: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAAAdJgIAA3/CAgAABaoCAAFe/AIAAZ+KAgAARuACAERcvYA==
Date: Tue, 26 Sep 2023 11:25:19 +0000
Message-ID: <0cfd80fc38134294aabd17ecda21dd05@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <cd28d7e5-cf77-dce0-756d-d6f75657727d@linaro.org>
 <b3975bd1-dd79-5206-9a8f-580161cc7b22@redhat.com>
In-Reply-To: <b3975bd1-dd79-5206-9a8f-580161cc7b22@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjMgNDoyMiBQTQ0KPiBUbzogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgbGl4aWFuZ2xhaQ0KPiA8bGl4aWFuZ2xhaUBsb29u
Z3Nvbi5jbj47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2FsaWwgTWVodGENCj4gPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+IENjOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAb3Buc3JjLm5l
dD47IFhpYW9qdWFuIFlhbmcNCj4gPHlhbmd4aWFvanVhbkBsb29uZ3Nvbi5jbj47IFNvbmcgR2Fv
IDxnYW9zb25nQGxvb25nc29uLmNuPjsgTWljaGFlbCBTLg0KPiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT47IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBBbmkgU2luaGENCj4g
PGFuaXNpbmhhQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29t
PjsgUmljaGFyZA0KPiBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBF
ZHVhcmRvIEhhYmtvc3QNCj4gPGVkdWFyZG9AaGFia29zdC5uZXQ+OyBNYXJjZWwgQXBmZWxiYXVt
IDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47DQo+IHdhbmd5YW5hbiAoWSkgPHdhbmd5YW5h
bjU1QGh1YXdlaS5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpDQo+IDxiZXJyYW5nZUByZWRoYXQu
Y29tPjsgUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPjsgQmlibyBNYW8NCj4gPG1hb2JpYm9A
bG9vbmdzb24uY24+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTBdIEludHJvZHVjZSB0
aGUgQ1BVIGFkZHJlc3Mgc3BhY2UgZGVzdHJ1Y3Rpb24NCj4gZnVuY3Rpb24NCj4gDQo+IE9uIDE1
LjA5LjIzIDE2OjE5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPiBPbiAxNS85
LzIzIDEwOjA3LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gPg0KPiA+PiBUaGUgQ1BVIGlt
cGxlbWVudGF0aW9uIGVuZCB1cCBjYWxsIHFlbXVfaW5pdF92Y3B1KCkgaW4gdGhlaXIgcmVhbGl6
ZQ0KPiA+PiBmdW5jdGlvbjsgdGhlcmUgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHFlbXVfZGVz
dHJveV92Y3B1KCkgb24gdGhlDQo+ID4+IHVucmVhbGl6ZSBwYXRoIHRoYXQgdGFrZXMgY2FyZSBv
ZiB1bmRvaW5nIGFueSBjcHVfYWRkcmVzc19zcGFjZV9pbml0KCkuDQo+ID4+DQo+ID4+IFdlIHNl
ZW0gdG8gaGF2ZSBjcHVfY29tbW9uX3VucmVhbGl6ZWZuKCktPmNwdV9leGVjX3VucmVhbGl6ZWZu
KCkgYnV0DQo+ID4+IHRoYXQgZG9lc24ndCB0YWtlIGNhcmUgb2YgYWRkcmVzcyBzcGFjZXMuDQo+
ID4+DQo+ID4+IEFsc28sIGluIHFlbXVfaW5pdF92Y3B1KCkgd2UgZG8gYSBjcHVzX2FjY2VsLT5j
cmVhdGVfdmNwdV90aHJlYWQoY3B1KS4NCj4gPj4gSSdtLCBjdXJpb3VzIGlmIHdlIGRlc3Ryb3kg
dGhhdCB0aHJlYWQgc29tZWhvdy4NCj4gPg0KPiA+IEltcGxpY2l0bHkgaW4gY3B1X3JlbW92ZV9z
eW5jKCkuDQo+IA0KPiBBaCwgaW5kZWVkLiB0aGVyZSBpcyB0aGUgcWVtdV90aHJlYWRfam9pbigp
Lg0KDQpDb3JyZWN0LiBUaGlzIG9uZS4gDQoNCkZvciBBUk0sIHRoaXMgd2FzIG5lY2Vzc2FyeSBi
ZWNhdXNlIG9mIHRoZSBkZXNpZ24gYXBwcm9hY2gNCndlIGhhdmUgdGFrZW4gYXMgYSB3b3JrYXJv
dW5kIHRvIHRoZSBBUk0gYXJjaGl0ZWN0dXJlIGxpbWl0YXRpb25zLg0KVGggS1ZNIG5lZWRzIHRv
IGtub3cgZXZlcnl0aGluZyBhdCB0aGUgVk0gaW5pdGlhbGl6YXRpb24gdGltZS4NCg0KUmVxdWVz
dCB0byBoZWxwIHJldmlldyB0aGUgcGF0Y2hlczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyMzA5MjYxMDA0MzYuMjgyODQtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tL1Qv
I201MjNiMzc4MTljNDgxMWM3ODI3MzMzOTgyMDA0ZTA3YTFlZjAzODc5DQoNCg0KVGhhbmtzDQpT
YWxpbC4NCg0KDQoNCg0KDQoNCg==

