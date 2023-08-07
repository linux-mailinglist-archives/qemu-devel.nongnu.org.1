Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AD772703
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT0qD-0004sf-8L; Mon, 07 Aug 2023 10:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qT0q4-0004rb-CT
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:04:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qT0py-0002aJ-3j
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:04:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe4b45a336so22814715e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417036; x=1692021836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ybHOHddZSdETsR4kLtiwqTBuOOQ6Q7i/BQT8b36uuzU=;
 b=bTyShhf8IE0IKMw9YHFUCYV18b5vflIFWe4VAi/7LQpyv8eEgNmdzUskFP/jxJaHSK
 GlFRnU8okN1JY8kWGKzbAYfkq0nyuDHxaRxUiKHHW2FHlInyYNGeqwd4Lbmiq8XbwBuY
 YwotIUjiyxvV3QEOFKddcNE+BJbb0pRC2Y+ksPp1h4CJDTZCYZWKtrBIyiCTUDbO8fR5
 hvujGC2CSEcBMBfV8f4EcPnrB9cPhdrwjKS5jP4sWxUhmzdp1mct7AoA4wkGJIX7L6jn
 +cXQIDRwrInM7c4zCHxIAhSGBz/PrXuvZzkJEUO9kNwskA8tzDIkaRApkLRwxBpSSl6h
 cOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417036; x=1692021836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybHOHddZSdETsR4kLtiwqTBuOOQ6Q7i/BQT8b36uuzU=;
 b=LQZBwABoUDs5Z0OnKLnyoJfJZYXN15nWlUKnWo6ARQFDmq8CEU4reEJZWEL6mo+SEw
 gj6LwgmnYXh5rXlQvI1BTUgp5Lf9kX1ExRI3R/X51TNCJ6NcQNZghnpbfPZtJSP1S4Ff
 VLMkhMHGNeGm3Y8J7O9YJG2BL6u8OhuJ5V0RCr081vvm//MULXUqH/+O6FZYiCfOgrCG
 3/3B8oEZ7/M+3Jo0mvtcIYtp+eeaDfAe46cDzz0KDDCEHbaWBoKgYKZGTRnHDg9YPuq7
 ul+HofoKSjCQ/IQmfoFMtzr1MD4f/1MhLShzTHXKnAfMfTrSBggocUSFDkUfsj0g0vVC
 t9ow==
X-Gm-Message-State: AOJu0Yw1mblXCUxc++IO9zZfwP1KAF9PEsbIFOJWpUPhYLGsMlgm8gnz
 oy1rznr5JV5qeHoWcSRm6yaoFgKiAsyNKpPz8yg=
X-Google-Smtp-Source: AGHT+IHXX2+Y+gl7RAcx6S5V+2LkcjMParNTVptQ7fWAzjVy4DDg6n2/vxnmXxZJ1gB8Swj1PnRWVQ==
X-Received: by 2002:a1c:f60b:0:b0:3fa:991c:2af9 with SMTP id
 w11-20020a1cf60b000000b003fa991c2af9mr5969338wmc.16.1691417036081; 
 Mon, 07 Aug 2023 07:03:56 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003fbc9b9699dsm10752429wmk.45.2023.08.07.07.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:03:55 -0700 (PDT)
Date: Mon, 7 Aug 2023 15:03:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/6] target/arm/helper: Check SCR_EL3.{NSE,NS}
 encoding for AT instructions
Message-ID: <20230807140357.GA769137@myrica>
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-6-jean-philippe@linaro.org>
 <CAFEAcA-0p2UhURwgLRnUxSK8ktFsULsHz5x3pu+h80VOPBrZvQ@mail.gmail.com>
 <CAFEAcA88J5QnuoJWOsVJj4qOhDHy-P4LMo+v5UdMLOQxy=pvQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA88J5QnuoJWOsVJj4qOhDHy-P4LMo+v5UdMLOQxy=pvQA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x332.google.com
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

On Mon, Aug 07, 2023 at 10:54:05AM +0100, Peter Maydell wrote:
> On Fri, 4 Aug 2023 at 19:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > The AT instruction is UNDEFINED if the {NSE,NS} configuration is
> > > invalid. Add a function to check this on all AT instructions that apply
> > > to an EL lower than 3.
> > >
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  target/arm/helper.c | 36 +++++++++++++++++++++++++-----------
> > >  1 file changed, 25 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > index fbb03c364b..77dd80ad28 100644
> > > --- a/target/arm/helper.c
> > > +++ b/target/arm/helper.c
> > > @@ -3616,6 +3616,20 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > >  #endif /* CONFIG_TCG */
> > >  }
> > >
> > > +static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
> > > +                                     bool isread)
> > > +{
> > > +    /*
> > > +     * R_NYXTL: instruction is UNDEFINED if it applies to an Exception level
> > > +     * lower than EL3 and the combination SCR_EL3.{NSE,NS} is reserved.
> > > +     */
> > > +    if (cpu_isar_feature(aa64_rme, env_archcpu(env)) &&
> > > +        (env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
> > > +        return CP_ACCESS_TRAP;
> > > +    }
> >
> > The AArch64.AT() pseudocode and the text in the individual
> > AT insn descriptions ("When FEAT_RME is implemented, if the Effective
> > value of SCR_EL3.{NSE, NS} is a reserved value, this instruction is
> > UNDEFINED at EL3") say that this check needs an "arm_current_el(env) == 3"
> > condition too.
> 
> It's been pointed out to me that since trying to return from
> EL3 with SCR_EL3.{NSE,NS} == {1,0} is an illegal exception return,
> it's not actually possible to try to execute these insns in this
> state from any other EL than EL3. So we don't actually need
> to check for EL3 here.
> 
> QEMU's implementation of exception return is missing that
> check for illegal-exception-return on bad {NSE,NS}, though.

I can add a patch to check that exception return condition, and add a
comment here explaining that this can only happen when executing at EL3

Thanks,
Jean

