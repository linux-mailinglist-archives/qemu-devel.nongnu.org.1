Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C896A72605F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sox-0008Jx-5Q; Wed, 07 Jun 2023 09:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6soq-0008Ag-EH
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:03:20 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6soo-0006Qx-CC
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:03:20 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b1b30445cfso67058011fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686142996; x=1688734996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPsuLLJszRkrLz3vNy+y0fVXasjC5E/6eOWSU0fJyFM=;
 b=O4yNbC5KPXt7Gs6qoJnG2hnNRVlZASLo+UyIQeUJ64BeE0783kKH3rj1RMVp4kU5L5
 NfbSsxEnrdI2Yg/TJnuGXqJ7ER73FO65Mz178GOlRHS2NmEbVv5XvqJd3gA0mdXYZ9S/
 28KQUFdmzBCohg52mqfD8ycuUlzM6boCfTMzPtFXxvvezcXrG78HZ8GgBbSDsXdOqoZF
 B+Z4qwM1zjGxLeOo9BiaUdqndX/8b2qL48a8aTF5LIQ13umrgk6ylmJoWi3pTKS7znJq
 +3DxevFVK8qTZ5eRF4ai5xyicft34mu2ru8XZbe4Cx/5Ky6bHS9KF+gvyHfIN2ELWfNQ
 q4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686142996; x=1688734996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPsuLLJszRkrLz3vNy+y0fVXasjC5E/6eOWSU0fJyFM=;
 b=F2BEVGHCRlQ6wcTf9UL5KGoiPsKxT4RhuibTtY7MS849DNu2ut9ZER+rNMgN3Lk95M
 RqsG/nn8+ADQpMSr2uZ6InPJzxqCqurU7foboNQmOai4mlNRfrWzwSXGfNCmRIZTcxYU
 TV1BEU5Im6/qlfuLYuokj09yvXV8WRtwkwMLp+x0cEf5Cjp1TIdBWyuruiD8v3cbTk6d
 yRIncFPW/jFiYACAdV2qXXAzqb39UHFBEtdtjcZdsLNd2fWK/+rCZdmUnpQH2Q5lCiSf
 /VLFTaCBMYlGWN8LootbBgVB7Ao0rdAuzqcbf0inPlJH1Ftqt1iNBcCtxfjeN/Pm6bxS
 neXw==
X-Gm-Message-State: AC+VfDxKlq8CystilsDiOadOzV4Sx7ZcKREt2VhrjIxLDhgPRj0olnbR
 s1pwbE9V66m4uoPhuIBtOiuPn1NKnPIG3DKhdWL+Xw==
X-Google-Smtp-Source: ACHHUZ60zu/6sokLcE90cuP4gVVkTw01zf5CbTQ3sba+mJXEPdU660qLbbLmpJNcvT9yHSbkXals5WNVzGHRe24Grj4=
X-Received: by 2002:a05:651c:20e:b0:2b1:fda8:e653 with SMTP id
 y14-20020a05651c020e00b002b1fda8e653mr1103693ljn.27.1686142995724; Wed, 07
 Jun 2023 06:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230606134917.3782215-1-peter.maydell@linaro.org>
 <CACPK8Xd3_ets6btF9ULqjFn_eT55M8t8C+_iQXg-_eXGDLDWqw@mail.gmail.com>
In-Reply-To: <CACPK8Xd3_ets6btF9ULqjFn_eT55M8t8C+_iQXg-_eXGDLDWqw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2023 14:03:04 +0100
Message-ID: <CAFEAcA812y_cG2+AMPRwAE_8_9DGOM_J7_zqHFju5mazr9hqYQ@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/nrf51_timer: Don't lose time when timer is
 queried in tight loop
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Wed, 7 Jun 2023 at 12:26, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 6 Jun 2023 at 13:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The nrf51_timer has a free-running counter which we implement using
> > the pattern of using two fields (update_counter_ns, counter) to track
> > the last point at which we calculated the counter value, and the
> > counter value at that time.  Then we can find the current counter
> > value by converting the difference in wall-clock time between then
> > and now to a tick count that we need to add to the counter value.
> >
> > Unfortunately the nrf51_timer's implementation of this has a bug
> > which means it loses time every time update_counter() is called.
> > After updating s->counter it always sets s->update_counter_ns to
> > 'now', even though the actual point when s->counter hit the new value
> > will be some point in the past (half a tick, say).  In the worst case
> > (guest code in a tight loop reading the counter, icount mode) the
> > counter is continually queried less than a tick after it was last
> > read, so s->counter never advances but s->update_counter_ns does, and
> > the guest never makes forward progress.
> >
> > The fix for this is to only advance update_counter_ns to the
> > timestamp of the last tick, not all the way to 'now'.  (This is the
> > pattern used in hw/misc/mps2-fpgaio.c's counter.)
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > The hang in icount mode was discovered by the Zephyr folks as part
> > of their investigation into
> > https://github.com/zephyrproject-rtos/zephyr/issues/57512
>
> Did you get an image to test with?

Yes, somewhere in the comments on one of the pullrequests
associated with that issue one of the Zephyr devs helpfully
provided a test image.

> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> >
> >  hw/timer/nrf51_timer.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
> > index 42be79c7363..50c6772383e 100644
> > --- a/hw/timer/nrf51_timer.c
> > +++ b/hw/timer/nrf51_timer.c
> > @@ -45,7 +45,12 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
> >      uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
> >
> >      s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
> > -    s->update_counter_ns = now;
> > +    /*
> > +     * Only advance the sync time to the timestamp of the last tick,
> > +     * not all the way to 'now', so we don't lose time if we do
> > +     * multiple resyncs in a single tick.
> > +     */
> > +    s->update_counter_ns += ticks_to_ns(s, ticks);
> >      return ticks;
>
> We're still returning the number of ticks up to 'now'. Should we
> instead return the elapsed ticks? If not, we will expire the timer
> early.

Hmm, I'm not sure what you mean here. The tick count at the
'update_counter_ns' time and the tick count at 'now' should be
identical (because there can't ever be an entire tick difference
between them).

thanks
-- PMM

