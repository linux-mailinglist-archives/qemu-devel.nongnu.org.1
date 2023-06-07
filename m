Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79939725DA5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6reh-0007cr-4Y; Wed, 07 Jun 2023 07:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6ree-0007cX-Rf
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:48:44 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6rea-0005wv-RU
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:48:44 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977d7bdde43so106895966b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686138519; x=1688730519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WIK1C2lddNHYs98Gm9NKGaeLSgyMES5LeOzieO8E/Pw=;
 b=Nn8qI8lFroDCnlc2v+pguCJsG/hNTc05Ka+W8BG6GEP+tn/XwvwpOLZzfxt09l3mO/
 CKQXjGzjCzJY6IEjTFzNS1IvZr2PXCZ5eZaXq0alMfNDFNI//fdSmdCJfbtRTDG80xu1
 MRcJlUWFDkLtrnH17awQETSY8exww9bxrbvSz3IAyKYUEmmKnFAt2F2UL2gc+iufX1dU
 zmdteE9QJo+7i5+c+nYJKZrzhjccHQQGmQr5s/2dFJNx5mnyYLrGWW/wPESnLB8ugSfH
 XC3pt79V+GwfOL6YFxNK4CgpSaziW9Xp9rD/VEylZW1/KLf7R9RZzovEXPnd/O+tIfm3
 UjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686138519; x=1688730519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIK1C2lddNHYs98Gm9NKGaeLSgyMES5LeOzieO8E/Pw=;
 b=a6GVHz0/haNjvZrkuQ8r5W8KAURwFS/Oo5C9xus+tE+74m76IiUbGS0Cy6+zJoyzMU
 abq0/mgjikW9YLWjdi1LoA3LxwLFzpSY2b18c4tqREdNFLHi8+47zBTWZ6sSj3m+r9mM
 Idfc4L1CwryncQnDlJ5xI1TxlDH11XFNZ20F1ddDmy/3bw15dqM32aRYwHKEIVrPky3n
 BzJ9JjS9Sqzzs1+SD6ux2z15QUJ4E8syOG5ZA7K23YeUetAQ3p+It4PQhkTsfZbG4Toj
 P1CyFwrf/BYTkILP4VvIH/4uuju8Zf/rqsyyOGSgctwwX6C36GQH0j8U5PTaKTQ99HPy
 Yqyw==
X-Gm-Message-State: AC+VfDyPtcGbNqYVvaPPbVGBkntdc1P7BwCocnkGOsgdiDn3vD/DC0ro
 8mHg7ArvovDF1jkrzFGJmgFcgg==
X-Google-Smtp-Source: ACHHUZ6sgZ6RlFTZxE7v1SSL+buv8Jvq1jSQESyX6fvWbVR0Epok3kZb8uj0MjpDoSeTqO+JQyIHyQ==
X-Received: by 2002:a17:907:72cb:b0:966:1bf2:2af5 with SMTP id
 du11-20020a17090772cb00b009661bf22af5mr11711764ejc.22.1686138518845; 
 Wed, 07 Jun 2023 04:48:38 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1709066bcf00b0096f7500502csm6851471ejs.199.2023.06.07.04.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 04:48:38 -0700 (PDT)
Date: Wed, 7 Jun 2023 13:48:37 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 13/16] target/riscv/kvm.c: add multi-letter extension KVM
 properties
Message-ID: <20230607-9a499522ac7de9ebcf0c8699@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-14-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-14-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
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

On Tue, May 30, 2023 at 04:46:20PM -0300, Daniel Henrique Barboza wrote:
> Let's add KVM user properties for the multi-letter extensions that KVM
> currently supports: zicbom, zicboz, zihintpause, zbb, ssaia, sstc,
> svinval and svpbmt.
> 
> As with the recently added MISA properties we're also going to add a
> 'user_set' flag in each of them. The flag will be set only if the user
> chose an option that's different from the host and will require extra
> handling from the KVM driver.
> 
> However, multi-letter CPUs have more cases to cover than MISA
> extensions, so we're adding an extra 'supported' flag as well. This flag
> will reflect if a given extension is supported by KVM, i.e. KVM knows
> how to handle it. This is determined during KVM extension discovery in
> kvm_riscv_init_multiext_cfg(), where we test for EINVAL errors. Any
> other error different from EINVAL will cause an abort.

I wish that was ENOENT, but I suppose that ship sailed.

> 
> The 'supported' flag will then be used later on to give an exception for
> users that are disabling multi-letter extensions that are unknown to
> KVM.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index bb1dafe263..b4193a10d8 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -202,6 +202,99 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
>      }
>  }
>  
> +typedef struct RISCVCPUMultiExtConfig {
> +    const char *name;

No description? I'd prefer we use the same cfg struct for single-letter
and multi-letter extensions. We can use a union to overlap cpu_cfg_offset
and misa_bit.

> +    int kvm_reg_id;
> +    int cpu_cfg_offset;
> +    bool supported;
> +    bool user_set;
> +} RISCVCPUMultiExtConfig;
> +
> +#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
> +
> +/*
> + * KVM ISA Multi-letter extensions. We care about the order
> + * since it'll be used to create the ISA string later on.
> + * We follow the same ordering rules of isa_edata_arr[]
> + * from target/riscv/cpu.c.
> + */
> +static RISCVCPUMultiExtConfig kvm_multi_ext_cfgs[] = {
> +    {.name = "zicbom", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZICBOM,
> +     .cpu_cfg_offset = CPUCFG(ext_icbom)},
> +    {.name = "zicboz", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZICBOZ,
> +     .cpu_cfg_offset = CPUCFG(ext_icboz)},
> +    {.name = "zihintpause", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
> +     .cpu_cfg_offset = CPUCFG(ext_zihintpause)},
> +    {.name = "zbb", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZBB,
> +     .cpu_cfg_offset = CPUCFG(ext_zbb)},
> +    {.name = "ssaia", .kvm_reg_id = KVM_RISCV_ISA_EXT_SSAIA,
> +     .cpu_cfg_offset = CPUCFG(ext_ssaia)},
> +    {.name = "sstc", .kvm_reg_id = KVM_RISCV_ISA_EXT_SSTC,
> +     .cpu_cfg_offset = CPUCFG(ext_sstc)},
> +    {.name = "svinval", .kvm_reg_id = KVM_RISCV_ISA_EXT_SVINVAL,
> +     .cpu_cfg_offset = CPUCFG(ext_svinval)},
> +    {.name = "svpbmt", .kvm_reg_id = KVM_RISCV_ISA_EXT_SVPBMT,
> +     .cpu_cfg_offset = CPUCFG(ext_svpbmt)},

As pointed out in the last patch, it'd be nice to share names (and
descriptions) with TCG.

> +};
> +
> +static void kvm_cpu_cfg_set(RISCVCPU *cpu, RISCVCPUMultiExtConfig *multi_ext,
> +                            uint32_t val)
> +{
> +    int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
> +    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
> +
> +    *ext_enabled = val;
> +}
> +
> +static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
> +                                RISCVCPUMultiExtConfig *multi_ext)
> +{
> +    int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
> +    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
> +
> +    return *ext_enabled;
> +}
> +
> +static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
> +                                      const char *name,
> +                                      void *opaque, Error **errp)
> +{
> +    RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    bool value, host_val;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    host_val = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
> +
> +    /*
> +     * Ignore if the user is setting the same value
> +     * as the host.
> +     */
> +    if (value == host_val) {
> +        return;
> +    }
> +
> +    if (!multi_ext_cfg->supported) {
> +        /*
> +         * Error out if the user is trying to enable an
> +         * extension that KVM doesn't support. Ignore
> +         * option otherwise.
> +         */
> +        if (value) {
> +            error_setg(errp, "KVM does not support disabling extension %s",
> +                       multi_ext_cfg->name);
> +        }
> +
> +        return;
> +    }
> +
> +    multi_ext_cfg->user_set = true;
> +    kvm_cpu_cfg_set(cpu, multi_ext_cfg, value);
> +}
> +
>  static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>  {
>      int i;
> @@ -216,6 +309,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>          object_property_set_description(cpu_obj, misa_cfg->name,
>                                          misa_cfg->description);
>      }
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
> +        RISCVCPUMultiExtConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
> +
> +        object_property_add(cpu_obj, multi_cfg->name, "bool",
> +                            NULL,

You have a getter function, so we might as well set it here, no?

> +                            kvm_cpu_set_multi_ext_cfg,
> +                            NULL, multi_cfg);
> +    }
>  }
>  
>  static int kvm_riscv_get_regs_core(CPUState *cs)
> @@ -531,6 +633,39 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
>      env->misa_ext = env->misa_ext_mask;
>  }
>  
> +static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint64_t val;
> +    int i, ret;
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
> +        RISCVCPUMultiExtConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
> +        struct kvm_one_reg reg;
> +
> +        reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
> +                                  multi_ext_cfg->kvm_reg_id);
> +        reg.addr = (uint64_t)&val;
> +        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +        if (ret != 0) {
> +            if (ret == -EINVAL) {
> +                /* Silently default to 'false' if KVM does not support it. */
> +                multi_ext_cfg->supported = false;
> +                val = false;
> +            } else {
> +                error_report("Unable to read ISA_EXT KVM register %s, "
> +                             "error %d", multi_ext_cfg->name, ret);
> +                kvm_riscv_destroy_scratch_vcpu(kvmcpu);

I don't think we usually bother cleaning up when exiting, we just let exit
do it, but OK.

> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            multi_ext_cfg->supported = true;
> +        }
> +
> +        kvm_cpu_cfg_set(cpu, multi_ext_cfg, val);
> +    }
> +}
> +
>  void kvm_riscv_init_user_properties(Object *cpu_obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cpu_obj);
> @@ -543,6 +678,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
>      kvm_riscv_add_cpu_user_properties(cpu_obj);
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
> +    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
>  
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> -- 
> 2.40.1
> 
>

Thanks,
drew

