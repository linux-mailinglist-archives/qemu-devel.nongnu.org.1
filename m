Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11A82770E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:12:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMu6l-00065e-Dc; Mon, 08 Jan 2024 13:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMu6Y-0005pF-CR
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:12:09 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMu6S-0003pC-RV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:12:05 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cd51c0e8ebso657655a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 10:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704737519; x=1705342319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1lmbW06hRXitdC3FpdS7xqR0DA7UO6ZByFcZQKLCroc=;
 b=UnoS0S4WO+WZQ/dzyd1zC/dXMLspzOZtXnwdVISE4BfMJWhMx6/eLFI5KpuSTktDbj
 55zXVY8cSLV6sC7hkO9GNbpTAAcPzN7RNQkA+kr2b7VAPwhdFC/yKqMMpSBLuNH4emyB
 gBetsPQ/VU2f0Q5VSvRVW3UcbRgRmM+MGbt2aEnqQ0KBvnIHjcgyhBwznTr6BnNUraFH
 zN/1WEMQ0ukeezaihz06nhm0wUmHZlscU2t81aenTytbJBZAofe6Ct/OBkv1KzI2ao7L
 H+nCS3bLDLRaaLmS4lzEKcWHr78Gxf2xUjcWRHK4ZxToABULeRbjPa2RiwcMLafXeXmW
 6t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704737519; x=1705342319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lmbW06hRXitdC3FpdS7xqR0DA7UO6ZByFcZQKLCroc=;
 b=oX6Kq/9kpEW9hObHBm+nbF6LSsF0WL02tIPRIUflyESwPlA66AHr19t+wXNZj/uOQ1
 xl0wICMOBpRbaxcwpn+dgu5/z2SXi/jgXCbNJprHaNT/DYtL+xze+4cOmJOF8hmcBh4B
 wsjIcfZss0lUC3h1m4It+O/mYZMc3iS1jxLmPF91tXMM+65/Vlyhd/R/uyXYCKd5+6RY
 tgqdR1BOHNFhj8eBktwc4ocDDyyuYtHSMVIK8qd40Jc+G74mpfeGWRMBoiVzs4ljimib
 U40WEAoOwlPFFAS4uw5X4OUEEGnZCpohIjC2JIQLI3aN2alTVhXl+RGkQHhAvtEjKFf3
 91tA==
X-Gm-Message-State: AOJu0Yw/zlyQIDeTtz2cMvv+Zvt+pd6UkXj3b1I5naLMdmAEw975PeEU
 VMOv3uczMFQUh2Ot2aginse92s1E1aduEA==
X-Google-Smtp-Source: AGHT+IF2Ms03/ucicWidYZqlsZNSGMabTHhAsouX+q4Shy9OfQSc86K4aL8FNWKUy1ju1RMZHgiz4A==
X-Received: by 2002:a05:6a20:2445:b0:199:9f30:aa32 with SMTP id
 t5-20020a056a20244500b001999f30aa32mr1204350pzc.66.1704737519317; 
 Mon, 08 Jan 2024 10:11:59 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.11])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a634f17000000b005c67a388836sm146772pgb.62.2024.01.08.10.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 10:11:58 -0800 (PST)
Message-ID: <090b3f37-0a93-4bf9-8701-ea3d17798f63@ventanamicro.com>
Date: Mon, 8 Jan 2024 15:11:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] target/riscv: Add cycle & instret privilege mode
 filtering support
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240105221327.176764-1-atishp@rivosinc.com>
 <20240105221327.176764-5-atishp@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240105221327.176764-5-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/5/24 19:13, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> QEMU only calculates dummy cycles and instructions, so there is no
> actual means to stop the icount in QEMU. Hence this patch merely adds
> the functionality of accessing the cfg registers, and cause no actual
> effects on the counting of cycle and instret counters.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 283468bbc652..3bd4aa22374f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -233,6 +233,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
>       return sscofpmf(env, csrno);
>   }
>   
> +static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) != MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smcntrpmf(env, csrno);
> +}
> +
>   static RISCVException any(CPURISCVState *env, int csrno)
>   {
>       return RISCV_EXCP_NONE;
> @@ -818,6 +836,54 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
>   
>   #else /* CONFIG_USER_ONLY */
>   
> +static int read_mcyclecfg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mcyclecfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mcyclecfg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mcyclecfg = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_mcyclecfgh(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->mcyclecfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_mcyclecfgh(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->mcyclecfgh = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_minstretcfg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->minstretcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_minstretcfg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->minstretcfg = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int read_minstretcfgh(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->minstretcfgh;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static int write_minstretcfgh(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->minstretcfgh = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
>   {
>       int evt_index = csrno - CSR_MCOUNTINHIBIT;
> @@ -4922,6 +4988,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                                write_mcountinhibit,
>                                .min_priv_ver = PRIV_VERSION_1_11_0       },
>   
> +    [CSR_MCYCLECFG]      = { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
> +                             write_mcyclecfg,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0       },
> +    [CSR_MINSTRETCFG]    = { "minstretcfg", smcntrpmf, read_minstretcfg,
> +                             write_minstretcfg,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0       },
> +
>       [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
>                                write_mhpmevent                           },
>       [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
> @@ -4981,6 +5054,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
>                                write_mhpmevent                           },
>   
> +    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf_32, read_mcyclecfgh,
> +                             write_mcyclecfgh,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0        },
> +    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf_32, read_minstretcfgh,
> +                             write_minstretcfgh,
> +                             .min_priv_ver = PRIV_VERSION_1_12_0        },
> +
>       [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },

