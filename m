Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580E81354A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 16:52:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDnzr-0003xp-6I; Thu, 14 Dec 2023 10:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDnzp-0003xg-6q
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:51:33 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDnzm-0005qZ-Fn
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 10:51:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c5ed26cf6so10492142a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702569089; x=1703173889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVO1dTWpsQbiPDzKjaeM+Zz+x+K4cGsI499qTDUGVIE=;
 b=v/K3J4ePPbwBqD/ZHgo4xO7DEYhJpK91JqVjhm4UAvKQrYy7apG28cP6uPPkeUZ0G3
 HuI6LPqdqdxlDnZ6oVmAP/1wTaNl4N3mrFvusFZ2SJxW3ZykhKwvPxUfXMS/JMRV6+oL
 KtITnuqVf+WJJPVLU5HyK4jxVFCezPS8TChzBB+4+m5SmHPV9ygzTxJVHOtGwK/XbHEL
 Sm1U7fJvFgePc06rTGUx2qFZusD4RxHMtstTh0Sl06IXgI93SWE8qwBzMHRnYRh0NE3C
 vGNqIzjKfUjiTTl2etlasq0K9Kr60CSRBd6dveA4ivtidav7yDnB0jNRzPZ81Ivp+BHg
 YunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702569089; x=1703173889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVO1dTWpsQbiPDzKjaeM+Zz+x+K4cGsI499qTDUGVIE=;
 b=UoyiSekOEUTBWkSVA1yxufKz1RCAc7uyvvBgiB6HQkA1cNtTpxvUkwjlyCMOViiN5o
 fkQWXZsq/4o5N37YEBuYjAXtdDWuN6+lUN6/GxboKomjvr40MRHpOpgkp5GM4MlCz6ul
 l2JQzmm87wVrMghpkqbErDlug/XBrrj5k+UB9rs8I3zu6P35L9HosB62JEwrtsp5430F
 IRh5vxbze5QbS/8Twd5v64BKW8tgK9niaDJVFwOMbXcT69fJXCHsxywkFfMBO5jNrKN/
 4VcLA1Qj/Lh44Sh2u65VS2lpfkFSQfLXGu9gpnjjo8i8JAcGdLm0ykvNGVKpH/9CJFHJ
 xolA==
X-Gm-Message-State: AOJu0Yw64gZoeaeP7PWCP06MNvkaWZR4bGDatEwBP1pCQ0844sgX6jL4
 IaamFeTEUEkrdfMwLJXM9dKs76XtdIbD3wNoQVdc8A==
X-Google-Smtp-Source: AGHT+IF2OccqX3hjBTKhWhhD04OEfK8d4U6HnXCt0UPgMImfWEBrPpYjv1ZksuIbvPjwTeiBjdfsFZ6j0c7bd7+/wG8=
X-Received: by 2002:a50:d4de:0:b0:552:231d:ac84 with SMTP id
 e30-20020a50d4de000000b00552231dac84mr1432606edj.79.1702569088889; Thu, 14
 Dec 2023 07:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20231127170823.589863-1-peter.maydell@linaro.org>
 <20231127170823.589863-3-peter.maydell@linaro.org>
 <ceb50d7c-16ed-41cf-bc51-3a47cb34d348@tls.msk.ru>
In-Reply-To: <ceb50d7c-16ed-41cf-bc51-3a47cb34d348@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 15:51:18 +0000
Message-ID: <CAFEAcA9BnxOy0UBhCxBLjxM3BtAuV7j2oK448Vo988REuAAJTg@mail.gmail.com>
Subject: Re: [PULL 02/13] target/arm: Handle overflow in calculation of next
 timer tick
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 14 Dec 2023 at 08:20, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 27.11.2023 20:08, Peter Maydell:
> > In commit edac4d8a168 back in 2015 when we added support for
> > the virtual timer offset CNTVOFF_EL2, we didn't correctly update
> > the timer-recalculation code that figures out when the timer
> > interrupt is next going to change state. We got it wrong in
> > two ways:
> >   * for the 0->1 transition, we didn't notice that gt->cval + offset
> >     can overflow a uint64_t
> >   * for the 1->0 transition, we didn't notice that the transition
> >     might now happen before the count rolls over, if offset > count
> >
> > In the former case, we end up trying to set the next interrupt
> > for a time in the past, which results in QEMU hanging as the
> > timer fires continuously.
> >
> > In the latter case, we would fail to update the interrupt
> > status when we are supposed to.
> >
> > Fix the calculations in both cases.
> >
> > The test case is Alex Benn=C3=A9e's from the bug report, and tests
> > the 0->1 transition overflow case.
> >
> > Fixes: edac4d8a168 ("target-arm: Add CNTVOFF_EL2")
> > Cc: qemu-stable@nongnu.org
>
> This change, when applied to 7.2, causes the newly added tests to fail,
> eg: https://gitlab.com/qemu-project/qemu/-/pipelines/1103065860
> (timeout running plugin-vtimer-with-libbb.so etc).
>
> Any hint what can be wrong there?

The test passes fine as a normal test, it's only failing when
plugins are enabled; in the job log
https://gitlab.com/qemu-project/qemu/-/jobs/5727705602
we can see the
TEST vtimer on aarch64
line and that one doesn't time out.  Alex, any ideas?

As a fallback, this isn't really important to backport as far
as the 7.2 branch I think -- although it's a bug it's one that's
been present (as the commit message notes) for many years without
it being a problem in practice.

thanks
-- PMM

