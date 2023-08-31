Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C978EA1F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbenw-0005O0-QO; Thu, 31 Aug 2023 06:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbenu-0005MI-DL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:21:34 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbenr-0006w9-MK
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:21:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so784755a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693477289; x=1694082089; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p3ZTbMpGlGZr04M7AHcw/ms/RWHHhtm8YDEiPgYrbRM=;
 b=GKn2zZmAotKWUbOch+qaefNmIE2G9mqdjysG27a2G53DgBSXo/ZwyyRf742D+i6vvP
 7/iS27FSyC92U13yB7+Y2UKgYOXNXChE+BcqZQiPg/Dg1Ceyb2ztsiA0bjQWshgO1GYR
 ykPnIkAN4HVo3TtlW5AeNzrHXRZ4x/KHExgyVQTAZK21vp2sh6nalLkNqNVzQ3lod4MI
 SffHZfgYcFjZwD2y2YM4rWr64bx7sgh2INn4IAjdrxMxIBZ7JH2cU9dBF4Hy+k7gi1I3
 85QVJo1u5+Ur+/vV5GSSQvFhZ7uKp06b3HHZmQJyZhigZ1hDUVBFq+Z0XK/HzFH8uueg
 3Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693477289; x=1694082089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3ZTbMpGlGZr04M7AHcw/ms/RWHHhtm8YDEiPgYrbRM=;
 b=fOwwBhpRI8bPdDipJJ3h3sN/GB/CbvyWqc4DOM1aRz18xK88pK8jCjVtzIN5wPQOA5
 dKlE4o+EK7edI9wV4lWb790lQfeB0tcinmaqY7HRJOsKC8xMFy52f9u758wiBrwi4hhF
 CFz+4EZm7e1jJq8J+opEdiE5hunzeOYSqRsZMTRZPzz/Fisd64Fbb3mdEqJY72/bC9uO
 YdX5m+ACMdwUi1a4hUpqvKwUo6uQKzkGd+WEsY47CDyCZrmWKaQpG+rBz6Wq3IhpJt2R
 vhrVaP/5dSIUiNXiojI6GeiQmaLO+dH8FNotXx1PDDsHpMNxleN5FKHMn4xAgTaVVF+T
 uInA==
X-Gm-Message-State: AOJu0Yxd11EPabq5RPgP7rT6CuPHHF7rqY0ePC7ykotTvUOaFjWGnIWL
 2Q752hgQKOtUKN5TxYlU3K1NSg==
X-Google-Smtp-Source: AGHT+IHVUQitIMwnKaSewAd9zx8RAg1KqmgDJrO0MExB5PBBQAT78xB6RP/5JhXoGr82ETgnJ/Vgkg==
X-Received: by 2002:a17:906:2192:b0:9a1:bf00:ae53 with SMTP id
 18-20020a170906219200b009a1bf00ae53mr3405082eju.69.1693477289362; 
 Thu, 31 Aug 2023 03:21:29 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ko18-20020a170907987200b0099de082442esm599415ejc.70.2023.08.31.03.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:21:28 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:21:28 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 02/20] target/riscv: move riscv_cpu_realize_tcg() to
 TCG::cpu_realizefn()
Message-ID: <20230831-fbbaf4a1fa62816f0ff9de1e@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 25, 2023 at 10:08:35AM -0300, Daniel Henrique Barboza wrote:
> riscv_cpu_realize_tcg() was added to allow TCG cpus to have a different
> realize() path during the common riscv_cpu_realize(), making it a good
> choice to start moving TCG exclusive code to tcg-cpu.c.
> 
> Rename it to tcg_cpu_realizefn() and assign it as a implementation of
> accel::cpu_realizefn(). tcg_cpu_realizefn() will then be called during
> riscv_cpu_realize() via cpu_exec_realizefn(). We'll use a similar
> approach with KVM in the near future.
> 
> riscv_cpu_validate_set_extensions() is too big and with too many
> dependencies to be moved in this same patch. We'll do that next.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 128 -----------------------------------
>  target/riscv/tcg/tcg-cpu.c | 132 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+), 128 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 38dcbc4dd2..36c5c6e579 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -23,9 +23,7 @@
>  #include "qemu/log.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> -#include "pmu.h"
>  #include "internals.h"
> -#include "time_helper.h"
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -1065,29 +1063,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>      }
>  }
>  
> -static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
> -{
> -    CPURISCVState *env = &cpu->env;
> -    int priv_version = -1;
> -
> -    if (cpu->cfg.priv_spec) {
> -        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
> -            priv_version = PRIV_VERSION_1_12_0;
> -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
> -            priv_version = PRIV_VERSION_1_11_0;
> -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
> -            priv_version = PRIV_VERSION_1_10_0;
> -        } else {
> -            error_setg(errp,
> -                       "Unsupported privilege spec version '%s'",
> -                       cpu->cfg.priv_spec);
> -            return;
> -        }
> -
> -        env->priv_ver = priv_version;
> -    }
> -}
> -
>  static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>  {
>      CPURISCVState *env = &cpu->env;
> @@ -1112,33 +1087,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>      }
>  }
>  
> -static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
> -{
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> -    CPUClass *cc = CPU_CLASS(mcc);
> -    CPURISCVState *env = &cpu->env;
> -
> -    /* Validate that MISA_MXL is set properly. */
> -    switch (env->misa_mxl_max) {
> -#ifdef TARGET_RISCV64
> -    case MXL_RV64:
> -    case MXL_RV128:
> -        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
> -        break;
> -#endif
> -    case MXL_RV32:
> -        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    if (env->misa_mxl_max != env->misa_mxl) {
> -        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
> -        return;
> -    }
> -}
> -
>  /*
>   * Check consistency between chosen extensions while setting
>   * cpu->cfg accordingly.
> @@ -1512,74 +1460,6 @@ static void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  #endif
>  }
>  
> -static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
> -{
> -    if (riscv_has_ext(env, RVH) && env->priv_ver < PRIV_VERSION_1_12_0) {
> -        error_setg(errp, "H extension requires priv spec 1.12.0");
> -        return;
> -    }
> -}
> -
> -static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
> -{
> -    RISCVCPU *cpu = RISCV_CPU(dev);
> -    CPURISCVState *env = &cpu->env;
> -    Error *local_err = NULL;
> -
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
> -        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
> -        return;
> -    }
> -
> -    riscv_cpu_validate_misa_mxl(cpu, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    riscv_cpu_validate_priv_spec(cpu, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    riscv_cpu_validate_misa_priv(env, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
> -        /*
> -         * Enhanced PMP should only be available
> -         * on harts with PMP support
> -         */
> -        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
> -        return;
> -    }
> -
> -    riscv_cpu_validate_set_extensions(cpu, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -#ifndef CONFIG_USER_ONLY
> -    CPU(dev)->tcg_cflags |= CF_PCREL;
> -
> -    if (cpu->cfg.ext_sstc) {
> -        riscv_timer_init(cpu);
> -    }
> -
> -    if (cpu->cfg.pmu_num) {
> -        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
> -            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                          riscv_pmu_timer_cb, cpu);
> -        }
> -     }
> -#endif
> -}
> -
>  static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -1598,14 +1478,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (tcg_enabled()) {
> -        riscv_cpu_realize_tcg(dev, &local_err);
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    }
> -
>      riscv_cpu_finalize_features(cpu, &local_err);
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1ad27a26aa..b3d3f265d7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -19,9 +19,140 @@
>  
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "pmu.h"
> +#include "time_helper.h"
> +#include "qapi/error.h"
>  #include "qemu/accel.h"
>  #include "hw/core/accel-cpu.h"
>  
> +
> +static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
> +{
> +    if (riscv_has_ext(env, RVH) && env->priv_ver < PRIV_VERSION_1_12_0) {
> +        error_setg(errp, "H extension requires priv spec 1.12.0");
> +        return;
> +    }
> +}
> +
> +static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
> +{
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +    CPUClass *cc = CPU_CLASS(mcc);
> +    CPURISCVState *env = &cpu->env;
> +
> +    /* Validate that MISA_MXL is set properly. */
> +    switch (env->misa_mxl_max) {
> +#ifdef TARGET_RISCV64
> +    case MXL_RV64:
> +    case MXL_RV128:
> +        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
> +        break;
> +#endif
> +    case MXL_RV32:
> +        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (env->misa_mxl_max != env->misa_mxl) {
> +        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
> +        return;
> +    }
> +}
> +
> +static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    int priv_version = -1;
> +
> +    if (cpu->cfg.priv_spec) {
> +        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
> +            priv_version = PRIV_VERSION_1_12_0;
> +        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
> +            priv_version = PRIV_VERSION_1_11_0;
> +        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
> +            priv_version = PRIV_VERSION_1_10_0;
> +        } else {
> +            error_setg(errp,
> +                       "Unsupported privilege spec version '%s'",
> +                       cpu->cfg.priv_spec);
> +            return;
> +        }
> +
> +        env->priv_ver = priv_version;
> +    }
> +}
> +
> +/*
> + * We'll get here via the following path:
> + *
> + * riscv_cpu_realize()
> + *   -> cpu_exec_realizefn()
> + *      -> tcg_cpu_realizefn() (via accel_cpu_realizefn())
> + */
> +static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    Error *local_err = NULL;
> +
> +    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
> +        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
> +        return false;
> +    }
> +
> +    riscv_cpu_validate_misa_mxl(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +    riscv_cpu_validate_priv_spec(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +    riscv_cpu_validate_misa_priv(env, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
> +        /*
> +         * Enhanced PMP should only be available
> +         * on harts with PMP support
> +         */
> +        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
> +        return false;
> +    }
> +
> +    riscv_cpu_validate_set_extensions(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +#ifndef CONFIG_USER_ONLY
> +    CPU(cs)->tcg_cflags |= CF_PCREL;
> +
> +    if (cpu->cfg.ext_sstc) {
> +        riscv_timer_init(cpu);
> +    }
> +
> +    if (cpu->cfg.pmu_num) {
> +        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
> +            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          riscv_pmu_timer_cb, cpu);
> +        }
> +     }
> +#endif
> +
> +    return true;
> +}
> +
>  static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
>  {
>      /*
> @@ -41,6 +172,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>  
>      acc->cpu_class_init = tcg_cpu_class_init;
> +    acc->cpu_realizefn = tcg_cpu_realizefn;
>  }
>  
>  static const TypeInfo tcg_cpu_accel_type_info = {
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

