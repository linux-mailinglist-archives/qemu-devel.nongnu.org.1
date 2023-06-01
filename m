Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDBE71A22E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4k1r-0000vf-8X; Thu, 01 Jun 2023 11:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4k1p-0000vT-As
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:15:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4k1n-0001BH-5p
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:15:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b00ecabdf2so8947165ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685632550; x=1688224550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLzeDtGYOeqN9uxNFx4cOOkJNFngkiGjBQ/zROJSAPA=;
 b=VFubMFh0YepRvVRgI/GMlMbipQ60LdGxcvfpOKadBtcar7qv7dwQ8MZGvDsFFZBYqa
 zxikyzFSIUSOzZSGntqzRXT7TU9KPbq45krmPhTU6vEDlKXkGm98rGIwzjpIb4MNUrYi
 UYUEc1pwTWaiVVAsPpLxUs0xF/CVdC6FJLYKocTz/E34KMylyplpUvSQI48SL68hUr1y
 QOjTGeETNcC9wjdiRBvQVQTKMWGXau4/bh1NG6XzCY92OCH7qLcbIP8WmOUFbiz8D0dE
 kmed+1szwzEVyqvO8slUeyBjCmhv6cxN+U8e93b2jsifzVy+6svH7PXbhwLuXtUtFxua
 HzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685632550; x=1688224550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLzeDtGYOeqN9uxNFx4cOOkJNFngkiGjBQ/zROJSAPA=;
 b=C4DqHhyetzEJ4nsmivYTt7K1LHhkWITBgk44qlk01vFCGPa/QOWhzM0El37Uy2VUiM
 4teG/DwYDedbBimbtZBHDnnkN0xdLHGP+RGDKOwaie0kfe+Gw2P7cwNELOZKzCz1YQIb
 cASgfxp9az+Ad07Uysie2VcpR0qtZREcqlJesHCeRr45opxJLZ1XDTPpw7BMFUL5nwA+
 8Ds8I4liR5Sur/G0unYDCuWISF8qgyAAgv8Lx0JZnL6u3vNDebsEs7iH/1SS5bT1eOyp
 vH6sW9UGyQXZgjpKNxdyVRfsgvxYzWncMLRFFyOdwr8JnnG/6L5jZ3wk3vSpK5g9mQSE
 tKdA==
X-Gm-Message-State: AC+VfDw441sMDmbE2gVlxzmuNY06advql3nbc2b+ijfd3XOWjjo5HiKg
 OoPJifyVvJwsblAvykEel82ASw==
X-Google-Smtp-Source: ACHHUZ5QpT1u1uOnAjAoOamtDBkInTCmfej/OIR4F2dn1xhLDZhTeZvP3o8/UMrN7iEKEO+JRLv1pw==
X-Received: by 2002:a17:902:b498:b0:1a6:6fe3:df8d with SMTP id
 y24-20020a170902b49800b001a66fe3df8dmr7966588plr.8.1685632548823; 
 Thu, 01 Jun 2023 08:15:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a1709028a8b00b001a661000398sm3614294plo.103.2023.06.01.08.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 08:15:48 -0700 (PDT)
Message-ID: <d4ced46f-ce77-d5d1-87f3-498b98249c3c@linaro.org>
Date: Thu, 1 Jun 2023 08:15:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] linux-user/riscv: Add syscall riscv_hwprobe
Content-Language: en-US
To: Robbin Ehn <rehn@rivosinc.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <964faef7016042962e3002b328a80c239f8de962.camel@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <964faef7016042962e3002b328a80c239f8de962.camel@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 05:27, Robbin Ehn wrote:
> This patch adds the new syscall for the
> "RISC-V Hardware Probing Interface"
> (https://docs.kernel.org/riscv/hwprobe.html).
> 
> Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
> ---
>   linux-headers/asm-riscv/unistd.h |   9 +++
>   linux-user/riscv/cpu_loop.c      | 119 ++++++++++++++++++++++++++++++-
>   linux-user/riscv/syscall32_nr.h  |   1 +
>   linux-user/riscv/syscall64_nr.h  |   1 +
>   4 files changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/unistd.h
> index 73d7cdd2ec..950ab3fd44 100644
> --- a/linux-headers/asm-riscv/unistd.h
> +++ b/linux-headers/asm-riscv/unistd.h
> @@ -43,3 +43,12 @@
>   #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
>   #endif
>   __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> +
> +/*
> + * Allows userspace to query the kernel for CPU architecture and
> + * microarchitecture details across a given set of CPUs.
> + */
> +#ifndef __NR_riscv_hwprobe
> +#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
> +#endif
> +__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)

You don't need to change linux-headers at all.



> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index bffca7db12..5207739185 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -26,6 +26,117 @@
>   #include "elf.h"
>   #include "semihosting/common-semi.h"
>   
> +#define RISCV_HWPROBE_KEY_MVENDORID     0
> +#define RISCV_HWPROBE_KEY_MARCHID       1
> +#define RISCV_HWPROBE_KEY_MIMPID        2
> +
> +#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
> +#define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
> +
> +#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
> +#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
> +#define     RISCV_HWPROBE_IMA_C        (1 << 1)
> +
> +#define RISCV_HWPROBE_KEY_CPUPERF_0     5
> +#define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> +#define     RISCV_HWPROBE_MISALIGNED_EMULATED    (1 << 0)
> +#define     RISCV_HWPROBE_MISALIGNED_SLOW        (2 << 0)
> +#define     RISCV_HWPROBE_MISALIGNED_FAST        (3 << 0)
> +#define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
> +#define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
> +
> +struct riscv_hwprobe {
> +    int64_t  key;
> +    uint64_t value;
> +};
> +
> +static void hwprobe_one_pair(CPURISCVState *env, struct riscv_hwprobe *pair)
> +{
> +    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
> +
> +    pair->value = 0;
> +
> +    switch (pair->key) {
> +    case RISCV_HWPROBE_KEY_MVENDORID:
> +        pair->value = cfg->mvendorid;
> +        break;
> +    case RISCV_HWPROBE_KEY_MARCHID:
> +        pair->value = cfg->marchid;
> +        break;
> +    case RISCV_HWPROBE_KEY_MIMPID:
> +        pair->value = cfg->mimpid;
> +        break;
> +    case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> +        pair->value = riscv_has_ext(env, RVI) &&
> +                      riscv_has_ext(env, RVM) &&
> +                      riscv_has_ext(env, RVA) ?
> +                      RISCV_HWPROBE_BASE_BEHAVIOR_IMA : 0;
> +        break;
> +    case RISCV_HWPROBE_KEY_IMA_EXT_0:
> +        pair->value = riscv_has_ext(env, RVF) &&
> +                      riscv_has_ext(env, RVD) ?
> +                      RISCV_HWPROBE_IMA_FD : 0;
> +        pair->value |= riscv_has_ext(env, RVC) ?
> +                       RISCV_HWPROBE_IMA_C : pair->value;
> +        break;
> +    case RISCV_HWPROBE_KEY_CPUPERF_0:
> +        pair->value = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +        break;
> +    default:
> +        pair->key = -1;
> +    break;
> +    }
> +}
> +
> +static long sys_riscv_hwprobe(CPURISCVState *env,
> +                              abi_ulong user_pairs,
> +                              size_t pair_count,
> +                              size_t cpu_count,
> +                              abi_ulong user_cpus,
> +                              unsigned int flags)
> +{
> +    struct riscv_hwprobe *host_pairs;
> +    cpu_set_t *host_cpus = NULL;
> +    size_t cpu_setsize = 0;
> +
> +    /* flags must be 0 */
> +    if (flags != 0) {
> +        return 1
> +    };
> +
> +    /* inconsistence cpu_set */
> +    if (cpu_count != 0 && user_cpus == 0) {
> +        return 1;
> +    }
> +
> +    host_pairs = lock_user(VERIFY_WRITE, user_pairs,
> +                           sizeof(*host_pairs) * pair_count, 0);
> +
> +    if (host_pairs == NULL) {
> +        return 1;
> +    }
> +
> +    if (user_cpus != 0) {
> +        cpu_setsize = CPU_ALLOC_SIZE(user_cpus);
> +        host_cpus = lock_user(VERIFY_READ, user_cpus, cpu_setsize, 0);
> +    }
> +
> +    /* cpuset is ignored, symmetric CPUs in qemu */
> +
> +    for (struct riscv_hwprobe *ipairs = host_pairs;
> +         pair_count > 0;
> +         pair_count--, ipairs++) {
> +        hwprobe_one_pair(env, ipairs);
> +    }
> +
> +    if (host_cpus != 0) {
> +        unlock_user(host_cpus, user_cpus, cpu_setsize);
> +    }
> +
> +    unlock_user(host_pairs, user_pairs, sizeof(*host_pairs) * pair_count);
> +    return 0;
> +};
> +
>   void cpu_loop(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -47,7 +158,13 @@ void cpu_loop(CPURISCVState *env)
>               break;
>           case RISCV_EXCP_U_ECALL:
>               env->pc += 4;
> -            if (env->gpr[xA7] == TARGET_NR_arch_specific_syscall + 15) {
> +            if (env->gpr[xA7] == TARGET_NR_arch_specific_syscall + 14) {
> +                /* riscv_hwprobe */
> +                ret = sys_riscv_hwprobe(env,
> +                                        env->gpr[xA0], env->gpr[xA1],
> +                                        env->gpr[xA2], env->gpr[xA3],
> +                                        env->gpr[xA4]);

This belongs in linux-user/syscall.c.
You've bypassed all of the strace support.


r~

