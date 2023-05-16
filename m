Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39270585F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0yV-0000kK-9p; Tue, 16 May 2023 16:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0yS-0000jA-4o
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:08:44 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0yQ-0000Dw-8D
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:08:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-528dd896165so10518542a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684267720; x=1686859720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RZZrwKydEztHPKUbUlgJFMFYTLXdDDQeUM+//JvEi3Y=;
 b=aDTJ+kfVRHJl4WRGjzu1SrcWkmJvAenEYhPkoFmM+eqbs8prG60232Rv8Uh+LbLaTn
 Js81lTSbNnE8UxrqZmmElqVUHK/WhpvcLbMCFO0RBSiy1nfG1ykBMfywM1MisNKTpbm9
 twAnWj7qIEV2huEnbUQ4Re4ZHSyFlw7RWOYkiqzW93KCr4xN9eadefMgMzDQJrGR2967
 aHDFHIdMx+GQEVudANWhJ7hXLAPS1QVhh/LuZr+r0f/PD43MY+WE2kwrrA5RNPI6H3U0
 48SqoV63AjTEuCW2BNtaD3KSQe4utckR1hpHpoBA/PVmnzRBqEnWc1awrHXP18rVU0Dd
 jqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684267720; x=1686859720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RZZrwKydEztHPKUbUlgJFMFYTLXdDDQeUM+//JvEi3Y=;
 b=XN/9O2EXxknTMxky3o83bQta9jvBxUQFe88YTZ5A9iBE7dVhwbpmkE1dOE93fKjHq8
 cS6vsflnOgrnKwkg63nKht2ek5nEZCU6432rjrxxudCVbB6hiUEGX+c1V8LMBv6aiYxY
 RoYSiaZPYAULNXxkddm/VbMxca0bUuHsVc5U7YrS9whmoMq56kUOOfRlxo/cIsyZKPjM
 NEP0DQxEfTQ7tT74OL1itHntCU0N4sFPuccxvJvBNU9gaaE5aivMN1PK3qwYlUpfDTZY
 zU+QAnqc0GivJADf6tR7CPPd69/xkY+2b4U4T6tmqYJgB0vf2UlduSoeQfSkdZmBSNbt
 qu6Q==
X-Gm-Message-State: AC+VfDxJBpd7MM6QB0z/NQSkawR9KuegIJcox0VcsuBMevJLcWiJHJ3B
 4pZmkSWIj3kXCGvWSQSyT4lEm5cR35zLtxs/HlA=
X-Google-Smtp-Source: ACHHUZ7QlXvYsHABuNDcvVpg6Goedry53nS6dTwN/1+iD0DMS+teyuY/qTbC+6BP6Ar3nMYg8ZCz1Q==
X-Received: by 2002:a05:6a20:2452:b0:103:558c:516 with SMTP id
 t18-20020a056a20245200b00103558c0516mr27504657pzc.55.1684267720384; 
 Tue, 16 May 2023 13:08:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 63-20020a630142000000b0051303d3e3c5sm14065201pgb.42.2023.05.16.13.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 13:08:39 -0700 (PDT)
Message-ID: <b442ffa8-1a3a-660b-2924-4e63b0d6a77f@linaro.org>
Date: Tue, 16 May 2023 13:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/arm: allow DC CVA[D]P in user mode emulation
Content-Language: en-US
To: Zhuojia Shen <chaosdefinition@hotmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org
References: <DS7PR12MB63094479AA92D99D8D777A95AC799@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <DS7PR12MB63094479AA92D99D8D777A95AC799@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/15/23 20:59, Zhuojia Shen wrote:
> DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> user_cache_maint_handler() in arch/arm64/kernel/traps.c).  The Arm ARM
> documents the semantics of the two instructions that they behave as
> DC CVAC if the address pointed to by their register operand is not
> persistent memory.
> 
> This patch enables execution of the two instructions in user mode
> emulation as NOP while preserving their original emulation in full
> system virtualization.
> 
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> ---
>   target/arm/helper.c               | 26 +++++++++++++-----
>   tests/tcg/aarch64/Makefile.target | 11 ++++++++
>   tests/tcg/aarch64/dcpodp.c        | 45 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/dcpop.c         | 45 +++++++++++++++++++++++++++++++
>   4 files changed, 120 insertions(+), 7 deletions(-)
>   create mode 100644 tests/tcg/aarch64/dcpodp.c
>   create mode 100644 tests/tcg/aarch64/dcpop.c
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0b7fd2e7e6..eeba5e7978 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7432,23 +7432,37 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>           }
>       }
>   }
> +#endif /*CONFIG_USER_ONLY*/
>   
>   static const ARMCPRegInfo dcpop_reg[] = {
>       { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
>         .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
> -      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .access = PL0_W,
>         .fgt = FGT_DCCVAP,
> -      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
> +      .accessfn = aa64_cacheop_poc_access,
> +#ifdef CONFIG_USER_ONLY
> +      .type = ARM_CP_NOP,
> +#else
> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .writefn = dccvap_writefn,
> +#endif
> +    },
>   };

Not quite correct, as CVAP to an unmapped address should SIGSEGV.  That'll be done by the 
probe_read within dccvap_writefn.

Need to make dccvap_writefn always present, ifdef out only the memory_region_from_host + 
memory_region_writeback from there.  Need to set SCTLR_EL1.UCI in arm_cpu_reset_hold in 
the CONFIG_USER_ONLY block.


r~

>   
>   static const ARMCPRegInfo dcpodp_reg[] = {
>       { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
>         .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
> -      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .access = PL0_W,
>         .fgt = FGT_DCCVADP,
> -      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
> +      .accessfn = aa64_cacheop_poc_access,
> +#ifdef CONFIG_USER_ONLY
> +      .type = ARM_CP_NOP,
> +#else
> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .writefn = dccvap_writefn,
> +#endif
> +    },
>   };
> -#endif /*CONFIG_USER_ONLY*/
>   
>   static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
>                                          bool isread)
> @@ -9092,7 +9106,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>       if (cpu_isar_feature(aa64_tlbios, cpu)) {
>           define_arm_cp_regs(cpu, tlbios_reginfo);
>       }
> -#ifndef CONFIG_USER_ONLY
>       /* Data Cache clean instructions up to PoP */
>       if (cpu_isar_feature(aa64_dcpop, cpu)) {
>           define_one_arm_cp_reg(cpu, dcpop_reg);
> @@ -9101,7 +9114,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>               define_one_arm_cp_reg(cpu, dcpodp_reg);
>           }
>       }
> -#endif /*CONFIG_USER_ONLY*/
>   
>       /*
>        * If full MTE is enabled, add all of the system registers.
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 0315795487..3430fd3cd8 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -21,12 +21,23 @@ config-cc.mak: Makefile
>   	$(quiet-@)( \
>   	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
>   	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
> +	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
>   	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
> +	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
>   	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
>   	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
>   	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
>   -include config-cc.mak
>   
> +ifneq ($(CROSS_CC_HAS_ARMV8_2),)
> +AARCH64_TESTS += dcpop
> +dcpop: CFLAGS += -march=armv8.2-a
> +endif
> +ifneq ($(CROSS_CC_HAS_ARMV8_5),)
> +AARCH64_TESTS += dcpodp
> +dcpodp: CFLAGS += -march=armv8.5-a
> +endif
> +
>   # Pauth Tests
>   ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>   AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
> diff --git a/tests/tcg/aarch64/dcpodp.c b/tests/tcg/aarch64/dcpodp.c
> new file mode 100644
> index 0000000000..dad61ce78c
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpodp.c
> @@ -0,0 +1,45 @@
> +/* Test execution of DC CVADP instruction */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP2_DCPODP
> +#define HWCAP2_DCPODP (1 << 0)
> +#endif
> +
> +static void sigill_handler(int sig)
> +{
> +    exit(EXIT_FAILURE);
> +}
> +
> +static int do_dc_cvadp(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = sigill_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
> +
> +    return 0;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {
> +        return do_dc_cvadp();
> +    } else {
> +        printf("SKIP: no HWCAP2_DCPODP on this system\n");
> +        return 0;
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/aarch64/dcpop.c b/tests/tcg/aarch64/dcpop.c
> new file mode 100644
> index 0000000000..8b4ea7c91c
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpop.c
> @@ -0,0 +1,45 @@
> +/* Test execution of DC CVAP instruction */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP_DCPOP
> +#define HWCAP_DCPOP (1 << 16)
> +#endif
> +
> +static void sigill_handler(int sig)
> +{
> +    exit(EXIT_FAILURE);
> +}
> +
> +static int do_dc_cvap(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = sigill_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
> +
> +    return 0;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
> +        return do_dc_cvap();
> +    } else {
> +        printf("SKIP: no HWCAP_DCPOP on this system\n");
> +        return 0;
> +    }
> +
> +    return 0;
> +}


