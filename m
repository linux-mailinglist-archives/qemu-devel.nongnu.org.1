Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95678EA50
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbf4s-0006kb-3y; Thu, 31 Aug 2023 06:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbf4m-0006Zc-TO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:39:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbf4j-0002uA-Gf
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:39:00 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so819837a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693478336; x=1694083136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sL3iFsaRePKAi0r+5lwj376Mc8I3ZXuv5uvF02qnOKU=;
 b=IGdsp+epQ1HJmF95u4QZDfu/P79EhyRGv3JWq/fK+uMC8KMzJWngzmj9l3TO8/1xCa
 8KjuokyjWJ9Vaha6zGVaApM5pV7ElYmCk5Yq9u7G0IG3i5qVUpnymhsig2qkYYLTHbFi
 ZYuO/r+ZqI9roOgTxd8hCp3RMasVaKrqEKIdOVtKE52aZ/dFek2AytxWcbwxnbiRl1kL
 nD669o7RDIyiDViwOovAIf1QyiJ+w/HPiiHY/gQzye9qb/35zccnHPNCLKyAU/RpdjnJ
 xKWXgwh26LJWx51dFy9pKzrZIiF5qoFblDyaMYNckmtCkiD4XJWE6fXH0dbKPhpYFwcz
 PK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478336; x=1694083136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL3iFsaRePKAi0r+5lwj376Mc8I3ZXuv5uvF02qnOKU=;
 b=F+AOXuR4Kr5EG+o39HGw+OmRi6/vB66xIV2hMbJShHE4C0k9yaUIGQ2i/CiEmOePqu
 FOpi57L22ZT6vWh8RTi//MZgQ6f7v09Cnb+HtQ+mdr2PBDMgmh0/hdliy8Co9gmT0Iix
 gReIP/ytyDDz6oqvY3F2N71Z/AQpmuR307pb94uAZd73n+Z6JFv5i08pLc66YSZXIiTx
 dPaKo7WZQ3cTIR+TmARXYZRULRg1+FARx4USf8a2UFzoOKOt950dsrSra4JmjrichoII
 j95zfTnp4sK3AA4tyGQJRHdNcMJ+n6EDQTcv1JZZ9jkzZmXkUziEfKOAuJ4gQAoieVxN
 q5AQ==
X-Gm-Message-State: AOJu0YxJU6wctPvH6T4wCVDe7EPVH6Qwu64UK8/HJUADxh+EquTxsNnV
 +QA+Ymkp4jwSitPHJFThashYKw==
X-Google-Smtp-Source: AGHT+IHKsrS4I2LFThJEYNdhxHbjRXhaGOqT+tmJm3NTQ17RJaytrRg+HhKLMZ4ALBQpUsCXn8+47Q==
X-Received: by 2002:a50:ee82:0:b0:525:950d:60ad with SMTP id
 f2-20020a50ee82000000b00525950d60admr4072093edr.25.1693478335872; 
 Thu, 31 Aug 2023 03:38:55 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 d17-20020aa7ce11000000b00522572f323dsm636680edv.16.2023.08.31.03.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:38:55 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:38:54 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 04/20] target/riscv: move riscv_tcg_ops to tcg-cpu.c
Message-ID: <20230831-6f8dde2ab55ce8323d5e3b0e@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52b.google.com
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

On Fri, Aug 25, 2023 at 10:08:37AM -0300, Daniel Henrique Barboza wrote:
> Move the remaining of riscv_tcg_ops now that we have a working realize()
> implementation.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 58 -------------------------------------
>  target/riscv/cpu.h         |  4 ---
>  target/riscv/tcg/tcg-cpu.c | 59 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 62 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 12cea62ee7..839b83e52a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -839,24 +839,6 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
>      return env->pc;
>  }
>  
> -static void riscv_cpu_synchronize_from_tb(CPUState *cs,
> -                                          const TranslationBlock *tb)
> -{
> -    if (!(tb_cflags(tb) & CF_PCREL)) {
> -        RISCVCPU *cpu = RISCV_CPU(cs);
> -        CPURISCVState *env = &cpu->env;
> -        RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
> -
> -        tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
> -
> -        if (xl == MXL_RV32) {
> -            env->pc = (int32_t) tb->pc;
> -        } else {
> -            env->pc = tb->pc;
> -        }
> -    }
> -}
> -
>  static bool riscv_cpu_has_work(CPUState *cs)
>  {
>  #ifndef CONFIG_USER_ONLY
> @@ -872,29 +854,6 @@ static bool riscv_cpu_has_work(CPUState *cs)
>  #endif
>  }
>  
> -static void riscv_restore_state_to_opc(CPUState *cs,
> -                                       const TranslationBlock *tb,
> -                                       const uint64_t *data)
> -{
> -    RISCVCPU *cpu = RISCV_CPU(cs);
> -    CPURISCVState *env = &cpu->env;
> -    RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
> -    target_ulong pc;
> -
> -    if (tb_cflags(tb) & CF_PCREL) {
> -        pc = (env->pc & TARGET_PAGE_MASK) | data[0];
> -    } else {
> -        pc = data[0];
> -    }
> -
> -    if (xl == MXL_RV32) {
> -        env->pc = (int32_t)pc;
> -    } else {
> -        env->pc = pc;
> -    }
> -    env->bins = data[1];
> -}
> -
>  static void riscv_cpu_reset_hold(Object *obj)
>  {
>  #ifndef CONFIG_USER_ONLY
> @@ -1796,23 +1755,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
>  };
>  #endif
>  
> -const struct TCGCPUOps riscv_tcg_ops = {
> -    .initialize = riscv_translate_init,
> -    .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
> -    .restore_state_to_opc = riscv_restore_state_to_opc,
> -
> -#ifndef CONFIG_USER_ONLY
> -    .tlb_fill = riscv_cpu_tlb_fill,
> -    .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
> -    .do_interrupt = riscv_cpu_do_interrupt,
> -    .do_transaction_failed = riscv_cpu_do_transaction_failed,
> -    .do_unaligned_access = riscv_cpu_do_unaligned_access,
> -    .debug_excp_handler = riscv_cpu_debug_excp_handler,
> -    .debug_check_breakpoint = riscv_cpu_debug_check_breakpoint,
> -    .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
> -#endif /* !CONFIG_USER_ONLY */
> -};
> -
>  static bool riscv_cpu_is_dynamic(Object *cpu_obj)
>  {
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 721bd0b119..2ac00a0304 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -706,10 +706,6 @@ enum riscv_pmu_event_idx {
>      RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
>  };
>  
> -/* Export tcg_ops until we move everything to tcg/tcg-cpu.c */
> -#include "hw/core/tcg-cpu-ops.h"
> -extern const struct TCGCPUOps riscv_tcg_ops;
> -
>  /* used by tcg/tcg-cpu.c*/
>  void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
>  bool cpu_cfg_ext_is_user_set(uint32_t ext_offset);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fb17097bb1..2024c98793 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -26,7 +26,66 @@
>  #include "qemu/accel.h"
>  #include "qemu/error-report.h"
>  #include "hw/core/accel-cpu.h"
> +#include "hw/core/tcg-cpu-ops.h"
> +#include "tcg/tcg.h"
>  
> +static void riscv_cpu_synchronize_from_tb(CPUState *cs,
> +                                          const TranslationBlock *tb)
> +{
> +    if (!(tb_cflags(tb) & CF_PCREL)) {
> +        RISCVCPU *cpu = RISCV_CPU(cs);
> +        CPURISCVState *env = &cpu->env;
> +        RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
> +
> +        tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
> +
> +        if (xl == MXL_RV32) {
> +            env->pc = (int32_t) tb->pc;
> +        } else {
> +            env->pc = tb->pc;
> +        }
> +    }
> +}
> +
> +static void riscv_restore_state_to_opc(CPUState *cs,
> +                                       const TranslationBlock *tb,
> +                                       const uint64_t *data)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
> +    target_ulong pc;
> +
> +    if (tb_cflags(tb) & CF_PCREL) {
> +        pc = (env->pc & TARGET_PAGE_MASK) | data[0];
> +    } else {
> +        pc = data[0];
> +    }
> +
> +    if (xl == MXL_RV32) {
> +        env->pc = (int32_t)pc;
> +    } else {
> +        env->pc = pc;
> +    }
> +    env->bins = data[1];
> +}
> +
> +const struct TCGCPUOps riscv_tcg_ops = {

This can be static again.

> +    .initialize = riscv_translate_init,
> +    .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
> +    .restore_state_to_opc = riscv_restore_state_to_opc,
> +
> +#ifndef CONFIG_USER_ONLY
> +    .tlb_fill = riscv_cpu_tlb_fill,
> +    .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
> +    .do_interrupt = riscv_cpu_do_interrupt,
> +    .do_transaction_failed = riscv_cpu_do_transaction_failed,
> +    .do_unaligned_access = riscv_cpu_do_unaligned_access,
> +    .debug_excp_handler = riscv_cpu_debug_excp_handler,
> +    .debug_check_breakpoint = riscv_cpu_debug_check_breakpoint,
> +    .debug_check_watchpoint = riscv_cpu_debug_check_watchpoint,
> +#endif /* !CONFIG_USER_ONLY */
> +};
>  
>  static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>                                      bool value)
> -- 
> 2.41.0
> 
>

With the above static change and Phil's remove comment change,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

