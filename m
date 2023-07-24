Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CB75F8B1
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvpc-00025X-UK; Mon, 24 Jul 2023 09:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvpX-000220-99
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:42:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvpS-0002Wq-UV
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:42:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so11257587a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690206143; x=1690810943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+R6lerAYT645kWXDBPJglBoizZ56cPHfkf3Fy5CDRxI=;
 b=n/CbVaJACn32ytBJxbsRusDa1BLJcxgq/ghGBPOLgpnMEvvaaQv3ru+PJyWy9uABVT
 tbeZjzi1SiH0vAwiDZV6MjgMb+KAsEoFb+/xlQG5vNkI61XtCG3158f9Tv0wjqYHJ584
 a3MvcxJSz/Gdv8ud1sR/Ee+oqxgoQQ012K680SGuH8gF2xdabS4Pd1cQHH+4Ulihu/3R
 mkPtbrtj2pOs2DMEymCFI5ldrWzJ8FUKsiOcVB9gcAc8mu3PCHiWY5uNhhNnb0P96/pn
 HQgDAJ9+2ByqGwpMgJe1GPmV/4ZJjih7KQnVWiuA/bX4k2s+rUdjq734c8hpJY9bxHQy
 CCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690206143; x=1690810943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+R6lerAYT645kWXDBPJglBoizZ56cPHfkf3Fy5CDRxI=;
 b=h58ZRdKis5AKmp3P7yG1EtaPAuPz72XRNrm6NNeKLbZgWZ8iWp40EuwAp1Ga0cIkv9
 EiV/Rh7VFLSYVTDWweTIfiRP1AxbTBaQ6oo3VwRxQAHcWUkm0XmiQ8Nfive91gyjBIpD
 yi8slRWKGOtqKdBDoTKp2OaiAU0awE7cF70wNAwnlHuwRXnTEsuefu7fN0n8uXvSd5qo
 bEMLDnAwgTRfgp+HjV7nzaMt0NM77jgbad52W5F/se50C4+Si+u6fdTmzgWNKB9iIcFh
 +0CHYOCcam0wKJHtcAFmdjn606kJlCRcGTMTobYXzX71d03fLI/vEenaz0jm9GfgnS3O
 AsQg==
X-Gm-Message-State: ABy/qLZDQYQ7VkikqrMfjmRGa1RlEUrlDF7lpQHiicnFc/is5QONh54O
 japa7Bfw4rX+1mYUrtxJMD+wmhTV8McJpr0O7B27cQ==
X-Google-Smtp-Source: APBJJlGt+hLSoGSueZelmnuAlnNZTTbzB4/HBgebkNrmsxiT/y5zuN0EwgI1gZcY3W2Ct/YAu+jPbdtlo+4++kjOTdY=
X-Received: by 2002:a50:ec93:0:b0:522:2add:5841 with SMTP id
 e19-20020a50ec93000000b005222add5841mr3632712edr.7.1690206142724; Mon, 24 Jul
 2023 06:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-7-peter.maydell@linaro.org>
 <230dd650-846f-7105-7add-43fa2d03dad7@linaro.org>
In-Reply-To: <230dd650-846f-7105-7add-43fa2d03dad7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:42:11 +0100
Message-ID: <CAFEAcA---QdS2vo3iAivTdBVAtFz5qOaC9Mdy2AhvXWGyaO7BQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] target/arm/ptw: Pass an ARMSecuritySpace to
 arm_hcr_el2_eff_secstate()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, 23 Jul 2023 at 16:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/14/23 16:46, Peter Maydell wrote:
> > arm_hcr_el2_eff_secstate() takes a bool secure, which it uses to
> > determine whether EL2 is enabled in the current security state.
> > With the advent of FEAT_RME this is no longer sufficient, because
> > EL2 can be enabled for Secure state but not for Root, and both
> > of those will pass 'secure == true' in the callsites in ptw.c.
> >
> > As it happens in all of our callsites in ptw.c we either avoid making
> > the call or else avoid using the returned value if we're doing a
> > translation for Root, so this is not a behaviour change even if the
> > experimental FEAT_RME is enabled.  But it is less confusing in the
> > ptw.c code if we avoid the use of a bool secure that duplicates some
> > of the information in the ArmSecuritySpace argument.
> >
> > Make arm_hcr_el2_eff_secstate() take an ARMSecuritySpace argument
> > instead.
> >
> > Note that since arm_hcr_el2_eff() uses the return value from
> > arm_security_space_below_el3() for the 'space' argument, its
> > behaviour does not change even when at EL3 (Root security state) and
> > it continues to tell you what EL2 would be if you were in it.
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> >   target/arm/cpu.h    |  2 +-
> >   target/arm/helper.c |  7 ++++---
> >   target/arm/ptw.c    | 13 +++++--------
> >   3 files changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 4d6c0f95d59..3743a9e2f8a 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -2555,7 +2555,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
> >    * "for all purposes other than a direct read or write access of HCR_EL2."
> >    * Not included here is HCR_RW.
> >    */
> > -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure);
> > +uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
> >   uint64_t arm_hcr_el2_eff(CPUARMState *env);
> >   uint64_t arm_hcrx_el2_eff(CPUARMState *env);
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index d08c058e424..1e45fdb47c9 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5731,11 +5731,12 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
> >    * Bits that are not included here:
> >    * RW       (read from SCR_EL3.RW as needed)
> >    */
> > -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, bool secure)
> > +uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
> >   {
> >       uint64_t ret = env->cp15.hcr_el2;
> >
> > -    if (!arm_is_el2_enabled_secstate(env, secure)) {
> > +    if (space == ARMSS_Root ||
> > +        !arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
> >           /*
>
> This is confusing, as without any larger context it certainly looks wrong.

Does it? HCR_EL2 says "behaves as 0 if EL2 is not enabled in the
current Security state". If the current Security state is Root then
EL2 isn't enabled (because there's no such thing as EL2 Root), so the
function should return 0, shouldn't it?

I did think about pushing the ARMSecuritySpace down further
so arm_is_el2_enabled_secstate() also called it.

thanks
-- PMM

