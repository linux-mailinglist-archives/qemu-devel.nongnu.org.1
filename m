Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEE81FB6B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 22:56:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyLt-0007Jr-Q1; Thu, 28 Dec 2023 16:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyLr-0007Ji-62
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:55:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIyLp-0002Mx-AL
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:55:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d44200b976so16920135ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703800535; x=1704405335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLnxobiYG5OKcbJWR067gTA5A6awu/VUkcZ5bokt/TU=;
 b=BpSty8A0hyR6j9eIOk/p6xoScADfLJfNU/ypa+66CZdEqt+OnpcLfkm53LkPDFeQzV
 7pYb3O6zPbwrxzbYtfKuIoRWHYVm4MGwg+glNH1ewhpS1Uaw18+Oj3lcNACI477PPbTh
 d3eeGgVFhwtU6dzsyWqQLEBYgup2JTzxR108gv80hVWrScVyWaT+r0tjKrMDAsKQgkxB
 a7C85+s654G8EZ40oSV9le3ywSgXP2QwYMXjmdSLtwiLhgxvdmT8Ew3KM3oVAundOQBu
 nLyh+2Q1JXhInh1sOj7A8ttLQCdxYZZNmkt2KIC3XTjONzIx5e86PFU2fHkDD+6CNoVx
 +mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703800535; x=1704405335;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLnxobiYG5OKcbJWR067gTA5A6awu/VUkcZ5bokt/TU=;
 b=bnXIamGfTdEcUaUaszASZNaykiiOVYN6YmXVN60pVd2yand04Rjo+P9I2RsOrwcZ00
 b8NJYeey5vxlo+7C9OPw6GKxU4OrjW6rtvKRDVvo/UNx95J8cE3DH0DU0fZVctyf3iVo
 IcLkgfmTTscrOvyEyFxD8yb/0iRbFImDhKo9ruh/lBi6mgxEEagbHmovQBQUYKt6IC0F
 DjCsil7Bkh+kCT3Zz+A4Hg1Fk91BW5XmukYbU4ewiAmILcvPMJW+IJNSwJFvgVTwn3hP
 H3zy69U+aUtmatrfIPNcTuTzo0ZSHPbS4C0qs76vuOmrMUC5117psO7DS4Hv2OKOZN0S
 sJjg==
X-Gm-Message-State: AOJu0YxHQSM0PAUnghb0KPXIzDEAerKWiVl8rkC4WcEgYdPgZNErAgC9
 rs4KO+qj7CYaTkD628uOFdwhYkL2rqS0SfF1NxjZx8FSk0DIGkmx
X-Google-Smtp-Source: AGHT+IHcwZyuk/xVDjgVOAjrXAznt+HtICy7XYuF5C2jG/BPT73x3PUJLUmEYsvmYZybw8Wqm48IpA==
X-Received: by 2002:a17:902:e5c8:b0:1d4:4467:97dc with SMTP id
 u8-20020a170902e5c800b001d4446797dcmr4384450plf.6.1703800534764; 
 Thu, 28 Dec 2023 13:55:34 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 kf8-20020a17090305c800b001d403f114d2sm14309726plb.303.2023.12.28.13.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 13:55:34 -0800 (PST)
Message-ID: <c8b251cc-0936-446e-9129-d3ba487f01ec@linaro.org>
Date: Fri, 29 Dec 2023 08:55:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] target/i386: reimplement check for validity of LOCK
 prefix
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> The previous check erroneously allowed CMP to be modified with LOCK.
> Instead, tag explicitly the instructions that do support LOCK.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 17 ++++++++++-------
>   target/i386/tcg/decode-new.h     |  3 +++
>   target/i386/tcg/emit.c.inc       |  5 -----
>   3 files changed, 13 insertions(+), 12 deletions(-)

It's hard to see how this fits together, because there don't seem to be any uses of 
X86_SPECIAL_{Locked,HasLock} yet.

But the illegal test in disas_insn_new looks more plausibly correct than the one in 
decode_modrm, so

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 232c6a45c96..5eb2e9d0224 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -151,6 +151,7 @@
>   
>   #define cpuid(feat) .cpuid = X86_FEAT_##feat,
>   #define xchg .special = X86_SPECIAL_Locked,
> +#define lock .special = X86_SPECIAL_HasLock,
>   #define mmx .special = X86_SPECIAL_MMX,
>   #define zext0 .special = X86_SPECIAL_ZExtOp0,
>   #define zext2 .special = X86_SPECIAL_ZExtOp2,
> @@ -1103,10 +1104,6 @@ static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
>   {
>       int modrm = get_modrm(s, env);
>       if ((modrm >> 6) == 3) {
> -        if (s->prefix & PREFIX_LOCK) {
> -            decode->e.gen = gen_illegal;
> -            return 0xff;
> -        }
>           op->n = (modrm & 7);
>           if (type != X86_TYPE_Q && type != X86_TYPE_N) {
>               op->n |= REX_B(s);
> @@ -1881,6 +1878,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
>           if (decode.op[0].has_ea) {
>               s->prefix |= PREFIX_LOCK;
>           }
> +        decode.e.special = X86_SPECIAL_HasLock;
> +        /* fallthrough */
> +    case X86_SPECIAL_HasLock:
>           break;
>   
>       case X86_SPECIAL_ZExtOp0:
> @@ -1909,6 +1909,12 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
>           break;
>       }
>   
> +    if (s->prefix & PREFIX_LOCK) {
> +        if (decode.e.special != X86_SPECIAL_HasLock || !decode.op[0].has_ea) {
> +            goto illegal_op;
> +        }
> +    }
> +
>       if (!validate_vex(s, &decode)) {
>           return;
>       }
> @@ -1952,9 +1958,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
>           gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
>       }
>       if (s->prefix & PREFIX_LOCK) {
> -        if (decode.op[0].unit != X86_OP_INT || !decode.op[0].has_ea) {
> -            goto illegal_op;
> -        }
>           gen_load(s, &decode, 2, s->T1);
>           decode.e.gen(s, env, &decode);
>       } else {
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index e6c904a3192..611bfddd957 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -158,6 +158,9 @@ typedef enum X86InsnCheck {
>   typedef enum X86InsnSpecial {
>       X86_SPECIAL_None,
>   
> +    /* Accepts LOCK prefix; LOCKed operations do not load or writeback operand 0 */
> +    X86_SPECIAL_HasLock,
> +
>       /* Always locked if it has a memory operand (XCHG) */
>       X86_SPECIAL_Locked,
>   
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index d444d83e534..98c4c9569ef 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -55,11 +55,6 @@ static void gen_NM_exception(DisasContext *s)
>       gen_exception(s, EXCP07_PREX);
>   }
>   
> -static void gen_illegal(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> -{
> -    gen_illegal_opcode(s);
> -}
> -
>   static void gen_load_ea(DisasContext *s, AddressParts *mem, bool is_vsib)
>   {
>       TCGv ea = gen_lea_modrm_1(s, *mem, is_vsib);


