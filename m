Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0EC78ECB2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbgN3-0005BT-2U; Thu, 31 Aug 2023 08:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbgMi-0004VE-BS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:01:39 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbgMd-0005eN-IV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:01:36 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so13902941fa.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693483288; x=1694088088; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3OsV/bYfKoH8v1MQpGrrxy4DsUPxmKaRrOO7eWCYbqQ=;
 b=miPYNx7IT1gg4RmxK8hIw4HcZBY3QA0cH58jZJQtEbMp3GFtwYZruY8StoDFjr6bhu
 NdXIdI+VumChFnFdVn+dqjlDlBRbKjpWfTbdIpd+wVucpkAQgcscSaegpuDyK8BeYNoR
 RibfBJZwursuI/G4op91mLXnCP+U7V0NcaCY9Ad80LP/NARwJje774A78mD8o/fImNRp
 JOffu6ihxBntjJPncg8oYOp9KJjPjHq6UMw7NcvaZ+67N9UH5xgvoTMdtuYhdDnLsbkZ
 arXd7p8g6DWzVcK3ogHgEYA2l/QhSu61CvPbAk+a++2aRSMcdfIEqbhe17bAV4eIUenF
 4Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693483288; x=1694088088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OsV/bYfKoH8v1MQpGrrxy4DsUPxmKaRrOO7eWCYbqQ=;
 b=asvB8TtMrX4Mfjg8Rqs0echCy+b44tBL9NZ0sVjxw75bUTvd97s7vd0+ei6GVqb+yA
 d3GGBnDXIq9ld3YpGKpaCHy2buREW96LoKonl5jhKaclnnTNdwvE1PuzgPzmQO+NXNE+
 fFU+EFiwdmvuSYnhAYsCpT5+uIrcoDD2ZxLsfN901rzlRRqCCl7LhEWoY6LGRjAYbqJZ
 OiSDhOSSxhQfNOegajhH+MiajpvNECYaYGWqXfdYHmlOL8u8zb7t5t3jOswJ9YTja4IO
 bILf8Izp6yOAMxBRzqZA6o9muhMKr44P4+zMSAPLJB2n0huWGqsMupTJrWCGkD1ZltKa
 X3GQ==
X-Gm-Message-State: AOJu0YxZ3LN+SQ/rnBFaDoYUJhqMKKMEuqwaeWQIu+fk0lD8SLPOsB3X
 Ujn5KQYuDJIEdnbPGXn304+Zng==
X-Google-Smtp-Source: AGHT+IELISqlbz+Vmp8tB3mS8UED0+zHEQYnyybZnvlIynsldHVJWch2imPMikr/6SCDPubCYKPJtA==
X-Received: by 2002:a2e:924e:0:b0:2bc:e882:f717 with SMTP id
 v14-20020a2e924e000000b002bce882f717mr3525421ljg.53.1693483287846; 
 Thu, 31 Aug 2023 05:01:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 f27-20020a170906391b00b0099cd1c0cb21sm668050eje.129.2023.08.31.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:01:27 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:01:26 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 16/20] target/riscv/tcg: move
 riscv_cpu_add_misa_properties() to tcg-cpu.c
Message-ID: <20230831-9135d7f6e2059b82be3f9300@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-17-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-17-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x229.google.com
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

On Fri, Aug 25, 2023 at 10:08:49AM -0300, Daniel Henrique Barboza wrote:
> All code related to MISA TCG properties is also moved.
> 
> At this point, all TCG properties handling is done in tcg-cpu.c, all KVM
> properties handling is done in kvm-cpu.c.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 89 --------------------------------------
>  target/riscv/cpu.h         |  1 -
>  target/riscv/tcg/tcg-cpu.c | 84 +++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 90 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 89b09a7e89..3c9db46837 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1201,49 +1201,6 @@ static void riscv_cpu_init(Object *obj)
>  #endif /* CONFIG_USER_ONLY */
>  }
>  
> -typedef struct RISCVCPUMisaExtConfig {
> -    const char *name;
> -    const char *description;
> -    target_ulong misa_bit;
> -    bool enabled;
> -} RISCVCPUMisaExtConfig;
> -
> -static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
> -                                 void *opaque, Error **errp)
> -{
> -    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
> -    target_ulong misa_bit = misa_ext_cfg->misa_bit;
> -    RISCVCPU *cpu = RISCV_CPU(obj);
> -    CPURISCVState *env = &cpu->env;
> -    bool value;
> -
> -    if (!visit_type_bool(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    if (value) {
> -        env->misa_ext |= misa_bit;
> -        env->misa_ext_mask |= misa_bit;
> -    } else {
> -        env->misa_ext &= ~misa_bit;
> -        env->misa_ext_mask &= ~misa_bit;
> -    }
> -}
> -
> -static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
> -                                 void *opaque, Error **errp)
> -{
> -    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
> -    target_ulong misa_bit = misa_ext_cfg->misa_bit;
> -    RISCVCPU *cpu = RISCV_CPU(obj);
> -    CPURISCVState *env = &cpu->env;
> -    bool value;
> -
> -    value = env->misa_ext & misa_bit;
> -
> -    visit_type_bool(v, name, &value, errp);
> -}
> -
>  typedef struct misa_ext_info {
>      const char *name;
>      const char *description;
> @@ -1304,52 +1261,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>      return val;
>  }
>  
> -#define MISA_CFG(_bit, _enabled) \
> -    {.misa_bit = _bit, .enabled = _enabled}
> -
> -static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
> -    MISA_CFG(RVA, true),
> -    MISA_CFG(RVC, true),
> -    MISA_CFG(RVD, true),
> -    MISA_CFG(RVF, true),
> -    MISA_CFG(RVI, true),
> -    MISA_CFG(RVE, false),
> -    MISA_CFG(RVM, true),
> -    MISA_CFG(RVS, true),
> -    MISA_CFG(RVU, true),
> -    MISA_CFG(RVH, true),
> -    MISA_CFG(RVJ, false),
> -    MISA_CFG(RVV, false),
> -    MISA_CFG(RVG, false),
> -};
> -
> -void riscv_cpu_add_misa_properties(Object *cpu_obj)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
> -        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
> -        int bit = misa_cfg->misa_bit;
> -
> -        misa_cfg->name = riscv_get_misa_ext_name(bit);
> -        misa_cfg->description = riscv_get_misa_ext_description(bit);
> -
> -        /* Check if KVM already created the property */
> -        if (object_property_find(cpu_obj, misa_cfg->name)) {
> -            continue;
> -        }
> -
> -        object_property_add(cpu_obj, misa_cfg->name, "bool",
> -                            cpu_get_misa_ext_cfg,
> -                            cpu_set_misa_ext_cfg,
> -                            NULL, (void *)misa_cfg);
> -        object_property_set_description(cpu_obj, misa_cfg->name,
> -                                        misa_cfg->description);
> -        object_property_set_bool(cpu_obj, misa_cfg->name,
> -                                 misa_cfg->enabled, NULL);
> -    }
> -}
> -
>  #define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
>      {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
>       .enabled = _defval}
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 74fbb33e09..4269523e24 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -726,7 +726,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
>  extern Property riscv_cpu_options[];
>  
> -void riscv_cpu_add_misa_properties(Object *cpu_obj);
>  void riscv_add_satp_mode_properties(Object *obj);
>  
>  /* CSR function table */
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 68ce3cbcb9..8e3f55d3a6 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -574,6 +574,90 @@ static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
>      return true;
>  }
>  
> +typedef struct RISCVCPUMisaExtConfig {
> +    const char *name;
> +    const char *description;
> +    target_ulong misa_bit;
> +    bool enabled;
> +} RISCVCPUMisaExtConfig;
> +
> +static void cpu_set_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
> +                                 void *opaque, Error **errp)
> +{
> +    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
> +    target_ulong misa_bit = misa_ext_cfg->misa_bit;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    CPURISCVState *env = &cpu->env;
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value) {
> +        env->misa_ext |= misa_bit;
> +        env->misa_ext_mask |= misa_bit;
> +    } else {
> +        env->misa_ext &= ~misa_bit;
> +        env->misa_ext_mask &= ~misa_bit;
> +    }
> +}
> +
> +static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
> +                                 void *opaque, Error **errp)
> +{
> +    const RISCVCPUMisaExtConfig *misa_ext_cfg = opaque;
> +    target_ulong misa_bit = misa_ext_cfg->misa_bit;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    CPURISCVState *env = &cpu->env;
> +    bool value;
> +
> +    value = env->misa_ext & misa_bit;
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +#define MISA_CFG(_bit, _enabled) \
> +    {.misa_bit = _bit, .enabled = _enabled}
> +
> +static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {

Can this be const?

> +    MISA_CFG(RVA, true),
> +    MISA_CFG(RVC, true),
> +    MISA_CFG(RVD, true),
> +    MISA_CFG(RVF, true),
> +    MISA_CFG(RVI, true),
> +    MISA_CFG(RVE, false),
> +    MISA_CFG(RVM, true),
> +    MISA_CFG(RVS, true),
> +    MISA_CFG(RVU, true),
> +    MISA_CFG(RVH, true),
> +    MISA_CFG(RVJ, false),
> +    MISA_CFG(RVV, false),
> +    MISA_CFG(RVG, false),
> +};
> +
> +static void riscv_cpu_add_misa_properties(Object *cpu_obj)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
> +        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
> +        int bit = misa_cfg->misa_bit;
> +
> +        misa_cfg->name = riscv_get_misa_ext_name(bit);
> +        misa_cfg->description = riscv_get_misa_ext_description(bit);
> +
> +        object_property_add(cpu_obj, misa_cfg->name, "bool",
> +                            cpu_get_misa_ext_cfg,
> +                            cpu_set_misa_ext_cfg,
> +                            NULL, (void *)misa_cfg);
> +        object_property_set_description(cpu_obj, misa_cfg->name,
> +                                        misa_cfg->description);
> +        object_property_set_bool(cpu_obj, misa_cfg->name,
> +                                 misa_cfg->enabled, NULL);
> +    }
> +}
> +
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>  {
> -- 
> 2.41.0
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

