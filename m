Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3521710C7C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AVI-0001bQ-Rp; Thu, 25 May 2023 08:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2AVF-0001aw-Jw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:55:38 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2AVD-0004OX-Qj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:55:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51426347bd2so3278739a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685019333; x=1687611333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnmdK1okFEDTpG2HnSm1Ma2k5nLE93zVWkO2eo3JDt8=;
 b=i1ThRSoi4Pi+lk6otkvkqL1fGzBoQz6m1oGgKy3ksdPU9WJB9eCybPET9Ycds1ul/H
 fcviK/R5nfIKLYCSuBcTLwY3EjEdzxd1G+aykY5+6TssPUmTmdiGmwL6a0l9lVHgnMLJ
 Z0VmsUPeXrKVtTeGc/KTwySW56w0m137BqbZfZUywrljPchGHv11Vya+CdzFyggbHLDT
 DIRD0aVYn6TMi9kMVK5E4z37xZFQCOwcQk7SN4Pxtpx/NqhqrXLRasKCoXicKSoDGUWj
 TLLkS+teJSJlLNDvcdWs0EFoOggO6oHSlxdNHb+KvJeq9ZAPW1yefHIflyLnnvsJLuZI
 QkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019333; x=1687611333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnmdK1okFEDTpG2HnSm1Ma2k5nLE93zVWkO2eo3JDt8=;
 b=DbsRqO/+OMjXhNcEiol6F2cHnySCc0HZP8j3jqnaZp08N/NYOBRgR1NqgtOujjSdGJ
 lt59vlCBCmYTefNtjCj2jlOe26TnznuSk4asU+HMZ5o0GDBgEqCeAwJZ9DV/pEEt6fPp
 bTSTelOKo2bHAzAZxIjH4ltEBtWNSw5jRQMzxLoxSPqll83Zo1lqvzhbeNzBaLpk6AGt
 uDz0nnMyM7YVlLFm1abzOrUvwdjperm8HCbcD5ObURI4cnwq1jFwYS7SlEMq6iwjnduy
 ppFV2NHswCWerKD5Shp8kwMPLL2rEADDNEdIwrq1X4tQPuL6FmV6HomzSvUDlDI3Edqv
 25Kw==
X-Gm-Message-State: AC+VfDxy1zbzs/bgBzoQ3ESan65xPlQa7t4ryfVaiYJ1jadQGSkVxp9g
 EMgQJ2noRIXAXipbcvoJ4U0Fo8Y/3lcdGrTASEeLXA==
X-Google-Smtp-Source: ACHHUZ7RzGG6CIfkdRteLHTtjZLPLrU/LVW6L4fMWA2d28PeDuS2HyfAsvAcm3e7uzxYqr0SXI0ADdqACo8y1Nrx9XA=
X-Received: by 2002:aa7:d1c8:0:b0:50d:89a3:d909 with SMTP id
 g8-20020aa7d1c8000000b0050d89a3d909mr4186530edp.30.1685019333545; Thu, 25 May
 2023 05:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-10-philmd@linaro.org>
 <CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com>
 <87zg5stvyi.fsf@linaro.org>
In-Reply-To: <87zg5stvyi.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 13:55:22 +0100
Message-ID: <CAFEAcA9EYLWnm6kEZGJn=Ah_wy1oE+8u0bZuVPq8=wTxtUo_Hw@mail.gmail.com>
Subject: Re: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 25 May 2023 at 13:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 22 May 2023 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Do not transmit characters when UART or transmitter are disabled.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > Last time somebody tried to add checks on the tx/rx enable bits
> > for the PL011 it broke 'make check' because the hand-rolled
> > UART code in boot-serial-test and migration-test doesn't
> > set up the UART control register strictly correctly:
> >
> > https://lore.kernel.org/qemu-devel/CAFEAcA8ZDmjP7G0eVpxcB1jiSGarZAbqPV0=
xr5WquR213mBUBg@mail.gmail.com/
> >
> > Given that imposing these checks doesn't help anything
> > much and might break naive bare-metal tested-only-on-QEMU
> > code, is it worthwhile ?
>
> Surely we aim to be a correct model so the fix should be in our naive
> and incorrect code?

In our own test suites, sure -- we should probably fix that
even if we don't change the PL011 model to require it.
But if we let this kind of thing get past us in our own testsuite,
it suggests there's probably a lot of similar naive code out
there in the world -- these Arm boards with PL011s are pretty
commonly used for "my first bare metal assembly program" stuff
and there's a lot of cargo-culting of how to do things like
serial output, and programs that were never tested on any
real hardware...

thanks
-- PMM

