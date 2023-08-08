Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4B773F7D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTPsL-0007gT-A3; Tue, 08 Aug 2023 12:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qTPsH-0007fM-10
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:48:01 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qTPsC-0006oz-TE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:48:00 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a1ebb85f99so4999060b6e.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691513275; x=1692118075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8cFiOfGI3TL7QyZPbHtEtIN8OCUaKrSAxW5UF1fVYA=;
 b=K4aT9FKDsKdmiSFl6EamoANU9oe9OWaYLhTAANcTVv80XU3EzDXeAsCdDLKadvl3Xv
 v+pJzfa/kDRU8H7kE1MdkQ8CDM8HbYRwTWUWxA7N+MBYSn7MgUy/dpygDBDi7RIv6vUn
 0rRcubKk+H7nlvW+mBq9NyD4d8dtah55oRaw1SrINc4vrFMpoBZ4Gbq8Fq8ADcFxH6LQ
 OV7mdVZfTK4/7Y9vxOJY2YZv0u4yhmDencxQ4QTvgd3tsktTlLrxWbdyjq0Ez3sqy9SO
 xJqKognHHmDJY1AiMWonhAVE9Wyi/zzl8/30nFw2sRjiCVDXnfW9NuO5MahVGUlZcaHM
 Q2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691513275; x=1692118075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8cFiOfGI3TL7QyZPbHtEtIN8OCUaKrSAxW5UF1fVYA=;
 b=YLc2eqCOS71qJpb+4qp6AfMrOkEpH8m/jZ6ZzmU+rbP+ht7HwwmxQpUHbqzAXPJbKC
 Ehfl8SHpoUA4tuYj2BcgghvXC7ob3SRbs+HjNWUpYPIjobICRfUgmBrPGv5JU0ZgkAes
 FE++wL/BBo+B4/PY4S5tDre8Dbca54FrcbyvEPVb6/Ko0RMTD9d2JqbCOnv7sKe7+rvP
 FguJWzDJG7bj52qxknHHcg01mLyfPfoFTAwiUmoHekGTluc3bYHEsF3JZOq3rRYr5NFJ
 mYEHh8PwgCTDWbQ+MRvNiYM3+Qq0zEYtV5gzw8MjxUDu08JPtWBC4wlRwhDeNePUimAu
 Etgw==
X-Gm-Message-State: AOJu0YwWAKHv8vm2Zen66IJZWYGbxmURfK+m8ALcDWpxjpQ0xDmXvCwZ
 K4yuMu4S08r/suJZLudipL4umQ==
X-Google-Smtp-Source: AGHT+IFBSfT/nc3AJj2iUV3Ia3C7GdMg+aw0OVs4VA80d3RsLPRZTSfvSSsAPuVPf+NA+NJ1zzMZRQ==
X-Received: by 2002:aca:1106:0:b0:3a7:540f:ca71 with SMTP id
 6-20020aca1106000000b003a7540fca71mr235415oir.53.1691513275458; 
 Tue, 08 Aug 2023 09:47:55 -0700 (PDT)
Received: from [192.168.68.108] (189-69-160-189.dial-up.telesp.net.br.
 [189.69.160.189]) by smtp.gmail.com with ESMTPSA id
 bh36-20020a056808182400b003a368f3e0a6sm6094385oib.3.2023.08.08.09.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 09:47:55 -0700 (PDT)
Message-ID: <f2ee3a32-7e38-8bd1-d89a-5949e4d72bec@ventanamicro.com>
Date: Tue, 8 Aug 2023 13:47:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/24] tcg/riscv: Implement negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-15-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230808031143.50925-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=unavailable autolearn_force=no
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



On 8/8/23 00:11, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tcg/riscv/tcg-target.h     |  4 ++--
>   tcg/riscv/tcg-target.c.inc | 45 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index b2961fec8e..7e8ac48a7d 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -120,7 +120,7 @@ extern bool have_zbb;
>   #define TCG_TARGET_HAS_ctpop_i32        have_zbb
>   #define TCG_TARGET_HAS_brcond2          1
>   #define TCG_TARGET_HAS_setcond2         1
> -#define TCG_TARGET_HAS_negsetcond_i32   0
> +#define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_movcond_i64      1
> @@ -159,7 +159,7 @@ extern bool have_zbb;
>   #define TCG_TARGET_HAS_muls2_i64        0
>   #define TCG_TARGET_HAS_muluh_i64        1
>   #define TCG_TARGET_HAS_mulsh_i64        1
> -#define TCG_TARGET_HAS_negsetcond_i64   0
> +#define TCG_TARGET_HAS_negsetcond_i64   1
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index eeaeb6b6e3..232b616af3 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -936,6 +936,44 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
>       }
>   }
>   
> +static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
> +                               TCGReg arg1, tcg_target_long arg2, bool c2)
> +{
> +    int tmpflags;
> +    TCGReg tmp;
> +
> +    /* For LT/GE comparison against 0, replicate the sign bit. */
> +    if (c2 && arg2 == 0) {
> +        switch (cond) {
> +        case TCG_COND_GE:
> +            tcg_out_opc_imm(s, OPC_XORI, ret, arg1, -1);
> +            arg1 = ret;
> +            /* fall through */
> +        case TCG_COND_LT:
> +            tcg_out_opc_imm(s, OPC_SRAI, ret, arg1, TCG_TARGET_REG_BITS - 1);
> +            return;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
> +    tmp = tmpflags & ~SETCOND_FLAGS;
> +
> +    /* If intermediate result is zero/non-zero: test != 0. */
> +    if (tmpflags & SETCOND_NEZ) {
> +        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
> +        tmp = ret;
> +    }
> +
> +    /* Produce the 0/-1 result. */
> +    if (tmpflags & SETCOND_INV) {
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, tmp, -1);
> +    } else {
> +        tcg_out_opc_reg(s, OPC_SUB, ret, TCG_REG_ZERO, tmp);
> +    }
> +}
> +
>   static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg test_ne,
>                                      int val1, bool c_val1,
>                                      int val2, bool c_val2)
> @@ -1782,6 +1820,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>           tcg_out_setcond(s, args[3], a0, a1, a2, c2);
>           break;
>   
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
> +        tcg_out_negsetcond(s, args[3], a0, a1, a2, c2);
> +        break;
> +
>       case INDEX_op_movcond_i32:
>       case INDEX_op_movcond_i64:
>           tcg_out_movcond(s, args[5], a0, a1, a2, c2,
> @@ -1910,6 +1953,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_xor_i64:
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, r, rI);
>   
>       case INDEX_op_andc_i32:

