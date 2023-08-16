Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63477DD1B
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCcr-00025S-8R; Wed, 16 Aug 2023 05:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qWCcb-000255-6w
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:15:21 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qWCcX-0005sr-Av
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:15:20 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-56c7f47ec42so4481511eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692177315; x=1692782115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkqMYbzFh8jDK06nJ+rN9IfFUiT7E31HVB50sPrnOL0=;
 b=V0km+NmXrsE/bZ/KdhqG3DsLHvQ6jLzf2+NJd+M5u57Cbqbt61iBnClySlYWQ9Abg3
 9CQBHrEuZcFpnm4Xy4znei+F/JhVgojoiVJOUW66EM5hdxemKsv+7Se9BKQbqp9ykAOw
 VH+9gzWUrEjrQv4m2yvLY2l+wjKDq3rI/aoV9Nob+DEGrFzVvoqnWmSPWKa0y47eey9t
 6eByX57iqZS5XWZ4x/qNaC1htgiDqfMvks4nr5oNKHyGXQH4h2hFoBa86KJpI5jdeJoR
 Rt6CEiX5G5Ps5Ck2+3Xz1/L6LfO2abApXrtjvzcVCK8jifbQ8ornrZ7OmxYumf0B1Yj0
 A6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692177315; x=1692782115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkqMYbzFh8jDK06nJ+rN9IfFUiT7E31HVB50sPrnOL0=;
 b=MJYPz3BIqw6pU5lcBoc/JBpLF7poCiCqDCmMGgKsM8JCwNS3dgeKzaqh8ulOLTbREN
 1ftGB/51bBNPJlTShqHQb16AamWTIrpbqy0/yLW/fWCb8PjwMEFB+sK7wfdyCqTfTnHJ
 BmVMPbSVPGz8mC3k3PBHRpXuj9N9gy4jPWp4x0LUYUesJI8wAeSlWsO1yKDCP5A5onfu
 g9jPXdLAexHq/4S8l9BjkncvU8w9LjLHEIwFOTEVNmN29d7LnQSKqugInIVyCfVZc/7f
 MVzknCItgPzMQ4mKiJC6cnpAzOSm1fbbj4PmFSHDZIE9dBu+igYsSO+E2nI+l9sqBLob
 Iv1A==
X-Gm-Message-State: AOJu0YySopjfVW86YWQqvkbBZABc9Q8wA4y+sBJp9LQmAY5o8ZcfWhfk
 /foymSoqM13olXOVrYhEBYLMCw==
X-Google-Smtp-Source: AGHT+IGaUW+DwiFLsR3nSNKBUSvbJuFdTfxncFBF5NdZ4ZGPXWn3Tqvf04TUqODU9zLI8jHle8b33A==
X-Received: by 2002:a05:6870:b428:b0:1bb:8842:7b5c with SMTP id
 x40-20020a056870b42800b001bb88427b5cmr1520216oap.43.1692177315231; 
 Wed, 16 Aug 2023 02:15:15 -0700 (PDT)
Received: from [192.168.68.108] (189-69-160-189.dial-up.telesp.net.br.
 [189.69.160.189]) by smtp.gmail.com with ESMTPSA id
 q3-20020a9d6643000000b006b94aba1f0bsm6036005otm.43.2023.08.16.02.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 02:15:14 -0700 (PDT)
Message-ID: <d9fa9c2f-29cb-d186-3023-29a16918aecc@ventanamicro.com>
Date: Wed, 16 Aug 2023 06:15:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/riscv: Update CSR bits name for svadu extension
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230815022442.25032-1-liweiwei@iscas.ac.cn>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230815022442.25032-1-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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



On 8/14/23 23:24, Weiwei Li wrote:
> The Svadu specification updated the name of the *envcfg bit from
> HADE to ADUE.
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---
>   target/riscv/cpu.c        |  4 ++--
>   target/riscv/cpu_bits.h   |  8 ++++----
>   target/riscv/cpu_helper.c |  4 ++--
>   target/riscv/csr.c        | 12 ++++++------
>   4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b93b04453..f04a985d55 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -875,9 +875,9 @@ static void riscv_cpu_reset_hold(Object *obj)
>       env->two_stage_lookup = false;
>   
>       env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
> -                   (cpu->cfg.ext_svadu ? MENVCFG_HADE : 0);
> +                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
>       env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
> -                   (cpu->cfg.ext_svadu ? HENVCFG_HADE : 0);
> +                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
>   
>       /* Initialized default priorities of local interrupts. */
>       for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 59f0ffd9e1..1c2ffae883 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -745,12 +745,12 @@ typedef enum RISCVException {
>   #define MENVCFG_CBIE                       (3UL << 4)
>   #define MENVCFG_CBCFE                      BIT(6)
>   #define MENVCFG_CBZE                       BIT(7)
> -#define MENVCFG_HADE                       (1ULL << 61)
> +#define MENVCFG_ADUE                       (1ULL << 61)
>   #define MENVCFG_PBMTE                      (1ULL << 62)
>   #define MENVCFG_STCE                       (1ULL << 63)
>   
>   /* For RV32 */
> -#define MENVCFGH_HADE                      BIT(29)
> +#define MENVCFGH_ADUE                      BIT(29)
>   #define MENVCFGH_PBMTE                     BIT(30)
>   #define MENVCFGH_STCE                      BIT(31)
>   
> @@ -763,12 +763,12 @@ typedef enum RISCVException {
>   #define HENVCFG_CBIE                       MENVCFG_CBIE
>   #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define HENVCFG_CBZE                       MENVCFG_CBZE
> -#define HENVCFG_HADE                       MENVCFG_HADE
> +#define HENVCFG_ADUE                       MENVCFG_ADUE
>   #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>   #define HENVCFG_STCE                       MENVCFG_STCE
>   
>   /* For RV32 */
> -#define HENVCFGH_HADE                       MENVCFGH_HADE
> +#define HENVCFGH_ADUE                       MENVCFGH_ADUE
>   #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
>   #define HENVCFGH_STCE                       MENVCFGH_STCE
>   
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9f611d89bb..0ff6b59cff 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -861,11 +861,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       }
>   
>       bool pbmte = env->menvcfg & MENVCFG_PBMTE;
> -    bool hade = env->menvcfg & MENVCFG_HADE;
> +    bool hade = env->menvcfg & MENVCFG_ADUE;

I suggest renaming the 'hade' var to 'adue' as well to avoid confusion.


Thanks,

Daniel

>   
>       if (first_stage && two_stage && env->virt_enabled) {
>           pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
> -        hade = hade && (env->henvcfg & HENVCFG_HADE);
> +        hade = hade && (env->henvcfg & HENVCFG_ADUE);
>       }
>   
>       int ptshift = (levels - 1) * ptidxbits;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea7585329e..b4c66dc8ca 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1951,7 +1951,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_HADE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>       }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>   
> @@ -1971,7 +1971,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_HADE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>   
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
> @@ -2023,7 +2023,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
>        * henvcfg.stce is read_only 0 when menvcfg.stce = 0
>        * henvcfg.hade is read_only 0 when menvcfg.hade = 0
>        */
> -    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE) |
> +    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
>                              env->menvcfg);
>       return RISCV_EXCP_NONE;
>   }
> @@ -2040,7 +2040,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>       }
>   
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE);
> +        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>       }
>   
>       env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
> @@ -2058,7 +2058,7 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
>           return ret;
>       }
>   
> -    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_HADE) |
> +    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
>                               env->menvcfg)) >> 32;
>       return RISCV_EXCP_NONE;
>   }
> @@ -2067,7 +2067,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>                                        target_ulong val)
>   {
>       uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_HADE);
> +                                    HENVCFG_ADUE);
>       uint64_t valh = (uint64_t)val << 32;
>       RISCVException ret;
>   

