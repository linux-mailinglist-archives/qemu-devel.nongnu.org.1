Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3F76D85D
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 22:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRI7J-0002lN-QG; Wed, 02 Aug 2023 16:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRI7G-0002l9-IW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:06:42 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRI7C-0000ff-GH
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691006794; x=1691611594; i=deller@gmx.de;
 bh=I2E4LYhKXSvLp2jT022aNifKxrQpy9MPMCKJSIWp/90=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XNKqv2fHwm2Jh6Q9WUIw0kMlqpyQrTGk74Mg7YNkcJGatz5wz6BWQR8FtkEMRg8sBsMbsSj
 jmyCrrZvyfsiqGMjnOP3r8rU0+6k350vWBa4Ru1YccKGn35ZnO2ATUHhZ4U/QVRQFgCNkZS4A
 QkuQ7coD0FYgypdWHIoe/Li4Anfqa+8A6UagjBZgPq3wQuGQmLaCXk6SUsjSXWRiYB2XVDWbS
 gYEaya3fmCG3i8MAU7uj++yWioFJndqROzMk86yCvj2e8fKSuI52AGZ934P+9LiRAlGAtK2kV
 MLYFBt5w+R7wBb8YQkUbZ2CH56WRIvYkTTZ90mxAWfXpSqQGaihA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1pgRpT3KiA-012XAi; Wed, 02
 Aug 2023 22:06:33 +0200
Message-ID: <06c94b8b-4243-0c18-e53e-496d00d7ae8f@gmx.de>
Date: Wed, 2 Aug 2023 22:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 7/8] linux-user: Optimize memory layout for static and
 dynamic executables
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-8-deller@gmx.de>
 <bdf9ebc2-ef7a-7dd4-a742-8bbf5e836aea@linaro.org>
 <07af035f-8ce0-7002-2fda-ab89cc2853d4@gmx.de>
 <8e602948-6ef2-9e45-30bc-f9bbc2e6802f@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <8e602948-6ef2-9e45-30bc-f9bbc2e6802f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:u40/usaz5/qfNwVr23ZJO42CoDjE1am3Mbrl8k29UaPSKF72vid
 i5kmHKFatMYBZc5/sMoNbfdGJ3/MEpwlzBkJAM2Rkek2qG+/OY78ZoM/zh3dc9Tp/DGj6VJ
 +XtSQmwT8msfUQ1fN+WftqH0f2qPTXp+9tlbB2b8xZL+KNzLGNvbXQHJsMpGRLehpwAI8V+
 SRw48zosF7N50G/rHTmBA==
UI-OutboundReport: notjunk:1;M01:P0:M7U5p9qei2o=;4r+h0FC1aK0y9E323vS7roD0VE3
 H7DmTKRwqA0TIWTFH+4yFMHSSrQVbXcOUctZGFKzZq/NPGFMCjNmLO/hExqFw0O9l2O954nyA
 d+D+qBDcBe4exKFAlqUSDKk/VfuhxJwIkDLb2I6QmfNS+Shir9rl0oqKYpvpFTNO7m0tCJYUv
 oSllSb4LC/ShwDizJeNnUs/SpcTSH3z2ZhJLFUZC1/7swc8GUsESzd6lx3TqYbxF8UshJnLFd
 1hOp6+c2vL47ybLaoQeiSYY75RWDYfcHu8sbE2Fiai0tQ17e19HzUEfKefwsZduUty8B70XLm
 zR+31dV6NoVwVYhVc5kS4+MzrjADq8wHFv+gfbt7kJf7EXgTaqAIPvaZU4fSdZ3r3/ae5UIQm
 KCaD71NP7YZfFIyupFeqth72OSjO94sg0J7L4NwUwbN6HfuYq6Tch9JnOfOhHxCxWcjCVgKGu
 cV7eldM/ALy33+9nocphFN9sta1DRGqOictu4sVP3JKHcKwx2VoUrZgc3JsVPLzn1nfvoyBRc
 mZDTdNRQzCkNeh3Qamzh3EOlvR41kuTFaa1yfdjGs/fOe5L9OH4B81TA8qgDGI0KcOrn3JJty
 CScV97yXYwHDfwdYhHBvyTsiPgC6COcdwGRhP4I5lO9HM/1heayD6ha6A9jvAbA/aYtPpPuWu
 qV2GTR/bloIdyu6Wy8K/Pdf2whexgeOrnPwX/SJMBimGxAymdqErUjTGPD/8OH4tKCU4k7N6V
 aNc/0IdFH4vjpd1KYAip2L2aeC5KaRSbWXRsiXxRO3EIdx8J3z7gfoSMyVmtUF9hp0yGZ93l+
 F/Ubj52EsHDLJyFoe0Qh1IKnglDZ6RCZuxTs4Fvo3q3mrLzImHeqONs5ZEg8PkLztlWzH6ht4
 ZEXMlZTyz4GXXefj8IfPrCsyVQc7myAGAVA1U/7ib0B8z7OO1p8//xdOWMLRxIM3R2+OP5kve
 0uVuO/i/Vwr5zyvuF5y76TXFj7M=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gOC8yLzIzIDIxOjU3LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gT24gOC8yLzIzIDEy
OjUxLCBIZWxnZSBEZWxsZXIgd3JvdGU6DQo+Pj4+IEBAIC0zMTU5LDcgKzMxNDAsNyBAQCBzdGF0
aWMgdm9pZCBsb2FkX2VsZl9pbWFnZShjb25zdCBjaGFyICppbWFnZV9uYW1lLCBpbnQgaW1hZ2Vf
ZmQsDQo+Pj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4+PiDCoMKgwqDCoMKgIGxvYWRfYWRkciA9IHRh
cmdldF9tbWFwKGxvYWRkciwgKHNpemVfdCloaWFkZHIgLSBsb2FkZHIgKyAxLCBQUk9UX05PTkUs
DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTiB8IE1BUF9OT1JFU0VSVkUgfA0KPj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChl
aGRyLT5lX3R5cGUgPT0gRVRfRVhFQyA/IE1BUF9GSVhFRCA6IDApLA0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpc19tYWluX2V4
ZWN1dGFibGUgPyBNQVBfRklYRUQgOiAwKSwNCj4+Pg0KPj4+IFRoaXMgaXMgZGVmaW5pdGVseSB3
cm9uZywgYXMgYWxsIEVUX0VYRUMgcmVxdWlyZSBGSVhFRC4NCj4+DQo+PiBOb3QgaWYgdGhlIFBJ
RSBmbGFnIGlzIHNldCB0b28uLi4NCj4gDQo+IFdoYXQgaW4gdGhlIHdvcmxkIGFyZSB5b3UgdGFs
a2luZyBhYm91dD8NCj4gVGhlcmUgaXMgbm8gIlBJRSBmbGFnIiBpbiBFTEYuDQoNCkkgcHJvYmFi
bHkgdXNlZCB0aGUgd3Jvbmcgd29yZGluZyAoYW5kIG1lYW50IHRoZSBzZW1pLXN0YXRpYyBiaW5h
cmllcw0Kd2hpY2ggc3RpbGwgaGF2ZSBlLmcuIGtsaWJjIGFzIGludGVycHJldGVyKS0NCkFueXdh
eSwgbG9hZGFkZHIgZGVmaW5lcyB0aGUgYWRkcmVzcyBhbHJlYWR5Lg0KDQpIZWxnZQ0K

