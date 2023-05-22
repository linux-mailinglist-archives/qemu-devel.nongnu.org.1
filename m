Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2570B4C8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 08:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0yc8-00069W-7K; Mon, 22 May 2023 02:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0ybo-00063b-SA
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:01:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0ybR-0000Yh-TN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:01:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f606a89795so2498715e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684735251; x=1687327251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/nI6QkoMk/CXuLb0DE4kihVeiVSRmfBX25yDRU9BwAI=;
 b=cuKO3+Axxakn56TRPI9KccPSJC9YRyM2QnR+6DlQo6ydsCfgL81pI3Wg/eggDdUrnR
 T8l5uidQuEXR3JQHZUItE3AlwW7k44QBPYb0NAp7i4SHodWzMwpZH47syfPPiyAQZNqN
 0LtjFbPxmOcl7q8Teg0ojAcQn90hn/90eNQ9PoKkX4uSU1wSSdsrhgWpIuNUq4RtYrq0
 o2W5zRwl0Npk4xxkQPCowGGWY9nrNF90z3envXUHDOzcRHwIQu1l0zAUYJTtEFiPXE2h
 55DMx0CeCD0IY/CSFu6ktX1At4+jqmiJJUE4WTOeUph3v30T3oEkByLhTpWpmUw50Evs
 B8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684735251; x=1687327251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/nI6QkoMk/CXuLb0DE4kihVeiVSRmfBX25yDRU9BwAI=;
 b=TcFwPTB0ier2q0jCcZM6fyaNA1dk74mq8BIm6G7YYL9/dJ+9jF10IxM23O/Bo7zj0A
 kXCfmDPU5+tyOLXNUd0MhfRDNjfNiBXC9aM4NYkmXeeiHbhZ4v5E0PpsgFKhKKiCnjf6
 kIUf2MCMZMqKu77H/5H5HkRvf7r4dQ+bXWsf8+ndf5KyNxUEEQPyaeHltHe1kPv3v/J8
 vc6FESi2cKUKE4kcvbbrXKxQJIPlBBI7V2GDRhAIA8OA8T1HNH26txSM9T7FzzLe1zrG
 4w0eq3qY2aQ0kjLJHmN50Qjbis0yBAkZ6r9VPkgSpxc2YHswnzSRZ90ofWiuRWibHQCY
 +IQw==
X-Gm-Message-State: AC+VfDxwjqSNz53PuEQJosxppUUtU7L4Af87tqxCqYxJb8kre/9ZsGZH
 4nFJvCUqNfnRpORLFLouyFl/hw==
X-Google-Smtp-Source: ACHHUZ6uwEdNSmdKOLG83IPBAEjRwpfBtmXtR8PNX9H3Vbw5vw+HrYZfRXdkfMPIqujqvFcHUJD4qg==
X-Received: by 2002:a5d:6547:0:b0:306:3ded:2bf1 with SMTP id
 z7-20020a5d6547000000b003063ded2bf1mr6983511wrv.60.1684735251212; 
 Sun, 21 May 2023 23:00:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4483000000b003062b57ffd1sm6492958wrq.50.2023.05.21.23.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 23:00:50 -0700 (PDT)
Message-ID: <9b8fcbe7-af56-7265-75ea-817460dbf6e8@linaro.org>
Date: Mon, 22 May 2023 08:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/mips: Implement Loongson CSR instructions
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-2-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521214832.20145-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

Hi Jiaxun,

On 21/5/23 23:48, Jiaxun Yang wrote:
> Loongson introduced CSR instructions since 3A4000, which looks
> similar to IOCSR and CPUCFG instructions we seen in LoongArch.
> 
> Unfortunately we don't have much document about those instructions,
> bit fields of CPUCFG instructions and IOCSR registers can be found
> at 3A4000's user manual, while instruction encodings can be found
> at arch/mips/include/asm/mach-loongson64/loongson_regs.h from
> Linux Kernel.
> 
> Our predefined CPUCFG bits are differ from actual 3A4000, since
> we can't emulate all CPUCFG features present in 3A4000 for now,
> we just enable bits for what we have in TCG.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/mips/cpu-defs.c.inc           |  9 ++++
>   target/mips/cpu.c                    |  8 ++++
>   target/mips/cpu.h                    | 40 ++++++++++++++++
>   target/mips/helper.h                 |  4 ++
>   target/mips/internal.h               |  2 +
>   target/mips/tcg/lcsr.decode          | 17 +++++++
>   target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
>   target/mips/tcg/meson.build          |  2 +
>   target/mips/tcg/op_helper.c          | 16 +++++++
>   target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
>   target/mips/tcg/sysemu/meson.build   |  4 ++
>   target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
>   target/mips/tcg/translate.c          |  3 ++
>   target/mips/tcg/translate.h          |  7 +++
>   14 files changed, 234 insertions(+)
>   create mode 100644 target/mips/tcg/lcsr.decode
>   create mode 100644 target/mips/tcg/lcsr_translate.c
>   create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c


>   static char *mips_cpu_type_name(const char *cpu_model)
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 1b8107b0af86..f63b128ff3d3 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -3,6 +3,9 @@
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-defs.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/memory.h"
> +#endif
>   #include "fpu/softfloat-types.h"
>   #include "hw/clock.h"
>   #include "mips-defs.h"
> @@ -1068,6 +1071,33 @@ typedef struct CPUArchState {
>    */
>       int32_t CP0_DESAVE;
>       target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
> +/*
> + * Loongson CSR CPUCFG registers
> + */
> +    uint32_t lcsr_cpucfg1;
> +#define CPUCFG1_FP     0
> +#define CPUCFG1_FPREV  1
> +#define CPUCFG1_MMI    4
> +#define CPUCFG1_MSA1   5
> +#define CPUCFG1_MSA2   6
> +#define CPUCFG1_LSLDR0 16
> +#define CPUCFG1_LSPERF 17
> +#define CPUCFG1_LSPERFX 18
> +#define CPUCFG1_LSSYNCI 19
> +#define CPUCFG1_LLEXC   20
> +#define CPUCFG1_SCRAND  21
> +#define CPUCFG1_MUALP   25
> +#define CPUCFG1_KMUALEN 26
> +#define CPUCFG1_ITLBT   27
> +#define CPUCFG1_SFBP    29
> +#define CPUCFG1_CDMAP   30
> +    uint32_t lcsr_cpucfg2;
> +#define CPUCFG2_LEXT1   0
> +#define CPUCFG2_LEXT2   1
> +#define CPUCFG2_LEXT3   2
> +#define CPUCFG2_LSPW    3
> +#define CPUCFG2_LCSRP   27
> +#define CPUCFG2_LDISBLIKELY 28
>   
>       /* We waste some space so we can handle shadow registers like TCs. */
>       TCState tcs[MIPS_SHADOW_SET_MAX];
> @@ -1162,6 +1192,10 @@ typedef struct CPUArchState {
>       QEMUTimer *timer; /* Internal timer */
>       Clock *count_clock; /* CP0_Count clock */
>       target_ulong exception_base; /* ExceptionBase input to the core */
> +
> +    /* Loongson IOCSR memory */

Preferrably:

    struct {

> +    AddressSpace address_space_iocsr;

        AddressSpace as;

> +    MemoryRegion system_iocsr;

        MemoryRegion mr;

     } iocsr;

>   } CPUMIPSState;
>   
>   /**
> @@ -1281,6 +1315,12 @@ static inline bool ase_msa_available(CPUMIPSState *env)
>       return env->CP0_Config3 & (1 << CP0C3_MSAP);
>   }
>   
> +/* Check presence of Loongson CSR instructions */
> +static inline bool ase_lcsr_available(CPUMIPSState *env)
> +{
> +    return env->lcsr_cpucfg1 & (1 << CPUCFG2_LCSRP);

You are checking CPUCFG1_ITLBT. Surely you want lcsr_cpucfg2 instead.

> +}

> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -218,6 +218,7 @@ bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
>   bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
>   bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
>   #if defined(TARGET_MIPS64)
> +bool decode_ase_lcsr(DisasContext *ctx, uint32_t insn);
>   bool decode_ext_tx79(DisasContext *ctx, uint32_t insn);
>   bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
>   #endif
> @@ -231,6 +232,12 @@ bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
>       static bool trans_##NAME(DisasContext *ctx, arg_##NAME *a) \
>       { return FUNC(ctx, a, __VA_ARGS__); }
>   
> +#define GEN_FALSE_TRANS(name)   \
> +static bool trans_##name(DisasContext *ctx, arg_##name * a)  \
> +{   \
> +    return false;   \
> +}

I'm not a big fan of this generic GEN_FALSE_TRANS() macro.

Otherwise LGTM!

