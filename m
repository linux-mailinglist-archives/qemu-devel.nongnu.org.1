Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57B778C3E
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUPeV-0001IC-I2; Fri, 11 Aug 2023 06:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPeM-0001Gk-TJ
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:45:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUPeB-0002bb-0g
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:45:45 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so2327273a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691750732; x=1692355532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N2FvBgkiIdUsjB/FxaUZBa1ZB141qaGSBWUTFySHBvs=;
 b=blBPD6HD8/SYnvzrcjkchCddZQJyt0JDrSYgcCnx9gotMlBW5gmYWVLDWqOWZOWYFY
 4hG73rLMNShtzjl3af52L6v9ZVYsYoJSrZ40w+t/UnkXWMnG7QgJQfivV1eIS5RS9SjH
 4ybPMGh86PXphuatyJYmYTstWQMq/AA3NJnZeVG44zaVD69N0uhcZLZEN+1M1kZ8WHb2
 CJojja2Y5hhcFzEt+3FKykoeFC5uyibJ/IY7m4KnrdwOjOed4gfSBblXNL7xOFJkoPpu
 7YPiVeNih+VhGg0W3zb/w3gIor9ZeBhwvEa5B/8jHB0ChQ8lGyI4X29hBaNSk/3Np6Mg
 TvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691750732; x=1692355532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2FvBgkiIdUsjB/FxaUZBa1ZB141qaGSBWUTFySHBvs=;
 b=C1OKya3huFOBnWdaqeq2DF3rHQzPMu/X68GnzKqaekfBv51qKTrCO7b5tJPE9S1JA6
 EQlB6zFFEXsLM+oRBEVRD9OKX7Z6nTcofx/G70Hu/Kon7LLz0xNaCo2l8Vktgl0H7R1V
 isHB8k+5elwSJAk4eKE8rsGQsRERfG/qIKI2M5KVMPvtiOCtAQddUVzaQInvK9GS99Dq
 oPWBsUWk6IayNFibInik3OS8sTygQ60Kzq1WUJfYJAA9ra+Kkosh+gVeW90U+Z0uXDui
 kaMCOR2CLTqMpBGRpuIRJDsVXOEH594cRtfMOJfNKFOibc4Qt4//oEVoT/W7AGImOuWV
 vUfw==
X-Gm-Message-State: AOJu0YysLMyTmCfw7UNHsifWlfGnQnqjHHHshezgiChCgiiW1x44rJwe
 PPNShjyLAcJ2mG2RpJGQPl/ODaSkxApygje1ajk6bg==
X-Google-Smtp-Source: AGHT+IEnOfuB8VVchtq/CHXO+vYHLurhSNwuuYF759reM8xl+ubcoUpMoAN7Fh8aS42Jj0xIqMqyGWuje23MXxH+uZE=
X-Received: by 2002:aa7:c557:0:b0:522:cef7:83c3 with SMTP id
 s23-20020aa7c557000000b00522cef783c3mr1291540edr.8.1691750732278; Fri, 11 Aug
 2023 03:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-21-richard.henderson@linaro.org>
 <CAFEAcA-N-QWQXcHgMNnXTr+Bmf7fhdSKYQwS-kkWGdR+UHvT-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-N-QWQXcHgMNnXTr+Bmf7fhdSKYQwS-kkWGdR+UHvT-Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 11:45:21 +0100
Message-ID: <CAFEAcA9xsPHOeorJvjfO7mrpX_TfYHMNcMHi3dyt41+CktyXsg@mail.gmail.com>
Subject: Re: [PATCH 20/24] tcg/i386: Add cf parameter to tcg_out_cmp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 11 Aug 2023 at 11:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 8 Aug 2023 at 04:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Add the parameter to avoid TEST and pass along to tgen_arithi.
> > All current users pass false.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  tcg/i386/tcg-target.c.inc | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> > index b88fc14afd..56549ff2a0 100644
> > --- a/tcg/i386/tcg-target.c.inc
> > +++ b/tcg/i386/tcg-target.c.inc
> > @@ -1418,15 +1418,15 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
> >      }
> >  }
> >
> > -static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
> > -                        int const_arg2, int rexw)
> > +static void tcg_out_cmp(TCGContext *s, int rexw, TCGArg arg1, TCGArg arg2,
> > +                        int const_arg2, bool cf)
> >  {
> >      if (const_arg2) {
> > -        if (arg2 == 0) {
> > +        if (arg2 == 0 && !cf) {
> >              /* test r, r */
> >              tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
> >          } else {
> > -            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
> > +            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, cf);
> >          }
> >      } else {
> >          tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
>
> I don't really understand the motivation here.
> Why are some uses of this function fine with using the TEST
> insn, but some must avoid it? What does 'cf' stand for?
> A comment would help here if there isn't a clearer argument
> name available...

Looking at the following patch suggests perhaps:

/**
 * tcg_out_cmp: Emit a compare, setting the X, Y, Z flags accordingly.
 * @need_cf : true if the comparison must also set CF
 */

(fill in which XYZ flags you can rely on even if need_cf is false)

?

-- PMM

