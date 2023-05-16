Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D90587052B9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywtT-00071t-7Y; Tue, 16 May 2023 11:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pywtI-0006zr-VR; Tue, 16 May 2023 11:47:10 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pywtB-0002Ko-RW; Tue, 16 May 2023 11:47:08 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-19638b3a304so6366799fac.1; 
 Tue, 16 May 2023 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684252019; x=1686844019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ujicVO9KdE17e/bccZpvl07tnVh1owFaMJObt6IfOk=;
 b=MEUZo7zZPDObMRnxHkTStFTj8G63hkeItvDX6L3vmv4cCCH1tPYMW6+/MiTX4ODdIn
 Ihq7F0jAlhk4wjfxqco5cwmEZGLlqFBR89Yxnrw3sYR1OEeWpq2kB7bgokwBx6MZzqvt
 F0nyH3nfmcLsBS2FFWRvTF42JeOhgPYBfHc3RsfskcmFZpdxQVON/g9mfanpNVnU6w/F
 321A0bGOdPvzRmYy5dl00l0ttA/l0v6RkM9PPg016wVyqfVR4CIjmsi4dQxu4RpdyR/j
 ZiNJex2FhCWcDO2j0B9Puf+FZqxn9B3XcSxWwz1YQXHAEjr03ayLOyEswyqlutYO8H+6
 4mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684252019; x=1686844019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ujicVO9KdE17e/bccZpvl07tnVh1owFaMJObt6IfOk=;
 b=GOUdU5ziyouJwj/6gWbXi8nVBkzfJweD/LfuxuAz61uDkNP6c5FRq6LSjBubEUIVN5
 vZESWjz3NhcyqaoULgBxsW6t5hZQmLObSmG6nCkhWdap37Ty0brO2yOLLLKg0UJttFc3
 UMZQR9BJdaLl5jweRoAeFadbHYYOeUfEY/E5r+UpVoOX8TmPS5+lPzKddKqUhtW4VGvw
 EMqQBSQxyv8x/0m+T/Lj9uiUHKsBqrAceCFa1ub3JFrG3yO7jLC9A2PQ9KiFNctWAdRx
 w+649WS/j6RnCjxEyhm5Q9GAFRSyMexlyax65+s9Pw1/p5aPpLZR4FneANqvyFvG8s45
 affQ==
X-Gm-Message-State: AC+VfDy/8c39GFiRPQOhneIhcq8oEhFxePHmG5efBG4ISjzaLfkcYQui
 gtRjhlXsD9g9YLXBwcLkWK0=
X-Google-Smtp-Source: ACHHUZ7Bn0zch8eNuui86T07VknMNDfavp1DIBybNeG5zAxhadYTKRLrvRtSWrAXjNyr5nan5wMApQ==
X-Received: by 2002:a54:4613:0:b0:38d:e19b:7d01 with SMTP id
 p19-20020a544613000000b0038de19b7d01mr11042537oip.30.1684252018638; 
 Tue, 16 May 2023 08:46:58 -0700 (PDT)
Received: from [192.168.68.107] (189-46-207-53.dsl.telesp.net.br.
 [189.46.207.53]) by smtp.gmail.com with ESMTPSA id
 u3-20020a544383000000b003943e08ee03sm6402440oiv.16.2023.05.16.08.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 08:46:58 -0700 (PDT)
Message-ID: <099d7a72-4fda-5dff-2bad-509b48aab3a3@gmail.com>
Date: Tue, 16 May 2023 12:46:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/9] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Fabiano Rosas <farosas@suse.de>
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-4-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230515092655.171206-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.666,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

RWl0aGVyIHRoaXMgcGF0Y2ggb3IgcGF0Y2ggNiBicm9rZSBhIGdpdGxhYiBLVk0gYnVpbGRl
ciAoY3Jvc3MtcHBjNjRlbC1rdm0tb25seSkNCmFzIGZvbGxvd3M6DQoNCg0KWzE0NDEvMjAx
OV0gQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXUtcHBjLXNvZnRtbXUuZmEucC90YXJnZXRf
cHBjX2V4Y3BfaGVscGVyLmMubw0KRkFJTEVEOiBsaWJxZW11LXBwYy1zb2Z0bW11LmZhLnAv
dGFyZ2V0X3BwY19leGNwX2hlbHBlci5jLm8NCnBvd2VycGM2NGxlLWxpbnV4LWdudS1nY2Mg
LW02NCAtbWxpdHRsZS1lbmRpYW4gLUlsaWJxZW11LXBwYy1zb2Z0bW11LmZhLnAgLUkuIC1J
Li4gLUl0YXJnZXQvcHBjIC1JLi4vdGFyZ2V0L3BwYyAtSXFhcGkgLUl0cmFjZSAtSXVpIC1J
dWkvc2hhZGVyIC1JL3Vzci9pbmNsdWRlL3BpeG1hbi0xIC1JL3Vzci9pbmNsdWRlL2NhcHN0
b25lIC1JL3Vzci9pbmNsdWRlL3NwaWNlLXNlcnZlciAtSS91c3IvaW5jbHVkZS9zcGljZS0x
IC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vzci9saWIvcG93ZXJwYzY0bGUtbGludXgt
Z251L2dsaWItMi4wL2luY2x1ZGUgLWZkaWFnbm9zdGljcy1jb2xvcj1hdXRvIC1XYWxsIC1X
aW52YWxpZC1wY2ggLVdlcnJvciAtc3RkPWdudTExIC1PMiAtZyAtaXN5c3RlbSAvYnVpbGRz
L2RhbmllbGhiL3FlbXUvbGludXgtaGVhZGVycyAtaXN5c3RlbSBsaW51eC1oZWFkZXJzIC1p
cXVvdGUgLiAtaXF1b3RlIC9idWlsZHMvZGFuaWVsaGIvcWVtdSAtaXF1b3RlIC9idWlsZHMv
ZGFuaWVsaGIvcWVtdS9pbmNsdWRlIC1wdGhyZWFkIC1VX0ZPUlRJRllfU09VUkNFIC1EX0ZP
UlRJRllfU09VUkNFPTIgLURfR05VX1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1E
X0xBUkdFRklMRV9TT1VSQ0UgLWZuby1zdHJpY3QtYWxpYXNpbmcgLWZuby1jb21tb24gLWZ3
cmFwdiAtV3VuZGVmIC1Xd3JpdGUtc3RyaW5ncyAtV21pc3NpbmctcHJvdG90eXBlcyAtV3N0
cmljdC1wcm90b3R5cGVzIC1XcmVkdW5kYW50LWRlY2xzIC1Xb2xkLXN0eWxlLWRlY2xhcmF0
aW9uIC1Xb2xkLXN0eWxlLWRlZmluaXRpb24gLVd0eXBlLWxpbWl0cyAtV2Zvcm1hdC1zZWN1
cml0eSAtV2Zvcm1hdC15MmsgLVdpbml0LXNlbGYgLVdpZ25vcmVkLXF1YWxpZmllcnMgLVdl
bXB0eS1ib2R5IC1XbmVzdGVkLWV4dGVybnMgLVdlbmRpZi1sYWJlbHMgLVdleHBhbnNpb24t
dG8tZGVmaW5lZCAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTIgLVdtaXNzaW5nLWZvcm1hdC1h
dHRyaWJ1dGUgLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXNoaWZ0LW5lZ2F0aXZl
LXZhbHVlIC1Xbm8tcHNhYmkgLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1mUElFIC1pc3lz
dGVtLi4vbGludXgtaGVhZGVycyAtaXN5c3RlbWxpbnV4LWhlYWRlcnMgLURORUVEX0NQVV9I
ICctRENPTkZJR19UQVJHRVQ9InBwYy1zb2Z0bW11LWNvbmZpZy10YXJnZXQuaCInICctRENP
TkZJR19ERVZJQ0VTPSJwcGMtc29mdG1tdS1jb25maWctZGV2aWNlcy5oIicgLU1EIC1NUSBs
aWJxZW11LXBwYy1zb2Z0bW11LmZhLnAvdGFyZ2V0X3BwY19leGNwX2hlbHBlci5jLm8gLU1G
IGxpYnFlbXUtcHBjLXNvZnRtbXUuZmEucC90YXJnZXRfcHBjX2V4Y3BfaGVscGVyLmMuby5k
IC1vIGxpYnFlbXUtcHBjLXNvZnRtbXUuZmEucC90YXJnZXRfcHBjX2V4Y3BfaGVscGVyLmMu
byAtYyAuLi90YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmMNCi4uL3RhcmdldC9wcGMvZXhjcF9o
ZWxwZXIuYzoxNDM6NDk6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhhYmlfcHRy4oCZ
OyBkaWQgeW91IG1lYW4g4oCYc2lfcHRy4oCZPw0KICAgMTQzIHwgc3RhdGljIHVpbnQzMl90
IHBwY19sZGxfY29kZShDUFVBcmNoU3RhdGUgKmVudiwgYWJpX3B0ciBhZGRyKQ0KICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fg0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2lfcHRyDQpbMTQ0Mi8yMDE5XSBDb21waWxpbmcgQyBvYmplY3QgbGlicWVt
dS1wcGMtc29mdG1tdS5mYS5wL3RhcmdldF9wcGNfY3B1LW1vZGVscy5jLm8NCm5pbmphOiBi
dWlsZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxlZC4NCm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTY1OiBydW4tbmluamFdIEVycm9yIDENCg0KDQpNb3JlIGRldGFpbHMgaGVyZToNCg0KaHR0
cHM6Ly9naXRsYWIuY29tL2RhbmllbGhiL3FlbXUvLS9qb2JzLzQyOTMzMjY0MzENCg0KDQpJ
IHN1cHBvc2Ugd2UncmUgbWlzc2luZyBhbiBpZmRlZiBzb21ld2hlcmUgdG8gZ2F0ZSB0aGlz
IGNvZGUgZnJvbSBLVk0gY29kZS4gJ2FiaV9wdHInDQppcyBhIFRDRyBwb2ludGVyIGFmYWlr
Lg0KDQoNCg0KVGhhbmtzLA0KDQpEYW5pZWwNCg0KDQpPbiA1LzE1LzIzIDA2OjI2LCBOaWNo
b2xhcyBQaWdnaW4gd3JvdGU6DQo+IHBvd2VycGMgaWZldGNoIGVuZGlhbm5lc3MgZGVwZW5k
cyBvbiBNU1JbTEVdIHNvIGl0IGhhcyB0byBieXRlc3dhcA0KPiBhZnRlciBjcHVfbGRsX2Nv
ZGUoKS4gVGhpcyBjb3JyZWN0cyBEU0lTUiBiaXRzIGluIGFsaWdubWVudA0KPiBpbnRlcnJ1
cHRzIHdoZW4gcnVubmluZyBpbiBsaXR0bGUgZW5kaWFuIG1vZGUuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogRmFiaWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5
OiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5AZ21haWwuY29tPg0KPiAtLS0NCj4gU2luY2Ug
djI6IG5vIGNoYW5nZS4NCj4gDQo+ICAgdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5jIHwgMjAg
KysrKysrKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9wcGMvZXhj
cF9oZWxwZXIuYyBiL3RhcmdldC9wcGMvZXhjcF9oZWxwZXIuYw0KPiBpbmRleCAxOTkzMjhm
NGI2Li5iYzJiZTRhNzI2IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcHBjL2V4Y3BfaGVscGVy
LmMNCj4gKysrIGIvdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5jDQo+IEBAIC0xMzMsNiArMTMz
LDI0IEBAIHN0YXRpYyB2b2lkIGR1bXBfaGNhbGwoQ1BVUFBDU3RhdGUgKmVudikNCj4gICAg
ICAgICAgICAgICAgICAgICBlbnYtPm5pcCk7DQo+ICAgfQ0KPiAgIA0KPiArLyogUmV0dXJu
IHRydWUgaWZmIGJ5dGVzd2FwIGlzIG5lZWRlZCBpbiBhIHNjYWxhciBtZW1vcCAqLw0KPiAr
c3RhdGljIGlubGluZSBib29sIG5lZWRfYnl0ZXN3YXAoQ1BVQXJjaFN0YXRlICplbnYpDQo+
ICt7DQo+ICsgICAgLyogU09GVE1NVSBidWlsZHMgVEFSR0VUX0JJR19FTkRJQU4uIE5lZWQg
dG8gc3dhcCB3aGVuIE1TUltMRV0gaXMgc2V0ICovDQo+ICsgICAgcmV0dXJuICEhKGVudi0+
bXNyICYgKCh0YXJnZXRfdWxvbmcpMSA8PCBNU1JfTEUpKTsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIHVpbnQzMl90IHBwY19sZGxfY29kZShDUFVBcmNoU3RhdGUgKmVudiwgYWJpX3B0ciBh
ZGRyKQ0KPiArew0KPiArICAgIHVpbnQzMl90IGluc24gPSBjcHVfbGRsX2NvZGUoZW52LCBh
ZGRyKTsNCj4gKw0KPiArICAgIGlmIChuZWVkX2J5dGVzd2FwKGVudikpIHsNCj4gKyAgICAg
ICAgaW5zbiA9IGJzd2FwMzIoaW5zbik7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJu
IGluc247DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBwcGNfZXhjcF9kZWJ1Z19zd190
bGIoQ1BVUFBDU3RhdGUgKmVudiwgaW50IGV4Y3ApDQo+ICAgew0KPiAgICAgICBjb25zdCBj
aGFyICplczsNCj4gQEAgLTMwOTcsNyArMzExNSw3IEBAIHZvaWQgcHBjX2NwdV9kb191bmFs
aWduZWRfYWNjZXNzKENQVVN0YXRlICpjcywgdmFkZHIgdmFkZHIsDQo+ICAgDQo+ICAgICAg
IC8qIFJlc3RvcmUgc3RhdGUgYW5kIHJlbG9hZCB0aGUgaW5zbiB3ZSBleGVjdXRlZCwgZm9y
IGZpbGxpbmcgaW4gRFNJU1IuICAqLw0KPiAgICAgICBjcHVfcmVzdG9yZV9zdGF0ZShjcywg
cmV0YWRkcik7DQo+IC0gICAgaW5zbiA9IGNwdV9sZGxfY29kZShlbnYsIGVudi0+bmlwKTsN
Cj4gKyAgICBpbnNuID0gcHBjX2xkbF9jb2RlKGVudiwgZW52LT5uaXApOw0KPiAgIA0KPiAg
ICAgICBzd2l0Y2ggKGVudi0+bW11X21vZGVsKSB7DQo+ICAgICAgIGNhc2UgUE9XRVJQQ19N
TVVfU09GVF80eHg6DQo=

