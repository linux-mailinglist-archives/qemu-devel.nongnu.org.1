Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32B8061AF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 23:29:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAdti-0003ex-Up; Tue, 05 Dec 2023 17:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAdte-0003d5-Ts
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 17:28:07 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAdtd-0005GY-6O
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 17:28:06 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d986a75337so1873303a34.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 14:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701815283; x=1702420083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xjX0ycV4920GSStvFTgVH7sc8iENdA8ndQ0y4AqF8VU=;
 b=mPfyw+URMXmUYg6SRlKOph7T6Ne85N2KCMutUVSY6ouOz09prsziNkEJj4H50pb1/0
 orHVAeZY6DQZXQV9Sf8gqV7qUybu2aSFKfPZcE9/L2kFj9SH4HTAmR/Kx2iWb44LAcCA
 gGfVVgPEoboZZFyLLekF9oeKt3aSoWh/hfooRrHGateMREl+3K2JrQa7XK4wc6Twy5v3
 1boJf3T37lfaE4g62+VFPnUAn/MgwJcAahI2B/dy0lMKE/CiUU1VmvAdI6YL2m1DKato
 UeIFN4D/1EAlwggqxbamd9kKXK2xJJByRdgwe2tGf7UihACR3cMeSMifXKM6DAt/Lan6
 mWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701815283; x=1702420083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjX0ycV4920GSStvFTgVH7sc8iENdA8ndQ0y4AqF8VU=;
 b=MidQ+dUsA644ml5Uoh6xtJMef6JL3zlWTTfnt44BVwNnIUtZOtAnhIB3vCXQmkK1k0
 hEyf6YYmkWfO/0VdWuux1F4YRn7lnFx16ezlFwQg0ZaSZXxtpE+1U0i5RwIwTk3yijUC
 6IZmBR+gTFtGTSRSn+7vpNE9MPq6kDzcTdIGiDOHfkn+fqpLgVDXFa1zv7ZGtJ/S6qKP
 5O/wOZPvUPURkYzwPaR805x1P/zUDq29ggsiQmeuM9Ay/vl5B00ciP1V8wemi/8/sBqc
 6+EFZDyXXWIyQ6HBhjpiUurvlGaHRSRaENHaBcCJwRGpPWye9prCzXgrQApw1PY4INNy
 M3pA==
X-Gm-Message-State: AOJu0YzwohYAxoketSzczrWLT75NXKSdoZHTDXlSXcpHjQ4yzVLtEOZp
 gYXz4A5PeW0xC1WIXiXz7LiBNYmQMFA09ljYdsA=
X-Google-Smtp-Source: AGHT+IES70pDJVf8sueoaoiUDUCDV/HMf3EyXxEFs/HG+3R91ocZkALxZ7LF8wAyr/e6V0s+gHeCb3gZOGjbTOTGXxE=
X-Received: by 2002:a05:6870:ad07:b0:1fb:217:5203 with SMTP id
 nt7-20020a056870ad0700b001fb02175203mr8954653oab.53.1701815283498; Tue, 05
 Dec 2023 14:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20231205221219.1151930-1-michael.roth@amd.com>
In-Reply-To: <20231205221219.1151930-1-michael.roth@amd.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Dec 2023 17:27:51 -0500
Message-ID: <CAJSP0QWtnDAmfM7FAyU4dizhVzUWrfagrBVzh-31MPAn9p4X4g@mail.gmail.com>
Subject: Re: [PATCH for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 5 Dec 2023 at 17:12, Michael Roth <michael.roth@amd.com> wrote:
>
> Commit 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> added error checking for KVM_SET_SREGS/KVM_SET_SREGS2. In doing so, it
> exposed a long-running bug in current KVM support for SEV-ES where the
> kernel assumes that MSR_EFER_LMA will be set explicitly by the guest
> kernel, in which case EFER write traps would result in KVM eventually
> seeing MSR_EFER_LMA get set and recording it in such a way that it would
> be subsequently visible when accessing it via KVM_GET_SREGS/etc.
>
> However, guests kernels currently rely on MSR_EFER_LMA getting set
> automatically when MSR_EFER_LME is set and paging is enabled via
> CR0_PG_MASK. As a result, the EFER write traps don't actually expose the
> MSR_EFER_LMA even though it is set internally, and when QEMU
> subsequently tries to pass this EFER value back to KVM via
> KVM_SET_SREGS* it will fail various sanity checks and return -EINVAL,
> which is now considered fatal due to the aforementioned QEMU commit.
>
> This can be addressed by inferring the MSR_EFER_LMA bit being set when
> paging is enabled and MSR_EFER_LME is set, and synthesizing it to ensure
> the expected bits are all present in subsequent handling on the host
> side.
>
> Ultimately, this handling will be implemented in the host kernel, but to
> avoid breaking QEMU's SEV-ES support when using older host kernels, the
> same handling can be done in QEMU just after fetching the register
> values via KVM_GET_SREGS*. Implement that here.

Hi Mike,
I am holding off on tagging 8.2.0-rc3 for one day so agreement can be
reached on how to proceed with this fix.

Stefan

>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: kvm@vger.kernel.org
> Fixes: 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/kvm/kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..0e9e4c1beb 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3654,6 +3654,7 @@ static int kvm_get_sregs2(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      struct kvm_sregs2 sregs;
> +    target_ulong cr0_old;
>      int i, ret;
>
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS2, &sregs);
> @@ -3676,12 +3677,18 @@ static int kvm_get_sregs2(X86CPU *cpu)
>      env->gdt.limit = sregs.gdt.limit;
>      env->gdt.base = sregs.gdt.base;
>
> +    cr0_old = env->cr[0];
>      env->cr[0] = sregs.cr0;
>      env->cr[2] = sregs.cr2;
>      env->cr[3] = sregs.cr3;
>      env->cr[4] = sregs.cr4;
>
>      env->efer = sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME) {
> +        if (!(cr0_old & CR0_PG_MASK) && env->cr[0] & CR0_PG_MASK) {
> +            env->efer |= MSR_EFER_LMA;
> +        }
> +    }
>
>      env->pdptrs_valid = sregs.flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
>
> --
> 2.25.1
>
>

