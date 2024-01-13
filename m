Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D5182C96D
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:18:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOWNt-0000y4-Pb; Sat, 13 Jan 2024 00:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rOWNo-0000xf-GD
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:16:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rOWNm-0003M4-MP
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:16:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e69b31366so6395445e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705122992; x=1705727792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7GMkNroX+RkFHF0ziDX7ki84Q4nz/gkakKKxLHbXdc=;
 b=ws/MFxctmq64F1T/s+p90MSaDRQVFASiN/DNG1dpQjLCWHXjHuneI2VMlVodE0ZhGJ
 reTVdR/r16uxPx9Z4Guft7Ch1ZKiI0zbSADW8r7mMuf1j33mMwdtvb9m1SxJSIMsjMRL
 G+ixmth1LyBpMe5seaNa9MQiv504lPNHvbeDCHxVdgQBqjdWJXLubzI73FFaK4mvDkiK
 HfDAtF6pk/1Yx0wPbMfTFvJFabIhGSCqtzcTycuRkubJPaWc33fODgc3CRqrCVs/4FxH
 W3nJku4OpxjUcK4ueS3XKjLCpyYZlk+fWaReOQwD0JyPFpPvJkcRoCV35+nB6mbiL5VN
 hUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705122992; x=1705727792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7GMkNroX+RkFHF0ziDX7ki84Q4nz/gkakKKxLHbXdc=;
 b=NqzdMalP82mzQ2OxrrlTNy8t34vJDcpHeGuuRXeACQNMWrgf9l1PPFAUB8lEoQp0YJ
 58qxhZrS90JskFxwnm8y5tLh1kG/bwKeMWqEov34WKnxm/2xqYcKHbFY54onc37y508z
 03JEBKNAqHgnEq4gRniVf47+GOUkxuWv8lWnzahmoGAfhgP8sqojtwV1QmC++j826Hv7
 g8ecwFxUxx7kqwtAgwD54Vewe+kQ5psA4mlp7GpuUR57hkg1/sPBlwef22Tvu8f97I1z
 y8WSS0wP0GXXsPZcewUEwS6FbnHOB210sOnnpdVokO172drv3I5HCwjxZatFlywc3uHC
 nuYA==
X-Gm-Message-State: AOJu0YxqENUVZtAB7wYbtoMpCSwX4Y0yCdw75CZMd0VadXgIRkLQIMlw
 3EGs0kg6BEplqduONinzXJCTHKEIdJYGDg==
X-Google-Smtp-Source: AGHT+IHaUtTL8xa+2qz0tV5FkNu9h10oYygGjH8t0dOmWTzd8UXjMpwKFV5QiTCnqzeJbGYrCRNp3Q==
X-Received: by 2002:a05:600c:4e48:b0:40d:39cb:6af6 with SMTP id
 e8-20020a05600c4e4800b0040d39cb6af6mr1374708wmq.28.1705122991819; 
 Fri, 12 Jan 2024 21:16:31 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a5d4e4c000000b003375083ff8esm5655290wrt.32.2024.01.12.21.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 21:16:31 -0800 (PST)
Message-ID: <58065fbd-84f9-4a21-beba-6eb2a18c3d0c@linaro.org>
Date: Sat, 13 Jan 2024 09:16:27 +0400
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v87yv588.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

T24gMS8xMi8yNCAyMToyMCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAx
LzExLzI0IDE5OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBIaSBQ
aWVycmljaywNCj4+PiBPbiAxMS8xLzI0IDE1OjIzLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPj4+PiBGb3Igbm93LCBpdCBzaW1wbHkgcGVyZm9ybXMgaW5zdHJ1Y3Rpb24sIGJiIGFu
ZCBtZW0gY291bnQsIGFuZCBlbnN1cmUNCj4+Pj4gdGhhdCBpbmxpbmUgdnMgY2FsbGJhY2sg
dmVyc2lvbnMgaGF2ZSB0aGUgc2FtZSByZXN1bHQuIExhdGVyLCB3ZSdsbA0KPj4+PiBleHRl
bmQgaXQgd2hlbiBuZXcgaW5saW5lIG9wZXJhdGlvbnMgYXJlIGFkZGVkLg0KPj4+Pg0KPj4+
PiBVc2UgZXhpc3RpbmcgcGx1Z2lucyB0byB0ZXN0IGV2ZXJ5dGhpbmcgd29ya3MgaXMgYSBi
aXQgY3VtYmVyc29tZSwgYXMNCj4+Pj4gZGlmZmVyZW50IGV2ZW50cyBhcmUgdHJlYXRlZCBp
biBkaWZmZXJlbnQgcGx1Z2lucy4gVGh1cywgdGhpcyBuZXcgb25lLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAgICAgdGVzdHMvcGx1Z2luL2lubGluZS5jICAgIHwg
MTgzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAg
dGVzdHMvcGx1Z2luL21lc29uLmJ1aWxkIHwgICAyICstDQo+Pj4+ICAgICAyIGZpbGVzIGNo
YW5nZWQsIDE4NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+ICAgICBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvcGx1Z2luL2lubGluZS5jDQo+Pj4NCj4+Pj4gKyNkZWZp
bmUgTUFYX0NQVVMgOA0KPj4+IFdoZXJlIGRvZXMgdGhpcyB2YWx1ZSBjb21lIGZyb20/DQo+
Pj4NCj4+DQo+PiBUaGUgcGx1Z2luIHRlc3RzL3BsdWdpbi9pbnNuLmMgaGFkIHRoaXMgY29u
c3RhbnQsIHNvIEkgcGlja2VkIGl0IHVwDQo+PiBmcm9tIGhlcmUuDQo+Pg0KPj4+IFNob3Vs
ZCB0aGUgcGx1Z2dpbiBBUEkgcHJvdmlkZSBhIGhlbHBlciB0byBhc2sgVENHIGhvdyBtYW55
DQo+Pj4gdkNQVXMgYXJlIGNyZWF0ZWQ/DQo+Pg0KPj4gSW4gdXNlciBtb2RlLCB3ZSBjYW4n
dCBrbm93IGhvdyBtYW55IHNpbXVsdGFuZW91cyB0aHJlYWRzIChhbmQgdGh1cw0KPj4gdmNw
dSkgd2lsbCBiZSB0cmlnZ2VyZWQgYnkgYWR2YW5jZS4gSSdtIG5vdCBzdXJlIGlmIGFkZGl0
aW9uYWwgY3B1cw0KPj4gY2FuIGJlIGFkZGVkIGluIHN5c3RlbSBtb2RlLg0KPj4NCj4+IE9u
ZSBwcm9ibGVtIHRob3VnaCwgaXMgdGhhdCB3aGVuIHlvdSByZWdpc3RlciBhbiBpbmxpbmUg
b3Agd2l0aCBhDQo+PiBkeW5hbWljIGFycmF5LCB3aGVuIHlvdSByZXNpemUgaXQgKHdoZW4g
ZGV0ZWN0aW5nIGEgbmV3IHZjcHUpLCB5b3UNCj4+IGNhbid0IGNoYW5nZSBpdCBhZnRlcndh
cmRzLiBTbywgeW91IG5lZWQgYSBzdG9yYWdlIHN0YXRpY2FsbHkgc2l6ZWQNCj4+IHNvbWV3
aGVyZS4NCj4+DQo+PiBZb3VyIHF1ZXN0aW9uIGlzIGdvb2QsIGFuZCBtYXliZSB3ZSBzaG91
bGQgZGVmaW5lIGEgTUFYIGNvbnN0YW50IHRoYXQNCj4+IHBsdWdpbnMgc2hvdWxkIHJlbHkg
b24sIGluc3RlYWQgb2YgYSByYW5kb20gYW1vdW50Lg0KPiANCj4gRm9yIHVzZXItbW9kZSBp
dCBjYW4gYmUgaW5maW5pdGUuIFRoZSBleGlzdGluZyBwbHVnaW5zIGRvIHRoaXMgYnkNCj4g
ZW5zdXJpbmcgdmNwdV9pbmRleCAlIG1heF92Y3B1LiBQZXJoYXBzIHdlIGp1c3QgZW5zdXJl
IHRoYXQgZm9yIHRoZQ0KPiBzY29yZWJvYXJkIGFzIHdlbGw/IE9mIGNvdXJzZSB0aGF0IGRv
ZXMgaW50cm9kdWNlIGEgdHJhcCBmb3IgdGhvc2UgdXNpbmcNCj4gdXNlci1tb2RlLi4uDQo+
IA0KDQpUaGUgcHJvYmxlbSB3aXRoIHZjcHUtaW5kZXggJSBtYXhfdmNwdSBpcyB0aGF0IGl0
IHJlaW50cm9kdWNlcyByYWNlIA0KY29uZGl0aW9uLCB0aG91Z2ggaXQncyBwcm9iYWJseSBs
ZXNzIGZyZXF1ZW50IHRoYW4gb24gYSBzaW5nbGUgdmFyaWFibGUuIA0KSU1ITywgeWVzIGl0
IHNvbHZlcyBtZW1vcnkgZXJyb3IsIGJ1dCBkb2VzIG5vdCBzb2x2ZSB0aGUgaW5pdGlhbCBw
cm9ibGVtIA0KaXRzZWxmLg0KDQpUaGUgc2ltcGxlc3Qgc29sdXRpb24gd291bGQgYmUgdG8g
aGF2ZSBhIHNpemUgImJpZyBlbm91Z2giIGZvciBtb3N0IA0KY2FzZXMsIGFuZCBhYm9ydCB3
aGVuIGl0J3MgcmVhY2hlZC4NCg0KQW5vdGhlciBzb2x1dGlvbiwgbXVjaCBtb3JlIGNvbXBs
aWNhdGVkLCBidXQgY29ycmVjdCwgd291bGQgYmUgdG8gbW92ZSANCm1lbW9yeSBtYW5hZ2Vt
ZW50IG9mIHBsdWdpbiBzY29yZWJvYXJkIHRvIHBsdWdpbiBydW50aW1lLCBhbmQgYWRkIGEg
DQpsZXZlbCBvZiBpbmRpcmVjdGlvbiB0byBhY2Nlc3MgaXQuIEV2ZXJ5IHRpbWUgYSBuZXcg
dmNwdSBpcyBhZGRlZCwgd2UgDQpjYW4gZ3JvdyBkeW5hbWljYWxseS4gVGhpcyB3YXksIHRo
ZSBhcnJheSBjYW4gZ3JvdywgYW5kIHVsdGltYXRlbHksIA0KcGx1Z2luIGNhbiBwb2tlIGl0
cyBjb250ZW50L3NpemUuIEknbSBub3Qgc3VyZSB0aGlzIGNvbXBsZXhpdHkgaXMgd2hhdCAN
CndlIHdhbnQgdGhvdWdoLg0K

