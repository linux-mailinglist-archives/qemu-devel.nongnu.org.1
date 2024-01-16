Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD782EA53
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPe9u-0000YN-Di; Tue, 16 Jan 2024 02:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rPe9p-0000Y6-MH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:46:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rPe9n-00068o-Pn
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:46:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e800461baso9750445e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705391205; x=1705996005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JTARQeMMyS+MhbjTtEPPk4K53N2I4p+qv+Tqi6L+9P8=;
 b=K56jBrcRYwc4JGWr83xK9R2/zFPomtAjVC730ZGUonweQMB79YvHkyApDpXxWqOx1i
 YcN8plfHXqfX612jMVvi9+hTUvwmT8DhHXhvEK0uIBh35d0m5xw5l4UYgfgAGJUOIyFA
 h+Itn9Wo5+QKR07FneurtuD5xon9WppzivGiuqxiTzl5QzQ69ciHCPC2IZo5J71bmelq
 FtWb1TOoDbu45Z7KFN24GQ9Z0R8G301a3DRlv5Wcf1Jr2OSBDF5n8+RHj9kRNowKkzH2
 8UAaFdFen8oj7VIPwcXWN4nMxuIk+LB8qNg3V+yZ/sP+jFRzkSfrI1HUB1XRmEnJBk8F
 tkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705391205; x=1705996005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTARQeMMyS+MhbjTtEPPk4K53N2I4p+qv+Tqi6L+9P8=;
 b=dU/KQLhxYbL9h/UMqkPA2+V0K2CpICzTg8VkYM7FQOqQY6KsHld4Lp+2Ml9KJCKS0r
 HWTWHQBmINmRV5VcLDrHNlTDTlOyl0C/RqvejkwyYbqFpCA0vKxHC0vKqWg0qI0vW1Ty
 Zvx4JDG4y8VyMeGbjisUqtCSHfMXtl85mfktafE1LWWxeXSao0kvxVOPV/7xS09Av7u0
 3n+bgRx+r+clUCukQbsVipQWUndb5sRCK1W6Wx9jnZMCPRjsA2MJIqK3cP7UQqD7/JEk
 ZD7vjg0oCA/zs1tgKTbCXPjssInCn0eR3IsXqcWyF72N16HRtzxSSdEp2QsxuXsS8Exf
 yguw==
X-Gm-Message-State: AOJu0Yw560GzlRFkTIcm3qGYBRKqx9S/JoGUUFXYFbrYU1TiwWJ18dqG
 01eEX4tMK30wNTJnoglXx/Io5x+Zb20PCQ==
X-Google-Smtp-Source: AGHT+IGozNRjKQQIJXgpB7sSCE4/u8Z9BtZZn2Xq7Pfhe4E74xkZswOPz9V4raIoSQ8gmqmR55xaJw==
X-Received: by 2002:a05:600c:b55:b0:40e:511e:2029 with SMTP id
 k21-20020a05600c0b5500b0040e511e2029mr1826448wmr.255.1705391205211; 
 Mon, 15 Jan 2024 23:46:45 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 hg14-20020a05600c538e00b0040e5cf9a6c7sm18707289wmb.13.2024.01.15.23.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 23:46:44 -0800 (PST)
Message-ID: <a8c97857-b816-45eb-9c7d-0f3509720c7a@linaro.org>
Date: Tue, 16 Jan 2024 11:46:39 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
 <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
 <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org>
 <87v87yv588.fsf@draig.linaro.org>
 <58065fbd-84f9-4a21-beba-6eb2a18c3d0c@linaro.org>
 <87ply5upbc.fsf@draig.linaro.org>
 <1b976012-7670-4086-88bb-c5097c8fbe0b@linaro.org>
 <87wmsbj7c6.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87wmsbj7c6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x333.google.com
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

T24gMS8xNS8yNCAxMzowNCwgQWxleCBCZW5uw6llIHdyb3RlOj4gUGllcnJpY2sgQm91dmll
ciANCjxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczo+DQo+PiBPbiAxLzEz
LzI0IDIxOjE2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gT24gMS8x
Mi8yNCAyMToyMCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+Pj4gUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4+Pg0KPj4+Pj4+
IE9uIDEvMTEvMjQgMTk6NTcsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+
Pj4+PiBIaSBQaWVycmljaywNCj4+Pj4+Pj4gT24gMTEvMS8yNCAxNToyMywgUGllcnJpY2sg
Qm91dmllciB3cm90ZToNCj4+Pj4+Pj4+IEZvciBub3csIGl0IHNpbXBseSBwZXJmb3JtcyBp
bnN0cnVjdGlvbiwgYmIgYW5kIG1lbSBjb3VudCwgYW5kIGVuc3VyZQ0KPj4+Pj4+Pj4gdGhh
dCBpbmxpbmUgdnMgY2FsbGJhY2sgdmVyc2lvbnMgaGF2ZSB0aGUgc2FtZSByZXN1bHQuIExh
dGVyLCB3ZSdsbA0KPj4+Pj4+Pj4gZXh0ZW5kIGl0IHdoZW4gbmV3IGlubGluZSBvcGVyYXRp
b25zIGFyZSBhZGRlZC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBVc2UgZXhpc3RpbmcgcGx1Z2lu
cyB0byB0ZXN0IGV2ZXJ5dGhpbmcgd29ya3MgaXMgYSBiaXQgY3VtYmVyc29tZSwgYXMNCj4+
Pj4+Pj4+IGRpZmZlcmVudCBldmVudHMgYXJlIHRyZWF0ZWQgaW4gZGlmZmVyZW50IHBsdWdp
bnMuIFRodXMsIHRoaXMgbmV3IG9uZS4NCj4+Pj4+Pj4+DQo+Pj4gPHNuaXA+DQo+Pj4+Pj4+
PiArI2RlZmluZSBNQVhfQ1BVUyA4DQo+Pj4+Pj4+IFdoZXJlIGRvZXMgdGhpcyB2YWx1ZSBj
b21lIGZyb20/DQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgcGx1Z2luIHRlc3RzL3Bs
dWdpbi9pbnNuLmMgaGFkIHRoaXMgY29uc3RhbnQsIHNvIEkgcGlja2VkIGl0IHVwDQo+Pj4+
Pj4gZnJvbSBoZXJlLg0KPj4+Pj4+DQo+Pj4+Pj4+IFNob3VsZCB0aGUgcGx1Z2dpbiBBUEkg
cHJvdmlkZSBhIGhlbHBlciB0byBhc2sgVENHIGhvdyBtYW55DQo+Pj4+Pj4+IHZDUFVzIGFy
ZSBjcmVhdGVkPw0KPj4+Pj4+DQo+Pj4+Pj4gSW4gdXNlciBtb2RlLCB3ZSBjYW4ndCBrbm93
IGhvdyBtYW55IHNpbXVsdGFuZW91cyB0aHJlYWRzIChhbmQgdGh1cw0KPj4+Pj4+IHZjcHUp
IHdpbGwgYmUgdHJpZ2dlcmVkIGJ5IGFkdmFuY2UuIEknbSBub3Qgc3VyZSBpZiBhZGRpdGlv
bmFsIGNwdXMNCj4+Pj4+PiBjYW4gYmUgYWRkZWQgaW4gc3lzdGVtIG1vZGUuDQo+Pj4+Pj4N
Cj4+Pj4+PiBPbmUgcHJvYmxlbSB0aG91Z2gsIGlzIHRoYXQgd2hlbiB5b3UgcmVnaXN0ZXIg
YW4gaW5saW5lIG9wIHdpdGggYQ0KPj4+Pj4+IGR5bmFtaWMgYXJyYXksIHdoZW4geW91IHJl
c2l6ZSBpdCAod2hlbiBkZXRlY3RpbmcgYSBuZXcgdmNwdSksIHlvdQ0KPj4+Pj4+IGNhbid0
IGNoYW5nZSBpdCBhZnRlcndhcmRzLiBTbywgeW91IG5lZWQgYSBzdG9yYWdlIHN0YXRpY2Fs
bHkgc2l6ZWQNCj4+Pj4+PiBzb21ld2hlcmUuDQo+Pj4+Pj4NCj4+Pj4+PiBZb3VyIHF1ZXN0
aW9uIGlzIGdvb2QsIGFuZCBtYXliZSB3ZSBzaG91bGQgZGVmaW5lIGEgTUFYIGNvbnN0YW50
IHRoYXQNCj4+Pj4+PiBwbHVnaW5zIHNob3VsZCByZWx5IG9uLCBpbnN0ZWFkIG9mIGEgcmFu
ZG9tIGFtb3VudC4NCj4+Pj4+IEZvciB1c2VyLW1vZGUgaXQgY2FuIGJlIGluZmluaXRlLiBU
aGUgZXhpc3RpbmcgcGx1Z2lucyBkbyB0aGlzIGJ5DQo+Pj4+PiBlbnN1cmluZyB2Y3B1X2lu
ZGV4ICUgbWF4X3ZjcHUuIFBlcmhhcHMgd2UganVzdCBlbnN1cmUgdGhhdCBmb3IgdGhlDQo+
Pj4+PiBzY29yZWJvYXJkIGFzIHdlbGw/IE9mIGNvdXJzZSB0aGF0IGRvZXMgaW50cm9kdWNl
IGEgdHJhcCBmb3IgdGhvc2UgdXNpbmcNCj4+Pj4+IHVzZXItbW9kZS4uLg0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gVGhlIHByb2JsZW0gd2l0aCB2Y3B1LWluZGV4ICUgbWF4X3ZjcHUgaXMgdGhh
dCBpdCByZWludHJvZHVjZXMgcmFjZQ0KPj4+PiBjb25kaXRpb24sIHRob3VnaCBpdCdzIHBy
b2JhYmx5IGxlc3MgZnJlcXVlbnQgdGhhbiBvbiBhIHNpbmdsZQ0KPj4+PiB2YXJpYWJsZS4g
SU1ITywgeWVzIGl0IHNvbHZlcyBtZW1vcnkgZXJyb3IsIGJ1dCBkb2VzIG5vdCBzb2x2ZSB0
aGUNCj4+Pj4gaW5pdGlhbCBwcm9ibGVtIGl0c2VsZi4NCj4+Pj4NCj4+Pj4gVGhlIHNpbXBs
ZXN0IHNvbHV0aW9uIHdvdWxkIGJlIHRvIGhhdmUgYSBzaXplICJiaWcgZW5vdWdoIiBmb3Ig
bW9zdA0KPj4+PiBjYXNlcywgYW5kIGFib3J0IHdoZW4gaXQncyByZWFjaGVkLg0KPj4+IFdl
bGwgdGhhdCBpcyBzaW1wbGUgZW5vdWdoIGZvciBzeXN0ZW0gZW11bGF0aW9uIGFzIG1heF92
Y3B1cyBpcyBhDQo+Pj4gYm91bmRlZA0KPj4+IG51bWJlci4NCj4+Pg0KPj4+PiBBbm90aGVy
IHNvbHV0aW9uLCBtdWNoIG1vcmUgY29tcGxpY2F0ZWQsIGJ1dCBjb3JyZWN0LCB3b3VsZCBi
ZSB0byBtb3ZlDQo+Pj4+IG1lbW9yeSBtYW5hZ2VtZW50IG9mIHBsdWdpbiBzY29yZWJvYXJk
IHRvIHBsdWdpbiBydW50aW1lLCBhbmQgYWRkIGENCj4+Pj4gbGV2ZWwgb2YgaW5kaXJlY3Rp
b24gdG8gYWNjZXNzIGl0Lg0KPj4+IFRoYXQgY2VydGFpbmx5IGdpdmVzIHVzIHRoZSBtb3N0
IGNvbnRyb2wgYW5kIHNhZmV0eS4gV2UgY2FuIHRoZW4NCj4+PiBlbnN1cmUNCj4+PiB3ZSds
bCBuZXZlciB0byB3cml0aW5nIHBhc3QgdGhlIGJvdW5kcyBvZiB0aGUgYnVmZmVyLiBUaGUg
cGx1Z2luIHdvdWxkDQo+Pj4gaGF2ZSB0byB1c2UgYW4gYWNjZXNzIGZ1bmN0aW9uIHRvIGdl
dCB0aGUgcG9pbnRlciB0byByZWFkIGF0IHRoZSB0aW1lIGl0DQo+Pj4gY2FyZWQgYW5kIG9m
IGNvdXJzZSBpbmxpbmUgY2hlY2tzIHNob3VsZCBiZSBwcmV0dHkgc2ltcGxlLg0KPj4+DQo+
Pj4+IEV2ZXJ5IHRpbWUgYSBuZXcgdmNwdSBpcyBhZGRlZCwgd2UNCj4+Pj4gY2FuIGdyb3cg
ZHluYW1pY2FsbHkuIFRoaXMgd2F5LCB0aGUgYXJyYXkgY2FuIGdyb3csIGFuZCB1bHRpbWF0
ZWx5LA0KPj4+PiBwbHVnaW4gY2FuIHBva2UgaXRzIGNvbnRlbnQvc2l6ZS4gSSdtIG5vdCBz
dXJlIHRoaXMgY29tcGxleGl0eSBpcyB3aGF0DQo+Pj4+IHdlIHdhbnQgdGhvdWdoLg0KPj4+
IEl0IGRvZXNuJ3Qgc2VlbSB0b28gYmFkLiBXZSBoYXZlIGEgc3RhcnQvZW5kX2V4Y2x1c2l2
ZSBpcyAqLXVzZXINCj4+PiBkb19mb3JrDQo+Pj4gd2hlcmUgd2UgY291bGQgdXBkYXRlIHBv
aW50ZXJzLiBJZiB3ZSBhcmUgc21hcnQgYWJvdXQgZ3Jvd2luZyB0aGUgc2l6ZQ0KPj4+IG9m
IHRoZSBhcnJheXMgd2UgY291bGQgYXZvaWQgdG9vIG11Y2ggcmUtdHJhbnNsYXRpb24uDQo+
Pj4NCj4+DQo+PiBJIHdhcyBjb25jZXJuZWQgYWJvdXQgYSBwb3RlbnRpYWwgcmFjZSB3aGVu
IHRoZSBzY29yZWJvYXJkIHVwZGF0ZXMNCj4+IHRoaXMgcG9pbnRlciwgYW5kIG90aGVyIGNw
dXMgYXJlIGV4ZWN1dGluZyB0YiAodXNpbmcgaXQpLiBCdXQgdGhpcw0KPj4gY29uY2VybiBp
cyBub3QgdmFsaWQsIHNpbmNlIHN0YXJ0X2V4Y2x1c2l2ZSBlbnN1cmVzIGFsbCBvdGhlciBj
cHVzIGFyZQ0KPj4gc3RvcHBlZC4NCj4+DQo+PiB2Y3B1X2luaXRfaG9vayBmdW5jdGlvbiBp
biBwbHVnaW5zL2NvcmUuYyBzZWVtcyBhIGdvb2QgbG9jYXRpb24gdG8gYWRkDQo+PiB0aGlz
IGxvZ2ljLiBXZSB3b3VsZCBjaGVjayBpZiBhbiB1cGRhdGUgaXMgbmVlZGVkLCB0aGVuDQo+
PiBzdGFydF9leGNsdXNpdmUoKSwgdXBkYXRlIHRoZSBzY29yZWJvYXJkIGFuZCBleGl0IGV4
Y2x1c2l2ZSBzZWN0aW9uLg0KPiANCj4gSXQgbWlnaHQgYWxyZWFkeSBiZSBpbiB0aGUgZXhj
bHVzaXZlIHNlY3Rpb24uIFdlIHNob3VsZCB0cnkgYW5kIHJlLXVzZQ0KPiBhbiBleGlzdGlu
ZyBleGNsdXNpdmUgcmVnaW9uIHJhdGhlciB0aGFuIGFkZGluZyBhIG5ldyBvbmUuIEl0J3MN
Cj4gZXhwZW5zaXZlIHNvIGJlc3QgYXZvaWRlZCBpZiB3ZSBjYW4uDQo+IA0KPj4gRG8geW91
IHRoaW5rIGl0J3Mgd29ydGggdG8gdHJ5IHRvIGlubGluZSBzY29yZWJvYXJkIHBvaW50ZXIg
KGFuZCBmbHVzaA0KPj4gYWxsIHRiIHdoZW4gdXBkYXRlZCksIGluc3RlYWQgb2Ygc2ltcGx5
IGFkZGluZyBhbiBpbmRpcmVjdGlvbiB0byBpdD8NCj4+IFdpdGggdGhpcywgd2UgY291bGQg
YXZvaWQgYW55IG5lZWQgdG8gcmUtdHJhbnNsYXRlIGFueXRoaW5nLg0KPiANCj4gRGVwZW5k
cyBvbiB0aGUgY29zdC9jb21wbGV4aXR5IG9mIHRoZSBpbmRpcmVjdGlvbiBJIGd1ZXNzLg0K
PiBSZS10cmFuc2xhdGlvbiBpc24ndCBzdXBlciBleHBlbnNpdmUgaWYgd2Ugc2F5IGRvdWJs
ZSB0aGUgc2l6ZSBvZiB0aGUNCj4gc2NvcmUgYm9hcmQgZWFjaCB0aW1lIHdlIG5lZWQgdG8u
DQo+DQo+Pj4gRG8gd2Ugd2FudCBhIGxpbWl0IG9mIG9uZSBzY29yZWJvYXJkIHBlciB0aHJl
YWQ/IENhbiB3ZSBzdG9yZSBzdHJ1Y3R1cmVzDQo+Pj4gaW4gdGhlcmU/DQo+Pj4NCj4+DQo+
PiAgRnJvbSB0aGUgY3VycmVudCBwbHVnaW5zIHVzZSBjYXNlLCBpdCBzZWVtcyB0aGF0IHNl
dmVyYWwgc2NvcmVib2FyZHMNCj4+IGFyZSBuZWVkZWQuDQo+PiBBbGxvd2luZyBzdHJ1Y3R1
cmUgc3RvcmFnZSBzZWVtcyBhIGJpdCBtb3JlIHRyaWNreSB0byBtZSwgYmVjYXVzZQ0KPj4g
c2luY2UgbWVtb3J5IG1heSBiZSByZWFsbG9jYXRlZCwgdXNlcnMgd29uJ3QgYmUgYWxsb3dl
ZCB0byBwb2ludA0KPj4gZGlyZWN0bHkgdG8gaXQuIEkgd291bGQgYmUgaW4gZmF2b3IgdG8g
YXZvaWQgdGhpcyAoY29tbWVudHMgYXJlDQo+PiB3ZWxjb21lKS4NCj4gDQo+IFRoZSBpbml0
IGZ1bmN0aW9uIGNhbiB0YWtlIGEgc2l6ZW9mKGVudHJ5KSBmaWVsZCBhbmQgdGhlIGlubGlu
ZSBvcCBjYW4NCj4gaGF2ZSBhbiBvZmZzZXQgZmllbGQgKHdoaWNoIGZvciB0aGUgc2ltcGxl
IDAgY2FzZSBjYW4gYmUgZm9sZGVkIGF3YXkgYnkNCj4gVENHKS4NCj4gDQoNClRoYW5rcyBm
b3IgYWxsIHlvdXIgY29tbWVudHMgYW5kIGd1aWRhbmNlIG9uIHRoaXMuDQoNCkkgaW1wbGVt
ZW50ZWQgYSBuZXcgdmVyc2lvbiwgd29ya2luZyB3aXRoIGEgc2NvcmVib2FyZCB0aGF0IGdl
dHMgcmVzaXplZCANCmF1dG9tYXRpY2FsbHksIHdoaWNoIGFsbG93cyB1c2FnZSBvZiBzdHJ1
Y3RzIGFzIHdlbGwuIFRoZSByZXN1bHQgaXMgDQpwcmV0dHkgc2F0aXNmeWluZyBhcyB0aGVy
ZSBpcyBhbG1vc3Qgbm8gbW9yZSBuZWVkIHRvIG1hbnVhbGx5IGtlZXAgdHJhY2sgDQpvZiBo
b3cgbWFueSBjcHVzIGhhdmUgYmVlbiB1c2VkLCB3aGlsZSBvZmZlcmluZyB0aHJlYWQtc2Fm
ZXR5IGJ5IGRlZmF1bHQuDQoNCkknbGwgcmUtc3BpbiB0aGUgc2VyaWUgb25jZSBJIGNsZWFu
ZWQgdXAgY29tbWl0cywgYW5kIHBvcnRlZCBleGlzdGluZyANCnBsdWdpbnMgdG8gdGhpcy4N
Cg==

