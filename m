Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D0D831FE5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:51:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYOj-0000CI-Ev; Thu, 18 Jan 2024 14:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQYOg-0000BX-CF
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:49:55 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rQYOe-00009k-AJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:49:54 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso12557a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 11:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705607391; x=1706212191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKx2cOlWSh9zUFFoI//hxlUo0CctpPzsg+x//5RxphM=;
 b=BtwnbyrNOMTFjQS0dlwe/s/dSTsm0VKiwxZKUsekKSyGq1fPcfwrJAjLmH4VFwVcxP
 LfS843jX9zPow1XQeQEHGYt/vsTNyRAzfOvBQAzYuneorwtjIV7eH7Lt+A3cAL152mv4
 sWMfJlXhqQLysaUAdEIItcvWXjAguHgH+f7JExDCZg1t2SqKixaBmj/+T/3fFedvtgCi
 dVoB4eSLysJOXdxBcHub3D6n26DlNaHwCnGYWBw79xl9xoWllJydGz4a++s6w3Rh9TVY
 Wp5jpY6F0YBZq3z+48li4glxufgucOrL5lyC2QwHFyNzwOWTNAKatSJfpF2S7Ca0cmzA
 mBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705607391; x=1706212191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKx2cOlWSh9zUFFoI//hxlUo0CctpPzsg+x//5RxphM=;
 b=h7UThf59PWxX0EyMeqBxz50Rg/OTnAWtzhqb0PRcIauqZllaeiH0txjaFvH0DV7MUT
 DFocSMZGembLuIOkcCm6XQTDv1XLJW20IchN2/qe3c7HWMlcWl2KSDqpeVK3758fEKjx
 m2llAp7oNSehZORrsDpYLr3Twm5XbVrlSyGAPVQKnp6gpR8FsnZlAbkWVRhaUPfwp8DU
 N1GibniemCI77fwWkGEY3Ia7h5f+zRXGhRwA5XdMb85aDHk1c0dzO/dkwiMzc/URzOT3
 8nhRzbi9sthPIEMuaJYgSbxQbzHv3PSzJZx3j6K5thgTZbh+4jq+yTxH1qJEOgIik4Z5
 mxSA==
X-Gm-Message-State: AOJu0Yx8lLfL4LL2OA1A+IOk5MGVCcKBaM/2T2JzTeemWVL2rfbclCdH
 z3qRRzHgMqk/4yT+1hcvs8CeYABU6e7hPti3otjEvfGAv1BJHP0k761deY6iIEo=
X-Google-Smtp-Source: AGHT+IFKM0jl3s663QYt2Ot7nvcI4LjoN0DHklkqhDloj+Mz30KBgjywVOBNZ36mgVTVSj89PFn6PQ==
X-Received: by 2002:a05:6a21:4847:b0:19a:2daf:1f86 with SMTP id
 au7-20020a056a21484700b0019a2daf1f86mr1163925pzc.123.1705607390879; 
 Thu, 18 Jan 2024 11:49:50 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 lp21-20020a056a003d5500b006da550512d8sm3675052pfb.126.2024.01.18.11.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 11:49:50 -0800 (PST)
Message-ID: <1ccdf50b-ef7f-46ab-a5bf-f0302990a290@ventanamicro.com>
Date: Thu, 18 Jan 2024 16:49:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: Check 'A' and split extensions for
 atomic instructions
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240115162525.63535-1-rbradford@rivosinc.com>
 <20240115162525.63535-3-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240115162525.63535-3-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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



On 1/15/24 13:25, Rob Bradford wrote:
> Following the pattern for 'M' and Zmmul check if either the 'A'
> extension is enabled or the appropriate split extension for the
> instruction.
> 
> Also remove the assumption that only checking for 64-bit systems is
> required for the double word variants.

Code LGTM but I don't understand what you mean in this sentence. The patch
is replacing REQUIRE_EXT(ctx, RVA) for either REQUIRE_A_OR_ZALRSC() or
REQUIRE_A_OR_ZAAMO(). There's no removal or change in any 64-bit line,
IIUC.


Thanks,

Daniel

> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
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

