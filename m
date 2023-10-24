Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268657D4737
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:13:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAen-0005Up-2N; Tue, 24 Oct 2023 02:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qvAeA-0005C8-2u
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qvAe7-000099-CM
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698127924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VISudmZ9lvyCWZAEyaRGb3n9C8SVNQXh2L9ScXJvEY=;
 b=AhUBNDStINyxKFrazCP2/BFPnb/M9+J/XNAsj7eExLwyayxHFY7euEvWswC6WVxiXoBh7m
 kNH/yoScmhCZNAfiMnfsMuvPipade9/ucRLRltAzTGXmuh7TEOKkiv9ssZqWISZz2g4zca
 LS3zinY78sEehwGUT1vWgtEQuTg8DUA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-QjZQTM34NMqIskfmHaAj_g-1; Tue, 24 Oct 2023 02:12:01 -0400
X-MC-Unique: QjZQTM34NMqIskfmHaAj_g-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-457c40973dcso1915864137.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698127921; x=1698732721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VISudmZ9lvyCWZAEyaRGb3n9C8SVNQXh2L9ScXJvEY=;
 b=cbk6EmdvwjBNEm43mOyZn80uS8JvBZynUdoCralHozzUa9LMp88hH7bGw/fE3/swjO
 Xnbku7nzcSztqXyi4eMoWwgaDC8R5FXXHZTLTgUW0K0/zPmjBQEIA+lVe4KcwhH1zKkn
 IwVKC6jz45DYwr6+bG0S9Cwr+s1dqQm+0t4xfTbwIJJH693OtPTlKPkB7xQ100B1Pqw6
 k+xv+svDNWf0HggFlyxA0m1JyTxpCVkbp1lpMJm96kjf6guZthCbJCYJRUUwWetwbzFS
 K6o6kb1Sd0wf3NZAUUSL/e6sTs0la1h+HeW5WMp4+8l3x3CVFmIEkgzTPkfXjY1667kD
 01dQ==
X-Gm-Message-State: AOJu0YwwsMdUcdh7uBudv0QohDukRRBlE8xzAnjDohmkFMi1OZLX6rop
 PAavaL7N4gngQRHQ04oQmvHo0Gb8jl4gHXMnYJ1Ux9MVezG+hqoGOGoJ98FlzXzdahFrW1P3RTJ
 MA/KAwFtVGzM059U=
X-Received: by 2002:a67:c28a:0:b0:457:bc5f:b4a8 with SMTP id
 k10-20020a67c28a000000b00457bc5fb4a8mr10317295vsj.28.1698127920996; 
 Mon, 23 Oct 2023 23:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFUVpBi1FqPMqX8VL2Hpa2w4hLeAFS/G3xb5MGq0ncXTjLk07qj0fqf5tFYrHshi1pW/H60w==
X-Received: by 2002:a67:c28a:0:b0:457:bc5f:b4a8 with SMTP id
 k10-20020a67c28a000000b00457bc5fb4a8mr10317285vsj.28.1698127920645; 
 Mon, 23 Oct 2023 23:12:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 e20-20020ad442b4000000b0063c71b62239sm3431543qvr.42.2023.10.23.23.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:12:00 -0700 (PDT)
Message-ID: <a2da8abd-a3e0-4341-afef-64b88e4254c3@redhat.com>
Date: Tue, 24 Oct 2023 08:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/s390x/kvm: Simplify the GPRs, ACRs, CRs and
 prefix synchronization code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>
References: <20231011080538.796999-1-thuth@redhat.com>
 <20231011080538.796999-3-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231011080538.796999-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/11/23 10:05, Thomas Huth wrote:
> KVM_SYNC_GPRS, KVM_SYNC_ACRS, KVM_SYNC_CRS and KVM_SYNC_PREFIX are
> available since kernel 3.10. Since we already require at least kernel
> 3.15 in the s390x KVM code, we can also assume that the KVM_CAP_SYNC_REGS
> sync code is always possible for these registers, and remove the
> related checks and fallbacks via KVM_SET_REGS and KVM_GET_REGS.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/s390x/kvm/kvm.c | 106 ++++++++++-------------------------------
>   1 file changed, 24 insertions(+), 82 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index b3e2eaa2eb..dc76f63d94 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -138,7 +138,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
>   
> -static int cap_sync_regs;
>   static int cap_async_pf;
>   static int cap_mem_op;
>   static int cap_mem_op_extension;
> @@ -359,7 +358,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           return -1;
>       }
>   
> -    cap_sync_regs = true;
>       cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>       cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>       cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);
> @@ -466,37 +464,28 @@ void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
>   
>   static int can_sync_regs(CPUState *cs, int regs)
>   {
> -    return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
> +    return (cs->kvm_run->kvm_valid_regs & regs) == regs;
>   }
>   
> +#define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
> +                                KVM_SYNC_CRS | KVM_SYNC_PREFIX)
> +
>   int kvm_arch_put_registers(CPUState *cs, int level)
>   {
>       S390CPU *cpu = S390_CPU(cs);
>       CPUS390XState *env = &cpu->env;
> -    struct kvm_sregs sregs;
> -    struct kvm_regs regs;
>       struct kvm_fpu fpu = {};
>       int r;
>       int i;
>   
> +    g_assert(can_sync_regs(cs, KVM_SYNC_REQUIRED_REGS));
> +
>       /* always save the PSW  and the GPRS*/
>       cs->kvm_run->psw_addr = env->psw.addr;
>       cs->kvm_run->psw_mask = env->psw.mask;
>   
> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
> -        for (i = 0; i < 16; i++) {
> -            cs->kvm_run->s.regs.gprs[i] = env->regs[i];
> -            cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> -        }
> -    } else {
> -        for (i = 0; i < 16; i++) {
> -            regs.gprs[i] = env->regs[i];
> -        }
> -        r = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
> -        if (r < 0) {
> -            return r;
> -        }
> -    }
> +    memcpy(cs->kvm_run->s.regs.gprs, env->regs, sizeof(cs->kvm_run->s.regs.gprs));
> +    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
>   
>       if (can_sync_regs(cs, KVM_SYNC_VRS)) {
>           for (i = 0; i < 32; i++) {
> @@ -529,6 +518,15 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           return 0;
>       }
>   
> +    /*
> +     * Access registers, control registers and the prefix - these are
> +     * always available via kvm_sync_regs in the kernels that we support
> +     */
> +    memcpy(cs->kvm_run->s.regs.acrs, env->aregs, sizeof(cs->kvm_run->s.regs.acrs));
> +    memcpy(cs->kvm_run->s.regs.crs, env->cregs, sizeof(cs->kvm_run->s.regs.crs));
> +    cs->kvm_run->s.regs.prefix = env->psa;
> +    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ACRS | KVM_SYNC_CRS | KVM_SYNC_PREFIX;
> +
>       if (can_sync_regs(cs, KVM_SYNC_ARCH0)) {
>           cs->kvm_run->s.regs.cputm = env->cputm;
>           cs->kvm_run->s.regs.ckc = env->ckc;
> @@ -575,25 +573,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           }
>       }
>   
> -    /* access registers and control registers*/
> -    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
> -        for (i = 0; i < 16; i++) {
> -            cs->kvm_run->s.regs.acrs[i] = env->aregs[i];
> -            cs->kvm_run->s.regs.crs[i] = env->cregs[i];
> -        }
> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ACRS;
> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_CRS;
> -    } else {
> -        for (i = 0; i < 16; i++) {
> -            sregs.acrs[i] = env->aregs[i];
> -            sregs.crs[i] = env->cregs[i];
> -        }
> -        r = kvm_vcpu_ioctl(cs, KVM_SET_SREGS, &sregs);
> -        if (r < 0) {
> -            return r;
> -        }
> -    }
> -
>       if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
>           memcpy(cs->kvm_run->s.regs.gscb, env->gscb, 32);
>           cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
> @@ -615,13 +594,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
>       }
>   
> -    /* Finally the prefix */
> -    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
> -        cs->kvm_run->s.regs.prefix = env->psa;
> -        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_PREFIX;
> -    } else {
> -        /* prefix is only supported via sync regs */
> -    }
>       return 0;
>   }
>   
> @@ -629,8 +601,6 @@ int kvm_arch_get_registers(CPUState *cs)
>   {
>       S390CPU *cpu = S390_CPU(cs);
>       CPUS390XState *env = &cpu->env;
> -    struct kvm_sregs sregs;
> -    struct kvm_regs regs;
>       struct kvm_fpu fpu;
>       int i, r;
>   
> @@ -638,37 +608,14 @@ int kvm_arch_get_registers(CPUState *cs)
>       env->psw.addr = cs->kvm_run->psw_addr;
>       env->psw.mask = cs->kvm_run->psw_mask;
>   
> -    /* the GPRS */
> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
> -        for (i = 0; i < 16; i++) {
> -            env->regs[i] = cs->kvm_run->s.regs.gprs[i];
> -        }
> -    } else {
> -        r = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
> -        if (r < 0) {
> -            return r;
> -        }
> -         for (i = 0; i < 16; i++) {
> -            env->regs[i] = regs.gprs[i];
> -        }
> -    }
> +    /* the GPRS, ACRS and CRS */
> +    g_assert(can_sync_regs(cs, KVM_SYNC_REQUIRED_REGS));
> +    memcpy(env->regs, cs->kvm_run->s.regs.gprs, sizeof(env->regs));
> +    memcpy(env->aregs, cs->kvm_run->s.regs.acrs, sizeof(env->aregs));
> +    memcpy(env->cregs, cs->kvm_run->s.regs.crs, sizeof(env->cregs));
>   
> -    /* The ACRS and CRS */
> -    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
> -        for (i = 0; i < 16; i++) {
> -            env->aregs[i] = cs->kvm_run->s.regs.acrs[i];
> -            env->cregs[i] = cs->kvm_run->s.regs.crs[i];
> -        }
> -    } else {
> -        r = kvm_vcpu_ioctl(cs, KVM_GET_SREGS, &sregs);
> -        if (r < 0) {
> -            return r;
> -        }
> -         for (i = 0; i < 16; i++) {
> -            env->aregs[i] = sregs.acrs[i];
> -            env->cregs[i] = sregs.crs[i];
> -        }
> -    }
> +    /* The prefix */
> +    env->psa = cs->kvm_run->s.regs.prefix;
>   
>       /* Floating point and vector registers */
>       if (can_sync_regs(cs, KVM_SYNC_VRS)) {
> @@ -693,11 +640,6 @@ int kvm_arch_get_registers(CPUState *cs)
>           env->fpc = fpu.fpc;
>       }
>   
> -    /* The prefix */
> -    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
> -        env->psa = cs->kvm_run->s.regs.prefix;
> -    }
> -
>       if (can_sync_regs(cs, KVM_SYNC_ARCH0)) {
>           env->cputm = cs->kvm_run->s.regs.cputm;
>           env->ckc = cs->kvm_run->s.regs.ckc;


