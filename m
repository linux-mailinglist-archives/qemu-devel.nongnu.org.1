Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF675FA06
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNwi8-0004bl-UK; Mon, 24 Jul 2023 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNwi6-0004bP-Gz
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:38:54 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNwi4-00008d-NC
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:38:54 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fdd31bf179so6581615e87.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690209530; x=1690814330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjRECCROJ6tI+ugYd62zH/whZz+wrT5OfIbvUn+09Fo=;
 b=Oc83NmLVRovWt2DGmHhDEpTg9NvepyBewEgAP+/JoDvPVDNQ3PLO2FZnSIQKJOk+hT
 EIZ3Vg99XE6oaQk/D5IequRP0cJbxjOAcNCt8X38D7+F/fByPsO0BBGAuLXfsQEQkiUf
 gxxzHke4JyMuHH4pCS2R+Ze2qJ55i07TEPPNM3V7NgaFyLStC533Kk7rck+rAJytQoHr
 hP7asJ6t4t11lcSm1soVte6BwJsD6ZMi8qQ+IE+0nXmF4EMd2BtP5TS02zE9aV2mLktV
 Z7heWO6rF6x5VSKf2BOXYUx3F3qG6KtCGkMC9izQlE/e/H5l/w0e+LPBpx31XxUaRfxn
 Y0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690209530; x=1690814330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjRECCROJ6tI+ugYd62zH/whZz+wrT5OfIbvUn+09Fo=;
 b=Twl/1Pof+eGHF/LHHunmhH3I19obPjfAid85fHOAhCzewDvIniNG5u1V3b6rejRT3O
 cj00Mv0cxG9LLDFHyT9cXZd7M2u8th370CH8adNfhMozjVCIjTsvEAtCQi2omLSRM+jZ
 Ex66zeiI2NzWURYdDoUcrSP6tTGhdcMiWZbXqBBmeT7uSwwd2G10QI7l+uerH8weuMAL
 RTgFW0FwSRDoNt6rfPYuV6MzW3pcfP/NHZlpf/4iLiMoWoi+aWl2wwDwvfx2oeKSFGDV
 i3jLTa4X17j1DHi1pGovSQiMmSZn3SEaInhlR3KoQyosF8F60JyfGCDLFHCcj5VR1PWw
 VEkg==
X-Gm-Message-State: ABy/qLYH3oQDgKkhsM4QhErQHXoD0IwwvU43ZtIgGcs6q0ZxpEUrgNbI
 +i1gOZ21HiqWCLCLlL37TPRtzUQNTcGNfq9ADiAQKw==
X-Google-Smtp-Source: APBJJlFfgJPLTwZkmRDv6fcmEf5DeAykdw+iTQHk+gxKt4CnUNAcJFX+b1x+J+8XNdQp+mFdKeB4N/xKC7TYehfpDmw=
X-Received: by 2002:a05:6512:128a:b0:4fb:74da:989a with SMTP id
 u10-20020a056512128a00b004fb74da989amr6400161lfs.3.1690209529992; Mon, 24 Jul
 2023 07:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-7-peter.maydell@linaro.org>
 <230dd650-846f-7105-7add-43fa2d03dad7@linaro.org>
 <CAFEAcA---QdS2vo3iAivTdBVAtFz5qOaC9Mdy2AhvXWGyaO7BQ@mail.gmail.com>
In-Reply-To: <CAFEAcA---QdS2vo3iAivTdBVAtFz5qOaC9Mdy2AhvXWGyaO7BQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 15:38:39 +0100
Message-ID: <CAFEAcA-za6cJvahgzNMXOZrMhW4REOfZ6HKJh5GwwutJDPmbzA@mail.gmail.com>
Subject: Re: [PATCH 06/14] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Mon, 24 Jul 2023 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 23 Jul 2023 at 16:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 7/14/23 16:46, Peter Maydell wrote:
> > > arm_hcr_el2_eff_secstate() takes a bool secure, which it uses to
> > > determine whether EL2 is enabled in the current security state.
> > > With the advent of FEAT_RME this is no longer sufficient, because
> > > EL2 can be enabled for Secure state but not for Root, and both
> > > of those will pass 'secure == true' in the callsites in ptw.c.
> > >
> > > As it happens in all of our callsites in ptw.c we either avoid making
> > > the call or else avoid using the returned value if we're doing a
> > > translation for Root, so this is not a behaviour change even if the
> > > experimental FEAT_RME is enabled.  But it is less confusing in the
> > > ptw.c code if we avoid the use of a bool secure that duplicates some
> > > of the information in the ArmSecuritySpace argument.
> > >
> > > Make arm_hcr_el2_eff_secstate() take an ARMSecuritySpace argument
> > > instead.
> > >
> > > Note that since arm_hcr_el2_eff() uses the return value from
> > > arm_security_space_below_el3() for the 'space' argument, its
> > > behaviour does not change even when at EL3 (Root security state) and
> > > it continues to tell you what EL2 would be if you were in it.
> > >
> > > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > > ---
> > >   target/arm/cpu.h    |  2 +-
> > >   target/arm/helper.c |  7 ++++---
> > >   target/arm/ptw.c    | 13 +++++--------
> > >   3 files changed, 10 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > index 4d6c0f95d59..3743a9e2f8a 100644
> > > --- a/target/arm/cpu.h
> > > +++ b/target/arm/cpu.h
> > > @@ -2555,7 +2555,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
> > >    * "for all purposes other than a direct read or write access of HCR_EL2."
> > >    * Not included here is HCR_RW.
> > >    */
> > > -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure);
> > > +uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
> > >   uint64_t arm_hcr_el2_eff(CPUARMState *env);
> > >   uint64_t arm_hcrx_el2_eff(CPUARMState *env);
> > >
> > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > index d08c058e424..1e45fdb47c9 100644
> > > --- a/target/arm/helper.c
> > > +++ b/target/arm/helper.c
> > > @@ -5731,11 +5731,12 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
> > >    * Bits that are not included here:
> > >    * RW       (read from SCR_EL3.RW as needed)
> > >    */
> > > -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure)
> > > +uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
> > >   {
> > >       uint64_t ret = env->cp15.hcr_el2;
> > >
> > > -    if (!arm_is_el2_enabled_secstate(env, secure)) {
> > > +    if (space == ARMSS_Root ||
> > > +        !arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
> > >           /*
> >
> > This is confusing, as without any larger context it certainly looks wrong.
>
> Does it? HCR_EL2 says "behaves as 0 if EL2 is not enabled in the
> current Security state". If the current Security state is Root then
> EL2 isn't enabled (because there's no such thing as EL2 Root), so the
> function should return 0, shouldn't it?

I guess there's an argument that what the spec really means is
"the security state described by the current effective value
of SCR_EL3.{NSE,NS}" (to steal language from the docs of the
AT operations), though. (If we wanted to implement that we could
assert(space != ARMSS_Root) and make sure we didn't call it
in that case.) I'll think about it...

-- PMM

