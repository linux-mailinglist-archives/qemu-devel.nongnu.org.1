Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BEB8078AD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 20:30:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAxaX-0007tG-Fz; Wed, 06 Dec 2023 14:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAxaW-0007t8-8x
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 14:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAxaU-0001h3-93
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 14:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701890976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sljBObNDGvGAqcWtvwFnUEKrACaMezHakqGzjYfrZeQ=;
 b=IQqOCl+L51cRM0kznECRez/+iSHpNKlyZSHEihB3DRwhl/s0t7TyFqPDg+MbBD8rwUZiRU
 qsVlskN4WH9OjceuB4MBq0iQno9lJFOS1k+SvvGoWh9XDnJbo9Ff+PYSBzflKvsKWmjzdg
 IMXM5LbP5u2sRsK9jcU4+xtqobo01RA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-rwPXH8N3N2uWD8Y6RtBd9w-1; Wed, 06 Dec 2023 14:29:32 -0500
X-MC-Unique: rwPXH8N3N2uWD8Y6RtBd9w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c9f594de2fso1500381fa.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 11:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701890970; x=1702495770;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sljBObNDGvGAqcWtvwFnUEKrACaMezHakqGzjYfrZeQ=;
 b=gqCu0vL8L5j7sQrf5N+hRf573mE6knbf7QG/k+WfYzOXQnqrKAaWJxUWRf7DgIU0pv
 8wHbbwh4HH9fxVMM2X8B2ewh/M7UipS0O7g5ATJm29UsLVVzMgJMbSQVhd0cGf5oRCkH
 HeR+o9wu66YWk4QZXBM5DLraZNIe+RI5J84eF9ykSYC9jphEkKwKLSc0OhR53HRHrmWP
 9vGeiUg66N8ABdeEP9dsqmpCfh5BxkjA4dzvROBKhcgOLARIVQS1mJJ2/Ct/axg6iek+
 m0YroZjvoUutWTP4sTAuf3mKoeVBPcklIk727m6ZJBzzEU6CCAE21PXfhkRSQhiaz3Gs
 filQ==
X-Gm-Message-State: AOJu0Yz+NPGfF+79e3JqpijiSyidhFMacOiCiKuA6GvFPNVMP6a9bFBu
 l3z8MnBBN3SfbmpFA2O36ldZxb3O7EftW0Ol0NDRCojWCxNhGOrofzsznHxM/Un853x1XnR+JIr
 dhUmRsRNAWaWM+18=
X-Received: by 2002:a2e:7816:0:b0:2c9:f68f:541f with SMTP id
 t22-20020a2e7816000000b002c9f68f541fmr901172ljc.10.1701890970615; 
 Wed, 06 Dec 2023 11:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4J9f99EcqypXlRDzp4mLmjhXquMG22fvmBx1RKBtE2OENiiupNKSeRu7CFOiH9uaaAHS9RA==
X-Received: by 2002:a2e:7816:0:b0:2c9:f68f:541f with SMTP id
 t22-20020a2e7816000000b002c9f68f541fmr901163ljc.10.1701890970239; 
 Wed, 06 Dec 2023 11:29:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 dc8-20020a170906c7c800b00a1c85124b08sm327152ejb.94.2023.12.06.11.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 11:29:29 -0800 (PST)
Message-ID: <f6f51261-7571-4713-a052-f232c8b2bfee@redhat.com>
Date: Wed, 6 Dec 2023 20:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 for-8.2] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lara Lazier <laramglazier@gmail.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 kvm@vger.kernel.org
References: <20231206155821.1194551-1-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231206155821.1194551-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/6/23 16:58, Michael Roth wrote:
> Commit 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> added error checking for KVM_SET_SREGS/KVM_SET_SREGS2. In doing so, it
> exposed a long-running bug in current KVM support for SEV-ES where the
> kernel assumes that MSR_EFER_LMA will be set explicitly by the guest
> kernel, in which case EFER write traps would result in KVM eventually
> seeing MSR_EFER_LMA get set and recording it in such a way that it would
> be subsequently visible when accessing it via KVM_GET_SREGS/etc.
> 
> However, guest kernels currently rely on MSR_EFER_LMA getting set
> automatically when MSR_EFER_LME is set and paging is enabled via
> CR0_PG_MASK. As a result, the EFER write traps don't actually expose the
> MSR_EFER_LMA bit, even though it is set internally, and when QEMU
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
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Lara Lazier <laramglazier@gmail.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: kvm@vger.kernel.org
> Fixes: 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   target/i386/kvm/kvm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..4ce80555b4 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3643,6 +3643,10 @@ static int kvm_get_sregs(X86CPU *cpu)
>       env->cr[4] = sregs.cr4;
>   
>       env->efer = sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME &&
> +        env->cr[0] & CR0_PG_MASK) {
> +        env->efer |= MSR_EFER_LMA;
> +    }
>   
>       /* changes to apic base and cr8/tpr are read back via kvm_arch_post_run */
>       x86_update_hflags(env);
> @@ -3682,6 +3686,10 @@ static int kvm_get_sregs2(X86CPU *cpu)
>       env->cr[4] = sregs.cr4;
>   
>       env->efer = sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME &&
> +        env->cr[0] & CR0_PG_MASK) {
> +        env->efer |= MSR_EFER_LMA;
> +    }
>   
>       env->pdptrs_valid = sregs.flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
>   

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks.  We can change it for 9.0 (especially adding a comment, because 
long term having it only in the commit message isn't great) but for now 
it's safe.

Paolo


