Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F27F2532
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 06:20:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5JA4-0005vp-1u; Tue, 21 Nov 2023 00:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1r5F7P-0000ht-GY; Mon, 20 Nov 2023 19:59:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1r5F7N-0003HA-2v; Mon, 20 Nov 2023 19:59:59 -0500
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SZ5X01KhfzRjRN;
 Tue, 21 Nov 2023 08:55:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 08:59:42 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Tue, 21 Nov 2023 08:59:42 +0800
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Zhenwei Pi <pizhenwei@bytedance.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=
 <berrange@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH-for-8.2 v2] backends/cryptodev: Do not ignore
 throttle/backends Errors
Thread-Topic: [PATCH-for-8.2 v2] backends/cryptodev: Do not ignore
 throttle/backends Errors
Thread-Index: AQHaG8LcHO/iTCngoEWLClaWZsK7ZbCD9DKA
Date: Tue, 21 Nov 2023 00:59:42 +0000
Message-ID: <352d38d89722453d838b695a120fd7d1@huawei.com>
References: <20231120150418.93443-1-philmd@linaro.org>
In-Reply-To: <20231120150418.93443-1-philmd@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=arei.gonglei@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 21 Nov 2023 00:18:54 -0500
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgW21haWx0bzpwaGlsbWRAbGluYXJvLm9yZ10NCj4gU2VudDogTW9uZGF5LCBOb3Zl
bWJlciAyMCwgMjAyMyAxMTowNCBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENj
OiBaaGVud2VpIFBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT47IEdvbmdsZWkgKEFyZWkpDQo+
IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVk
aGF0LmNvbT47DQo+IERhbmllbCBQIC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsg
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gPHBoaWxtZEBsaW5hcm8ub3JnPjsgcWVtdS1zdGFi
bGVAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0gtZm9yLTguMiB2Ml0gYmFja2VuZHMvY3J5
cHRvZGV2OiBEbyBub3QgaWdub3JlDQo+IHRocm90dGxlL2JhY2tlbmRzIEVycm9ycw0KPiANCj4g
Qm90aCBjcnlwdG9kZXZfYmFja2VuZF9zZXRfdGhyb3R0bGUoKSBhbmQgQ3J5cHRvRGV2QmFja2Vu
ZENsYXNzOjppbml0KCkgY2FuDQo+IHNldCB0aGVpciBFcnJvcioqIGFyZ3VtZW50LiBEbyBub3Qg
aWdub3JlIHRoZW0sIHJldHVybiBlYXJseSBvbiBmYWlsdXJlLiBVc2UNCj4gdGhlIEVSUlBfR1VB
UkQoKSBtYWNybyBhcyBzdWdnZXN0ZWQgaW4gY29tbWl0IGFlN2M4MGE3YmQNCj4gKCJlcnJvcjog
TmV3IG1hY3JvIEVSUlBfR1VBUkQoKSIpLg0KPiANCj4gQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5v
cmcNCj4gRml4ZXM6IGU3YTc3NWZkOWYgKCJjcnlwdG9kZXY6IEFjY291bnQgc3RhdGlzdGljcyIp
DQo+IEZpeGVzOiAyNTgwYjQ1MmZmICgiY3J5cHRvZGV2OiBzdXBwb3J0IFFvUyIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4g
LS0tDQoNClJldmlld2VkLWJ5OiBHb25nbGVpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT4NCg0K
DQpSZWdhcmRzLA0KLUdvbmdsZWkNCg0K

