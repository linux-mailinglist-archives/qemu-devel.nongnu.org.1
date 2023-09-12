Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42A79D10C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2UF-00035z-BZ; Tue, 12 Sep 2023 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg2UD-00035C-2S
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:27:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg2UA-0002AY-Mm
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:27:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso5059964f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694521637; x=1695126437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a+QJ6aLCYJHfzYSh+WK/aIRaGCoM4QdlNhV2yGIGdAg=;
 b=lI+pE8NUnoxtLrGFjMEYBs03Ix1zq3lgSiOMtxWE3QvWbunzPRiEda0CgnlYq0qAbO
 39qh113X8Y3gTx/JePuGLAqutEQVX+dYqfiw7rW7qwR1haXnjml/XXlk/kCcyRWnhiM3
 5XZTMzz9IC/yd0dmEfKaQFufovlq9pf1nAdGF26LyUAY0gCGv3b2fhTb6cXXQqsl6yxj
 u0nQQEvZ/3J96c3C9zAMkiimrMjtvmybGFeINi3lucPYHO56u0aZktZBhsC3L3YYYyKz
 WM7Uc2tyMSyytIJibyopr9EfEmKgH1MnNpvl6p3edJfrAe3Nwb5y5m1sjk02DrF+ZeLY
 Pstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694521637; x=1695126437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+QJ6aLCYJHfzYSh+WK/aIRaGCoM4QdlNhV2yGIGdAg=;
 b=KFL4s1KRSr85HdJ4eV7d4bOTzZSqDq+C1a7ZqOj7AdbXTfIqf28XuCpHPwjpM/3bpo
 tdRnGsbI4tZqqE/QlBLM5G556lyjoxpUP0K9EiU1HN6LdZhua0OFwc/4y3a8SAM5aHUO
 p9sQhdJ2nu9HTrFPSxheegOISEOJLr98C6mKOodXyADEmLtpvYYCukBLGvSiwQVnC4ss
 Zzb0JcFAzK5f6+PJp819AmLt/z8Jxrz9/NJ9WGnLtUeNUix4SAcQeOEn3FkjD3rKuEIP
 tNtJHvsbAgC62FDqPGMJU5LHHn7Dl+D4PmjCBAm+yKU6etG+xOZ7oubC7zxiiQn3/h7t
 7P+w==
X-Gm-Message-State: AOJu0Yx6oQbe0HXKIfYi96jZoxpuSOuC0wSxuchWpB2xgt23XtSHRgHm
 dtnQTma8q11cCojy0SWLyg38qaH08rFfZJMF4TrFaQ==
X-Google-Smtp-Source: AGHT+IE7d34oCkjFJt4Gv1KuLzZRvX8Jmzx2z9RIMXDdOZm2E6TYFsQjSqc+w9pz5u1kadJp5fxRc+iZj23dtSVVMks=
X-Received: by 2002:a5d:4ac3:0:b0:31a:e6c2:7705 with SMTP id
 y3-20020a5d4ac3000000b0031ae6c27705mr10915143wrs.50.1694521636880; Tue, 12
 Sep 2023 05:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-14-peter.maydell@linaro.org>
 <28b64da1-6c0f-012e-1af9-ac27a8581f6f@linaro.org>
In-Reply-To: <28b64da1-6c0f-012e-1af9-ac27a8581f6f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 13:27:05 +0100
Message-ID: <CAFEAcA89pF2mw7ePuVOsee1n8+L8PMuBSKEYg-gCNLd2gLFKoA@mail.gmail.com>
Subject: Re: [PATCH 13/14] target/arm: Implement the CPY* instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

On Sat, 9 Sept 2023 at 18:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/7/23 09:03, Peter Maydell wrote:
> > +void HELPER(cpyp)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
> > +                  uint32_t rdesc, uint32_t move)
> > +{
> > +    int rd = mops_destreg(syndrome);
> > +    int rs = mops_srcreg(syndrome);
> > +    int rn = mops_sizereg(syndrome);
> > +    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
> > +    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
> > +    bool forwards = true;
> > +    uintptr_t ra = GETPC();
> > +    uint64_t toaddr = env->xregs[rd];
> > +    uint64_t fromaddr = env->xregs[rs];
> > +    uint64_t copysize = env->xregs[rn];
> > +    uint64_t stagecopysize, step;
> > +
> > +    check_mops_enabled(env, ra);
> > +
> > +    if (copysize > 0x007FFFFFFFFFFFFFULL) {
> > +        copysize = 0x007FFFFFFFFFFFFFULL;
> > +    }
>
> CPYFP does not have the same saturation as CPYP.
>
> Again, you would do better if 'move' was a parameter for an inline, so that the tests can
> be folded away.
>
> > +void HELPER(cpym)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
> > +                  uint32_t rdesc, uint32_t move)
> > +{
> > +    /* Main: we choose to copy until less than a page remaining */
> > +    CPUState *cs = env_cpu(env);
> > +    int rd = mops_destreg(syndrome);
> > +    int rs = mops_srcreg(syndrome);
> > +    int rn = mops_sizereg(syndrome);
> > +    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
> > +    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
> > +    uintptr_t ra = GETPC();
> > +    bool forwards;
> > +    uint64_t toaddr, fromaddr, copysize, step;
> > +
> > +    check_mops_enabled(env, ra);
> > +
> > +    /* We choose to NOP out "no data to copy" before consistency checks */
> > +    if (env->xregs[rn] == 0) {
> > +        return;
> > +    }
> > +
> > +    check_mops_wrong_option(env, syndrome, ra);
> > +
> > +    if ((int64_t)env->xregs[rn] < 0) {
> > +        forwards = true;
> > +        toaddr = env->xregs[rd] + env->xregs[rn];
> > +        fromaddr = env->xregs[rs] + env->xregs[rn];
> > +        copysize = -env->xregs[rn];
> > +    } else {
> > +        forwards = false;
> > +        copysize = env->xregs[rn];
> > +        /* This toaddr and fromaddr point to the *last* byte to copy */
> > +        toaddr = env->xregs[rd] + copysize - 1;
> > +        fromaddr = env->xregs[rs] + copysize - 1;
> > +    }
>
> You're passing 'move' but not using it.  I would have expected that here.

Whoops. You can't tell the difference for correct guest code,
because CPYFP will always set up Xn so that it is negative,
but yes, CPYFM and CPYFE should be forwards always.

thanks
-- PMM

