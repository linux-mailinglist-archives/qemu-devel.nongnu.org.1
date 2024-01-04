Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFF8245A2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:01:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQ8D-0000Tn-JF; Thu, 04 Jan 2024 10:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQ8B-0000Qu-5L
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:59:39 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQ89-00073p-Ee
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:59:38 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5571b26fda8so75162a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704383975; x=1704988775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zsO3hJlRvieRtzgzFWW/di8vjLeFOct1kXD4EepUEdg=;
 b=dwoI7aGZkLFcraipuRdXjHZSJMlfTMqIfnpKN5rCk5fxeLlCW2AzDfYwkyr4IeWgMS
 mbHDT+7cO6L4dfNk7A6uEHvr67HbUmbaZ3Aj/wEupfZOqKbWFIFT9pb0KiWPRW6W9spe
 DkX+QaspRRpuTJ3ZDZxmKhVBw0bHYqRLfvqLp8HMsYZkh9oDYk8z790+AxXhzy41kD0P
 EMjRZz0TvHOKpETR9EvUyV/xQBfBp7ZllPn0mfbgGXBTWJZwshR6VqyUQNEQaDVof/6h
 Oxm7rR3HxbSbROBkCRBnclqZmmdnmbX4S0pwicAhEQaRXXa/F/B//xeNcr2jSPtkvBWd
 vZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704383975; x=1704988775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zsO3hJlRvieRtzgzFWW/di8vjLeFOct1kXD4EepUEdg=;
 b=s9yW0rX68PasKTE9+0lE8aZ8hhXd7OHbKFkHLfLvJau/djbb4+cE2Fjpb3/9kYnjhL
 wVFunY4GirGEqjYFOWWpQwghKdhH8aHoGblRrhdu1Eng/DaJGyFTlrVMYWSS5AYIRWrX
 5x7c8oL3JExzhQcYgC2gUM6ZXfM2qnOC7E6zhL/xmM58frQaLzTMe4rxYv/pAQN8QWer
 HFzsAfuUStYy/CMV9y5HscjkGNuKqK/41uYliNuOgT8W7nJZjl7PbHt/L6MOJa3bBX2I
 6QLMFRUJPjol69sEB35XNkcep2zgM5wX7z3NcyvLZ82P9TdF1UfQ9AERK53fZWx6Tsu8
 bXpw==
X-Gm-Message-State: AOJu0YwOiZUZ66qGg+9x6ww+HOeEez5iCzT8I/Zu3UqxeI7nmh9YeQ8S
 tPJR4HBOhujdrzra8OvdfpkWP09mhNzrjGPecsDDayEkGbNZq6YsVX83citB
X-Google-Smtp-Source: AGHT+IGbOMP3er8kn5LBs4ifKBtJf0E8/bzvWoDAI2bwaUizZD3yOQox/XDzHPX2uEGiqYAb8CQl4LGPrITUvFC+m28=
X-Received: by 2002:a50:8e19:0:b0:554:89f6:5802 with SMTP id
 25-20020a508e19000000b0055489f65802mr462752edw.63.1704383975056; Thu, 04 Jan
 2024 07:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-18-peter.maydell@linaro.org>
 <34263e7c-1419-4680-89ef-dd4fd28c1a88@linaro.org>
In-Reply-To: <34263e7c-1419-4680-89ef-dd4fd28c1a88@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 15:59:23 +0000
Message-ID: <CAFEAcA_z_Rfnb1jR8EhR9NjMjvtP=-OKo_49rC1D+L8RE5qWNA@mail.gmail.com>
Subject: Re: [PATCH 17/35] target/arm: Always use arm_pan_enabled() when
 checking if PAN is enabled
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 27 Dec 2023 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/18/23 22:32, Peter Maydell wrote:
> > Currently the code in target/arm/helper.c mostly checks the PAN bits
> > in env->pstate or env->uncached_cpsr directly when it wants to know
> > if PAN is enabled, because in most callsites we know whether we are
> > in AArch64 or AArch32. We do have an arm_pan_enabled() function, but
> > we only use it in a few places where the code might run in either an
> > AArch32 or AArch64 context.
> >
> > For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
> > even when the PSTATE.PAN bit is set, the "is PAN enabled" test
> > becomes more complicated. Make all places that check for PAN use
> > arm_pan_enabled(), so we have a place to put the FEAT_NV test.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/helper.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 3270fb11049..4b0e46cfaae 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -263,6 +263,15 @@ void init_cpreg_list(ARMCPU *cpu)
> >       g_list_free(keys);
> >   }
> >
> > +static bool arm_pan_enabled(CPUARMState *env)
> > +{
> > +    if (is_a64(env)) {
> > +        return env->pstate & PSTATE_PAN;
> > +    } else {
> > +        return env->uncached_cpsr & CPSR_PAN;
> > +    }
> > +}
>
> Worth splitting out helpers aa{32,64}_pan_enabled to avoid the is_a64 check when context
> dictates?

Doesn't really seem worthwhile to me -- we only know this
for a couple of subcases of AT instructions, which aren't
all that common in guest execution, and the cost of
is_a64() is going to be completely swamped by the cost
of actually doing the address translation...

thanks
-- PMM

