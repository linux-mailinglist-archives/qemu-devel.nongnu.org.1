Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95931771D94
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwwY-00087e-0t; Mon, 07 Aug 2023 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qSwwP-00086K-5l
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:54:21 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qSwwM-0004WU-Hj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:54:19 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b962535808so65086501fa.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691402056; x=1692006856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5AgXqcGWgizO9h0h7Vjhp2nLOL60iwt7LetHDUyXzRU=;
 b=RqejgfN4nrQkFkpGlwiJ00kJtk6a6VuF+UhKEbANZ3g6gXOnz3j4zUGQelM3+opDsa
 hvxr2/RnJhWbjfyDaZ2hSIUWqsDUFGg5ujlvKIr36ZwfMlftAYCu8LcFSrHlLaFNjon6
 hzcjk8q/ER6hKxiF/TssmISqpz1yPQDOYSOo4LuGBRDzhQPcQg9ct6F3g1AjrwnqcOJ5
 hAcNVv2dLphn9/3c7zrFrhEAbRw12UXfCpfWrMabOUCRNLWlyXbHkZ9K4NaP8ss/qXoy
 jNTXuyZg/essu7b1fnch2hteJGX/AOzwOFZvhzhqsvxK3mAU2GCKO3UU5TVKSgEhDqo4
 WfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691402056; x=1692006856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5AgXqcGWgizO9h0h7Vjhp2nLOL60iwt7LetHDUyXzRU=;
 b=bLfxSKUIi1BDwTZ8+NP3omDHef7LbosrKT0gLB1dlsKJ2fxzp3h7geWP+l8IylbA2x
 soEFewHY1fdVIJwnY54wcdKVirrEwo7hje4ODCrqWUWgKKOMrNdqQGHVfq68iU4zqcFP
 CGcnQy3a1GE4mW0SUJtb6XJzFl7BcxarAzIBZVEMBNzALGOFWQq79Fgd8N1IkwQuXF/m
 VxpCQXfxiiA15oRpENi1qEKCfk9rTmmiURcNU9STKGSHFIq5OUb+m4xOhVLEPWjYmW/n
 0mU0sBjZiP6q0CchVY848tdmUACgC6AzmbRpsOLXNK+9VIE43ahHE7Ul5zwycM1JZ8iv
 +osA==
X-Gm-Message-State: AOJu0YwsP3+da6vWTNSXcp/z9dk42+A6DXWiKjmnumvy85w3PknOkYhN
 k2r1m+5iO5zKSN11DRMH/dYz5DQSuly1eLdki2fTw8tON+99k7Uo
X-Google-Smtp-Source: AGHT+IEL0GoEdhFjAROYKxz6hkLLUjLnl9EFxlC21kb/WddeVf+bSaGws3LtWV4b31k3+Nk0SjQMoc2Hz9BRGcm8JAg=
X-Received: by 2002:a2e:98cf:0:b0:2b9:e053:79d8 with SMTP id
 s15-20020a2e98cf000000b002b9e05379d8mr6547585ljj.18.1691402056436; Mon, 07
 Aug 2023 02:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-6-jean-philippe@linaro.org>
 <CAFEAcA-0p2UhURwgLRnUxSK8ktFsULsHz5x3pu+h80VOPBrZvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-0p2UhURwgLRnUxSK8ktFsULsHz5x3pu+h80VOPBrZvQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 10:54:05 +0100
Message-ID: <CAFEAcA88J5QnuoJWOsVJj4qOhDHy-P4LMo+v5UdMLOQxy=pvQA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] target/arm/helper: Check SCR_EL3.{NSE, NS} encoding
 for AT instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Fri, 4 Aug 2023 at 19:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > The AT instruction is UNDEFINED if the {NSE,NS} configuration is
> > invalid. Add a function to check this on all AT instructions that apply
> > to an EL lower than 3.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  target/arm/helper.c | 36 +++++++++++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index fbb03c364b..77dd80ad28 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -3616,6 +3616,20 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >  #endif /* CONFIG_TCG */
> >  }
> >
> > +static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                                     bool isread)
> > +{
> > +    /*
> > +     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
> > +     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved.
> > +     */
> > +    if (cpu_isar_feature(aa64_rme, env_archcpu(env)) &&
> > +        (env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
> > +        return CP_ACCESS_TRAP;
> > +    }
>
> The AArch64.AT() pseudocode and the text in the individual
> AT insn descriptions ("When FEAT_RME is implemented, if the Effective
> value of SCR_EL3.{NSE, NS} is a reserved value, this instruction is
> UNDEFINED at EL3") say that this check needs an "arm_current_el(env) == 3"
> condition too.

It's been pointed out to me that since trying to return from
EL3 with SCR_EL3.{NSE,NS} == {1,0} is an illegal exception return,
it's not actually possible to try to execute these insns in this
state from any other EL than EL3. So we don't actually need
to check for EL3 here.

QEMU's implementation of exception return is missing that
check for illegal-exception-return on bad {NSE,NS}, though.

thanks
-- PMM

