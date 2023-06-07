Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E72725D0D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6rJe-0001t7-5J; Wed, 07 Jun 2023 07:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6rJb-0001si-8p; Wed, 07 Jun 2023 07:26:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6rJX-0001nr-MW; Wed, 07 Jun 2023 07:26:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so1069102966b.0; 
 Wed, 07 Jun 2023 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686137210; x=1688729210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hOOS0KVKvVqoKA3p+DeXd8G4BIGaBKXgaPi2v7zbdvE=;
 b=b1lEmrL8ploklK5iSzsMa3KD+2GbJe6x4/SDpa6FH0hauh/zhAji+5Gj4ADklgM74m
 3PlmqszD3eoVLMIJSkR/pgvNt2+sVZu2hHPb/OFRYUoU92J48qBmee1tTPKN9i59i6js
 i3xrZNjlSGI/zXKxpm3wGMeMbKeKESHebTqRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686137210; x=1688729210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOOS0KVKvVqoKA3p+DeXd8G4BIGaBKXgaPi2v7zbdvE=;
 b=jfgMYlZUGRul3SQh2fiQqvPR2drxn4Lvy2uJsPcO10M1yUtBSBqNBGZs2PbA7SA/uh
 kKvLWAKGsjP6kKTyrZvvuceVqeOZFqkM3lgPoPWQk2ybVFhJQDddOJJMyyDB4fRIqzvY
 rhSpcPIfSDrxs67XMitWpc0wdlLnCYS542zJfnFeHO0Fdokge6FNM+SRO0IgM56fldT3
 V4CqpSm28klNFUVkzu7JQrlAF3iH4RUULUzTXyTk+6DV2AqmA6Lbt7R17s3mssvmOTB5
 IUWIrEKOMiyvjABbW8UglJtcEjxTC2ulC6xk5LLqRxuBW1dwk2Mhmhv0ACvc1que6Zj6
 v0pw==
X-Gm-Message-State: AC+VfDxlw68W7WEDWsaCACrv74pVJrWhHUXV/jnPzgkHaCKMGGAOcuLV
 TmUcbClJ0fV/7ibnyVPmHmkES89JoRGBmJXec7E=
X-Google-Smtp-Source: ACHHUZ7Mv/svzqze/KqfODlAxrJw0ooZvzrkSDlVHRgZmySeg8Dpz1gDW8BXD93HiqLW6kSQoWZVKXR072qcjnzH57A=
X-Received: by 2002:a17:906:dac9:b0:957:2d2a:e8a2 with SMTP id
 xi9-20020a170906dac900b009572d2ae8a2mr5504455ejb.27.1686137210285; Wed, 07
 Jun 2023 04:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230606134917.3782215-1-peter.maydell@linaro.org>
In-Reply-To: <20230606134917.3782215-1-peter.maydell@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 11:26:38 +0000
Message-ID: <CACPK8Xd3_ets6btF9ULqjFn_eT55M8t8C+_iQXg-_eXGDLDWqw@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/nrf51_timer: Don't lose time when timer is
 queried in tight loop
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 6 Jun 2023 at 13:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The nrf51_timer has a free-running counter which we implement using
> the pattern of using two fields (update_counter_ns, counter) to track
> the last point at which we calculated the counter value, and the
> counter value at that time.  Then we can find the current counter
> value by converting the difference in wall-clock time between then
> and now to a tick count that we need to add to the counter value.
>
> Unfortunately the nrf51_timer's implementation of this has a bug
> which means it loses time every time update_counter() is called.
> After updating s->counter it always sets s->update_counter_ns to
> 'now', even though the actual point when s->counter hit the new value
> will be some point in the past (half a tick, say).  In the worst case
> (guest code in a tight loop reading the counter, icount mode) the
> counter is continually queried less than a tick after it was last
> read, so s->counter never advances but s->update_counter_ns does, and
> the guest never makes forward progress.
>
> The fix for this is to only advance update_counter_ns to the
> timestamp of the last tick, not all the way to 'now'.  (This is the
> pattern used in hw/misc/mps2-fpgaio.c's counter.)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The hang in icount mode was discovered by the Zephyr folks as part
> of their investigation into
> https://github.com/zephyrproject-rtos/zephyr/issues/57512

Did you get an image to test with?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
>  hw/timer/nrf51_timer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
> index 42be79c7363..50c6772383e 100644
> --- a/hw/timer/nrf51_timer.c
> +++ b/hw/timer/nrf51_timer.c
> @@ -45,7 +45,12 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
>      uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
>
>      s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
> -    s->update_counter_ns = now;
> +    /*
> +     * Only advance the sync time to the timestamp of the last tick,
> +     * not all the way to 'now', so we don't lose time if we do
> +     * multiple resyncs in a single tick.
> +     */
> +    s->update_counter_ns += ticks_to_ns(s, ticks);
>      return ticks;

We're still returning the number of ticks up to 'now'. Should we
instead return the elapsed ticks? If not, we will expire the timer
early.

Cheers,

Joel

