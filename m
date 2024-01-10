Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1882A093
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:57:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNdjy-0007fZ-Gv; Wed, 10 Jan 2024 13:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdjw-0007ej-3J
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:55:48 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdju-0007uc-9R
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:55:47 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28be52a85b9so3095870a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704912945; x=1705517745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlyWdxOFxMjY7mOuyQw6zJWhym6i+gLPrLPvBXJgg6I=;
 b=KinFbSILuagCQYEu05NpnZC+50ukrRq8k8mUrIK8+xR31tyJ0MtrT5bsBpGLshPu2g
 GcLAc6g546e9MFYljPXj+6l5StiHF+S2MEtoB7P7H/I6FCs8OAE87EE5FdDIX1QX8uOy
 0b7IC4SPQGARql7otbrYxCertuV4vFYnFZFP4ZK318HvvU20dMXsa55Z2rB4kDwpRuOA
 1rBykUm6ACoWpN86dG7ZUfLeu2t91FWtQ5y07QBsQBeAVZyRmYMFlFNvc75z5aK4hviu
 +z+c1jZAxESTST/iKF0Fu13OBMnaFxf3h9Nn4uc9mhi1r3+lqlJYti6vR+cCLK3yhvGa
 KFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912945; x=1705517745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlyWdxOFxMjY7mOuyQw6zJWhym6i+gLPrLPvBXJgg6I=;
 b=PoLPCaqSMPRpKCkJB5URPYPtU587vJJLj5EJ9J+ft3FQovKR+0QkWq748qoxL4qbje
 zU4WwawP/I2iaSyPDPjaqbK1HZejTq8N4Eex2AQPwpMwuUEiV/p1ZNreMh3FsKX7/H8A
 Z/lFYu8RhFpFIWEUcJ9qT8VExzjvXG3XGT2s0P0q5LSj/tqKKe68pKlKbIPQJZZ9mLe+
 xthz9rylKhFnuH/ZYU9+/YbZSN607s2Lj3lTUrEZqK8iCOUFtIyWvqNrz8Xeuwi/Xemi
 ibC+eGA6nj90WxOiaavzMyoEU8FtLi6GYQzfJKgFxff867KmY3YDgZ/PFACGeQLnWQJR
 LE+A==
X-Gm-Message-State: AOJu0YwHr4fxubumNJvL0DJ43NAsPOYqT0j7l6gbUnAddtv1WiCm/D8W
 qBRNe6osKjpN6oV4avJZPxbochI8NjGluQ==
X-Google-Smtp-Source: AGHT+IFUbBx7WNS3rs/Fd2sDqw9lluOqQ2UlFMtnV8jyH/ZgmtX9Kbbj5JyiHt2afjyjb6s0R/+QUA==
X-Received: by 2002:a17:90a:bc88:b0:28d:a588:a5f6 with SMTP id
 x8-20020a17090abc8800b0028da588a5f6mr1091901pjr.6.1704912944805; 
 Wed, 10 Jan 2024 10:55:44 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a17090b068100b0028b6759d8c1sm1935651pjz.29.2024.01.10.10.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:55:44 -0800 (PST)
Message-ID: <e26c1386-3168-4c6b-81a6-3d42d5fda56d@ventanamicro.com>
Date: Wed, 10 Jan 2024 15:55:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Check for 'A' extension on all atomic
 instructions
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240110163959.31291-1-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240110163959.31291-1-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 1/10/24 13:39, Rob Bradford wrote:
> Add requirement that 'A' is enabled for all atomic instructions that
> lack the check. This makes the 64-bit versions consistent with the
> 32-bit versions in the same file.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rva.c.inc | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index 5f194a447b..f0368de3e4 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -163,65 +163,76 @@ static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>   static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
>   }
>   
>   static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> +    REQUIRE_EXT(ctx, RVA);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
>   }

