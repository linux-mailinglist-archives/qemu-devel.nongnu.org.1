Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BE7AEB08
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5rP-0000Mm-OO; Tue, 26 Sep 2023 07:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5rK-0000MO-FL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:04:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5rH-00076x-0d
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:04:06 -0400
Received: from dggpemm100024.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvxcK3LwJzVkdm;
 Tue, 26 Sep 2023 19:00:49 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm100024.china.huawei.com (7.185.36.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 19:03:55 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 12:03:53 +0100
To: David Hildenbrand <david@redhat.com>, xianglai li
 <lixianglai@loongson.cn>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Topic: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgBZURWA=
Date: Tue, 26 Sep 2023 11:03:53 +0000
Message-ID: <042d0b2c56ae4e298a55b5fbb5fba8af@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
In-Reply-To: <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

SGkgRGF2aWQsDQoNCj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1YXdl
aS5jb21Abm9uZ251Lm9yZyA8cWVtdS1kZXZlbC0NCj4gYm91bmNlcytzYWxpbC5tZWh0YT1odWF3
ZWkuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBEYXZpZCBIaWxkZW5icmFuZA0KPiBTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjMgODowMCBBTQ0KPiBUbzogeGlhbmdsYWkgbGkg
PGxpeGlhbmdsYWlAbG9vbmdzb24uY24+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IFNh
bGlsIE1laHRhIDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0PjsgWGlhb2p1YW4gWWFuZw0KPiA8eWFu
Z3hpYW9qdWFuQGxvb25nc29uLmNuPjsgU29uZyBHYW8gPGdhb3NvbmdAbG9vbmdzb24uY24+OyBN
aWNoYWVsIFMuDQo+IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgSWdvciBNYW1tZWRvdiA8aW1h
bW1lZG9AcmVkaGF0LmNvbT47IEFuaSBTaW5oYQ0KPiA8YW5pc2luaGFAcmVkaGF0LmNvbT47IFBh
b2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+IEhlbmRlcnNvbiA8
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29zdA0KPiA8ZWR1YXJk
b0BoYWJrb3N0Lm5ldD47IE1hcmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwu
Y29tPjsNCj4gUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgd2Fu
Z3lhbmFuIChZKQ0KPiA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBQZXRlcg0KPiBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+
OyBCaWJvIE1hbyA8bWFvYmlib0Bsb29uZ3Nvbi5jbj4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAwNC8xMF0gSW50cm9kdWNlIHRoZSBDUFUgYWRkcmVzcyBzcGFjZSBkZXN0cnVjdGlvbg0KPiBm
dW5jdGlvbg0KPiANCj4gT24gMTIuMDkuMjMgMDQ6MTEsIHhpYW5nbGFpIGxpIHdyb3RlOg0KPiA+
IEludHJvZHVjZSBuZXcgZnVuY3Rpb24gdG8gZGVzdHJveSBDUFUgYWRkcmVzcyBzcGFjZSByZXNv
dXJjZXMNCj4gPiBmb3IgY3B1IGhvdC0odW4pcGx1Zy4NCj4gPg0KPiBIb3cgZG8gb3RoZXIgYXJj
aHMgaGFuZGxlIHRoYXQ/IE9yIGhvdyBhcmUgdGhleSBhYmxlIHRvIGdldCBhd2F5IHdpdGhvdXQN
Cj4gZGVzdHJveWluZz8NCg0KVGhpcyBwYXRjaC1zZXQgaXMgYmFzZWQgb24gdGhlIEFSTSBSRkMu
IFdlIGRvIGRlc3Ryb3kgQWRkcmVzc1NwYWNlIHRoZXJlLg0KSXMgdGhlcmUgYW55IHJlYXNvbiB5
b3UgYXJlIGhpbnRpbmcgd2h5IGl0IHNob3VsZCBub3QgYmUgZG9uZT8NCg0KSSBoYXZlIHBvc3Rl
ZCB0aGUgUkZDIFYyIFZpcnR1YWwgQ1BVIEhvdHBsdWcgU3VwcG9ydCBvbiBBUk0gdG9kYXkgYW5k
DQpZb3UgYXJlIENDJ2VkIGluIGl0LiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIGltcGxlbWVu
dGF0aW9uOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjMwOTI2MTAw
NDM2LjI4Mjg0LTEtc2FsaWwubWVodGFAaHVhd2VpLmNvbS9ULyNtNTIzYjM3ODE5YzQ4MTFjNzgy
NzMzMzk4MjAwNGUwN2ExZWYwMzg3OQ0KDQpUaGFua3MNClNhbGlsLg0KDQoNCg==

