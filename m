Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA1832974
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 13:25:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnva-0004XR-UD; Fri, 19 Jan 2024 07:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQnvY-0004X8-9d
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:24:52 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQnvW-0005iD-67
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:24:52 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so1190707b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705667089; x=1706271889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=70cCuI9dQ9Ifp0rRicDUuHMay2HNrHoMkAoC3IqJVIc=;
 b=Nw1DISYxKz9TVAdiItTlgwi3t8E/pq1SYeeWSmtZGZ16q+lMBRdNtwQMHURZafZrC8
 KUZ5tVpcktxEZepcPGALmuntErAam4JohIq5ieR2+SZHG4ix2XiRWHBS+E7p5ip0mk40
 tPG9d8geuS9wF1huZ5O4nqBNZlB//hYR75q12goiUslFcHsE5Iw0aQp2I1bdxpIKeC9s
 Znkxo+sP983dVhHoKhXMzTPwI5CNJ4OeTn6Ra0Sc0Im2r85bkojvRv3qLCou/yeZwi1c
 PoG79YQtLy+Xd0slQCWJ72vrFwV1zZD6RozICp9PfUK6lNjaUL8t63Vak91JM+zEn7Sy
 oUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705667089; x=1706271889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70cCuI9dQ9Ifp0rRicDUuHMay2HNrHoMkAoC3IqJVIc=;
 b=EYiGwodATxGtEFezAewiuWLb23kiiEPntxC8dxrIbupzuOKaU3XdLpbYqlAaDOWGYw
 a4mEPvKA5tfQu9DgGrBVMm7Nn+ckSPMmyifHrbgssGvwxKosQQv07+YqulEBEubZ6752
 GPCGCCooaCBAtmmpD9+CCoMv1vsvWaJPM7ta3Conj8AnHg2kq+ERkw9F/H2Z2pBjSIW5
 2naeqqKLwpz25wco4oSeobuE3MiXaa4/Worzu0fmosRW9nyDACfkJGbjrBcjoivb+0mi
 lREKgw4qc9o3Ni96akSgTPa9UM+b5JmBDv9YawehAgdLWSUwaCeQ+raR8VXU8h7I7wv4
 iczg==
X-Gm-Message-State: AOJu0Yy078mt+KeWbMJjaZ+c8LByQJ5qISvajw5JARewbXd6saRq3V6I
 nHaEY5CQxbE0AELwc48oFSEDNhMw3tQJ/XI3zXW5Lvlb0rBV2yChDPIZwhdkNjPIFpKq2VM7dww
 o
X-Google-Smtp-Source: AGHT+IF83JlFLgC/a0W2LnaO+R507J9DsHMVxUjbWgXtI2t3aI7eAeU/jILAO24WUR/gSVBOvw3H1w==
X-Received: by 2002:a05:6a20:6709:b0:19a:9973:2b22 with SMTP id
 q9-20020a056a20670900b0019a99732b22mr1052376pzh.40.1705667088763; 
 Fri, 19 Jan 2024 04:24:48 -0800 (PST)
Received: from [192.168.68.110] ([189.38.141.140])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm4894988pfh.204.2024.01.19.04.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 04:24:48 -0800 (PST)
Message-ID: <1f898244-3106-40be-adc0-395661c6b904@ventanamicro.com>
Date: Fri, 19 Jan 2024 09:24:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: Check 'A' and split extensions for
 atomic instructions
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240119112129.20067-1-rbradford@rivosinc.com>
 <20240119112129.20067-3-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240119112129.20067-3-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 1/19/24 08:21, Rob Bradford wrote:
> Following the pattern for 'M' and Zmmul check if either the 'A'
> extension is enabled or the appropriate split extension for the
> instruction.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
>   1 file changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index f0368de3e4..267930e5bc 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -18,6 +18,18 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
> +    if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
> +        return false;                                     \
> +    }                                                     \
> +} while (0)
> +
> +#define REQUIRE_A_OR_ZALRSC(ctx) do {                      \
> +    if (!ctx->cfg_ptr->ext_zalrsc && !has_ext(ctx, RVA)) { \
> +        return false;                                     \
> +    }                                                     \
> +} while (0)
> +
>   static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   {
>       TCGv src1;
> @@ -96,143 +108,143 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>   
>   static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
>   }
>   
>   static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
>   }

