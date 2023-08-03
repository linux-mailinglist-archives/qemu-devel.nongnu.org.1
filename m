Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CC76EF18
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRarr-0001en-RX; Thu, 03 Aug 2023 12:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRarp-0001eJ-7B
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:08:01 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qRarm-0003BC-GM
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:08:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 080F6C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691078873; bh=ZUjdOybnw2lrikov8x+GsWUBNExYeJBZiBDSQ+UvmIw=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=xS8Py3CibxjoSLaqm0Bq6NjXfhl91EkylLbuMFytlm04VT/2k+U95Gifk2tBWIPZS
 9vGFbd0iwJJpxpiaB7hwAy2KUFAdYzdCtNPRySSC/ATMQyCqEHcrMkIU5z0GVscOfc
 9VOliEi4t0mFbwTFaQHyf4blEj9Wtn1zUUBoTxFJVJnzh982paCT0IJi886cTeaYPS
 +ZEQsNX9Xvq8aTo1lU8MpYOPTjq6VZ38T8+JsOic7PqudDckKlT0XwRW22PbA6LuDG
 sMjZkx/60agZDxCLlbktho0YA/pmmy8GomZ6LA1Z98wC3DkqTLseW2AgHhv/p649Bp
 x2ZiWk6RxBFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691078873; bh=ZUjdOybnw2lrikov8x+GsWUBNExYeJBZiBDSQ+UvmIw=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=oYlUYZPJAWsoH0SRRSaDwYxc2zD7OYorR4K+0ujZlQFbUFzIWCYD4w7PxorNHCsCN
 grBzYSMe6leavPLGVH0Hkqy8VzZFGD+VFSH/X+kyLdIm51iYyklra+EcSahpCDHCE6
 kYqh6A02lUrKw3nJrFAF07YqlwyghG6w71Y5k7huIQAtvAA1Fdbt5t9fDWfYeUYjCF
 JnIwCeuMdcQR0owCiPXJXAln4cMV+BppmcMRFOk+2Ts30WpajFwZvZbjbzwWvbQ5T7
 41NQDbB/Oo+ivhc2deqmhbBtV07CD5hD7OqtLkuOGDH4u2I0s0lBXXg+90o/SOh39E
 e6uV3dbzaK3nw==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, Dmitriy Solovev <d.solovev@yadro.com>
Subject: RE: [PATCH v2] Fix SEGFAULT on getting physical address of MMIO
 region.
Thread-Topic: [PATCH v2] Fix SEGFAULT on getting physical address of MMIO
 region.
Thread-Index: AQHZxfmHdNFQIv2hd0q374T8AlC4wq/YfFgAgAA+0WA=
Date: Thu, 3 Aug 2023 16:07:52 +0000
Message-ID: <37a69b1aad0c42e1b280079ee330ca8a@yadro.com>
References: <20230803105830.8722-1-m.tyutin@yadro.com>
 <CAFEAcA8dsYuMaAG7RpO_47WaedR=2AaA7V5q02T3MYCUiDCCvA@mail.gmail.com>
In-Reply-To: <CAFEAcA8dsYuMaAG7RpO_47WaedR=2AaA7V5q02T3MYCUiDCCvA@mail.gmail.com>
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

PiA+IEFwcGx5IHNhdmVfaW90bGJfZGF0YSgpIHRvIGlvX3JlYWR4KCkgYXMgd2VsbCBhcyB0byBp
b193cml0ZXgoKS4NCj4gDQo+IENvdWxkIHdlIGhhdmUgYSBiaXQgbW9yZSBkZXRhaWwgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlIGFib3V0DQo+IHdoZW4geW91IGNhbiBnZXQgdGhpcyBzZWdmYXVsdD8N
Cj4gDQo+IEluIHBhcnRpY3VsYXIsIGRvZXMgdGhpcyBoYXBwZW4gb25seSBpZiB5b3UncmUgdXNp
bmcgcGx1Z2lucz8NCj4gDQoNCkkgdGhpbmsgc28uIEl0IGNyYXNoZXMgb24gc3BlY2lmaWMgYWRk
cmVzc2VzIHdoZW4gcGx1Z2luIGNhbGxzIHFlbXVfcGx1Z2luX2h3YWRkcl9waHlzX2FkZHIoKS4g
SSBoYXZlbid0IHNlZW4gdGhpcyBjcmFzaCB3aXRob3V0IGEgcGx1Z2luLg0K

