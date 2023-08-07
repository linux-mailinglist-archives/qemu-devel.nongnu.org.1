Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078127728BE
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1qP-0005wC-7X; Mon, 07 Aug 2023 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT1qK-0005vu-DA
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:08:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT1qI-0000Cg-Nu
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:08:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so5973786a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691420901; x=1692025701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VeXLHBTkp21nFEwIliIYemJYk6vTHb9RO5IkIPzkk+c=;
 b=uQxRTbX2CyqbDoQN+Qg8SkKzftzv9kc8ttBwnigQgoHOCblLdy/T44hJB1Vo2/pZRd
 A0EZmRiTeBINwdGbGGAuRi92TvFGpdXGGrSrRJ0NdkhgwFk8cgkj7Jbi2s8GPnfIXZbJ
 3qLhZoRg2QnWOYLuHdIpg0ztvhXqZZwfssv6WwkD3w8i+qTaf7PtGsgejt9/8Q3yOpYN
 jOO0mAhiMlAQCZyeXz8iJ9pcE5uI91j1VaOim4Brx+L2BNUBy45dB91jfPK1wRVmLFnW
 VCCB520LYcedsm/fqdQuyX6c+rGWRaMKJwdP8QALO75+DehFMpMIJbrU0qXPn8F894eT
 t4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691420901; x=1692025701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VeXLHBTkp21nFEwIliIYemJYk6vTHb9RO5IkIPzkk+c=;
 b=PjWh4RVkDdHebcm1nwKC/nUOjsWeqJlfUDe9y99AwOQRpRFRfWk4QYzPceet6wFAuL
 py4d1zRI6kgCev1edSLtAGM8Kl53uG1jIl8LFuwB8VXIbvMQPs2X5KC+iXLM5I/8qMW3
 cMvuFx+egc3e4n+KccRHCCYE1DoDWdrnpLNuBbHExTN9FOksFVgIjZoFj2TphY9V3CI7
 8Ottxa7Wlhxwx70d8jPm7LLsaTNSqx/UsxNKDjgNFJHrsBk+jh6TnOO7zu4RVYomK1mD
 AiRlnGdB0wjJAuBQpQ/2utIoLCK3dKNfe0we+KDCuz8iNn9i4Qsfg49HcYncN+OJwECJ
 mbqg==
X-Gm-Message-State: AOJu0YzW98h0GYpLIvmFnKbC+QZY0ClO7zBXESXDfzUkOJMINVh/bth0
 iUz2uqZt1rLrjanN7tdKvxctp2uzVgBzQyBGERhRzA==
X-Google-Smtp-Source: AGHT+IFw5Fn5QTLJF/Pw/RiKN5JczPzMH9APkFEh3saT8BKB1jsVYY8n+uutVOh4lCoZN2ir2mPCZi9/kek3/FQbm0A=
X-Received: by 2002:a05:6402:b31:b0:523:3fa1:6a3a with SMTP id
 bo17-20020a0564020b3100b005233fa16a3amr669418edb.27.1691420901146; Mon, 07
 Aug 2023 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-6-jean-philippe@linaro.org>
 <CAFEAcA-0p2UhURwgLRnUxSK8ktFsULsHz5x3pu+h80VOPBrZvQ@mail.gmail.com>
 <CAFEAcA88J5QnuoJWOsVJj4qOhDHy-P4LMo+v5UdMLOQxy=pvQA@mail.gmail.com>
 <20230807140357.GA769137@myrica>
In-Reply-To: <20230807140357.GA769137@myrica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 16:08:10 +0100
Message-ID: <CAFEAcA_FS5SsOLw60XDnL_RM=jG+8_9wh1VLm0ND0SozzGLCxw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] target/arm/helper: Check SCR_EL3.{NSE, NS} encoding
 for AT instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 7 Aug 2023 at 15:03, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, Aug 07, 2023 at 10:54:05AM +0100, Peter Maydell wrote:
> > On Fri, 4 Aug 2023 at 19:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
> > > <jean-philippe@linaro.org> wrote:
> > > >
> > > > The AT instruction is UNDEFINED if the {NSE,NS} configuration is
> > > > invalid. Add a function to check this on all AT instructions that apply
> > > > to an EL lower than 3.
> > > >
> > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > ---
> > > >  target/arm/helper.c | 36 +++++++++++++++++++++++++-----------
> > > >  1 file changed, 25 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > > index fbb03c364b..77dd80ad28 100644
> > > > --- a/target/arm/helper.c
> > > > +++ b/target/arm/helper.c
> > > > @@ -3616,6 +3616,20 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > > >  #endif /* CONFIG_TCG */
> > > >  }
> > > >
> > > > +static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
> > > > +                                     bool isread)
> > > > +{
> > > > +    /*
> > > > +     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
> > > > +     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved.
> > > > +     */
> > > > +    if (cpu_isar_feature(aa64_rme, env_archcpu(env)) &&
> > > > +        (env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
> > > > +        return CP_ACCESS_TRAP;
> > > > +    }
> > >
> > > The AArch64.AT() pseudocode and the text in the individual
> > > AT insn descriptions ("When FEAT_RME is implemented, if the Effective
> > > value of SCR_EL3.{NSE, NS} is a reserved value, this instruction is
> > > UNDEFINED at EL3") say that this check needs an "arm_current_el(env) == 3"
> > > condition too.
> >
> > It's been pointed out to me that since trying to return from
> > EL3 with SCR_EL3.{NSE,NS} == {1,0} is an illegal exception return,
> > it's not actually possible to try to execute these insns in this
> > state from any other EL than EL3. So we don't actually need
> > to check for EL3 here.
> >
> > QEMU's implementation of exception return is missing that
> > check for illegal-exception-return on bad {NSE,NS}, though.
>
> I can add a patch to check that exception return condition, and add a
> comment here explaining that this can only happen when executing at EL3

I just sent a patch to do the illegal-exc-ret check; I agree a
comment here would probably help.

With the comment
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

