Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D00823637
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:12:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7aQ-0004uF-Qh; Wed, 03 Jan 2024 15:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL7aP-0004sK-Gv
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:11:33 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL7aN-00045G-Hk
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:11:33 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28c075ad8e7so7813756a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704312690; x=1704917490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tGEwr640h0u/FfpSuYFikvMebGCxIeVepMHEfzH/Ld0=;
 b=YOobJzk8xheX+K4W6pAsVH4+GEPQBys3vjEiRW/ooOMMJfGSO44zvNuvSWBd5O8Lyp
 vfsRskWZzlYdWiyiip/Q45g4M0lwPYZcrfM/apoiKDmBE2b+gLCfCo2b1/g4gamp9uHV
 1+rqUgLIndo605tOp7PaFYd3B2nWuNCM7kvLK89zwTc18LP71wwFUrn6Fe/AVT1eJL/6
 YbP1w5jV7AYkjyBI7XTGgYe6Jt5TAjeOmReL2omJMZv7tzq4PVywMIvQ+73Z0RWJN5JO
 yjGm+DFZ/zjCZ4gb9BAxizwMEo0Q61JzIAQp+V5SS/CPgw66JjGi1+cHuxXtsejIJ4Un
 PZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704312690; x=1704917490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGEwr640h0u/FfpSuYFikvMebGCxIeVepMHEfzH/Ld0=;
 b=R7N2cC1gJNDoe3tG+4q7XVRzl9UAN0exCr3yPBn8FIy1eX1zbLXrU/IOIl13WtiV0r
 8TdYB4ZVcI5bK1Ry9Kg3Bso3c8su2vBjSjwC6s/a3zZrdAnlH2FNTY6sg72zYuOYSnvT
 SSC8gyJUnk0Eeax12QEgQi0xZ5DZBjfuRLB7d2zhb44Cu1vPhbLMFbSPoR4vEEtUUQcl
 AnYMh4aXMdFPbPLxRkqWH87GFMHT7zwd4fBkJZEeRjaYOsHSG9JDcVq4dSg1Cmz8bjK9
 yjZMNV/j22UwMvV0BLXfIY0BFWWyrbQFJHHPQBRlGsA3dA+WB+4PYQTqQlRzF9EGS39s
 cl4g==
X-Gm-Message-State: AOJu0Ywd2v4osj635ANrfWkgtPkxWl7C7fPW7kyxPz0knrnWnMZyqnso
 52gKD+KgdZSRfmVhXKoNPKhvW3OgJb4CkA==
X-Google-Smtp-Source: AGHT+IHxO5YeqL8tbuS0Y4lKWrszQSWIZ78ufO73l+BFJfc+FtxcooKCW/3zWxzsLG3Mj+u7gafgeQ==
X-Received: by 2002:a17:90b:378b:b0:28c:2886:1fb2 with SMTP id
 mz11-20020a17090b378b00b0028c28861fb2mr9347548pjb.84.1704312690119; 
 Wed, 03 Jan 2024 12:11:30 -0800 (PST)
Received: from [192.168.68.110] ([189.79.21.107])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a17090a930700b0028b89520c7asm2132049pjo.9.2024.01.03.12.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 12:11:29 -0800 (PST)
Message-ID: <c15053f6-edda-4171-aed9-b4c8e14b9c6a@ventanamicro.com>
Date: Wed, 3 Jan 2024 17:11:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/5] target/riscv: Fix the predicate functions for
 mhpmeventhX CSRs
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20231229004929.3842055-1-atishp@rivosinc.com>
 <20231229004929.3842055-2-atishp@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231229004929.3842055-2-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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



On 12/28/23 21:49, Atish Patra wrote:
> mhpmeventhX CSRs are available for RV32. The predicate function
> should check that first before checking sscofpmf extension.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 67 ++++++++++++++++++++++++++--------------------
>   1 file changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fde7ce1a5336..283468bbc652 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -224,6 +224,15 @@ static RISCVException sscofpmf(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_mxl(env) != MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return sscofpmf(env, csrno);
> +}
> +
>   static RISCVException any(CPURISCVState *env, int csrno)
>   {
>       return RISCV_EXCP_NONE;
> @@ -4972,91 +4981,91 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
>                                write_mhpmevent                           },
>   
> -    [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT4H]    = { "mhpmevent4h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT4H]    = { "mhpmevent4h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT5H]    = { "mhpmevent5h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT5H]    = { "mhpmevent5h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT6H]    = { "mhpmevent6h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT6H]    = { "mhpmevent6h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT7H]    = { "mhpmevent7h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT7H]    = { "mhpmevent7h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT8H]    = { "mhpmevent8h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT8H]    = { "mhpmevent8h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT9H]    = { "mhpmevent9h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT9H]    = { "mhpmevent9h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT10H]   = { "mhpmevent10h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT10H]   = { "mhpmevent10h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT11H]   = { "mhpmevent11h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT11H]   = { "mhpmevent11h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT12H]   = { "mhpmevent12h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT12H]   = { "mhpmevent12h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT13H]   = { "mhpmevent13h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT13H]   = { "mhpmevent13h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT14H]   = { "mhpmevent14h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT14H]   = { "mhpmevent14h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT15H]   = { "mhpmevent15h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT15H]   = { "mhpmevent15h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT16H]   = { "mhpmevent16h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT16H]   = { "mhpmevent16h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT17H]   = { "mhpmevent17h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT17H]   = { "mhpmevent17h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT18H]   = { "mhpmevent18h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT18H]   = { "mhpmevent18h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT19H]   = { "mhpmevent19h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT19H]   = { "mhpmevent19h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT20H]   = { "mhpmevent20h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT20H]   = { "mhpmevent20h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT21H]   = { "mhpmevent21h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT21H]   = { "mhpmevent21h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT22H]   = { "mhpmevent22h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT22H]   = { "mhpmevent22h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT23H]   = { "mhpmevent23h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT23H]   = { "mhpmevent23h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT24H]   = { "mhpmevent24h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT24H]   = { "mhpmevent24h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT25H]   = { "mhpmevent25h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT25H]   = { "mhpmevent25h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT26H]   = { "mhpmevent26h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT26H]   = { "mhpmevent26h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT27H]   = { "mhpmevent27h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT27H]   = { "mhpmevent27h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT28H]   = { "mhpmevent28h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT28H]   = { "mhpmevent28h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT29H]   = { "mhpmevent29h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT29H]   = { "mhpmevent29h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT30H]   = { "mhpmevent30h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT30H]   = { "mhpmevent30h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
> -    [CSR_MHPMEVENT31H]   = { "mhpmevent31h",    sscofpmf,  read_mhpmeventh,
> +    [CSR_MHPMEVENT31H]   = { "mhpmevent31h",    sscofpmf_32,  read_mhpmeventh,
>                                write_mhpmeventh,
>                                .min_priv_ver = PRIV_VERSION_1_12_0        },
>   

