Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0E7D2350
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 16:01:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quZ09-0006pK-9c; Sun, 22 Oct 2023 10:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1quZ04-0006ow-5I
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 10:00:16 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1quZ01-0006ra-N8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 10:00:15 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c51f5a1ecdso39367221fa.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697983211; x=1698588011;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bYpW3jPcacRLf35yrCIDcJ3c7/bUr0K4lRMdd4aXh3w=;
 b=n5ZA7egVxacaRcUZgdJ5P9Wna5Ie6fqOehjUL3hAbvRmn6SuHp0VZbxJBzip6myH67
 xGrYWrqntLr91aJ3+MpERR6l0qYMQo3ps8r7ehw1Kn5hfW+3YRXv6CTuAlcIyIjC16Vy
 +5zm+ifBt2WnoNtvlk+bxne06h11jRzwFx0o7lwN1je0DXVc0TukD3Mdwl6wjbx7Gsvh
 L+EGYzQLLXaIm4sBpodu/fqD78hcYHopgLhHU6GLMR80M/CQ2pWHm0sVT2bZ7rvVaPLn
 pw95r9Gae7xmoOYmaT8HjT6s+c+Jeq679O0N5dD4naWuZ/uAI9Iainh6TwNxAhjWogkG
 korQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697983211; x=1698588011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYpW3jPcacRLf35yrCIDcJ3c7/bUr0K4lRMdd4aXh3w=;
 b=Rgt/1vk4W1HdS/2TU8vrdwXPmirM5Vf4t49YteT7jQbv5191V9LAaaRtKk5B/xVnn6
 d93DnPTbBA3MfqQYPQ8i3qupw+hmbrK1WUgPXFfAU4rXYyzXrvhcwnz8VX+jghsBiplc
 AbDxXx8mgf+otEEyvkH1RssAzFHiCDiZL90UIs+eoIdX+svGkxXZBVB9EvAB8klOQT0p
 kPnAYn8ZYTujjRD/9roDGC3zD6eXerFbd00USNHSqP0x49CpcnqYBJE1q0Y5zzrZjpmR
 KJ6v925GqDaPqdx6QlBqmag8hefnwMeb8hH2rwxWbhTWDiDNNHQLQlFrnZJNLrdQ/56x
 QM8w==
X-Gm-Message-State: AOJu0YwDiiWochRXc7C58BnuYKOzHLVqibA3bPYl+Y1Xh/jzbqClm0up
 FuTc9cMroQNGfoPOmmA0Urh4zmDHipVzsldhPDXmTQ==
X-Google-Smtp-Source: AGHT+IHlD5YRn822zChoEq+yMlXpbFO18GTvG+WKxJPaQVO8LoQq7s6DydqP35DCoiffBM5GgUbHQgqD4EyYv+6Uss8=
X-Received: by 2002:a2e:8ece:0:b0:2c3:cb49:43b9 with SMTP id
 e14-20020a2e8ece000000b002c3cb4943b9mr3260022ljl.20.1697983211034; Sun, 22
 Oct 2023 07:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <20230926160637.27995-2-minhquangbui99@gmail.com>
In-Reply-To: <20230926160637.27995-2-minhquangbui99@gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 22 Oct 2023 15:59:59 +0200
Message-ID: <CAGCz3vtQiRkeErcA9NpUeu0Ak7o=qsy02PiVvZrEMoP=86MU1g@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] i386/tcg: implement x2APIC registers MSR access
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000210c6d06084e8672"
Received-SPF: neutral client-ip=2a00:1450:4864:20::22f;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000210c6d06084e8672
Content-Type: text/plain; charset="UTF-8"

I can confirm that this works. The build issue obviously needs fixing,
but once that's fixed, this improves on the status quo.

I've tested this and patch 2/5 with x2apic CPUID bit enabled with the
hvf backend on macOS. To make it work in hvf mode, I used the attached
additional minimal patch to wire it up, but with that in place it
noticeably improves guest OS performance. (This patch doesn't yet
implement raising exceptions or checking for x2apic mode, more on that
in my comments below.)

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

On Tue, 26 Sept 2023 at 18:08, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> @@ -455,6 +469,19 @@ void helper_rdmsr(CPUX86State *env)
>          val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
>          break;
>      }
> +    case MSR_APIC_START ... MSR_APIC_END: {
> +        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> +
> +        if (!is_x2apic_mode(env_archcpu(env)->apic_state)) {
> +            raise_exception_ra(env, EXCP0D_GPF, GETPC());
> +        }
> +
> +        qemu_mutex_lock_iothread();
> +        val = apic_register_read(index);
> +        qemu_mutex_unlock_iothread();

Shouldn't the x2apic mode check technically be inside the lock?
Furthermore, we need the mode check logic in each accelerator whose
MSR read and write we wire up. Finally, there's the exception raising
issue which Michael noted.

So my suggestion would be to wrap the x2apic mode check and the call
to the lower level apic_register_read into a standalone
apic_x2apic_msr_read() or similar, and the equivalent for writes.
These functions should then also return success or failure, the latter
indicating an exception should be raised. Raising the exception can
then also be implemented for each accelerator at the relevant call
site. That contains the raise_exception_ra call in the TCG specific
code, and I can do the equivalent on the hvf side.

It may also be cleaner to only implement the shared xAPIC and x2APIC
functionality in the apic_register_{read|write} functions, and put the
code that's specific to MMIO and MSR paths in the
apic_mem_{read|write} and apic_x2apic_msr_{read|write} wrappers,
respectively? Not sure.

--000000000000210c6d06084e8672
Content-Type: application/octet-stream; 
	name="0001-i386-hvf-Wires-up-MSRs-and-enables-x2apic-mode-when-.patch"
Content-Disposition: attachment; 
	filename="0001-i386-hvf-Wires-up-MSRs-and-enables-x2apic-mode-when-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lo1ihaha0>
X-Attachment-Id: f_lo1ihaha0

RnJvbSBmNDY2MWYyYjhkYzAzZGVkMGRlMTg2YzhiM2U0OWRlYmI1OTg3NmZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsIERlbm5pcy1Kb3JkYW4gPHBoaWxAcGhpbGpvcmRhbi5l
dT4KRGF0ZTogU3VuLCAyMiBPY3QgMjAyMyAxNToxNToxMiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IGkzODY6IGh2ZjogV2lyZXMgdXAgTVNScyBhbmQgZW5hYmxlcyB4MmFwaWMgbW9kZSB3aGVuIHVz
aW5nCiBodmYKClRoaXMgY2hhbmdlIGFkZHMgc3VwcG9ydCBmb3IgcmVjZW50bHkgaW1wbGVtZW50
ZWQgeDJhcGljIE1TUiByZWFkcyBhbmQKd3JpdGVzIHdoZW4gdXNpbmcgbWFjT1MgSHlwZXJ2aXNv
ci5mcmFtZXdvcmsuIFRoZSBjb3JyZXNwb25kaW5nIENQVUlECmZsYWcgaXMgbGlrZXdpc2UgYWxs
b3ctbGlzdGVkIHdoZW4gdXNpbmcgdGhlIGFjY2VsZXJhdG9yLgoKU2lnbmVkLW9mZi1ieTogUGhp
bCBEZW5uaXMtSm9yZGFuIDxwaGlsQHBoaWxqb3JkYW4uZXU+Ci0tLQogdGFyZ2V0L2kzODYvaHZm
L3g4Nl9jcHVpZC5jIHwgNCArKy0tCiB0YXJnZXQvaTM4Ni9odmYveDg2X2VtdS5jICAgfCA2ICsr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvaHZmL3g4Nl9jcHVpZC5jIGIvdGFyZ2V0L2kzODYvaHZm
L3g4Nl9jcHVpZC5jCmluZGV4IGU1NmNkODQxMWIuLjRmMjYwZDQ2YTggMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9pMzg2L2h2Zi94ODZfY3B1aWQuYworKysgYi90YXJnZXQvaTM4Ni9odmYveDg2X2NwdWlk
LmMKQEAgLTY0LDggKzY0LDggQEAgdWludDMyX3QgaHZmX2dldF9zdXBwb3J0ZWRfY3B1aWQodWlu
dDMyX3QgZnVuYywgdWludDMyX3QgaWR4LAogICAgICAgICAgICAgIENQVUlEX1BBVCB8IENQVUlE
X1BTRTM2IHwgQ1BVSURfQ0xGTFVTSCB8IENQVUlEX01NWCB8CiAgICAgICAgICAgICAgQ1BVSURf
RlhTUiB8IENQVUlEX1NTRSB8IENQVUlEX1NTRTIgfCBDUFVJRF9TUzsKICAgICAgICAgZWN4ICY9
IENQVUlEX0VYVF9TU0UzIHwgQ1BVSURfRVhUX1BDTE1VTFFEUSB8IENQVUlEX0VYVF9TU1NFMyB8
Ci0gICAgICAgICAgICAgQ1BVSURfRVhUX0ZNQSB8IENQVUlEX0VYVF9DWDE2IHwgQ1BVSURfRVhU
X1BDSUQgfAotICAgICAgICAgICAgIENQVUlEX0VYVF9TU0U0MSB8IENQVUlEX0VYVF9TU0U0MiB8
IENQVUlEX0VYVF9NT1ZCRSB8CisgICAgICAgICAgICAgQ1BVSURfRVhUX0ZNQSB8IENQVUlEX0VY
VF9DWDE2IHwgQ1BVSURfRVhUX1BDSUQgfCBDUFVJRF9FWFRfU1NFNDEgfAorICAgICAgICAgICAg
IENQVUlEX0VYVF9TU0U0MiB8IENQVUlEX0VYVF9YMkFQSUMgfCBDUFVJRF9FWFRfTU9WQkUgfAog
ICAgICAgICAgICAgIENQVUlEX0VYVF9QT1BDTlQgfCBDUFVJRF9FWFRfQUVTIHwgQ1BVSURfRVhU
X1hTQVZFIHwKICAgICAgICAgICAgICBDUFVJRF9FWFRfQVZYIHwgQ1BVSURfRVhUX0YxNkMgfCBD
UFVJRF9FWFRfUkRSQU5EOwogICAgICAgICBlY3ggfD0gQ1BVSURfRVhUX0hZUEVSVklTT1I7CmRp
ZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9odmYveDg2X2VtdS5jIGIvdGFyZ2V0L2kzODYvaHZmL3g4
Nl9lbXUuYwppbmRleCBlODQ4MzFlNmMyLi5hNzY0YTU2NGRmIDEwMDY0NAotLS0gYS90YXJnZXQv
aTM4Ni9odmYveDg2X2VtdS5jCisrKyBiL3RhcmdldC9pMzg2L2h2Zi94ODZfZW11LmMKQEAgLTc1
MCw2ICs3NTAsOSBAQCB2b2lkIHNpbXVsYXRlX3JkbXNyKHN0cnVjdCBDUFVTdGF0ZSAqY3B1KQog
ICAgICAgICB2YWwgPSBjcy0+bnJfdGhyZWFkcyAqIGNzLT5ucl9jb3JlczsgLyogdGhyZWFkIGNv
dW50LCBiaXRzIDE1Li4wICovCiAgICAgICAgIHZhbCB8PSAoKHVpbnQzMl90KWNzLT5ucl9jb3Jl
cyA8PCAxNik7IC8qIGNvcmUgY291bnQsIGJpdHMgMzEuLjE2ICovCiAgICAgICAgIGJyZWFrOwor
ICAgIGNhc2UgTVNSX0FQSUNfU1RBUlQgLi4uIE1TUl9BUElDX0VORDoKKyAgICAgICAgdmFsID0g
YXBpY19yZWdpc3Rlcl9yZWFkKG1zciAtIE1TUl9BUElDX1NUQVJUKTsKKyAgICAgICAgYnJlYWs7
CiAgICAgZGVmYXVsdDoKICAgICAgICAgLyogZnByaW50ZihzdGRlcnIsICIlczogdW5rbm93biBt
c3IgMHgleFxuIiwgX19mdW5jX18sIG1zcik7ICovCiAgICAgICAgIHZhbCA9IDA7CkBAIC04NDQs
NiArODQ3LDkgQEAgdm9pZCBzaW11bGF0ZV93cm1zcihzdHJ1Y3QgQ1BVU3RhdGUgKmNwdSkKICAg
ICBjYXNlIE1TUl9NVFJSZGVmVHlwZToKICAgICAgICAgZW52LT5tdHJyX2RlZnR5cGUgPSBkYXRh
OwogICAgICAgICBicmVhazsKKyAgICBjYXNlIE1TUl9BUElDX1NUQVJUIC4uLiBNU1JfQVBJQ19F
TkQ6CisgICAgICAgIGFwaWNfcmVnaXN0ZXJfd3JpdGUobXNyIC0gTVNSX0FQSUNfU1RBUlQsIGRh
dGEpOworICAgICAgICBicmVhazsKICAgICBkZWZhdWx0OgogICAgICAgICBicmVhazsKICAgICB9
Ci0tIAoyLjM2LjEKCg==
--000000000000210c6d06084e8672--

