Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594F807674
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:22:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvb6-0000Ep-Vl; Wed, 06 Dec 2023 12:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1rAvb4-0000Da-2L
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1rAvb1-000370-WE
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701883321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsLFzQv2YNuDCZra2Kj0iJALxsgAF/x7Gz2Slw1HQQQ=;
 b=jFKmiJxX+5l9GqpZMrFUlr4/Z/zpME7MsHQmk6WMNm9nkMmjY464PIXZS2EOcAmIh/eALn
 chR+URzQnJPmfQejRV6khXU9QvSl5NfrUCAfxt9HB8ds796iSF5Tr59zVy/1GXQemTgQ2u
 O9QpwDmKo3OFMY4U8YB8nuMUn/KiuiM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-YoNi1TJCOS6byVuG7MpDpg-1; Wed, 06 Dec 2023 12:20:18 -0500
X-MC-Unique: YoNi1TJCOS6byVuG7MpDpg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33342e25313so9194f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 09:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701883217; x=1702488017;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SsLFzQv2YNuDCZra2Kj0iJALxsgAF/x7Gz2Slw1HQQQ=;
 b=SjGMkC/+7lIUcdAz9Hq2+Mb0tNmUVYZgjRGxTRbBBqyMZC6R0qPQztkN7GAvO7EscK
 1tY8z7aIJhQnpdpF1SsRI7BdIh8j0qUbmwphCxnfgDGJf+GTldC3MUmEf35byQKT0lez
 xkQgM7RFr+BIhV/EmAG4hFmv3Gz43uUQj/70Aq0wrzsTejAcjAY5fEQu44dkgpm7rcQT
 8B3WuPI4rZlevCgMUJsZHX8XF3kV7hWnvHBuJ3ndDWOH+Yd6zbdy8bhV6tSNcu/qcIxY
 V0qxQh8PQscOFmZM4wjOXL3KvPtHMFncYNIAH+GJZv4JjrL4yFXW9OYBqtcifDbXWBLt
 IsZQ==
X-Gm-Message-State: AOJu0YyWqOMbRYN93oOT9xSNByVP9I4lOOm6DPopqhrmXZo6EgNA3Vd8
 83IFuk63kYCusHYhiCNx5QRgN/rHokf/iP8yc1quMFnrjb1XwUmgRFUwdZqY5joK58q2eFTbzDs
 XC8pUPZ/ojbFE51Q=
X-Received: by 2002:a05:600c:152:b0:40c:711:f492 with SMTP id
 w18-20020a05600c015200b0040c0711f492mr755827wmm.181.1701883216910; 
 Wed, 06 Dec 2023 09:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEDaeszLqwAe0nU5bPLurT8kY29VuNk8fXrhQGAvKHABN9JIws3HuahPDdf6VZlB5WEBMVQQ==
X-Received: by 2002:a05:600c:152:b0:40c:711:f492 with SMTP id
 w18-20020a05600c015200b0040c0711f492mr755819wmm.181.1701883216571; 
 Wed, 06 Dec 2023 09:20:16 -0800 (PST)
Received: from starship ([89.237.98.20]) by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b0040b43da0bbasm215072wmo.30.2023.12.06.09.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 09:20:16 -0800 (PST)
Message-ID: <9eae0513c912faa04a11db378ea3ca176ab45f0d.camel@redhat.com>
Subject: Re: [PATCH v2 for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>,  Tom Lendacky <thomas.lendacky@amd.com>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org
Date: Wed, 06 Dec 2023 19:20:14 +0200
In-Reply-To: <20231205222816.1152720-1-michael.roth@amd.com>
References: <20231205222816.1152720-1-michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 2023-12-05 at 16:28 -0600, Michael Roth wrote:
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
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: kvm@vger.kernel.org
> Fixes: 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
> v2:
>   - Add handling for KVM_GET_SREGS, not just KVM_GET_SREGS2
> 
>  target/i386/kvm/kvm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..8721c1bf8f 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3610,6 +3610,7 @@ static int kvm_get_sregs(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      struct kvm_sregs sregs;
> +    target_ulong cr0_old;
>      int ret;
>  
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS, &sregs);
> @@ -3637,12 +3638,18 @@ static int kvm_get_sregs(X86CPU *cpu)
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

I think that we should not check that CR0_PG has changed, and just blindly assume
that if EFER.LME is set and CR0.PG is set, then EFER.LMA must be set as defined in x86 spec.

Otherwise, suppose qemu calls kvm_get_sregs twice: First time it will work,
but second time CR0.PG will match one that is stored in the env, and thus the workaround
will not be executed, and instead we will revert back to wrong EFER value 
reported by the kernel.

How about something like that:


if (sev_es_enabled() && env->efer & MSR_EFER_LME && env->cr[0] & CR0_PG_MASK) {
	/* 
         * Workaround KVM bug, because of which KVM might not be aware of the 
         * fact that EFER.LMA was toggled by the hardware 
         */
	env->efer |= MSR_EFER_LMA;
}


Best regards,
	Maxim Levitsky

>  
>      /* changes to apic base and cr8/tpr are read back via kvm_arch_post_run */
>      x86_update_hflags(env);
> @@ -3654,6 +3661,7 @@ static int kvm_get_sregs2(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      struct kvm_sregs2 sregs;
> +    target_ulong cr0_old;
>      int i, ret;
>  
>      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS2, &sregs);
> @@ -3676,12 +3684,18 @@ static int kvm_get_sregs2(X86CPU *cpu)
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



