Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E716A9886B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 13:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YBS-0001Fu-KR; Wed, 23 Apr 2025 07:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7YBJ-0001Ed-B3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:22:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7YBG-0002RP-HJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:22:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2295d78b433so73471385ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745407336; x=1746012136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZuMmzsV36Tqgnyy3F4z2bEjddLgrfZnhjPAKuzK3A0=;
 b=RbWoFDEdCRwgqsRe6PWzfgtFw1TVlZI6yG3y3tp+mpAOshMqvgD/wqvqKPJ4ftrpew
 xT1bi8ccexsLL55+SDQ4rvb4Tlg5fqv8EQm++g8kzXJ9bJ+lFxysKbS2EIkIETHChXyK
 BwnfsYyuC0kB4zS98UQNirZAZfpgMLvQdJgAbaSolGMhZs8HhWD4low6NxdrSrYAE/sl
 dTIRnLA6bT1MZYppIIJ80/blrosPIb0t7SnF5eaG/vA5ugeHy4/3ninEyAx+Cnv9+2V5
 1r+ZTs3pyN4s9NyFW+l63+7JZjC5YJs7GsTjTO8SpV6fm0BGZtUW74dsREw6HzJY2b8m
 crFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407336; x=1746012136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZuMmzsV36Tqgnyy3F4z2bEjddLgrfZnhjPAKuzK3A0=;
 b=o5hlQAdbWBNm9HZe6OMzw7jeTlfWNyMXTtEFp+zUI/u1nZuH+lOvPmfHhsdmZPbYM5
 dKvsejm5ZA9a05vWsNiNrOH44Gs4NWdqeynYXiQhjq2o5I7d+/RBZjTH9aiQ/yZRnui8
 u+xSsIW1iZ6Z4Pk9TSy7iyiNgHoGRd7yjAUE0jmr7SSsKC50EQqHJrPHpidMJiXvMbRX
 r4iIZ84krRUWLlnasi1AfUgmx82y1Du2cgpjRi6Xw/jzvaCam8b4GsDwLagrG3FMQpDJ
 NVc1gH+QqB0ClKlDnlqia9Nuv+Xwoiz3MT+U6teTX81LJZux9y2sUjeBgdOeoED9JqFh
 qRvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzNx41S6kv2AfWTjbVvtvc4a3iD8F6Jur1drQhwxTVgCQnT1brML0BNd1C1JHaOlnqIiuBLQHjuzq@nongnu.org
X-Gm-Message-State: AOJu0YzjEAqr96Ujd56Lo9vIIXgIUU7dx+3zE7o3eliE2PPLGqDpt3Mh
 tJa/q2QCttICKwTdQDhOAwz49LhnDPXcXq2BskZh+ZuNi932kIiqPkpdePLLTDk=
X-Gm-Gg: ASbGncvhyCRHRQrrBtVPOIVjmnpLKyGuaxfUpCQ7wwXoFpQn8G7nNj5WMIESCIybwCL
 Z6SBpTgPx0r6cpdSv2ic0nk+BlCTCXa2kzYA1Kq7a65jVaKt75aQ7USe3TKsvEETz9tlebtnYh3
 aBrNgqtqFesAsASncGAm+ogtbB8Cu6zFbSHsDBt1JDcXl7Et+3GEXBZSnZPEL7nsKXamMdP+zkc
 teVrmyVrnnolvD1Jno10hW9gOfiENl5vi+gNib8UqDLaiq/lsqsRYgQ6n6d3HFiBhYO8VtDjqE7
 sBtTxXoXU8LWRwtgdO2qI37GwJbbdsVHsQNd0640kkI2zEYx7+iF9+AaqjQHbExTm4YAuxnRvh0
 fl3Who1Cq8QsbzOffOrU=
X-Google-Smtp-Source: AGHT+IFZYq0qW49hqGB6BvaZHpSst00cqrTrGZ2+5pVJVZAi9Kl8FFyk3a+R7v+l0nzw67PNJjPSIw==
X-Received: by 2002:a17:903:98f:b0:224:f12:3746 with SMTP id
 d9443c01a7336-22c535aca10mr265992425ad.30.1745407336234; 
 Wed, 23 Apr 2025 04:22:16 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:89f4:3b90:a265:963d:8357?
 ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf31e7sm102032315ad.55.2025.04.23.04.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:22:15 -0700 (PDT)
Message-ID: <266fef99-7b1d-40bd-96e2-eb8f8e911879@ventanamicro.com>
Date: Wed, 23 Apr 2025 08:22:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Extend PMP region up to 64
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20250421094656.48997-1-jay.chang@sifive.com>
 <20250421094656.48997-2-jay.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250421094656.48997-2-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 4/21/25 6:46 AM, Jay Chang wrote:
> According to the RISC-V Privileged Specification (version >1.12),
> RV32 supports 16 CSRs (pmpcfg0–pmpcfg15) to configure 64 PMP regions
> (pmpaddr0–pmpaddr63).
> 
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h |  60 +++++++++++++++++++
>   target/riscv/csr.c      | 124 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 182 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c617..e6b3e28386 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -372,6 +372,18 @@
>   #define CSR_PMPCFG1         0x3a1
>   #define CSR_PMPCFG2         0x3a2
>   #define CSR_PMPCFG3         0x3a3
> +#define CSR_PMPCFG4         0x3a4
> +#define CSR_PMPCFG5         0x3a5
> +#define CSR_PMPCFG6         0x3a6
> +#define CSR_PMPCFG7         0x3a7
> +#define CSR_PMPCFG8         0x3a8
> +#define CSR_PMPCFG9         0x3a9
> +#define CSR_PMPCFG10        0x3aa
> +#define CSR_PMPCFG11        0x3ab
> +#define CSR_PMPCFG12        0x3ac
> +#define CSR_PMPCFG13        0x3ad
> +#define CSR_PMPCFG14        0x3ae
> +#define CSR_PMPCFG15        0x3af
>   #define CSR_PMPADDR0        0x3b0
>   #define CSR_PMPADDR1        0x3b1
>   #define CSR_PMPADDR2        0x3b2
> @@ -388,6 +400,54 @@
>   #define CSR_PMPADDR13       0x3bd
>   #define CSR_PMPADDR14       0x3be
>   #define CSR_PMPADDR15       0x3bf
> +#define CSR_PMPADDR16       0x3c0
> +#define CSR_PMPADDR17       0x3c1
> +#define CSR_PMPADDR18       0x3c2
> +#define CSR_PMPADDR19       0x3c3
> +#define CSR_PMPADDR20       0x3c4
> +#define CSR_PMPADDR21       0x3c5
> +#define CSR_PMPADDR22       0x3c6
> +#define CSR_PMPADDR23       0x3c7
> +#define CSR_PMPADDR24       0x3c8
> +#define CSR_PMPADDR25       0x3c9
> +#define CSR_PMPADDR26       0x3ca
> +#define CSR_PMPADDR27       0x3cb
> +#define CSR_PMPADDR28       0x3cc
> +#define CSR_PMPADDR29       0x3cd
> +#define CSR_PMPADDR30       0x3ce
> +#define CSR_PMPADDR31       0x3cf
> +#define CSR_PMPADDR32       0x3d0
> +#define CSR_PMPADDR33       0x3d1
> +#define CSR_PMPADDR34       0x3d2
> +#define CSR_PMPADDR35       0x3d3
> +#define CSR_PMPADDR36       0x3d4
> +#define CSR_PMPADDR37       0x3d5
> +#define CSR_PMPADDR38       0x3d6
> +#define CSR_PMPADDR39       0x3d7
> +#define CSR_PMPADDR40       0x3d8
> +#define CSR_PMPADDR41       0x3d9
> +#define CSR_PMPADDR42       0x3da
> +#define CSR_PMPADDR43       0x3db
> +#define CSR_PMPADDR44       0x3dc
> +#define CSR_PMPADDR45       0x3dd
> +#define CSR_PMPADDR46       0x3de
> +#define CSR_PMPADDR47       0x3df
> +#define CSR_PMPADDR48       0x3e0
> +#define CSR_PMPADDR49       0x3e1
> +#define CSR_PMPADDR50       0x3e2
> +#define CSR_PMPADDR51       0x3e3
> +#define CSR_PMPADDR52       0x3e4
> +#define CSR_PMPADDR53       0x3e5
> +#define CSR_PMPADDR54       0x3e6
> +#define CSR_PMPADDR55       0x3e7
> +#define CSR_PMPADDR56       0x3e8
> +#define CSR_PMPADDR57       0x3e9
> +#define CSR_PMPADDR58       0x3ea
> +#define CSR_PMPADDR59       0x3eb
> +#define CSR_PMPADDR60       0x3ec
> +#define CSR_PMPADDR61       0x3ed
> +#define CSR_PMPADDR62       0x3ee
> +#define CSR_PMPADDR63       0x3ef
>   
>   /* RNMI */
>   #define CSR_MNSCRATCH       0x740
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7948188356..f8f61ffff5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -6088,6 +6088,30 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
>       [CSR_PMPCFG2]    = { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg  },
>       [CSR_PMPCFG3]    = { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg  },
> +    [CSR_PMPCFG4]    = { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG5]    = { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG6]    = { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG7]    = { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG8]    = { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG9]    = { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG10]   = { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG11]   = { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG12]   = { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG13]   = { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG14]   = { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPCFG15]   = { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
>       [CSR_PMPADDR0]   = { "pmpaddr0",  pmp, read_pmpaddr, write_pmpaddr },
>       [CSR_PMPADDR1]   = { "pmpaddr1",  pmp, read_pmpaddr, write_pmpaddr },
>       [CSR_PMPADDR2]   = { "pmpaddr2",  pmp, read_pmpaddr, write_pmpaddr },
> @@ -6102,8 +6126,104 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_PMPADDR11]  = { "pmpaddr11", pmp, read_pmpaddr, write_pmpaddr },
>       [CSR_PMPADDR12]  = { "pmpaddr12", pmp, read_pmpaddr, write_pmpaddr },
>       [CSR_PMPADDR13]  = { "pmpaddr13", pmp, read_pmpaddr, write_pmpaddr },
> -    [CSR_PMPADDR14] =  { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
> -    [CSR_PMPADDR15] =  { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
> +    [CSR_PMPADDR14]  = { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
> +    [CSR_PMPADDR15]  = { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
> +    [CSR_PMPADDR16]  = { "pmpaddr16", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR17]  = { "pmpaddr17", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR18]  = { "pmpaddr18", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR19]  = { "pmpaddr19", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR20]  = { "pmpaddr20", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR21]  = { "pmpaddr21", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR22]  = { "pmpaddr22", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR23]  = { "pmpaddr23", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR24]  = { "pmpaddr24", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR25]  = { "pmpaddr25", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR26]  = { "pmpaddr26", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR27]  = { "pmpaddr27", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR28]  = { "pmpaddr28", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR29]  = { "pmpaddr29", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR30]  = { "pmpaddr30", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR31]  = { "pmpaddr31", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR32]  = { "pmpaddr32", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR33]  = { "pmpaddr33", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR34]  = { "pmpaddr34", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR35]  = { "pmpaddr35", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR36]  = { "pmpaddr36", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR37]  = { "pmpaddr37", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR38]  = { "pmpaddr38", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR39]  = { "pmpaddr39", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR40]  = { "pmpaddr40", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR41]  = { "pmpaddr41", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR42]  = { "pmpaddr42", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR43]  = { "pmpaddr43", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR44]  = { "pmpaddr44", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR45]  = { "pmpaddr45", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR46]  = { "pmpaddr46", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR47]  = { "pmpaddr47", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR48]  = { "pmpaddr48", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR49]  = { "pmpaddr49", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR50]  = { "pmpaddr50", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR51]  = { "pmpaddr51", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR52]  = { "pmpaddr52", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR53]  = { "pmpaddr53", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR54]  = { "pmpaddr54", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR55]  = { "pmpaddr55", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR56]  = { "pmpaddr56", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR57]  = { "pmpaddr57", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR58]  = { "pmpaddr58", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR59]  = { "pmpaddr59", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR60]  = { "pmpaddr60", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR61]  = { "pmpaddr61", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR62]  = { "pmpaddr62", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
> +    [CSR_PMPADDR63]  = { "pmpaddr63", pmp, read_pmpaddr, write_pmpaddr,
> +                         .min_priv_ver = PRIV_VERSION_1_12_0           },
>   
>       /* Debug CSRs */
>       [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },


