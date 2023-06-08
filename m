Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D77282EA
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GpY-0002Jj-OT; Thu, 08 Jun 2023 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GpW-0002J1-UB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:41:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GpV-0007nI-De
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:41:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5169f920a9dso1519909a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235295; x=1688827295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBmK1OGLOrPR3xnnFyfshbWhcI1owq0tAQaYX+0lio8=;
 b=lk5h+oahEuhH3uDToCVAoISTrc51iIlciXRdji41Ys74PiIUyiYZ6kSdkaBOgpSl8c
 QIqZoC1vnu/x/Trp5aC2LrlE2+AJ3yMEuvO/b4tcHA7OA0zW0VjJ9MPTRQuF6DuBxkPa
 ucSF6b/jF3jhJyh6ydGkSU33IppxhtssQ4vhC6v57tjyQN4wnp0lN8IT0y6orHlXIJwK
 KfWNakLFWrbmZMnM8hoRraAYarH9vFTL5mVjqKr2KCIoZpbfkR5DpciQg2XQR1e3HnSW
 KzxW4ceRpnDWti/e/W2N9yCEhdpsSnjYKmmTUQ0QylrNHAeKOB4syg/Bgw6C7+YpLaEN
 feXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235295; x=1688827295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBmK1OGLOrPR3xnnFyfshbWhcI1owq0tAQaYX+0lio8=;
 b=k4vwIQHF+ZHVULF/pvEeIBUGztXjmDzupZT5lzAvc2HcjHwM5JzjM/CN/+YyJxO2iX
 UmrFEczxQMySo7QR5/B0OnzgItfPdPv86Szp+81LujG/mBq6ienqSW99ImH1dbfwN//8
 47JmWt/p0HutXRP0pfIjlBE4jkDs8hkGINKIUW6RorSJAGV4Ngmr7GlNoc9Xt4bvxCdv
 OCli3jMVZhznW8gz6vvMDpxS4OQVrPvHKTzE9gsj4L/pD1Fa/ChEvfhQGp6XbfUFJzAm
 W1WY+orkE4+fFPlVWvfM9cNxboPmFaMakJ3bGoSeE81b9c+rz5d/ODJ+SZBiBlf5Ecsi
 +Nzw==
X-Gm-Message-State: AC+VfDx/isfm8zMrzTTnynavaGWff0ZAqhtZjW93hGgFh3M4b0kO8GMg
 F7Tg4GWSQBs+Au784pG3Up/9PiNlKEkJiJw3Mq7hiQ==
X-Google-Smtp-Source: ACHHUZ4iZRdvEVK6oQOrMTJNeHzZyCp+N7r21uuwAoP6lk7qyER/60SQrPeighyQP5KQAAXCjz2RWRGXilScv13w9x4=
X-Received: by 2002:aa7:d44d:0:b0:513:fa61:397a with SMTP id
 q13-20020aa7d44d000000b00513fa61397amr2468617edr.12.1686235295282; Thu, 08
 Jun 2023 07:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-4-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:41:24 +0100
Message-ID: <CAFEAcA8ZXZ1x9ruh5DuFF+xMM+75W-dcjHJQXQLBcqi0i-peHQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] hw/timer/arm_timer: Add missing sp804_unrealize()
 handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Release the IRQs allocated in sp804_realize() in the
> corresponding sp804_unrealize() handler.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 36f6586f80..5caf42649a 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -309,6 +309,15 @@ static void sp804_realize(DeviceState *dev, Error **=
errp)
>      s->timer[1]->irq =3D qemu_allocate_irq(sp804_set_irq, s, 1);
>  }
>
> +static void sp804_unrealize(DeviceState *dev)
> +{
> +    SP804State *s =3D SP804(dev);
> +
> +    for (unsigned i =3D 0; i < ARRAY_SIZE(s->timer); i++) {
> +        qemu_free_irq(s->timer[i]->irq);
> +    }
> +}

I don't really see the purpose in this. It doesn't actually
avoid a leak if we ever destroy an SP804, because
s->timer[i] itself is memory allocated by arm_timer_init()
which we don't clean up (the arm_timer_state not being
a qdev). If we did convert arm_timer_state to qdev
then these interrupts should turn into being sysbus irqs
and gpio inputs on the relevant devices. (In fact if you
were willing to take the migration-compat hit you
could just have the sp804 create a 2 input OR gate and
wire the arm_timer irqs up to it and use the output
of the OR gate as the sp804 outbound interrupt line.)

thanks
-- PMM

