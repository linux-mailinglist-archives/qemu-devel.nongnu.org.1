Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144BA90D7B
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Apr 2025 22:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u59pd-0002os-TH; Wed, 16 Apr 2025 16:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59pb-0002ln-Jk
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:58:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u59pW-0002UW-B0
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 16:58:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2260c91576aso811285ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744837077; x=1745441877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tMxZjuPCA9rfKmjA8ccDATx7BiXNECF7JmBrjgzmD30=;
 b=shtarek+6yUpSmBDgGOL3HHb1tGmpNmIidy5dTttdTIxuieDcZTP/CyeQDA/2n+RhK
 spPMw2mZu70cI7Xcl9ImLHfbT5BBPF6VbLTjgOMLMlhQSQ/KirMbSCO5tpSZEO2Nlq2n
 LazrvdNkQWoIRdBaNl7guAYjq2IhQs8FMbI/fnzY8f83nuwLdOk15Fvmq3TGXu8Da8w5
 Cv9ypOlNUSB/Tle3Gg6fgMqA/Gr6w2fGTVKjZRGGXGAhdTsDSiWjU6IWfhEQj6R+QbUK
 KKX4DE01hAzJ/v79YbcPbWkzqtN5gUVl8+JP51oKvwTizmxfIa8aHd/XLoCFQltNfrOa
 mDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744837077; x=1745441877;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tMxZjuPCA9rfKmjA8ccDATx7BiXNECF7JmBrjgzmD30=;
 b=VM6mzRFj+ePUv3HQ0lfsP14hEbP9TqT/lJg4ps7l7RPaTrxoGZ/0tVMVO+tG3CeSu/
 ziQvDWpt4KQ2YITgfDo2O1+jJunVkefppsbKBY5cBS/d7TDhgB3xDNmbg+R6QdsoZ5aO
 nbvw6qspHdMZ8aOS6qcHWS8slCeEEHgMGJCS11EYSAVWYVfYpmIgr4xoq8jLGu0LS96B
 gjNmWJt6PgLkE6SDivj5nwI6BCo/13P5kKNwvZZIr3oNlc/g8aGlB+KssF/tU5+tHuio
 ZbmfOxxPxvl0Ybcag93unbXycnNxP0FUrwGNUM8YE2T4hWGFKi4lcFW08s55wRXEr6J6
 9FkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeUHfWAMNCIOmw5zl9wjkIMrvLC2Bjz4SmPGshHPxAUdfY5QqRjcaHSAjSEkph5F3sIxWKv/QOI1oM@nongnu.org
X-Gm-Message-State: AOJu0Yyz3vkErLA1w467n9Z1FquJQU+957jDP9+XaiXMMF0w0/oDIQKv
 89ouwpPrEgYguwHsE3Hxa2kMqOCwpD6cVi88SVMnG57MO6FD63IuFlN/+3cv7GST8Gp8z3MYJeV
 W
X-Gm-Gg: ASbGncuyCAqdseOy4oTSmriiOLrryKaKC31T1FNZMmPspsScxR4WC3PPLWcOu/yfrCR
 i7Q8eJLcOl2KudjasmrV5Vthja3SDvKtu5cEnreRnmmiexKmW6xLLKtETF63/ZQzAolnC4xM0oF
 Cv3I80kZSn//qppRZqZRlWBkMrbc1ZSAzivCjbzrpiP0XYhUsHlS4lgi2yKfFNfyKtqsDLLHrwd
 76qYFTC6jAjWU0+0faK8movLnYfdcGOGh39LJjPvylC3FYz/0XJVRWSQL7S8t933sKpByzXswp5
 0PrQ9w/aI03i4e1ptFIdy7ZJqiYTuFAWS95K9tDVoNvKHoSJAYBOaQ==
X-Google-Smtp-Source: AGHT+IFW0dRlZrtlpyurY5rafQKCcJxgZL9LDRT+ysNy96Z3ui24cnaH2t62BMSuGvoFXhwxy8X6yw==
X-Received: by 2002:a17:902:fac7:b0:224:194c:694c with SMTP id
 d9443c01a7336-22c3591226fmr43056195ad.28.1744837076846; 
 Wed, 16 Apr 2025 13:57:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1c1e6sm19033955ad.63.2025.04.16.13.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 13:57:56 -0700 (PDT)
Message-ID: <acf29586-dde7-42c4-9a7b-60b75bdadaca@linaro.org>
Date: Wed, 16 Apr 2025 13:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 161/163] tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-162-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-162-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/15/25 12:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 32 +++++++++++++++-
>   tcg/aarch64/tcg-target.c.inc     | 30 +++++++++------
>   tcg/arm/tcg-target.c.inc         | 63 +++++++++++++++++++++++---------
>   tcg/i386/tcg-target.c.inc        | 47 ++++++++++++++++--------
>   tcg/loongarch64/tcg-target.c.inc | 37 ++++++++++---------
>   tcg/mips/tcg-target.c.inc        | 57 +++++++++++++++++++++--------
>   tcg/ppc/tcg-target.c.inc         | 45 ++++++++++++++---------
>   tcg/riscv/tcg-target.c.inc       | 22 ++++++-----
>   tcg/s390x/tcg-target.c.inc       | 32 +++++++++-------
>   tcg/sparc64/tcg-target.c.inc     | 21 ++++++-----
>   tcg/tci/tcg-target.c.inc         | 30 ++++++++++++---
>   11 files changed, 283 insertions(+), 133 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 062f176fa5..ac955223a5 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1071,6 +1071,18 @@ typedef struct TCGOutOpMul2 {
>                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3);
>   } TCGOutOpMul2;
>   
> +typedef struct TCGOutOpQemuLdSt {
> +    TCGOutOp base;
> +    void (*out)(TCGContext *s, TCGType type, TCGReg dest,
> +                TCGReg addr, MemOpIdx oi);
> +} TCGOutOpQemuLdSt;
> +
> +typedef struct TCGOutOpQemuLdSt2 {
> +    TCGOutOp base;
> +    void (*out)(TCGContext *s, TCGType type, TCGReg dlo, TCGReg dhi,
> +                TCGReg addr, MemOpIdx oi);
> +} TCGOutOpQemuLdSt2;
> +
>   typedef struct TCGOutOpUnary {
>       TCGOutOp base;
>       void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
> @@ -1210,6 +1222,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
>       OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
>       OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
> +    OUTOP(INDEX_op_qemu_ld, TCGOutOpQemuLdSt, outop_qemu_ld),
> +    OUTOP(INDEX_op_qemu_ld2, TCGOutOpQemuLdSt2, outop_qemu_ld2),
>       OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
>       OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
>       OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
> @@ -2446,7 +2460,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>               return true;
>           }
>           tcg_debug_assert(type == TCG_TYPE_I128);
> -        return TCG_TARGET_HAS_qemu_ldst_i128;
> +        goto do_lookup;
>   
>       case INDEX_op_add:
>       case INDEX_op_and:
> @@ -2558,6 +2572,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>                   return false;
>               }
>   
> +    do_lookup:
>               outop = all_outop[op];
>               tcg_debug_assert(outop != NULL);
>   
> @@ -5797,6 +5812,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> +    case INDEX_op_qemu_ld:
> +        {
> +            const TCGOutOpQemuLdSt *out = &outop_qemu_ld;
> +            out->out(s, type, new_args[0], new_args[1], new_args[2]);
> +        }
> +        break;
> +
> +    case INDEX_op_qemu_ld2:
> +        {
> +            const TCGOutOpQemuLdSt2 *out = &outop_qemu_ld2;
> +            out->out(s, type, new_args[0], new_args[1],
> +                     new_args[2], new_args[3]);
> +        }
> +        break;
> +
>       case INDEX_op_brcond:
>           {
>               const TCGOutOpBrcond *out = &outop_brcond;
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index f4a0b0e720..21b6ce1229 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1806,8 +1806,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
> -                            MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType data_type, TCGReg data_reg,
> +                         TCGReg addr_reg, MemOpIdx oi)
>   {
>       TCGLabelQemuLdst *ldst;
>       HostAddress h;
> @@ -1822,6 +1822,11 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
>   static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
>                               MemOpIdx oi, TCGType data_type)
>   {
> @@ -1940,6 +1945,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       }
>   }
>   
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
> +{
> +    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_O2_I1(r, r, r),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   static const tcg_insn_unit *tb_ret_addr;
>   
>   static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
> @@ -2875,15 +2891,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>       TCGArg a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, a1, a2, ext);
> -        break;
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, a1, a2, ext);
>           break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
> -        break;
>       case INDEX_op_qemu_st2:
>           tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
>           break;
> @@ -3340,10 +3350,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
> -    case INDEX_op_qemu_ld2:
> -        return C_O2_I1(r, r, r);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(rz, r);
>       case INDEX_op_qemu_st2:
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 29fd82e9e0..681ecc3d7a 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -1586,8 +1586,8 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg datalo,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
> -                            TCGReg addr, MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
>   {
>       MemOp opc = get_memop(oi);
>       TCGLabelQemuLdst *ldst;
> @@ -1595,7 +1595,41 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
>   
>       ldst = prepare_host_addr(s, &h, addr, oi, true);
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
> +        ldst->datalo_reg = data;
> +        ldst->datahi_reg = -1;
> +
> +        /*
> +         * This a conditional BL only to load a pointer within this
> +         * opcode into LR for the slow path.  We will not be using
> +         * the value for a tail call.
> +         */
> +        ldst->label_ptr[0] = s->code_ptr;
> +        tcg_out_bl_imm(s, COND_NE, 0);
> +    }
> +
> +    tcg_out_qemu_ld_direct(s, opc, data, -1, h);
> +
> +    if (ldst) {
> +        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
> +    }
> +}
> +
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, q),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    MemOp opc = get_memop(oi);
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    ldst = prepare_host_addr(s, &h, addr, oi, true);
> +    if (ldst) {
> +        ldst->type = type;
>           ldst->datalo_reg = datalo;
>           ldst->datahi_reg = datahi;
>   
> @@ -1606,14 +1640,20 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
>            */
>           ldst->label_ptr[0] = s->code_ptr;
>           tcg_out_bl_imm(s, COND_NE, 0);
> +    }
>   
> -        tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
> +    tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
> +
> +    if (ldst) {
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
> -    } else {
> -        tcg_out_qemu_ld_direct(s, opc, datalo, datahi, h);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_O2_I1(e, p, q),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
>                                      TCGReg datahi, HostAddress h)
>   {
> @@ -2570,13 +2610,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
> -        break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
> -        break;
> -
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
>           break;
> @@ -2596,10 +2629,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, q);
> -    case INDEX_op_qemu_ld2:
> -        return C_O2_I1(e, p, q);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(q, q);
>       case INDEX_op_qemu_st2:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index cb66f6c27f..7ec06f57ee 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2422,23 +2422,50 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
> -                            TCGReg addr, MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
>   {
>       TCGLabelQemuLdst *ldst;
>       HostAddress h;
>   
>       ldst = prepare_host_addr(s, &h, addr, oi, true);
> -    tcg_out_qemu_ld_direct(s, datalo, datahi, h, data_type, get_memop(oi));
> +    tcg_out_qemu_ld_direct(s, data, -1, h, type, get_memop(oi));
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
> +        ldst->datalo_reg = data;
> +        ldst->datahi_reg = -1;
> +        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
> +    }
> +}
> +
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, L),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    ldst = prepare_host_addr(s, &h, addr, oi, true);
> +    tcg_out_qemu_ld_direct(s, datalo, datahi, h, type, get_memop(oi));
> +
> +    if (ldst) {
> +        ldst->type = type;
>           ldst->datalo_reg = datalo;
>           ldst->datahi_reg = datahi;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_O2_I1(r, r, L),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
>                                      HostAddress h, MemOp memop)
>   {
> @@ -3552,13 +3579,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, -1, a1, a2, type);
> -        break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
> -        break;
> -
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, -1, a1, a2, type);
>           break;
> @@ -4119,16 +4139,11 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, L);
> -
>       case INDEX_op_qemu_st:
>           return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
>                   ? C_O0_I2(s, L)
>                   : C_O0_I2(L, L));
>   
> -    case INDEX_op_qemu_ld2:
> -        return C_O2_I1(r, r, L);
>       case INDEX_op_qemu_st2:
>           return C_O0_I3(L, L, L);
>   
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index d4f65692dd..a1147a1cdc 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1155,22 +1155,27 @@ static void tcg_out_qemu_ld_indexed(TCGContext *s, MemOp opc, TCGType type,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
> -                            MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data_reg,
> +                         TCGReg addr_reg, MemOpIdx oi)
>   {
>       TCGLabelQemuLdst *ldst;
>       HostAddress h;
>   
>       ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
> -    tcg_out_qemu_ld_indexed(s, get_memop(oi), data_type, data_reg, h);
> +    tcg_out_qemu_ld_indexed(s, get_memop(oi), type, data_reg, h);
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
>           ldst->datalo_reg = data_reg;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
>   static void tcg_out_qemu_st_indexed(TCGContext *s, MemOp opc,
>                                       TCGReg rd, HostAddress h)
>   {
> @@ -1258,6 +1263,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi
>       }
>   }
>   
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
> +{
> +    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_N2_I1(r, r, r),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   /*
>    * Entry-points
>    */
> @@ -2008,12 +2024,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       TCGArg a3 = args[3];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, a1, a2, type);
> -        break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
> -        break;
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, a1, a2, type);
>           break;
> @@ -2531,16 +2541,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       switch (op) {
>       case INDEX_op_qemu_st:
>           return C_O0_I2(rz, r);
> -
> -    case INDEX_op_qemu_ld2:
> -        return C_N2_I1(r, r, r);
> -
>       case INDEX_op_qemu_st2:
>           return C_O0_I3(r, r, r);
>   
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
> -
>       case INDEX_op_ld_vec:
>       case INDEX_op_dupm_vec:
>       case INDEX_op_dup_vec:
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index eaaf0f2024..14bffcd404 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1387,8 +1387,8 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
> -                            TCGReg addr, MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
>   {
>       MemOp opc = get_memop(oi);
>       TCGLabelQemuLdst *ldst;
> @@ -1397,19 +1397,56 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       ldst = prepare_host_addr(s, &h, addr, oi, true);
>   
>       if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
> -        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, data_type);
> +        tcg_out_qemu_ld_direct(s, data, 0, h.base, opc, type);
>       } else {
> -        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, data_type);
> +        tcg_out_qemu_ld_unalign(s, data, 0, h.base, opc, type);
>       }
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
> +        ldst->datalo_reg = data;
> +        ldst->datahi_reg = 0;
> +        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
> +    }
> +}
> +
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    MemOp opc = get_memop(oi);
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
> +    ldst = prepare_host_addr(s, &h, addr, oi, true);
> +
> +    if (use_mips32r6_instructions || h.aa.align >= (opc & MO_SIZE)) {
> +        tcg_out_qemu_ld_direct(s, datalo, datahi, h.base, opc, type);
> +    } else {
> +        tcg_out_qemu_ld_unalign(s, datalo, datahi, h.base, opc, type);
> +    }
> +
> +    if (ldst) {
> +        ldst->type = type;
>           ldst->datalo_reg = datalo;
>           ldst->datahi_reg = datahi;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    /* Ensure that the mips32 code is compiled but discarded for mips64. */
> +    .base.static_constraint =
> +        TCG_TARGET_REG_BITS == 32 ? C_O2_I1(r, r, r) : C_NotImplemented,
> +    .out =
> +        TCG_TARGET_REG_BITS == 32 ? tgen_qemu_ld2 : NULL,
> +};
> +
>   static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
>                                      TCGReg base, MemOp opc)
>   {
> @@ -2381,14 +2418,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, 0, a1, a2, type);
> -        break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
> -        tcg_out_qemu_ld(s, a0, a1, a2, args[3], type);
> -        break;
> -
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, 0, a1, a2, type);
>           break;
> @@ -2409,8 +2438,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(rz, r);
>       case INDEX_op_qemu_ld2:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index bb26769d53..e4e6b7b2d9 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2695,6 +2695,33 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       }
>   }
>   
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
> +{
> +    tcg_out_qemu_ld(s, data, -1, addr, oi, type);
> +}
> +
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    if (TCG_TARGET_REG_BITS == 32) {
> +        tcg_out_qemu_ld(s, datalo, datahi, addr, oi, type);
> +    } else {
> +        tcg_out_qemu_ldst_i128(s, datalo, datahi, addr, oi, true);
> +    }
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint =
> +        TCG_TARGET_REG_BITS == 64 ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
>   {
>       int i;
> @@ -3779,18 +3806,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], type);
> -        break;
> -    case INDEX_op_qemu_ld2:
> -        if (TCG_TARGET_REG_BITS == 32) {
> -            tcg_out_qemu_ld(s, args[0], args[1], args[2],
> -                            args[3], TCG_TYPE_I64);
> -            break;
> -        }
> -        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
> -        break;
> -
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, args[0], -1, args[1], args[2], type);
>           break;
> @@ -4418,12 +4433,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
> -    case INDEX_op_qemu_ld2:
> -        return TCG_TARGET_REG_BITS == 64
> -               ? C_N1O1_I1(o, m, r) : C_O2_I1(r, r, r);
> -
>       case INDEX_op_qemu_st:
>           return C_O0_I2(r, r);
>       case INDEX_op_qemu_st2:
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 89c7736f9a..94e6f04fa6 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1833,22 +1833,31 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg val,
>       }
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
> -                            MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data_reg,
> +                         TCGReg addr_reg, MemOpIdx oi)
>   {
>       TCGLabelQemuLdst *ldst;
>       TCGReg base;
>   
>       ldst = prepare_host_addr(s, &base, addr_reg, oi, true);
> -    tcg_out_qemu_ld_direct(s, data_reg, base, get_memop(oi), data_type);
> +    tcg_out_qemu_ld_direct(s, data_reg, base, get_memop(oi), type);
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
>           ldst->datalo_reg = data_reg;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg val,
>                                      TCGReg base, MemOp opc)
>   {
> @@ -2633,9 +2642,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       TCGArg a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, a1, a2, type);
> -        break;
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, a1, a2, type);
>           break;
> @@ -2869,8 +2875,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(rz, r);
>   
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 652ce9023e..72dd161007 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2081,8 +2081,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>       return ldst;
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
> -                            MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext* s, TCGType type, TCGReg data_reg,
> +                         TCGReg addr_reg, MemOpIdx oi)
>   {
>       TCGLabelQemuLdst *ldst;
>       HostAddress h;
> @@ -2091,12 +2091,17 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
>       tcg_out_qemu_ld_direct(s, get_memop(oi), data_reg, h);
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
>           ldst->datalo_reg = data_reg;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
>   static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
>                               MemOpIdx oi, TCGType data_type)
>   {
> @@ -2187,6 +2192,17 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
>       }
>   }
>   
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr_reg, MemOpIdx oi)
> +{
> +    tcg_out_qemu_ldst_i128(s, datalo, datahi, addr_reg, oi, true);
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_O2_I1(o, m, r),
> +    .out = tgen_qemu_ld2,
> +};
> +
>   static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
>   {
>       /* Reuse the zeroing that exists for goto_ptr.  */
> @@ -3133,15 +3149,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, args[0], args[1], args[2], type);
> -        break;
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, args[0], args[1], args[2], type);
>           break;
> -    case INDEX_op_qemu_ld2:
> -        tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
> -        break;
>       case INDEX_op_qemu_st2:
>           tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
>           break;
> @@ -3594,12 +3604,8 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(r, r);
> -    case INDEX_op_qemu_ld2:
> -        return C_O2_I1(o, m, r);
>       case INDEX_op_qemu_st2:
>           return C_O0_I3(o, m, r);
>   
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 2f23d713b7..d9a4b4ea36 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1186,8 +1186,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>       return ldst;
>   }
>   
> -static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
> -                            MemOpIdx oi, TCGType data_type)
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
>   {
>       static const int ld_opc[(MO_SSIZE | MO_BSWAP) + 1] = {
>           [MO_UB]   = LDUB,
> @@ -1219,12 +1219,21 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
>                       ld_opc[get_memop(oi) & (MO_BSWAP | MO_SSIZE)]);
>   
>       if (ldst) {
> -        ldst->type = data_type;
> +        ldst->type = type;
>           ldst->datalo_reg = data;
>           ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
>       }
>   }
>   
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
>                               MemOpIdx oi, TCGType data_type)
>   {
> @@ -2063,9 +2072,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       a2 = args[2];
>   
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
> -        tcg_out_qemu_ld(s, a0, a1, a2, type);
> -        break;
>       case INDEX_op_qemu_st:
>           tcg_out_qemu_st(s, a0, a1, a2, type);
>           break;
> @@ -2082,9 +2088,6 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
> -
>       case INDEX_op_qemu_st:
>           return C_O0_I2(rz, r);
>   
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 6b8f71f49e..f69e35e6ce 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -40,12 +40,8 @@ static TCGConstraintSetIndex
>   tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   {
>       switch (op) {
> -    case INDEX_op_qemu_ld:
> -        return C_O1_I1(r, r);
>       case INDEX_op_qemu_st:
>           return C_O0_I2(r, r);
> -    case INDEX_op_qemu_ld2:
> -        return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r);
>       case INDEX_op_qemu_st2:
>           return TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r);
>   
> @@ -1197,17 +1193,39 @@ static const TCGOutOpStore outop_st = {
>       .out_r = tcg_out_st,
>   };
>   
> +static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
> +                         TCGReg addr, MemOpIdx oi)
> +{
> +    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
> +}
> +
> +static const TCGOutOpQemuLdSt outop_qemu_ld = {
> +    .base.static_constraint = C_O1_I1(r, r),
> +    .out = tgen_qemu_ld,
> +};
> +
> +static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
> +                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
> +{
> +    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
> +    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
> +}
> +
> +static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
> +    .base.static_constraint =
> +        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
> +    .out =
> +        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
> +};
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       switch (opc) {
> -    case INDEX_op_qemu_ld:
>       case INDEX_op_qemu_st:
>           tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
>           break;
> -    case INDEX_op_qemu_ld2:
>       case INDEX_op_qemu_st2:
>           tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
>           tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


