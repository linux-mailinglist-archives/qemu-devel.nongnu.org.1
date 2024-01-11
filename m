Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EE82B3F0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:21:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyjg-0005s5-Ez; Thu, 11 Jan 2024 12:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNyjd-0005ox-On
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:20:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNyjb-0005gQ-Vj
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:20:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so26746585e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 09:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704993650; x=1705598450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYJGfaWD+wmivfyM5OCQmiMNo/7Sa4bLA5yRLCAhZtI=;
 b=LYBi2fyqAlKIX71TVFZcpdZnl82W+uPu8je41HMkzvdNUMrw65vZo2cLxkoNhgprm1
 kNHw8I1HFIt3eptuJd11DZHRZQcwbVtT8UHJ6NdbjcOEy1NXXtkmK4UpPF6OKSG4OrCA
 3IbZYq5N21NrGUaSXUDjQJFy7Hl0ly7dDMU0d19zBHlBrJwx7R8PmWxPOAHUMkIB0XZU
 HSEMI9xgP/j8FhKGJkeaeQHYR3KWldSHKzJOsAJiD8a4Q+a0YPWa6UY449huVsPqR5TW
 TdD9vkAuV5Rxx0FJwxou4x2oycmbw/TYPdFfOC2ufZ188lxWphWoDzhB8YfgWEdgEgIP
 Vukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704993650; x=1705598450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYJGfaWD+wmivfyM5OCQmiMNo/7Sa4bLA5yRLCAhZtI=;
 b=QpNqQFJB3mEHfdJ2Mweru0dsq8N8FIORr50h4HZ+o7bGWubsUN0IO9ns+GaiV2RL01
 Hp4cIHbh31KAq4qh0Q8uSNz1VR63LIpWGqpykL0mwHdwEBbCwKZmdpeFR60ukURQOV0A
 8JrgqnL0LbA7R6KvI/awaCtihmLp3JOhGoMdP+dOuuKGIkEKJmzOOGtQduibWdgRwskc
 y2d2GvAuJ4fkph9WOU+dgGaYc22RxcG+jo6t7WGnA+ON+8FPuxJXhtJLGPpeu/ofhTJT
 Lk0qsBc0Q/0rHMlaT44XNzeECQxsRXKojAkoL9+vzXq26d5bev5zlmvXBxS1AeV8zGx/
 WxHA==
X-Gm-Message-State: AOJu0Yzi55fqSZ8Z+AhouJxdJMseWRchHkjQrT9PD0qZZF1h6BFV57vL
 oQwJRiVcN2hPvCKvmHDM1nSmgc/ALeFF7Q==
X-Google-Smtp-Source: AGHT+IFUOPnneDLEvm/VylQSR5PHUVfIruZDMjYw8SHK/cCh0SBRsWhOpadsqGNbUEwIi2pf1fSmEw==
X-Received: by 2002:a05:600c:358b:b0:40e:4560:6cf5 with SMTP id
 p11-20020a05600c358b00b0040e45606cf5mr102138wmq.25.1704993650314; 
 Thu, 11 Jan 2024 09:20:50 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b0040d839e7bb3sm6626509wmb.19.2024.01.11.09.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 09:20:50 -0800 (PST)
Message-ID: <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org>
Date: Thu, 11 Jan 2024 21:20:45 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
 <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gMS8xMS8yNCAxOTo1NywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEhp
IFBpZXJyaWNrLA0KPiANCj4gT24gMTEvMS8yNCAxNToyMywgUGllcnJpY2sgQm91dmllciB3
cm90ZToNCj4+IEZvciBub3csIGl0IHNpbXBseSBwZXJmb3JtcyBpbnN0cnVjdGlvbiwgYmIg
YW5kIG1lbSBjb3VudCwgYW5kIGVuc3VyZQ0KPj4gdGhhdCBpbmxpbmUgdnMgY2FsbGJhY2sg
dmVyc2lvbnMgaGF2ZSB0aGUgc2FtZSByZXN1bHQuIExhdGVyLCB3ZSdsbA0KPj4gZXh0ZW5k
IGl0IHdoZW4gbmV3IGlubGluZSBvcGVyYXRpb25zIGFyZSBhZGRlZC4NCj4+DQo+PiBVc2Ug
ZXhpc3RpbmcgcGx1Z2lucyB0byB0ZXN0IGV2ZXJ5dGhpbmcgd29ya3MgaXMgYSBiaXQgY3Vt
YmVyc29tZSwgYXMNCj4+IGRpZmZlcmVudCBldmVudHMgYXJlIHRyZWF0ZWQgaW4gZGlmZmVy
ZW50IHBsdWdpbnMuIFRodXMsIHRoaXMgbmV3IG9uZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+PiAt
LS0NCj4+ICAgIHRlc3RzL3BsdWdpbi9pbmxpbmUuYyAgICB8IDE4MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgIHRlc3RzL3BsdWdpbi9tZXNvbi5i
dWlsZCB8ICAgMiArLQ0KPj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxODQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3BsdWdp
bi9pbmxpbmUuYw0KPiANCj4+ICsjZGVmaW5lIE1BWF9DUFVTIDgNCj4gDQo+IFdoZXJlIGRv
ZXMgdGhpcyB2YWx1ZSBjb21lIGZyb20/DQo+IA0KDQpUaGUgcGx1Z2luIHRlc3RzL3BsdWdp
bi9pbnNuLmMgaGFkIHRoaXMgY29uc3RhbnQsIHNvIEkgcGlja2VkIGl0IHVwIGZyb20gDQpo
ZXJlLg0KDQo+IFNob3VsZCB0aGUgcGx1Z2dpbiBBUEkgcHJvdmlkZSBhIGhlbHBlciB0byBh
c2sgVENHIGhvdyBtYW55DQo+IHZDUFVzIGFyZSBjcmVhdGVkPw0KDQpJbiB1c2VyIG1vZGUs
IHdlIGNhbid0IGtub3cgaG93IG1hbnkgc2ltdWx0YW5lb3VzIHRocmVhZHMgKGFuZCB0aHVz
IA0KdmNwdSkgd2lsbCBiZSB0cmlnZ2VyZWQgYnkgYWR2YW5jZS4gSSdtIG5vdCBzdXJlIGlm
IGFkZGl0aW9uYWwgY3B1cyBjYW4gDQpiZSBhZGRlZCBpbiBzeXN0ZW0gbW9kZS4NCg0KT25l
IHByb2JsZW0gdGhvdWdoLCBpcyB0aGF0IHdoZW4geW91IHJlZ2lzdGVyIGFuIGlubGluZSBv
cCB3aXRoIGEgDQpkeW5hbWljIGFycmF5LCB3aGVuIHlvdSByZXNpemUgaXQgKHdoZW4gZGV0
ZWN0aW5nIGEgbmV3IHZjcHUpLCB5b3UgY2FuJ3QgDQpjaGFuZ2UgaXQgYWZ0ZXJ3YXJkcy4g
U28sIHlvdSBuZWVkIGEgc3RvcmFnZSBzdGF0aWNhbGx5IHNpemVkIHNvbWV3aGVyZS4NCg0K
WW91ciBxdWVzdGlvbiBpcyBnb29kLCBhbmQgbWF5YmUgd2Ugc2hvdWxkIGRlZmluZSBhIE1B
WCBjb25zdGFudCB0aGF0IA0KcGx1Z2lucyBzaG91bGQgcmVseSBvbiwgaW5zdGVhZCBvZiBh
IHJhbmRvbSBhbW91bnQuDQo=

