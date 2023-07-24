Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AB75E9B2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 04:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNlHT-0005ST-OC; Sun, 23 Jul 2023 22:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qNlHR-0005Rs-5D
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 22:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qNlHN-0002Nq-BB
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 22:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690165592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vr63vJsetUCTOqbqYx8iyEflgHvCtl53gxJoykotGzo=;
 b=Dln+lK0fEvki3MGXWOGyLq/IDy20oJIKLWxh9mFLzkwCc9/EYukt5QMU35+pNdoZrChgnX
 tmyQXLdmANfmPWc3+zT6PWM0d+RPBIYwO3Yu/iiufsg0qRCjE3kiJB3Ih7JTSrNxFoeOhs
 88e+2tT+G8wuzijowBa+FM//RKd2qM0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-xGWX8AzrPhaptLV-mTSiFg-1; Sun, 23 Jul 2023 22:26:26 -0400
X-MC-Unique: xGWX8AzrPhaptLV-mTSiFg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3a3df1e1f38so8372489b6e.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 19:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690165586; x=1690770386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vr63vJsetUCTOqbqYx8iyEflgHvCtl53gxJoykotGzo=;
 b=h4SlQYgAH0pWsqUyklLdioaG4OMaQFr8Zydcp92aMAMpkzZBHTLK4nh5UTpKR7NRCT
 LBrDKjS7IdgGy2pFa0m5+JW0omfS/aOtBfDWDnE+/eHMcZ/GUz0EResS6WR9R2F6IyX4
 3CEDsq8VGBNIiCi+T8JGiWwW6R9Uxx2OvivxmeiJFEIkABQo7aVieWWBpc+/UFTTHT5G
 5m8uddd+fWndxT85vPVrDGWyyr8eCavhxMZNArYBrFtVcxO983OI5Hs3dgXXQCaUt9ZB
 t+osiROVEdzFoabjXzXseawsKeXjLe9YAt075dmkikdjU5rJnnFgNYCWR/2IdY4h/MDa
 Jmwg==
X-Gm-Message-State: ABy/qLbK5jdBBsopS2MWIgngOErdCA2f+8MfAFJ9tLwBd1+fjwir5aCZ
 luIvnU6MiyBl1T0lFMLHsECgwbsCoQcx9z/11VXXeZcqvfbNd9eIDItPpK/zOL9zfdDZJ13FVRH
 nkRfgNiVXP1PGc0I=
X-Received: by 2002:a05:6358:4285:b0:135:afe6:4f83 with SMTP id
 s5-20020a056358428500b00135afe64f83mr2526973rwc.29.1690165586087; 
 Sun, 23 Jul 2023 19:26:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlCrbKs1uXsdVh6cZikEK0WO7UhMRzBI9Nld43goXvN9CF2yN9xdOrCqvQeqoN2yaMH6Ydzw==
X-Received: by 2002:a05:6358:4285:b0:135:afe6:4f83 with SMTP id
 s5-20020a056358428500b00135afe64f83mr2526957rwc.29.1690165585704; 
 Sun, 23 Jul 2023 19:26:25 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a639509000000b005633941a547sm7213949pgd.27.2023.07.23.19.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 19:26:25 -0700 (PDT)
Message-ID: <a5b93992-5576-04cf-3af0-2c237831f5c6@redhat.com>
Date: Mon, 24 Jul 2023 12:26:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.2 1/2] arm/kvm: convert to kvm_set_one_reg
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230718111404.23479-1-cohuck@redhat.com>
 <20230718111404.23479-2-cohuck@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230718111404.23479-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Connie,

On 7/18/23 21:14, Cornelia Huck wrote:
> We can neaten the code by switching to the kvm_set_one_reg function.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c   | 13 +++------
>   target/arm/kvm64.c | 66 +++++++++++++---------------------------------
>   2 files changed, 21 insertions(+), 58 deletions(-)
> 

Some wrong replacements to be fixed in kvm_arch_put_fpsimd() as below.
Apart from that, LGTM:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c7654f4980..cdbffc3c6e0d 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -561,7 +561,6 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
>       bool ok = true;
>   
>       for (i = 0; i < cpu->cpreg_array_len; i++) {
> -        struct kvm_one_reg r;
>           uint64_t regidx = cpu->cpreg_indexes[i];
>           uint32_t v32;
>           int ret;
> @@ -570,19 +569,17 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
>               continue;
>           }
>   
> -        r.id = regidx;
>           switch (regidx & KVM_REG_SIZE_MASK) {
>           case KVM_REG_SIZE_U32:
>               v32 = cpu->cpreg_values[i];
> -            r.addr = (uintptr_t)&v32;
> +            ret = kvm_set_one_reg(cs, regidx, &v32);
>               break;
>           case KVM_REG_SIZE_U64:
> -            r.addr = (uintptr_t)(cpu->cpreg_values + i);
> +            ret = kvm_set_one_reg(cs, regidx, cpu->cpreg_values + i);
>               break;
>           default:
>               g_assert_not_reached();
>           }
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
>           if (ret) {
>               /* We might fail for "unknown register" and also for
>                * "you tried to set a register which is constant with
> @@ -703,17 +700,13 @@ void kvm_arm_get_virtual_time(CPUState *cs)
>   void kvm_arm_put_virtual_time(CPUState *cs)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> -    struct kvm_one_reg reg = {
> -        .id = KVM_REG_ARM_TIMER_CNT,
> -        .addr = (uintptr_t)&cpu->kvm_vtime,
> -    };
>       int ret;
>   
>       if (!cpu->kvm_vtime_dirty) {
>           return;
>       }
>   
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
>       if (ret) {
>           error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
>           abort();
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 94bbd9661fd3..b4d02dff5381 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -540,14 +540,10 @@ static int kvm_arm_sve_set_vls(CPUState *cs)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = { cpu->sve_vq.map };
> -    struct kvm_one_reg reg = {
> -        .id = KVM_REG_ARM64_SVE_VLS,
> -        .addr = (uint64_t)&vls[0],
> -    };
>   
>       assert(cpu->sve_max_vq <= KVM_ARM64_SVE_VQ_MAX);
>   
> -    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    return kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_VLS, &vls[0]);
>   }
>   
>   #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
> @@ -725,19 +721,17 @@ static void kvm_inject_arm_sea(CPUState *c)
>   static int kvm_arch_put_fpsimd(CPUState *cs)
>   {
>       CPUARMState *env = &ARM_CPU(cs)->env;
> -    struct kvm_one_reg reg;
>       int i, ret;
>   
>       for (i = 0; i < 32; i++) {
>           uint64_t *q = aa64_vfp_qreg(env, i);
>   #if HOST_BIG_ENDIAN
>           uint64_t fp_val[2] = { q[1], q[0] };
> -        reg.addr = (uintptr_t)fp_val;
> +        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]),
> +                                                        &fp_val);
                                                            ^^^^^^^
                                                            s/&fp_val/fp_val
>   #else
> -        reg.addr = (uintptr_t)q;
> +        ret = kvm_set_one_reg(cs, AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]), &q);
                                                                               ^^^
                                                                              s/&q/q
                                                                               
>   #endif
> -        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>           if (ret) {
>               return ret;
>           }
> @@ -758,14 +752,11 @@ static int kvm_arch_put_sve(CPUState *cs)
>       CPUARMState *env = &cpu->env;
>       uint64_t tmp[ARM_MAX_VQ * 2];
>       uint64_t *r;
> -    struct kvm_one_reg reg;
>       int n, ret;
>   
>       for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
>           r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
> -        reg.addr = (uintptr_t)r;
> -        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_ZREG(n, 0), r);
>           if (ret) {
>               return ret;
>           }
> @@ -774,9 +765,7 @@ static int kvm_arch_put_sve(CPUState *cs)
>       for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
>           r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
>                           DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> -        reg.addr = (uintptr_t)r;
> -        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
>           if (ret) {
>               return ret;
>           }
> @@ -784,9 +773,7 @@ static int kvm_arch_put_sve(CPUState *cs)
>   
>       r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
>                       DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
> -    reg.addr = (uintptr_t)r;
> -    reg.id = KVM_REG_ARM64_SVE_FFR(0);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
>       if (ret) {
>           return ret;
>       }
> @@ -796,7 +783,6 @@ static int kvm_arch_put_sve(CPUState *cs)
>   
>   int kvm_arch_put_registers(CPUState *cs, int level)
>   {
> -    struct kvm_one_reg reg;
>       uint64_t val;
>       uint32_t fpr;
>       int i, ret;
> @@ -813,9 +799,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>       }
>   
>       for (i = 0; i < 31; i++) {
> -        reg.id = AARCH64_CORE_REG(regs.regs[i]);
> -        reg.addr = (uintptr_t) &env->xregs[i];
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> +                              &env->xregs[i]);
>           if (ret) {
>               return ret;
>           }
> @@ -826,16 +811,12 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>        */
>       aarch64_save_sp(env, 1);
>   
> -    reg.id = AARCH64_CORE_REG(regs.sp);
> -    reg.addr = (uintptr_t) &env->sp_el[0];
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.sp), &env->sp_el[0]);
>       if (ret) {
>           return ret;
>       }
>   
> -    reg.id = AARCH64_CORE_REG(sp_el1);
> -    reg.addr = (uintptr_t) &env->sp_el[1];
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(sp_el1), &env->sp_el[1]);
>       if (ret) {
>           return ret;
>       }
> @@ -846,23 +827,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>       } else {
>           val = cpsr_read(env);
>       }
> -    reg.id = AARCH64_CORE_REG(regs.pstate);
> -    reg.addr = (uintptr_t) &val;
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pstate), &val);
>       if (ret) {
>           return ret;
>       }
>   
> -    reg.id = AARCH64_CORE_REG(regs.pc);
> -    reg.addr = (uintptr_t) &env->pc;
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
>       if (ret) {
>           return ret;
>       }
>   
> -    reg.id = AARCH64_CORE_REG(elr_el1);
> -    reg.addr = (uintptr_t) &env->elr_el[1];
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(elr_el1), &env->elr_el[1]);
>       if (ret) {
>           return ret;
>       }
> @@ -881,9 +856,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>   
>       /* KVM 0-4 map to QEMU banks 1-5 */
>       for (i = 0; i < KVM_NR_SPSR; i++) {
> -        reg.id = AARCH64_CORE_REG(spsr[i]);
> -        reg.addr = (uintptr_t) &env->banked_spsr[i + 1];
> -        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(spsr[i]),
> +                              &env->banked_spsr[i + 1]);
>           if (ret) {
>               return ret;
>           }
> @@ -898,18 +872,14 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           return ret;
>       }
>   
> -    reg.addr = (uintptr_t)(&fpr);
>       fpr = vfp_get_fpsr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpsr), &fpr);
>       if (ret) {
>           return ret;
>       }
>   
> -    reg.addr = (uintptr_t)(&fpr);
>       fpr = vfp_get_fpcr(env);
> -    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> -    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    ret = kvm_set_one_reg(cs, AARCH64_SIMD_CTRL_REG(fp_regs.fpcr), &fpr);
>       if (ret) {
>           return ret;
>       }

Thanks,
Gavin


