Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A8710C24
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2A7J-0006JP-G5; Thu, 25 May 2023 08:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q2A7G-0006J4-HX
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:30:50 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q2A7D-0005Gz-E9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:30:50 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5576c2791e6so160980eaf.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685017846; x=1687609846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hKskh4KyVyXxo9D2ZAhIhrJqHma2qd+GV3z+9+nVwM=;
 b=YeVjpSZ9yaAF5M9yMRfhVGRbu6bzzgiHGSyJIzencVlnFeHr/N1Bu9wSS3uWbJX7yd
 eUqsgbvLRHRq7e1qorOZCrvKM63lVLNhyxIFMUsiCCiv3WR7W4MOv/nfTT2TkKmWNb2Y
 gs0cyz8f/EJ7NiVGHRP8nW2+oeyrGuHtuWPmzJwR0npQ4U8fCAn9orzXEW0GowZk4B3a
 wIFRkzXPCFp6tPJQ+p9QpedwPeVAieelmRD9ezcw5Q9wUxgJEYTGsULCUiznW2TqpulJ
 58YiUE3BwrBOSn76/Mw4yTxu7J/FOJxBF02i2a3DnAgg2VxCIcF74kVUtiTQ2IxOv4G/
 Iwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685017846; x=1687609846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hKskh4KyVyXxo9D2ZAhIhrJqHma2qd+GV3z+9+nVwM=;
 b=BOsSh7qTBASMDvsvVzt4yCPQCfDTVpInemsDu1C36RRfILf7auzXvrnjpnrMoSWxpq
 EXF9rNzh0FtUEzIM4yqpVwy5Fh8ur+hyUBhELJ8lfHsezv2YfdA/meZjW0QHMq9RkDLI
 SlzYf+C+IUoQWMYc6O4qw+wWwSZkDTnM8/x2BJ7KYhxktrBXtyt38LnbEOcaNXPGOSUI
 YozkQk27UwZ6GBZFDdkU38UMSNhuKdOooayBorLyXAeUuAqmoJetrX4QXjtn1scqj/f6
 7w6xufQ2ooKyvC+ZDJ2ia8eYICVePX+jF/lNxfjxTokrTfloO/klUY6sBS4yK5R0smbw
 WyOA==
X-Gm-Message-State: AC+VfDyRUh7/9L+0iJK8rszZBojIpf+B5ljVzcTBWNhb4X2StQ3Qwgwt
 VZA+Y6r+JvWHP3tkNmxtRSu69Q==
X-Google-Smtp-Source: ACHHUZ5rP5ugZ9zhsvTtE0OOzqFY7oj4ctPuHgHbdDEAIMMZ740nBU9ymTTbMmKwVTItn1uXH36PPQ==
X-Received: by 2002:a4a:270e:0:b0:555:5ab5:a0e1 with SMTP id
 l14-20020a4a270e000000b005555ab5a0e1mr4628961oof.3.1685017845992; 
 Thu, 25 May 2023 05:30:45 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 t8-20020a0568301e2800b006ab241d8c42sm565997otr.17.2023.05.25.05.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 05:30:45 -0700 (PDT)
Message-ID: <bec08cb5-2497-80a2-e8c0-af5fb02066ac@ventanamicro.com>
Date: Thu, 25 May 2023 09:30:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/4] target/riscv: Add Smrnmi CSRs.
Content-Language: en-US
To: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org
References: <20230522131123.3498539-1-tommy.wu@sifive.com>
 <20230522131123.3498539-3-tommy.wu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230522131123.3498539-3-tommy.wu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 5/22/23 10:11, Tommy Wu wrote:
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c      |  5 +++
>   target/riscv/cpu.h      |  4 ++
>   target/riscv/cpu_bits.h | 11 ++++++
>   target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 102 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 39b74569b1..1b645c5485 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -810,6 +810,11 @@ static void riscv_cpu_reset_hold(Object *obj)
>           riscv_trigger_init(env);
>       }
>   
> +    if (cpu->cfg.ext_smrnmi) {
> +        env->rnmip = 0;
> +        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
> +    }
> +
>       if (kvm_enabled()) {
>           kvm_riscv_reset_vcpu(cpu);
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6c14b93cb5..f44fd95f16 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -368,6 +368,10 @@ struct CPUArchState {
>       uint64_t kvm_timer_frequency;
>   
>       /* RNMI */
> +    target_ulong mnscratch;
> +    target_ulong mnepc;
> +    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
> +    target_ulong mnstatus;
>       target_ulong rnmip;
>       uint64_t rnmi_irqvec;
>       uint64_t rnmi_excpvec;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 7cb43b88f3..d7bd4538ab 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -355,6 +355,12 @@
>   #define CSR_PMPADDR14       0x3be
>   #define CSR_PMPADDR15       0x3bf
>   
> +/* RNMI */
> +#define CSR_MNSCRATCH       0x740
> +#define CSR_MNEPC           0x741
> +#define CSR_MNCAUSE         0x742
> +#define CSR_MNSTATUS        0x744
> +
>   /* Debug/Trace Registers (shared with Debug Mode) */
>   #define CSR_TSELECT         0x7a0
>   #define CSR_TDATA1          0x7a1
> @@ -624,6 +630,11 @@ typedef enum {
>   #define SATP64_ASID         0x0FFFF00000000000ULL
>   #define SATP64_PPN          0x00000FFFFFFFFFFFULL
>   
> +/* RNMI mnstatus CSR mask */
> +#define MNSTATUS_NMIE       0x00000008
> +#define MNSTATUS_MNPV       0x00000080
> +#define MNSTATUS_MNPP       0x00001800
> +
>   /* VM modes (satp.mode) privileged ISA 1.10 */
>   #define VM_1_10_MBARE       0
>   #define VM_1_10_SV32        1
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 4451bd1263..a1d39fc116 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -536,6 +536,18 @@ static RISCVException debug(CPURISCVState *env, int csrno)
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
> +
> +static RISCVException rnmi(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (cpu->cfg.ext_smrnmi) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>   #endif
>   
>   static RISCVException seed(CPURISCVState *env, int csrno)
> @@ -2336,6 +2348,66 @@ static RISCVException rmw_miph(CPURISCVState *env, int csrno,
>       return ret;
>   }
>   
> +static int read_mnscratch(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mnscratch;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mnscratch = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mnepc;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mnepc = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mncause;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mncause(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mncause = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mnstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        /* Flush tlb on mnstatus fields that affect VM. */
> +        if ((val ^ env->mnstatus) & MNSTATUS_MNPV) {
> +            tlb_flush(env_cpu(env));
> +        }
> +
> +        mask |= MNSTATUS_MNPV;
> +    }
> +
> +    /* mnstatus.mnie can only be cleared by hardware. */
> +    env->mnstatus = (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
> +    return RISCV_EXCP_NONE;
> +}
> +
>   /* Supervisor Trap Setup */
>   static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                           Int128 *val)
> @@ -4204,6 +4276,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                           write_sstateen_1_3,
>                           .min_priv_ver = PRIV_VERSION_1_12_0 },
>   
> +    /* RNMI */
> +    [CSR_MNSCRATCH] = { "mnscratch", rnmi, read_mnscratch, write_mnscratch,
> +                        .min_priv_ver = PRIV_VERSION_1_12_0               },
> +    [CSR_MNEPC]     = { "mnepc",     rnmi, read_mnepc,     write_mnepc,
> +                        .min_priv_ver = PRIV_VERSION_1_12_0               },
> +    [CSR_MNCAUSE]   = { "mncause",   rnmi, read_mncause,   write_mncause,
> +                        .min_priv_ver = PRIV_VERSION_1_12_0               },
> +    [CSR_MNSTATUS]  = { "mnstatus",  rnmi, read_mnstatus,  write_mnstatus,
> +                        .min_priv_ver = PRIV_VERSION_1_12_0               },
> +
>       /* Supervisor Trap Setup */
>       [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
>                            NULL,                read_sstatus_i128              },

