Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B77CAB2A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOM5-0002v8-BY; Mon, 16 Oct 2023 10:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsOM2-0002uT-S2
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:13:59 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsOM1-00020n-7M
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:13:58 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so7897747a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697465635; x=1698070435; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=phQxIX8T/eE5G1lpVLOkFYrKOLOKnb+r3Zm5nLLnAGo=;
 b=o5U3K77g0qa67A8YIbdB+OCk9LClRjWIkZVZLex59PHDcu5NtDtYma+BhoAFDN1Qdp
 s0Tj+jyVkTb6hjowFID/vN3hT+Cbd+aaeGaNFAbtolHg7Spzp5lFkoM9VPKCQJ+0sRNJ
 lFdQJomzY35OGA12R2lJQk8zwjlnbdGPFpinxwnoi88B7WxoYZtXgOOO9SvChX7ZsdYp
 e5FI2hflRM0MI/LJLeHJzBzd3jZ/CJI70Fv7KBqD1w7IvHuDADtB0iX8OOAchZQsYpXv
 D/S9s5uOWHAcFlM6JXK0CyoQpMcXkinYtsRfHHGzaO8QpkvTAdm+IIAKzm7u0RPXWQ/h
 tN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697465635; x=1698070435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phQxIX8T/eE5G1lpVLOkFYrKOLOKnb+r3Zm5nLLnAGo=;
 b=FG4NvM+avi0BP6AE+CkGLKwF8xQkI5P3fkwlPW+s8/EzOAco2FZTbO1PgTtTe99ntb
 RPPcm/3rdmVagppTl0rAY8HNtInRTqQLAwK3wKg4C1iUqhaQQiQz2RRDl5Akq5xHynWY
 XUPL7w2t2vdI5viE8WhDnc0VKAFqtqfbbgrZOxN6XGNI3QnPx96hT8dthrCVydbG2r4O
 AF9RIjS80JiXD9SqvQwqaOoQSjb4s16QZXPtsk9RvMStyH52sCh8TEkoWGGs0vArVxcN
 zMYaDOd+n51SwEmM/CjlHlULR8KmNcFfPKMqtYfKjnr4f49OqHyT4PCD9yghx5zFsbTg
 3+sg==
X-Gm-Message-State: AOJu0YzRTaeMpIX/u4/xhKrlvaNPHMHY/waRn4mJ2iJ7SGoFoikm97tC
 ywQ7EvboRzmvUSAWS2x1PsPGpZ2jwZXbebgXruLgWA==
X-Google-Smtp-Source: AGHT+IGfQgRkvXnnuwpRzBfBc6HA+HexF4q3cCbiWZnVG5vFM54Z1cC2b9gu6tj8TslpChD3UkpU+JAXkGW6cM68WJY=
X-Received: by 2002:a50:8adc:0:b0:53e:467c:33f1 with SMTP id
 k28-20020a508adc000000b0053e467c33f1mr6728635edk.8.1697465634909; Mon, 16 Oct
 2023 07:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <87o7h2hey5.fsf@pond.sub.org>
In-Reply-To: <87o7h2hey5.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 15:13:43 +0100
Message-ID: <CAFEAcA-LQP_dQ0mjeNe8nOtMVy22iwJt2yfG5m_f4oQjQ9ts7w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
To: Markus Armbruster <armbru@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 13 Oct 2023 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > Hello,
> >
> > This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> > back in 2019.[0]
> > We take one step (or two) further by increasing it to 5 which rejects
> > fall through comments and requires an attribute statement.
> >
> > [0]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
> >
> > The line differences are not many, but they spread all over different
> > subsystems, architectures and devices. An attempt has been made to split
> > them in cohesive patches to aid post-RFC review. Part of the RFC is to
> > determine whether these patch divisions needs improvement.
> >
> > Main questions this RFC poses
> > =============================
> >
> > - Is this change desirable and net-positive.
>
> Unwanted fallthrough is an easy mistake to make, and
> -Wimplicit-fallthrough=N helps avoid it.  The question is how far up we
> need to push N.  Right now we're at N=2.  Has unwanted fallthrough been
> a problem?

Mmm, this is my opinion I think. We have a mechanism for
catching "forgot the 'break'" already (our =2 setting) and
a way to say "intentional" in a fairly natural way (add the
comment). Does pushing N up any further gain us anything
except a load of churn?

Also, the compiler is not the only thing that processes our
code: Coverity also looks for "unexpected fallthrough" issues,
so if we wanted to switch away from our current practice we
should check whether what we're switching to is an idiom
that Coverity recognises.

thanks
-- PMM

