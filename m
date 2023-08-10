Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB30777E24
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8R8-0005Zr-DW; Thu, 10 Aug 2023 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8R0-0005Yz-Bl
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:22:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8Qw-0004t5-Ew
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:22:50 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so1350097a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691684564; x=1692289364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vzWOho4GMynsk2L81CW9YpHjDBR30YqTkrHWseLSMFY=;
 b=bccdww+a8hWxja/oIPDnlncc6tgAU7sLq9JdUWaYD79K6r9KLhOks+Utw+IuU2HRuI
 bejcsLpl4v8/HwlFJve1nKPa+WGXQyFY4thrK+DkorCEsHlqzJPyvqduDgOiz2TaUTfj
 Ot6YGzahFHmLfmi7jcNpnfuYFF28IEkGLVjjixCzuNbUksUvrF/4QL8bVapryenfTAPx
 wBls8UkuOmeJaITQRHoeaAdrbv5tDK+Vp7mYkvNLk7OnGg0Sov8lBLIiFa5+K/oKuupW
 51pM6p6PBlm3w7XLov9dnVk673ClqSjJnfGryMIlmi1Qptto/qAdQOMDNMzks5qwOnxW
 Q3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691684564; x=1692289364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vzWOho4GMynsk2L81CW9YpHjDBR30YqTkrHWseLSMFY=;
 b=JTEWCPXckUhrttaTigx6R/3TOrerIBN+FpeMGk7cQzRaMz0i0H+RRS9A8LIQik87/t
 XqGEKS+wXYP5bU90V/OEG6wN5aBcAfbapUlVSE4S+Ow6pH+WNDPhVk/h3sE3tbsiBR9M
 kCoo+qh7LcoUiTh5PO7yRtyroakWOsz8xxxk4SWVyE7mGrucWKMxlXiv3xCTRWWv22p/
 xxEr+yX6FXewQIg3ajrQNcq3qeqsBK0YTd73akV2KEmip8o84cvCTgFlsJmFfstTgxW9
 chvVFyTiFtYiC2hohSBlfHcm84gveVB1IKTcxwZMUgWHa5yclaTlL98ZQj+tUDYNPVk7
 4WMw==
X-Gm-Message-State: AOJu0YwdcaH120mLTitmsWMusgDygn3QLCfqZgLPdh6VVWRt7/Cx9wWR
 sO+966Xv45FUnPSlGw5VP38mqpx2kpOs4SxfnlSdxg==
X-Google-Smtp-Source: AGHT+IEpdbiBMTwNmHD5EGP+C4tpzjQuIxgoQL81AwqkrvBbbyN+V1xP9iQ58k9fHV0dwNQjhJ6n1NT+Rg+OqptDPko=
X-Received: by 2002:a05:6402:5157:b0:523:2911:950 with SMTP id
 n23-20020a056402515700b0052329110950mr2698628edd.18.1691684564237; Thu, 10
 Aug 2023 09:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-5-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:22:33 +0100
Message-ID: <CAFEAcA9ym=bQbfizfCbEOP9tZR3pnzBeVLzLQJ6xrc4C4fyRwg@mail.gmail.com>
Subject: Re: [PATCH 04/24] target/arm: Use tcg_gen_negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 22 +++++++++-------------
>  target/arm/tcg/translate.c     | 12 ++++--------
>  2 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 5fa1257d32..ac16593699 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -4935,9 +4935,12 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
>
>      if (rn == 31 && rm == 31 && (else_inc ^ else_inv)) {
>          /* CSET & CSETM.  */
> -        tcg_gen_setcond_i64(tcg_invert_cond(c.cond), tcg_rd, c.value, zero);
>          if (else_inv) {
> -            tcg_gen_neg_i64(tcg_rd, tcg_rd);
> +            tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
> +                                   tcg_rd, c.value, zero);
> +        } else {
> +            tcg_gen_setcond_i64(tcg_invert_cond(c.cond),
> +                                tcg_rd, c.value, zero);
>          }
>      } else {
>          TCGv_i64 t_true = cpu_reg(s, rn);
> @@ -8670,13 +8673,10 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
>          }
>          break;
>      case 0x6: /* CMGT, CMHI */
> -        /* 64 bit integer comparison, result = test ? (2^64 - 1) : 0.
> -         * We implement this using setcond (test) and then negating.
> -         */
>          cond = u ? TCG_COND_GTU : TCG_COND_GT;
>      do_cmop:
> -        tcg_gen_setcond_i64(cond, tcg_rd, tcg_rn, tcg_rm);
> -        tcg_gen_neg_i64(tcg_rd, tcg_rd);
> +        /* 64 bit integer comparison, result = test ? -1 : 0. */
> +        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_rm);
>          break;
>      case 0x7: /* CMGE, CMHS */
>          cond = u ? TCG_COND_GEU : TCG_COND_GE;
> @@ -9265,14 +9265,10 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
>          }
>          break;
>      case 0xa: /* CMLT */
> -        /* 64 bit integer comparison against zero, result is
> -         * test ? (2^64 - 1) : 0. We implement via setcond(!test) and
> -         * subtracting 1.
> -         */
> +        /* 64 bit integer comparison against zero, result is test ? 1 : 0. */

surely "-1" ?

>          cond = TCG_COND_LT;
>      do_cmop:
> -        tcg_gen_setcondi_i64(cond, tcg_rd, tcg_rn, 0);
> -        tcg_gen_neg_i64(tcg_rd, tcg_rd);
> +        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_constant_i64(0));
>          break;
>      case 0x8: /* CMGT, CMGE */
>          cond = u ? TCG_COND_GE : TCG_COND_GT;
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index b71ac2d0d5..31d3130e4c 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -2946,13 +2946,11 @@ void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>  #define GEN_CMP0(NAME, COND)                                            \
>      static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
>      {                                                                   \
> -        tcg_gen_setcondi_i32(COND, d, a, 0);                            \
> -        tcg_gen_neg_i32(d, d);                                          \
> +        tcg_gen_negsetcond_i32(COND, d, a, tcg_constant_i32(0));        \
>      }                                                                   \
>      static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
>      {                                                                   \
> -        tcg_gen_setcondi_i64(COND, d, a, 0);                            \
> -        tcg_gen_neg_i64(d, d);                                          \
> +        tcg_gen_negsetcond_i64(COND, d, a, tcg_constant_i64(0));        \
>      }                                                                   \
>      static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
>      {                                                                   \
> @@ -3863,15 +3861,13 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>  static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
>  {
>      tcg_gen_and_i32(d, a, b);
> -    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
> -    tcg_gen_neg_i32(d, d);
> +    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
>  }
>
>  void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
>  {
>      tcg_gen_and_i64(d, a, b);
> -    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
> -    tcg_gen_neg_i64(d, d);
> +    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
>  }
>
>  static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

