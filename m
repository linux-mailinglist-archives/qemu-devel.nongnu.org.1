Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D278D76E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNl5-0001Li-11; Wed, 30 Aug 2023 12:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNl2-0001Gk-OJ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:09:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNl0-0002Jb-6q
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:09:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so43614165ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693411764; x=1694016564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H6ByQkJ1C1jwHKnBCrov7ZWzhDXhBS6BeyDAj9wWvXs=;
 b=PN33BW2lLZDv4HvAkocF7pHj9f/weKT9D4NXLfnMcrDltKLHyHw4MSkCu3cpWxDEoT
 EO/qStRMkw/fT0dhIxBQCHmXQMs44IoIpG3BdJDkiOZVEqwfcvrYb0Il4vDDfDZBfBR/
 /woykOvrCdjAA58cRH+GiTEsdN/veETp2ncG/mhApc1rxtYHKLR4wn+HVUrAnAtvjWeM
 IAUepzBsf1Bs33zwQ1iZVF7UK/NQGnQV9q68YQkaQRwPkjnegYfgBUgVP8x7ggy6sPfJ
 b2jLShLL2j3sU31EEAYGD/yZFSz7k5AL76R9oWtxaIEU6DyDnp6ME57Y1gz4rk6Hnx9D
 IBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693411764; x=1694016564;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H6ByQkJ1C1jwHKnBCrov7ZWzhDXhBS6BeyDAj9wWvXs=;
 b=Izxrvi7QFX2HTqCmGm7WwZeqZZc15dkGsTCNouAmVWY9VNDFYGzrv8hMyiUmadc8Rb
 w2snmzRxvwkD/+CnlWPmpV2zV0rjFpfeQ17avCjJKrdHz8inlMk342kpvxV3l+ayRlRy
 xJAIUWw/8UHC/2C1ztkXD5bcMZ9ID31Aqo6gAnaNWTQGrn2UpbXjP4iFNDTJ8eVyMvfo
 YnwpM8g+WLbbMbu7/JPk2RHUwrW29GgoO9fW8sdIZE0OThRyozILO/8G4WgWtakZpXEJ
 kunlHtG2imn2OB6w3ymMdaDAL8zx7OVcq6+W+YXYwJI1wWrtdnksAZW+cdTYSNtDb2vR
 Cbmw==
X-Gm-Message-State: AOJu0YxC0Y3QR8xfDSImoH/6Cib9+BbEuirTd/qSJ6ygMWyfXeXje7N1
 UI+3SSiuC9qxpjC5GU2zzGMQ6w==
X-Google-Smtp-Source: AGHT+IGn7LON0hs+J47s1855rtyrV8Jrt/oOrHDNVT0Jn+XY4Twnva8Cwe5XK03UQv3YyYk566nOYQ==
X-Received: by 2002:a17:903:48b:b0:1bc:2d43:c747 with SMTP id
 jj11-20020a170903048b00b001bc2d43c747mr2568242plb.38.1693411764154; 
 Wed, 30 Aug 2023 09:09:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a17090311ca00b001bdcc3a09c3sm11251691plh.256.2023.08.30.09.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 09:09:23 -0700 (PDT)
Message-ID: <34b735fd-0b90-8e3d-a0a8-3091adeccbf5@linaro.org>
Date: Wed, 30 Aug 2023 09:09:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/48] target/loongarch: Implement xvreplgr2vr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-7-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVREPLGR2VR.{B/H/W/D}.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/insns.decode                |  5 +++++
>   target/loongarch/disas.c                     | 10 ++++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 12 ++++++------
>   4 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
> index bcc18fb6c5..04bd238995 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -1310,3 +1310,8 @@ xvsub_h          0111 01000000 11001 ..... ..... .....    @vvv
>   xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
>   xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
>   xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
> +
> +xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
> +xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
> +xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
> +xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index d8b62ba532..c47f455ed0 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -1708,6 +1708,11 @@ static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
>       output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
>   }
>   
> +static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
> +{
> +    output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
> +}
> +
>   INSN_LASX(xvadd_b,           vvv)
>   INSN_LASX(xvadd_h,           vvv)
>   INSN_LASX(xvadd_w,           vvv)
> @@ -1718,3 +1723,8 @@ INSN_LASX(xvsub_h,           vvv)
>   INSN_LASX(xvsub_w,           vvv)
>   INSN_LASX(xvsub_d,           vvv)
>   INSN_LASX(xvsub_q,           vvv)
> +
> +INSN_LASX(xvreplgr2vr_b,     vr)
> +INSN_LASX(xvreplgr2vr_h,     vr)
> +INSN_LASX(xvreplgr2vr_w,     vr)
> +INSN_LASX(xvreplgr2vr_d,     vr)
> diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
> index 218b8dc648..66b5abc790 100644
> --- a/target/loongarch/insn_trans/trans_lasx.c.inc
> +++ b/target/loongarch/insn_trans/trans_lasx.c.inc
> @@ -50,3 +50,8 @@ TRANS(xvsub_b, LASX, gvec_vvv, 32, MO_8, tcg_gen_gvec_sub)
>   TRANS(xvsub_h, LASX, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
>   TRANS(xvsub_w, LASX, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
>   TRANS(xvsub_d, LASX, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
> +
> +TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
> +TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
> +TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
> +TRANS(xvreplgr2vr_d, LASX, gvec_dup, 32, MO_64)
> diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
> index 0e12213e8b..c0e7a9a372 100644
> --- a/target/loongarch/insn_trans/trans_lsx.c.inc
> +++ b/target/loongarch/insn_trans/trans_lsx.c.inc
> @@ -4161,7 +4161,7 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
>       return true;
>   }
>   
> -static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
> +static bool gvec_dup(DisasContext *ctx, arg_vr *a, uint32_t oprsz, MemOp mop)
>   {
>       TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
>   
> @@ -4172,14 +4172,14 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
>       CHECK_VEC;
>   
>       tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
> -                         16, ctx->vl/8, src);
> +                         oprsz, ctx->vl / 8, src);
>       return true;
>   }
>   
> -TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
> -TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
> -TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
> -TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
> +TRANS(vreplgr2vr_b, LSX, gvec_dup, 16, MO_8)
> +TRANS(vreplgr2vr_h, LSX, gvec_dup, 16, MO_16)
> +TRANS(vreplgr2vr_w, LSX, gvec_dup, 16, MO_32)
> +TRANS(vreplgr2vr_d, LSX, gvec_dup, 16, MO_64)

Hmm.

Ok, so revising the advice I gave versus the previous patch, I can see how having a common 
CHECK_VEC is helpful.  But it still needs to use oprsz not vl for the size check.

It would be better to replace with a function, like

     if (!check_vec(ctx, oprsz)) {
         return true;
     }

rather than a macro with a hidden return.  The replacement should be done in a patch by 
itself, probably using check_vec(ctx, 16) for all of the existing LSX code until, step by 
step, oprsz is plumbed into all of the places required.

I still think having separate minimal gen_vvv and gen_xxx helpers will help reduce the 
possibility of typos, when there are a lot of instructions within an instruction format. 
But when there are just 8, like here, just adding oprsz certainly looks simpler.

I wonder if it is really clearer having the LASX instructions in a separate file?  Perhaps 
it be better to keep all of the similar patterns together, e.g.

static bool gvec_dup(...)
{
...
}

TRANS(vreplgr2vr_b, LSX, gvec_dup, 16, MO_8)
TRANS(vreplgr2vr_h, LSX, gvec_dup, 16, MO_16)
TRANS(vreplgr2vr_w, LSX, gvec_dup, 16, MO_32)
TRANS(vreplgr2vr_d, LSX, gvec_dup, 16, MO_64)

TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
TRANS(xvreplgr2vr_d, LASX, gvec_dup, 32, MO_64)


r~

