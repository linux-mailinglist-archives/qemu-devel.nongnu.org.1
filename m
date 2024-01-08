Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5126982770D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:12:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMu6g-0005Vs-Mv; Mon, 08 Jan 2024 13:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMu66-0005Jj-IQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:11:38 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rMu64-0003NY-Pg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:11:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d4ba539f6cso19324175ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704737494; x=1705342294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/Nvy1D1qwW8ddnqHbMNAjtSEyHgtqbhjhqVKgV2GXw=;
 b=MX3R015nSDXh50EWjwQ+rrd6ctpjwxAvCmi3Vi6aaQe560VMbdoIMloVuVzrNHHLns
 Rt4wrjkCu6yTrR10sK37diIiPY7mxkPBiTsxvYurJ26iczhZnHG13aw3l2TrC1iQPnH8
 MFAp3EDodnSr0ZnVjUKFkJmxuaIlIN7wQ8V156WZev4LLdquXr65l4sjJdWIAOaekzVO
 dJLORgPYek92KQbEScEIMU6uQFbRWi28L12OjcdutZafzqTHH0KEvTnbOU4tE6RtuSWx
 RqBXuXtqz8VPLN69xFA3+EaUuNFNEKk1/OcR8nkUDo/KR6/vPK+1SEb8TapC1tR3QD+l
 W5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704737494; x=1705342294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/Nvy1D1qwW8ddnqHbMNAjtSEyHgtqbhjhqVKgV2GXw=;
 b=eDoRf6R+1NR5dJ/1Vq6BtXz9Ak2K4qiYqjedR3gA9AxYeQnm36HWcLPyfsGy9xo4KF
 PH/OSfy/QeE1hVWis3Z2QzrR7MivAUqF6JCZe81a4K/qAiMU9/nkhKjM4e98bbdTprwW
 W69PhLFQ7uH4sMbeNMkMncCNKGyQ4xO6zBxzNgcLobrHCMVwh3wF4e/YxuribrztduUR
 ixfccJkIbwiG491XTmVgMk3LJCUEQC2k7L+9GstbPf8KWjal2BM4m3sjX0GfZA8me/lN
 dy0T+1YHfVVPv6TTLagV2laQYQokt34ZsmIOKMMhbLIzk2z5bsz16uRmpJVLTYXeKTHp
 CZIQ==
X-Gm-Message-State: AOJu0YxSqWjy5kDnT+pZntb5M7iDt8IrU0W9C2m3hSXee1vZZtXLhtEV
 k2Fa1rrZJjIyrb0bIPQw/FuOCX0HmORPENqI7eDPkTp6u+3iYQ==
X-Google-Smtp-Source: AGHT+IFOVZoLIH+bF+vhrZ8wtonpFMYmZ3DmTW8tgCoeke+mf/gnyEb5QbIO6eXXPUhWzyASfMWCsw==
X-Received: by 2002:a17:902:6b81:b0:1d4:f1c:6378 with SMTP id
 p1-20020a1709026b8100b001d40f1c6378mr4100504plk.27.1704737493937; 
 Mon, 08 Jan 2024 10:11:33 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.11])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a634f17000000b005c67a388836sm146772pgb.62.2024.01.08.10.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 10:11:33 -0800 (PST)
Message-ID: <dcd747d7-03d4-4915-a54c-0df799049874@ventanamicro.com>
Date: Mon, 8 Jan 2024 15:11:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] target/riscv: Add cycle & instret privilege mode
 filtering definitions
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>
Cc: Kaiwen Xue <kaiwenx@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240105221327.176764-1-atishp@rivosinc.com>
 <20240105221327.176764-4-atishp@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240105221327.176764-4-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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



On 1/5/24 19:13, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the definitions for ISA extension smcntrpmf.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h      |  6 ++++++
>   target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d74b361be641..34617c4c4bab 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -319,6 +319,12 @@ struct CPUArchState {
>   
>       target_ulong mcountinhibit;
>   
> +    /* PMU cycle & instret privilege mode filtering */
> +    target_ulong mcyclecfg;
> +    target_ulong mcyclecfgh;
> +    target_ulong minstretcfg;
> +    target_ulong minstretcfgh;
> +
>       /* PMU counter state */
>       PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
>   
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index ebd7917d490a..0ee91e502e8f 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -401,6 +401,10 @@
>   /* Machine counter-inhibit register */
>   #define CSR_MCOUNTINHIBIT   0x320
>   
> +/* Machine counter configuration registers */
> +#define CSR_MCYCLECFG       0x321
> +#define CSR_MINSTRETCFG     0x322
> +
>   #define CSR_MHPMEVENT3      0x323
>   #define CSR_MHPMEVENT4      0x324
>   #define CSR_MHPMEVENT5      0x325
> @@ -431,6 +435,9 @@
>   #define CSR_MHPMEVENT30     0x33e
>   #define CSR_MHPMEVENT31     0x33f
>   
> +#define CSR_MCYCLECFGH      0x721
> +#define CSR_MINSTRETCFGH    0x722
> +
>   #define CSR_MHPMEVENT3H     0x723
>   #define CSR_MHPMEVENT4H     0x724
>   #define CSR_MHPMEVENT5H     0x725
> @@ -885,6 +892,28 @@ typedef enum RISCVException {
>   /* PMU related bits */
>   #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
>   
> +#define MCYCLECFG_BIT_MINH                 BIT_ULL(62)
> +#define MCYCLECFGH_BIT_MINH                BIT(30)
> +#define MCYCLECFG_BIT_SINH                 BIT_ULL(61)
> +#define MCYCLECFGH_BIT_SINH                BIT(29)
> +#define MCYCLECFG_BIT_UINH                 BIT_ULL(60)
> +#define MCYCLECFGH_BIT_UINH                BIT(28)
> +#define MCYCLECFG_BIT_VSINH                BIT_ULL(59)
> +#define MCYCLECFGH_BIT_VSINH               BIT(27)
> +#define MCYCLECFG_BIT_VUINH                BIT_ULL(58)
> +#define MCYCLECFGH_BIT_VUINH               BIT(26)
> +
> +#define MINSTRETCFG_BIT_MINH               BIT_ULL(62)
> +#define MINSTRETCFGH_BIT_MINH              BIT(30)
> +#define MINSTRETCFG_BIT_SINH               BIT_ULL(61)
> +#define MINSTRETCFGH_BIT_SINH              BIT(29)
> +#define MINSTRETCFG_BIT_UINH               BIT_ULL(60)
> +#define MINSTRETCFGH_BIT_UINH              BIT(28)
> +#define MINSTRETCFG_BIT_VSINH              BIT_ULL(59)
> +#define MINSTRETCFGH_BIT_VSINH             BIT(27)
> +#define MINSTRETCFG_BIT_VUINH              BIT_ULL(58)
> +#define MINSTRETCFGH_BIT_VUINH             BIT(26)
> +
>   #define MHPMEVENT_BIT_OF                   BIT_ULL(63)
>   #define MHPMEVENTH_BIT_OF                  BIT(31)
>   #define MHPMEVENT_BIT_MINH                 BIT_ULL(62)

