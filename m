Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A59AB7A2
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 22:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LX9-0004KO-90; Tue, 22 Oct 2024 16:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LX5-0004Ju-Rl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:31:12 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LX1-0007hQ-7b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:31:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so4119058a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629056; x=1730233856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mn0yUv/VNueViYeILhO/lJwpnkY1E2U10JXud4XZBsk=;
 b=lkTyEuLlP6MS11BnQmeCZXN0xgqdZpUqyp8oLA2TZrH7ggzz+2cdjgc9QVuINUF4E3
 wb4QqxjeczOELQodwMugTf5V+dWQNRvSG3pr6yCdwshfdk1LBwrywZ6mvjv2oHsbi/Ao
 a2WTHdU6GCAdopcztMMR3omyt6YlUM9l6DraNY3JhtdpGiFhIx545Q6Fbowx/AL6VV/S
 WSls348XdqzdRohNE5sqbGO3LF71QYyIPrpBS6Xc2Eg5tJ9LHK4sZs7UkgpNa8vyFCER
 eJbe/A1AVtU7SMK9p9ocoB1nn8Jt9DGWX+BC+w2/qo/sqzpp/lwLQDGNT8V7HLa+P50Q
 l3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629056; x=1730233856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mn0yUv/VNueViYeILhO/lJwpnkY1E2U10JXud4XZBsk=;
 b=KKd854Q8PC4Qf8oFqA6tfD1nZCS91BvorXcnZm7IMnJcg/nCvKmz2ULGXIL4Cw5NkD
 plBNOGMLsM52eBOBHlg1bn1yGa+xLAs76ThBeRSJzvv8VSisgpWvkjXI2MXaqvIn3FJJ
 2OVHJYtUMGXvPAy6c4PRqZChEaGpd4yofgYQAas1S7n9UaBp9TbBW3A2QlKiStVIq3/5
 kWe/Ihmik3a2sQzEGPsxFrwVRj+rxdkP5MPuCZGpzLNs+6jyzUCZlVbp8sY9BdgwPYMT
 3oU21Z02H2CpUD7tqg7AphfsWjy+hvwnJadygR3qdf05lJM12MPwAhn77L7wjc8onsEm
 FFhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtRblBN2QgVWX4iw6W5ipfhEiGvAb9NmPqs8gM1iUU0I7m1Cpskfbjcb1smM3ivx7H9MVaQft7LaD8@nongnu.org
X-Gm-Message-State: AOJu0YzIQZGysIsY5GN+LJ+VItK7HdYi83U0NDUIAqesQLL1gTsTYPNL
 UvpkbqGBfe+NrimFNpfayrxC20VMY3qIfB4YCSIdW7fR3tGUaJm8B9iBTWzK/UU=
X-Google-Smtp-Source: AGHT+IFStsDu3D39MVTj4FAFck5GuxbFhm8mNq6Eqrj528hfwM/5gYgTzL2d2fBLL6mi8NCVKZcbZA==
X-Received: by 2002:a17:90a:ca08:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e76b5b67aamr216165a91.3.1729629056298; 
 Tue, 22 Oct 2024 13:30:56 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad365d4dsm6673854a91.14.2024.10.22.13.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:30:55 -0700 (PDT)
Message-ID: <7fcd1db2-3df8-4d1b-8651-ba8bea1abd83@linaro.org>
Date: Tue, 22 Oct 2024 13:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] tests/docker: Fix microblaze atomics
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

T24gMTAvMjIvMjQgMDM6NTUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gRnJvbTogSWx5YSBM
ZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQo+IA0KPiBHQ0MgcHJvZHVjZXMgaW52
YWxpZCBjb2RlIGZvciBtaWNyb2JsYXplIGF0b21pY3MuDQo+IA0KPiBUaGUgZml4IGlzIHVu
Zm9ydHVuYXRlbHkgbm90IHVwc3RyZWFtLCBzbyBmZXRjaCBpdCBmcm9tIGFuIGV4dGVybmFs
DQo+IGxvY2F0aW9uIGFuZCBhcHBseSBpdCBsb2NhbGx5Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5
OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1v
ZmYtYnk6IElseWEgTGVvc2hrZXZpY2ggPGlpaUBsaW51eC5pYm0uY29tPg0KPiBNZXNzYWdl
LUlkOiA8MjAyNDA5MTkxNTIzMDguMTA0NDAtMS1paWlAbGludXguaWJtLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAt
LS0NCj4gICAuLi4vZGViaWFuLW1pY3JvYmxhemUtY3Jvc3MuZC9idWlsZC10b29sY2hhaW4u
c2ggICAgICAgICAgfCA4ICsrKysrKysrDQo+ICAgdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVz
L2RlYmlhbi10b29sY2hhaW4uZG9ja2VyICAgICAgICAgIHwgNyArKysrKysrDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1taWNyb2JsYXplLWNyb3NzLmQvYnVpbGQt
dG9vbGNoYWluLnNoIGIvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1taWNyb2Js
YXplLWNyb3NzLmQvYnVpbGQtdG9vbGNoYWluLnNoDQo+IGluZGV4IDIzZWMwYWE5YTcuLmM1
Y2QwYWE5MzEgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9kZWJp
YW4tbWljcm9ibGF6ZS1jcm9zcy5kL2J1aWxkLXRvb2xjaGFpbi5zaA0KPiArKysgYi90ZXN0
cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGViaWFuLW1pY3JvYmxhemUtY3Jvc3MuZC9idWlsZC10
b29sY2hhaW4uc2gNCj4gQEAgLTEwLDYgKzEwLDggQEAgVE9PTENIQUlOX0lOU1RBTEw9L3Vz
ci9sb2NhbA0KPiAgIFRPT0xDSEFJTl9CSU49JHtUT09MQ0hBSU5fSU5TVEFMTH0vYmluDQo+
ICAgQ1JPU1NfU1lTUk9PVD0ke1RPT0xDSEFJTl9JTlNUQUxMfS8kVEFSR0VUL3N5cy1yb290
DQo+ICAgDQo+ICtHQ0NfUEFUQ0gwX1VSTD1odHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVu
dC5jb20vWGlsaW54L21ldGEteGlsaW54L3JlZnMvdGFncy94bG54LXJlbC12MjAyNC4xL21l
dGEtbWljcm9ibGF6ZS9yZWNpcGVzLWRldnRvb2xzL2djYy9nY2MtMTIvMDAwOS1QYXRjaC1t
aWNyb2JsYXplLUZpeC1hdG9taWMtYm9vbGVhbi1yZXR1cm4tdmFsdWUucGF0Y2gNCj4gKw0K
PiAgIGV4cG9ydCBQQVRIPSR7VE9PTENIQUlOX0JJTn06JFBBVEgNCj4gICANCj4gICAjDQo+
IEBAIC0zMSw2ICszMywxMiBAQCBtdiBnY2MtMTEuMi4wIHNyYy1nY2MNCj4gICBtdiBtdXNs
LTEuMi4yIHNyYy1tdXNsDQo+ICAgbXYgbGludXgtNS4xMC43MCBzcmMtbGludXgNCj4gICAN
Cj4gKyMNCj4gKyMgUGF0Y2ggZ2NjDQo+ICsjDQo+ICsNCj4gK3dnZXQgLU8gLSAke0dDQ19Q
QVRDSDBfVVJMfSB8IHBhdGNoIC1kIHNyYy1nY2MgLXAxDQo+ICsNCj4gICBta2RpciAtcCBi
bGQtaGRyIGJsZC1iaW51IGJsZC1nY2MgYmxkLW11c2wNCj4gICBta2RpciAtcCAke0NST1NT
X1NZU1JPT1R9L3Vzci9pbmNsdWRlDQo+ICAgDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9kb2Nr
ZXIvZG9ja2VyZmlsZXMvZGViaWFuLXRvb2xjaGFpbi5kb2NrZXIgYi90ZXN0cy9kb2NrZXIv
ZG9ja2VyZmlsZXMvZGViaWFuLXRvb2xjaGFpbi5kb2NrZXINCj4gaW5kZXggNjg3YTk3ZmVj
NC4uYWI0Y2UyOTUzMyAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVz
L2RlYmlhbi10b29sY2hhaW4uZG9ja2VyDQo+ICsrKyBiL3Rlc3RzL2RvY2tlci9kb2NrZXJm
aWxlcy9kZWJpYW4tdG9vbGNoYWluLmRvY2tlcg0KPiBAQCAtMTAsNiArMTAsOCBAQCBGUk9N
IGRvY2tlci5pby9saWJyYXJ5L2RlYmlhbjoxMS1zbGltDQo+ICAgIyA/Pz8gVGhlIGJ1aWxk
LWRlcCBpc24ndCB3b3JraW5nLCBtaXNzaW5nIGEgbnVtYmVyIG9mDQo+ICAgIyBtaW5pbWFs
IGJ1aWxkIGRlcGVuZGllbmNpZXMsIGUuZy4gbGlibXBjLg0KPiAgIA0KPiArUlVOIHNlZCAn
cy9eZGViIC9kZWItc3JjIC8nIDwvZXRjL2FwdC9zb3VyY2VzLmxpc3QgPi9ldGMvYXB0L3Nv
dXJjZXMubGlzdC5kL2RlYi1zcmMubGlzdA0KPiArDQo+ICAgUlVOIGFwdCB1cGRhdGUgJiYg
XA0KPiAgICAgICBERUJJQU5fRlJPTlRFTkQ9bm9uaW50ZXJhY3RpdmUgYXB0IGluc3RhbGwg
LXl5IGVhdG15ZGF0YSAmJiBcDQo+ICAgICAgIERFQklBTl9GUk9OVEVORD1ub25pbnRlcmFj
dGl2ZSBlYXRteWRhdGEgXA0KPiBAQCAtMzMsNiArMzUsMTEgQEAgUlVOIGNkIC9yb290ICYm
IC4vYnVpbGQtdG9vbGNoYWluLnNoDQo+ICAgIyBhbmQgdGhlIGJ1aWxkIHRyZWVzIGJ5IHJl
c3RvcmluZyB0aGUgb3JpZ2luYWwgaW1hZ2UsDQo+ICAgIyB0aGVuIGNvcHlpbmcgdGhlIGJ1
aWx0IHRvb2xjaGFpbiBmcm9tIHN0YWdlIDAuDQo+ICAgRlJPTSBkb2NrZXIuaW8vbGlicmFy
eS9kZWJpYW46MTEtc2xpbQ0KPiArUlVOIGFwdCB1cGRhdGUgJiYgXA0KPiArICAgIERFQklB
Tl9GUk9OVEVORD1ub25pbnRlcmFjdGl2ZSBhcHQgaW5zdGFsbCAteXkgZWF0bXlkYXRhICYm
IFwNCj4gKyAgICBERUJJQU5fRlJPTlRFTkQ9bm9uaW50ZXJhY3RpdmUgZWF0bXlkYXRhIFwN
Cj4gKyAgICBhcHQgaW5zdGFsbCAteSAtLW5vLWluc3RhbGwtcmVjb21tZW5kcyBcDQo+ICsg
ICAgICAgIGxpYm1wYzMNCj4gICBDT1BZIC0tZnJvbT0wIC91c3IvbG9jYWwgL3Vzci9sb2Nh
bA0KPiAgICMgQXMgYSBmaW5hbCBzdGVwIGNvbmZpZ3VyZSB0aGUgdXNlciAoaWYgZW52IGlz
IGRlZmluZWQpDQo+ICAgQVJHIFVTRVINCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

