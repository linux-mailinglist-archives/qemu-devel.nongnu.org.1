Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E078B5BA
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 18:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafYn-0006vl-4t; Mon, 28 Aug 2023 12:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafYl-0006vS-AA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:57:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafYi-0002V3-Us
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:57:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d6so27357355ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693241867; x=1693846667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PJnlWk9MGuOeU/pYF1ozqRyygys3qFnQBSv80afNiDs=;
 b=Yur7qe9psQw7oGhfToHya6zX8CGURTGa/IQIpz72xAXjeKtbyh3uL1l+XKLOtrpx4o
 R0eAFrSqWK1ZQ28R8JFe1vpS39Zlq7cLkEsDxQNSHmwdbVtaXAXS9/Xdxc0P/4ALbqUA
 lU+UCocUgbElvZ60UCY3jvMAmT/H1S15t/Mgsmp4A/vS05tRnS89KzNAgJxzF45CwQ10
 YFCLZd6mc8WhBq4Ar6gGdON9fwHWTgp23CkIzCXhaHuJU2IuHj3mhGh1WVlXKIHcnBJE
 0wdhd4nw2JATtnrr4sbgD7oAmL5nkPyY2Kf0vZg2I/q6pKDntZwCCvBflh4LtaAuX1zS
 6TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693241867; x=1693846667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJnlWk9MGuOeU/pYF1ozqRyygys3qFnQBSv80afNiDs=;
 b=Eki1dorjMi6MECL4NbiNL+8jPuk3EndK2NaX7j8J67OZdCMHO3dDIHzvMieKtV51Da
 +/g3wjnPd0XqPR/VtLb/MZdMRDxa3WERV6GfUv8oe3kI0bdRkEuIvxOUDKkrK+BBhp73
 bSslzwWFbOM+hS0iRggN3E0fioKS2uNCcf5Ww2a3AYXiYgSjjaMIULHkJV2Q1/QTVKhB
 F4gTMzSFP0lvoCV15/t6JCtKS2qUZE9V+a6g6qXnrbDtoSEIQw06ULjxoYeLZG44S/7m
 3J/XYorkNTVSXffFB/mO0vAZpOUcjHP/fSEOy4XgepQQz+OK54ZQ1rjxKPGFBa7wPWhz
 Kg2w==
X-Gm-Message-State: AOJu0YwLsG8Aadke+Sile8I83NIRwsgkTNcVcGkjqgxQ8FmtAoXEls+T
 EnzuFiFhI4mcFEt0jl8ho4h0gtspzHTi4+XYPns=
X-Google-Smtp-Source: AGHT+IGlI8Gm4ruKauX1TbUfvZIt9E04RCeUZCdyznwhTf2nRdN3jNpkVQTFzfl33BdMottpBU8HBQ==
X-Received: by 2002:a17:903:258a:b0:1bf:25a1:9813 with SMTP id
 jb10-20020a170903258a00b001bf25a19813mr23937386plb.6.1693241867390; 
 Mon, 28 Aug 2023 09:57:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jw21-20020a170903279500b001b06c106844sm7558426plb.151.2023.08.28.09.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 09:57:46 -0700 (PDT)
Message-ID: <692c49da-af4d-3913-cf82-726294a0d792@linaro.org>
Date: Mon, 28 Aug 2023 09:57:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/11] tcg/loongarch64: Lower basic tcg vec ops to LSX
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-3-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-3-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
> +                             TCGReg rd, int64_t v64)
> +{
> +    /* Try vldi if imm can fit */
> +    if (vece <= MO_32 && (-0x200 <= v64 && v64 <= 0x1FF)) {
> +        uint32_t imm = (vece << 10) | ((uint32_t)v64 & 0x3FF);
> +        tcg_out_opc_vldi(s, rd, imm);
> +        return;
> +    }

v64 has the value replicated across 64 bits.
In order to do the comparison above, you'll want

     int64_t vale = sextract64(v64, 0, 8 << vece);
     if (-0x200 <= vale && vale <= 0x1ff)
         ...

Since the only documentation for LSX is qemu's own translator code, why are you testing 
vece <= MO_32?  MO_64 should be available as well?  Or is there a bug in trans_vldi()?

It might be nice to leave a to-do for vldi imm bit 12 set, for the patterns expanded by 
vldi_get_value().  In particular, mode == 9 is likely to be useful, and modes {1,2,3,5} 
are easy to test for.


> +
> +    /* Fallback to vreplgr2vr */
> +    tcg_out_movi(s, type, TCG_REG_TMP0, v64);

type is a vector type; you can't use it here.
Correct would be TCG_TYPE_I64.

Better to load vale instead, since that will take fewer insns in tcg_out_movi.


> +static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
> +                           unsigned vecl, unsigned vece,
> +                           const TCGArg args[TCG_MAX_OP_ARGS],
> +                           const int const_args[TCG_MAX_OP_ARGS])
> +{
> +    TCGType type = vecl + TCG_TYPE_V64;
> +    TCGArg a0, a1, a2;
> +    TCGReg base;
> +    TCGReg temp = TCG_REG_TMP0;
> +    int32_t offset;
> +
> +    a0 = args[0];
> +    a1 = args[1];
> +    a2 = args[2];
> +
> +    /* Currently only supports V128 */
> +    tcg_debug_assert(type == TCG_TYPE_V128);
> +
> +    switch (opc) {
> +    case INDEX_op_st_vec:
> +        /* Try to fit vst imm */
> +        if (-0x800 <= a2 && a2 <= 0x7ff) {
> +            base = a1;
> +            offset = a2;
> +        } else {
> +            tcg_out_addi(s, TCG_TYPE_I64, temp, a1, a2);
> +            base = temp;
> +            offset = 0;
> +        }
> +        tcg_out_opc_vst(s, a0, base, offset);
> +        break;
> +    case INDEX_op_ld_vec:
> +        /* Try to fit vld imm */
> +        if (-0x800 <= a2 && a2 <= 0x7ff) {
> +            base = a1;
> +            offset = a2;
> +        } else {
> +            tcg_out_addi(s, TCG_TYPE_I64, temp, a1, a2);
> +            base = temp;
> +            offset = 0;
> +        }
> +        tcg_out_opc_vld(s, a0, base, offset);

tcg_out_addi has a hole in bits [15:12], and can take an extra insn if those bits are set. 
  Better to load the offset with tcg_out_movi and then use VLDX/VSTX instead of VLD/VST.

> @@ -159,6 +170,30 @@ typedef enum {
>   #define TCG_TARGET_HAS_mulsh_i64        1
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> +#define TCG_TARGET_HAS_v64              0
> +#define TCG_TARGET_HAS_v128             use_lsx_instructions
> +#define TCG_TARGET_HAS_v256             0

Perhaps reserve for a follow-up, but TCG_TARGET_HAS_v64 can easily be supported using the 
same instructions.

The only difference is load/store, where you could use FLD.D/FST.D to load the lower 
64-bits of the fp/vector register, or VLDREPL.D to load and initialize all bits and 
VSTELM.D to store the lower 64-bits.

I tend to think the float insns are more flexible, having a larger displacement, and the 
availability of FLDX/FSTX as well.


r~

