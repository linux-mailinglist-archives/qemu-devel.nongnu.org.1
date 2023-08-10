Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B180777E79
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8h6-0000dX-FJ; Thu, 10 Aug 2023 12:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8h4-0000XE-0f
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:39:26 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8gz-00089F-NH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:39:25 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe0fe622c3so1701325e87.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685560; x=1692290360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d4S6ax0GQAgWndF5nePyMopDHsjLNLNzVViEbcdlH38=;
 b=z6xT7P69jrEWLWpdlUm/1I/Xf1wgMauXaQ/9u1xc/58QkMo8hlpwLkwioTOs3TQdtB
 zJ9YyYx0S83cWSUj7JdaainIia5+dOXXxQWVZamFJOOy3FpDsOqvjVqcHe6a/omhpj8j
 kzvL5gzWnDFi2696TUrMhv099IhWvTib+LpOvR61YXLTer4Pzz842Mv1BLfjlxuMRbjB
 tsH7IS/Ix9KZKHDLXsRP+82/g6lrmfNXlN5TQGqwyyS6oIctEVNZuyrFQOw/OajgOUJU
 qCMWRQjH4UBJSGQpzJOnfr87CV/cb52OgnXeDhjxT+fiQiejgQn9idZSSOYjndGQvxkh
 BPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685560; x=1692290360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4S6ax0GQAgWndF5nePyMopDHsjLNLNzVViEbcdlH38=;
 b=mH0xwXqSjlRtneG+smtMvIwhn+wyAS6NGZecWghL5TeWYgiJWT3HIab98mw6rETZlp
 DUCZBcBXxmrPT87rIw97XiVb/TNZFuoFs9e5enpgeHT+0K0TOtQDcNk6nrcWW4umWkB/
 PZm+y0TlQYOez/Fl3pfzIndlhEinRie3clj71JyoDSG2Fu5FQsBht3xfX2blMJTISKSm
 UAObCkWWcV/cR52mCxWAdt9CUlRmTcvoLE0Kh8t1NtiJiv8RZxKih1vJ8YDzZ7Y17PT5
 MQ1LUkSFQS8zPgOzmOVA/ngYJiH2jw/GLoxwwYbKaeSyra0vBDRZHGk6l4rrbGDIvRHz
 fa1g==
X-Gm-Message-State: AOJu0Ywcd4KCAqn871+k89F4Iy/JFGqX+sDWZ17p4OL47UgakKxZ63LN
 yD4AJcam/7jLx8JLqHTVIi3il+TE0U44fbO6EQE2xA==
X-Google-Smtp-Source: AGHT+IGUrYQnNRikO89gpkqi4uNF3gZrUO2tnaT4n3oa5cx8J9LnEZIW43tECshhCvlr8VgUcnLvZud9hnaPt8kQ53k=
X-Received: by 2002:a05:6512:1d0:b0:4fb:9469:d659 with SMTP id
 f16-20020a05651201d000b004fb9469d659mr2098174lfp.23.1691685559778; Thu, 10
 Aug 2023 09:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-13-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:39:08 +0100
Message-ID: <CAFEAcA9dqnaqGrLz804UB8zHSnbCEWwhv1nzvdt_j0CS3=mCSg@mail.gmail.com>
Subject: Re: [PATCH 12/24] tcg/aarch64: Implement negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 8 Aug 2023 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Trivial, as aarch64 has an instruction for this: CSETM.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     |  4 ++--
>  tcg/aarch64/tcg-target.c.inc | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 6080fddf73..e3faa9cff4 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -94,7 +94,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_mulsh_i32        0
>  #define TCG_TARGET_HAS_extrl_i64_i32    0
>  #define TCG_TARGET_HAS_extrh_i64_i32    0
> -#define TCG_TARGET_HAS_negsetcond_i32   0
> +#define TCG_TARGET_HAS_negsetcond_i32   1
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
>
>  #define TCG_TARGET_HAS_div_i64          1
> @@ -130,7 +130,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_muls2_i64        0
>  #define TCG_TARGET_HAS_muluh_i64        1
>  #define TCG_TARGET_HAS_mulsh_i64        1
> -#define TCG_TARGET_HAS_negsetcond_i64   0
> +#define TCG_TARGET_HAS_negsetcond_i64   1
>
>  /*
>   * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 35ca80cd56..7d8d114c9e 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2262,6 +2262,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                       TCG_REG_XZR, tcg_invert_cond(args[3]));
>          break;
>
> +    case INDEX_op_negsetcond_i32:
> +        a2 = (int32_t)a2;
> +        /* FALLTHRU */

I see this is what we already do for setcond and movcond,
but how does it work when the 2nd input is a register?
Or is reg-reg guaranteed to always use the _i64 op?

> +    case INDEX_op_negsetcond_i64:
> +        tcg_out_cmp(s, ext, a1, a2, c2);
> +        /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
> +        tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
> +                     TCG_REG_XZR, tcg_invert_cond(args[3]));
> +        break;
> +
>      case INDEX_op_movcond_i32:
>          a2 = (int32_t)a2;
>          /* FALLTHRU */
> @@ -2868,6 +2878,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_sub_i64:
>      case INDEX_op_setcond_i32:
>      case INDEX_op_setcond_i64:
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
>          return C_O1_I2(r, r, rA);
>
>      case INDEX_op_mul_i32:

thanks
-- PMM

