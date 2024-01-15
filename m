Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB982D46D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:06:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPH2z-0006Vm-Ch; Mon, 15 Jan 2024 02:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rPH2w-0006VX-To
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:06:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rPH2u-0004CS-Ua
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:06:10 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so8654407f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 23:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705302366; x=1705907166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FH2pl8n/DBkv8hTnYicoJ8L7NbsAaNZfH9DW4gaXrA=;
 b=trgqDZ2sxm4qc0iUgRfq6eFG6VqgwqVAJy9Kv2JBblCcC7MPt1aWAuUlbk89DbNbPm
 YwU8QbqYcd8BsoXRL4lfV0JY0RS0Zn8n63QrkuS50lARCTJQvQ1B6SvyGFP/K8qUmBjp
 Yy5x95LWD3ZyXsl6TWyxa15P+96akJTrF6PVDxLIz/5SHS4TnOnc2a3dc6b6uhJkUrhR
 D+/3H2Kiv8E+JR42by0PS+R/S+7gBLk1ijPjtGQZQ3V0pXADcauF5yVyHAjkbrdxg/Cp
 MgHz17n53BCzYOJUHY7TAbgPHsneFIWZGivP7XJj+AtGXE+uqiIzUpzi1ZrlI1UaVnHN
 AVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705302366; x=1705907166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3FH2pl8n/DBkv8hTnYicoJ8L7NbsAaNZfH9DW4gaXrA=;
 b=beXsIaC7g/0+zTASWCAp0HsMuQPQCm+Ty3yn4pfQ/s1iF8X8Qy7C1TiMV6tTVWXLEw
 cUq/9SYKh/6wJMoy/rVlND3Zc0tKI9/VsQacMgzCJGBMP+9ezRnKiBvtugxAVE9lVzCb
 ml20LamTUKo/TMaUYNg8z6ldjz3otlFed9+38dFFpeYfJwYohlzQH+ZnV5Z0Czsd0cki
 +4i52McWBGxSMp5bNSjSuoJyJrlKS+2rAbq5gwJ9J+W6Hat/04y4bg74mQutyV8uaW9I
 wNkTGBamDrsasTvmv7MS4777gOvledTHEcsH958fHwrjAdjc+ra6tNgWQPjLm1ClfeW+
 aaMA==
X-Gm-Message-State: AOJu0Yyw60/axQ67HIowvxeiFNsT8YchwHiBQ0fqHOyYzbahLbF7zKik
 sRlBUD1O9UWVb6YtCXtvJH7tQLNBiLzPMA==
X-Google-Smtp-Source: AGHT+IEWhTAM/xShoa7mdxDYKRkwiEsoEAFYr4PbcYIrwdIC2PGJKkPjIOtizK4nYqeFCh80h3sF/w==
X-Received: by 2002:a5d:5709:0:b0:337:a6fc:1d8a with SMTP id
 a9-20020a5d5709000000b00337a6fc1d8amr385535wrv.84.1705302366438; 
 Sun, 14 Jan 2024 23:06:06 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a5d4c85000000b003367ff4aadasm10993741wrs.31.2024.01.14.23.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 23:06:06 -0800 (PST)
Message-ID: <1b976012-7670-4086-88bb-c5097c8fbe0b@linaro.org>
Date: Mon, 15 Jan 2024 11:06:01 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
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
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ply5upbc.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

T24gMS8xMy8yNCAyMToxNiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAx
LzEyLzI0IDIxOjIwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gT24g
MS8xMS8yNCAxOTo1NywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+PiBI
aSBQaWVycmljaywNCj4+Pj4+IE9uIDExLzEvMjQgMTU6MjMsIFBpZXJyaWNrIEJvdXZpZXIg
d3JvdGU6DQo+Pj4+Pj4gRm9yIG5vdywgaXQgc2ltcGx5IHBlcmZvcm1zIGluc3RydWN0aW9u
LCBiYiBhbmQgbWVtIGNvdW50LCBhbmQgZW5zdXJlDQo+Pj4+Pj4gdGhhdCBpbmxpbmUgdnMg
Y2FsbGJhY2sgdmVyc2lvbnMgaGF2ZSB0aGUgc2FtZSByZXN1bHQuIExhdGVyLCB3ZSdsbA0K
Pj4+Pj4+IGV4dGVuZCBpdCB3aGVuIG5ldyBpbmxpbmUgb3BlcmF0aW9ucyBhcmUgYWRkZWQu
DQo+Pj4+Pj4NCj4+Pj4+PiBVc2UgZXhpc3RpbmcgcGx1Z2lucyB0byB0ZXN0IGV2ZXJ5dGhp
bmcgd29ya3MgaXMgYSBiaXQgY3VtYmVyc29tZSwgYXMNCj4+Pj4+PiBkaWZmZXJlbnQgZXZl
bnRzIGFyZSB0cmVhdGVkIGluIGRpZmZlcmVudCBwbHVnaW5zLiBUaHVzLCB0aGlzIG5ldyBv
bmUuDQo+Pj4+Pj4NCj4gPHNuaXA+DQo+Pj4+Pj4gKyNkZWZpbmUgTUFYX0NQVVMgOA0KPj4+
Pj4gV2hlcmUgZG9lcyB0aGlzIHZhbHVlIGNvbWUgZnJvbT8NCj4+Pj4+DQo+Pj4+DQo+Pj4+
IFRoZSBwbHVnaW4gdGVzdHMvcGx1Z2luL2luc24uYyBoYWQgdGhpcyBjb25zdGFudCwgc28g
SSBwaWNrZWQgaXQgdXANCj4+Pj4gZnJvbSBoZXJlLg0KPj4+Pg0KPj4+Pj4gU2hvdWxkIHRo
ZSBwbHVnZ2luIEFQSSBwcm92aWRlIGEgaGVscGVyIHRvIGFzayBUQ0cgaG93IG1hbnkNCj4+
Pj4+IHZDUFVzIGFyZSBjcmVhdGVkPw0KPj4+Pg0KPj4+PiBJbiB1c2VyIG1vZGUsIHdlIGNh
bid0IGtub3cgaG93IG1hbnkgc2ltdWx0YW5lb3VzIHRocmVhZHMgKGFuZCB0aHVzDQo+Pj4+
IHZjcHUpIHdpbGwgYmUgdHJpZ2dlcmVkIGJ5IGFkdmFuY2UuIEknbSBub3Qgc3VyZSBpZiBh
ZGRpdGlvbmFsIGNwdXMNCj4+Pj4gY2FuIGJlIGFkZGVkIGluIHN5c3RlbSBtb2RlLg0KPj4+
Pg0KPj4+PiBPbmUgcHJvYmxlbSB0aG91Z2gsIGlzIHRoYXQgd2hlbiB5b3UgcmVnaXN0ZXIg
YW4gaW5saW5lIG9wIHdpdGggYQ0KPj4+PiBkeW5hbWljIGFycmF5LCB3aGVuIHlvdSByZXNp
emUgaXQgKHdoZW4gZGV0ZWN0aW5nIGEgbmV3IHZjcHUpLCB5b3UNCj4+Pj4gY2FuJ3QgY2hh
bmdlIGl0IGFmdGVyd2FyZHMuIFNvLCB5b3UgbmVlZCBhIHN0b3JhZ2Ugc3RhdGljYWxseSBz
aXplZA0KPj4+PiBzb21ld2hlcmUuDQo+Pj4+DQo+Pj4+IFlvdXIgcXVlc3Rpb24gaXMgZ29v
ZCwgYW5kIG1heWJlIHdlIHNob3VsZCBkZWZpbmUgYSBNQVggY29uc3RhbnQgdGhhdA0KPj4+
PiBwbHVnaW5zIHNob3VsZCByZWx5IG9uLCBpbnN0ZWFkIG9mIGEgcmFuZG9tIGFtb3VudC4N
Cj4+PiBGb3IgdXNlci1tb2RlIGl0IGNhbiBiZSBpbmZpbml0ZS4gVGhlIGV4aXN0aW5nIHBs
dWdpbnMgZG8gdGhpcyBieQ0KPj4+IGVuc3VyaW5nIHZjcHVfaW5kZXggJSBtYXhfdmNwdS4g
UGVyaGFwcyB3ZSBqdXN0IGVuc3VyZSB0aGF0IGZvciB0aGUNCj4+PiBzY29yZWJvYXJkIGFz
IHdlbGw/IE9mIGNvdXJzZSB0aGF0IGRvZXMgaW50cm9kdWNlIGEgdHJhcCBmb3IgdGhvc2Ug
dXNpbmcNCj4+PiB1c2VyLW1vZGUuLi4NCj4+Pg0KPj4NCj4+IFRoZSBwcm9ibGVtIHdpdGgg
dmNwdS1pbmRleCAlIG1heF92Y3B1IGlzIHRoYXQgaXQgcmVpbnRyb2R1Y2VzIHJhY2UNCj4+
IGNvbmRpdGlvbiwgdGhvdWdoIGl0J3MgcHJvYmFibHkgbGVzcyBmcmVxdWVudCB0aGFuIG9u
IGEgc2luZ2xlDQo+PiB2YXJpYWJsZS4gSU1ITywgeWVzIGl0IHNvbHZlcyBtZW1vcnkgZXJy
b3IsIGJ1dCBkb2VzIG5vdCBzb2x2ZSB0aGUNCj4+IGluaXRpYWwgcHJvYmxlbSBpdHNlbGYu
DQo+Pg0KPj4gVGhlIHNpbXBsZXN0IHNvbHV0aW9uIHdvdWxkIGJlIHRvIGhhdmUgYSBzaXpl
ICJiaWcgZW5vdWdoIiBmb3IgbW9zdA0KPj4gY2FzZXMsIGFuZCBhYm9ydCB3aGVuIGl0J3Mg
cmVhY2hlZC4NCj4gDQo+IFdlbGwgdGhhdCBpcyBzaW1wbGUgZW5vdWdoIGZvciBzeXN0ZW0g
ZW11bGF0aW9uIGFzIG1heF92Y3B1cyBpcyBhIGJvdW5kZWQNCj4gbnVtYmVyLg0KPiANCj4+
IEFub3RoZXIgc29sdXRpb24sIG11Y2ggbW9yZSBjb21wbGljYXRlZCwgYnV0IGNvcnJlY3Qs
IHdvdWxkIGJlIHRvIG1vdmUNCj4+IG1lbW9yeSBtYW5hZ2VtZW50IG9mIHBsdWdpbiBzY29y
ZWJvYXJkIHRvIHBsdWdpbiBydW50aW1lLCBhbmQgYWRkIGENCj4+IGxldmVsIG9mIGluZGly
ZWN0aW9uIHRvIGFjY2VzcyBpdC4NCj4gDQo+IFRoYXQgY2VydGFpbmx5IGdpdmVzIHVzIHRo
ZSBtb3N0IGNvbnRyb2wgYW5kIHNhZmV0eS4gV2UgY2FuIHRoZW4gZW5zdXJlDQo+IHdlJ2xs
IG5ldmVyIHRvIHdyaXRpbmcgcGFzdCB0aGUgYm91bmRzIG9mIHRoZSBidWZmZXIuIFRoZSBw
bHVnaW4gd291bGQNCj4gaGF2ZSB0byB1c2UgYW4gYWNjZXNzIGZ1bmN0aW9uIHRvIGdldCB0
aGUgcG9pbnRlciB0byByZWFkIGF0IHRoZSB0aW1lIGl0DQo+IGNhcmVkIGFuZCBvZiBjb3Vy
c2UgaW5saW5lIGNoZWNrcyBzaG91bGQgYmUgcHJldHR5IHNpbXBsZS4NCj4gDQo+PiBFdmVy
eSB0aW1lIGEgbmV3IHZjcHUgaXMgYWRkZWQsIHdlDQo+PiBjYW4gZ3JvdyBkeW5hbWljYWxs
eS4gVGhpcyB3YXksIHRoZSBhcnJheSBjYW4gZ3JvdywgYW5kIHVsdGltYXRlbHksDQo+PiBw
bHVnaW4gY2FuIHBva2UgaXRzIGNvbnRlbnQvc2l6ZS4gSSdtIG5vdCBzdXJlIHRoaXMgY29t
cGxleGl0eSBpcyB3aGF0DQo+PiB3ZSB3YW50IHRob3VnaC4NCj4gDQo+IEl0IGRvZXNuJ3Qg
c2VlbSB0b28gYmFkLiBXZSBoYXZlIGEgc3RhcnQvZW5kX2V4Y2x1c2l2ZSBpcyAqLXVzZXIg
ZG9fZm9yaw0KPiB3aGVyZSB3ZSBjb3VsZCB1cGRhdGUgcG9pbnRlcnMuIElmIHdlIGFyZSBz
bWFydCBhYm91dCBncm93aW5nIHRoZSBzaXplDQo+IG9mIHRoZSBhcnJheXMgd2UgY291bGQg
YXZvaWQgdG9vIG11Y2ggcmUtdHJhbnNsYXRpb24uDQo+DQoNCkkgd2FzIGNvbmNlcm5lZCBh
Ym91dCBhIHBvdGVudGlhbCByYWNlIHdoZW4gdGhlIHNjb3JlYm9hcmQgdXBkYXRlcyB0aGlz
IA0KcG9pbnRlciwgYW5kIG90aGVyIGNwdXMgYXJlIGV4ZWN1dGluZyB0YiAodXNpbmcgaXQp
LiBCdXQgdGhpcyBjb25jZXJuIGlzIA0Kbm90IHZhbGlkLCBzaW5jZSBzdGFydF9leGNsdXNp
dmUgZW5zdXJlcyBhbGwgb3RoZXIgY3B1cyBhcmUgc3RvcHBlZC4NCg0KdmNwdV9pbml0X2hv
b2sgZnVuY3Rpb24gaW4gcGx1Z2lucy9jb3JlLmMgc2VlbXMgYSBnb29kIGxvY2F0aW9uIHRv
IGFkZCANCnRoaXMgbG9naWMuIFdlIHdvdWxkIGNoZWNrIGlmIGFuIHVwZGF0ZSBpcyBuZWVk
ZWQsIHRoZW4gDQpzdGFydF9leGNsdXNpdmUoKSwgdXBkYXRlIHRoZSBzY29yZWJvYXJkIGFu
ZCBleGl0IGV4Y2x1c2l2ZSBzZWN0aW9uLg0KDQpEbyB5b3UgdGhpbmsgaXQncyB3b3J0aCB0
byB0cnkgdG8gaW5saW5lIHNjb3JlYm9hcmQgcG9pbnRlciAoYW5kIGZsdXNoIA0KYWxsIHRi
IHdoZW4gdXBkYXRlZCksIGluc3RlYWQgb2Ygc2ltcGx5IGFkZGluZyBhbiBpbmRpcmVjdGlv
biB0byBpdD8gDQpXaXRoIHRoaXMsIHdlIGNvdWxkIGF2b2lkIGFueSBuZWVkIHRvIHJlLXRy
YW5zbGF0ZSBhbnl0aGluZy4NCg0KPiBEbyB3ZSB3YW50IGEgbGltaXQgb2Ygb25lIHNjb3Jl
Ym9hcmQgcGVyIHRocmVhZD8gQ2FuIHdlIHN0b3JlIHN0cnVjdHVyZXMNCj4gaW4gdGhlcmU/
DQo+IA0KDQogRnJvbSB0aGUgY3VycmVudCBwbHVnaW5zIHVzZSBjYXNlLCBpdCBzZWVtcyB0
aGF0IHNldmVyYWwgc2NvcmVib2FyZHMgDQphcmUgbmVlZGVkLg0KQWxsb3dpbmcgc3RydWN0
dXJlIHN0b3JhZ2Ugc2VlbXMgYSBiaXQgbW9yZSB0cmlja3kgdG8gbWUsIGJlY2F1c2Ugc2lu
Y2UgDQptZW1vcnkgbWF5IGJlIHJlYWxsb2NhdGVkLCB1c2VycyB3b24ndCBiZSBhbGxvd2Vk
IHRvIHBvaW50IGRpcmVjdGx5IHRvIA0KaXQuIEkgd291bGQgYmUgaW4gZmF2b3IgdG8gYXZv
aWQgdGhpcyAoY29tbWVudHMgYXJlIHdlbGNvbWUpLg0K

