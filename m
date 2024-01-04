Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F29824617
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:25:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQX8-0003WJ-KC; Thu, 04 Jan 2024 11:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQWw-0003Ti-KG
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:25:14 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQWq-00076O-Be
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:25:11 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cce6bb9b48so8322531fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704385505; x=1704990305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdc5ZyGzqm0akkLt7bQ4+HgnyTVp3YFbEgfv/BjOLgQ=;
 b=CrkjYyjk8HfhRNLXaw7qJ93wgNLkucNX5s+AiZiAKrjRdtKHGHCcCtiAR2lOsM9urb
 I5g4Bh3mgxsfo8U+73kezy/m8D/2PA1K43ETKQ5r9Ii83sVpqSCQ03rwvHYlfXPfpnYV
 KGS/oMi7EA0izQGI1O/Omb0bpgtFZS7D9KEuxI1cxAftc8IVSLJtgOg3a1DgYgk+2TaA
 3gmo3sD0HlpB1NP+xDLFKmoboCnV+rcgTo+D54tEM7vqaG5pATTTCVesg4//i9UGmz0L
 Ga7aSqPF+Z3YjtyhGdhMyvFernUcGozgjGrCZCZEzlGPWQ3EsSbimm92sEuaBsc2Jn4e
 uLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385505; x=1704990305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hdc5ZyGzqm0akkLt7bQ4+HgnyTVp3YFbEgfv/BjOLgQ=;
 b=duXfDx1QlKcFGTGS5AgLDQkSlTiAbp4lK4npglKlwznKcWlkTmXGmapyHhftdOctD1
 EerrNwjdzWJAIg1bMvHPjU5VGcRl8MEqnjOT0uMpOumv16ExFXS7luvPYnDK77Y+ium9
 qmT/BkxTPPgrkbkt8EpAS1VoKh+W2YE7+rCAj2B68wpfNk+3Y3/YE2Vy94QkH5z82sWH
 mn4o2wtVvnODZlEK5c4wtVfadYcrURdjzTI35/TBO0Mqh7TcCkR1kF8r+5dl7o8HvX0f
 CxxbOrAFiOvBLwKWXKsoFhN20WUplf75QPvisg/PQCr7BapWjXQLRbnqO5/lHn8perMe
 L2Ig==
X-Gm-Message-State: AOJu0YzjkFMZeTBPDNv2iaep0lsJHdh3jTbAfMiiSdjtrKSyOqdHwfKz
 hieRpPBE8iv5JG782mLt3dfI4OQXwNXMtEOrKEOxzZlbterDv/h4diX5M3At
X-Google-Smtp-Source: AGHT+IH8tbW+7+avQdhybH6G4yzU/SnVSgRHiyZifWT1OhE51NnlTvXRQjaHFQ3Z+t5UVx2f7wtLjy4RXfTHUhMMXKY=
X-Received: by 2002:a2e:a27a:0:b0:2cd:278b:fe5f with SMTP id
 k26-20020a2ea27a000000b002cd278bfe5fmr218466ljm.99.1704385505576; Thu, 04 Jan
 2024 08:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-30-peter.maydell@linaro.org>
 <bf5e3af4-75a0-4398-8a54-eb8bdf641eb6@linaro.org>
In-Reply-To: <bf5e3af4-75a0-4398-8a54-eb8bdf641eb6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 16:24:54 +0000
Message-ID: <CAFEAcA8nRWyOqqZZ1iq7uB3BYsnFpZdad-FXvzK_w1RBnQfGVA@mail.gmail.com>
Subject: Re: [PATCH 29/35] target/arm: Mark up VNCR offsets (offsets
 0x100..0x160)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Thu, 28 Dec 2023 at 00:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/18/23 22:32, Peter Maydell wrote:
> > Mark up the cpreginfo structs to indicate offsets for system
> > registers from VNCR_EL2, as defined in table D8-66 in rule R_CSRPQ in
> > the Arm ARM.  This commit covers offsets 0x100 to 0x160.
> >
> > Many (but not all) of the registers in this range have _EL12 aliases,
> > and the slot in memory is shared between the _EL12 version of the
> > register and the _EL1 version.  Where we programmatically generate
> > the regdef for the _EL12 register, arrange that its
> > nv2_redirect_offset is set up correctly to do this.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/debug_helper.c |  1 +
> >   target/arm/helper.c       | 22 ++++++++++++++++++++++
> >   2 files changed, 23 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +        /*
> > +         * If the _EL1 register is redirected to memory by FEAT_NV2,
> > +         * then it shares the offset with the _EL12 register,
> > +         * and which one is redirected depends on HCR_EL2.NV1.
> > +         */
> > +        if (new_reg->nv2_redirect_offset) {
> > +            assert(new_reg->nv2_redirect_offset & NV2_REDIR_NV1);
> > +            new_reg->nv2_redirect_offset &= ~NV2_REDIR_NV1;
> > +            new_reg->nv2_redirect_offset |= NV2_REDIR_NO_NV1;
> > +        }
>
> Could use xor to flip both bits at once.

Could do, but explicit clear-then-set seems a bit more
readable to me, and since this is only happening once at
startup there's no efficiency concern here.

thanks
-- PMM

