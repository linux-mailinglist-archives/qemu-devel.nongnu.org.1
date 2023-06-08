Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B1728347
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HGO-0005LP-Er; Thu, 08 Jun 2023 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7HGL-0005Kr-Us
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:09:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7HGK-0006fj-7s
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:09:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ad99fa586so727984f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686236957; x=1688828957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ree3ttQRecQGudWFMRQ4DPWFI1qcXD6d0QNOmLXDU4=;
 b=nVeKt3S+nnpnCDHxovCcoNL1p3ERMUSyRY3Bh29JcjoLxg1O7fhOGOCPIRNxGKvT+c
 Eb0JSD9Fn6eLpmfT3Rn0UJIU5g9vc8gbODXDKVqL2Mz3nlnETpTMZfRO+B6xfrraSwHG
 kUCSnnJLKWWMYP1ti4SFLV6xWQ2l5w12D2areVr3uSba7Qnoao8dssjAanE4w7wqSjdr
 CFRJ+dKRUS6xZG4tK7abdqZaR4QazqIdOMMTHXZJVfEeB6YOzp8ozj5rNECc9pEI3EnK
 ZF1db7y1VL0srXmm3IfdjxPszwrlMsjeRPKi3bWvsxJXuTIfoEud2xWgaoZlG5/QaseT
 b2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686236957; x=1688828957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ree3ttQRecQGudWFMRQ4DPWFI1qcXD6d0QNOmLXDU4=;
 b=Kdc80scMeBqT54S5/7FRT9Sxbnwa1LrqV31g0DOdM2OccOej4HU00RvDGkdZCY0zel
 ULr1barzK6PEMmljl8REmC56FuG/ydpGaWMD9hzP7+U11A+h1EwXfiIJJDvTWXEhkUAn
 9VMzUcREsiS7aO5gpsZMHawpQs6iRB+nSpADmrFOjqrAKFr/k7q9gqCNXmUc6N1TXLEq
 eGdux6TbTyoYxB0mFj9ASlWcQOHQdL/JmkIhwMcML+9ykxoCpir8J8o/CCVZ/QI8fYzB
 EI/WBG4Kybq/qvY530Od38FBJ4gAzMnz5vTo4KmZvcCbh4BMezBHbCLGa38mtZlNolx2
 i0OQ==
X-Gm-Message-State: AC+VfDxZNbyHrqx7Gf9FlhrUArpdq4wSyaljne2ICEKrQ6sOfuEUQ6o0
 KOglJ3Isi4u/4UtC0PG/aHHJjSQtx76mH7Mrynpg2g==
X-Google-Smtp-Source: ACHHUZ6/EXpZNUr0nWpRVSt0VjSJCr7Wn60lBKdcEaXgcMgFjjpPf2w1p4uJQ5uUSOzyz9xmkPcVu99uw9Ho0bNIJXY=
X-Received: by 2002:adf:f442:0:b0:2f6:ca0d:ec1c with SMTP id
 f2-20020adff442000000b002f6ca0dec1cmr7060689wrp.10.1686236957303; Thu, 08 Jun
 2023 08:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-14-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-14-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 16:09:06 +0100
Message-ID: <CAFEAcA8GTuV0AtHnFHbvii9bgDqYjhAJjsjq0CX3WRHrkkaFvw@mail.gmail.com>
Subject: Re: [PATCH 13/15] hw/timer/arm_timer: Fix misuse of SysBus IRQ in
 IcpPitState
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

On Wed, 31 May 2023 at 21:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> SysBus IRQ are *output* IRQs. As some sort of simplification
> to avoid to forward it, IcpPitState misuses it as ARM timer
> input IRQ. Fix that by using a simple IRQ forwarder handler.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> index 6f444e1789..874f9b63bc 100644
> --- a/hw/timer/arm_timer.c
> +++ b/hw/timer/arm_timer.c
> @@ -352,6 +352,7 @@ struct IntegratorPitState {
>      MemoryRegion iomem;
>      ArmTimerState *timer[3];
>      qemu_irq irq_in[3];
> +    qemu_irq irq[3];
>  };
>
>  static uint64_t icp_pit_read(void *opaque, hwaddr offset,
> @@ -391,6 +392,13 @@ static const MemoryRegionOps icp_pit_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
>
> +static void icp_pit_fwd_irq(void *opaque, int n, int level)
> +{
> +    IntegratorPitState *s =3D opaque;
> +
> +    qemu_set_irq(s->irq[n], level);
> +}
> +
>  static void icp_pit_init(Object *obj)
>  {
>      static const uint32_t tmr_freq[] =3D {
> @@ -402,9 +410,14 @@ static void icp_pit_init(Object *obj)
>      IntegratorPitState *s =3D INTEGRATOR_PIT(obj);
>      SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>
> +    qdev_init_gpio_in_named(DEVICE(obj), icp_pit_fwd_irq,
> +                            "timer-in", ARRAY_SIZE(s->timer));
> +
>      for (unsigned i =3D 0; i < ARRAY_SIZE(s->timer); i++) {
>          s->timer[i] =3D arm_timer_new(tmr_freq[i], s->irq_in[i]);
> -        sysbus_init_irq(dev, &s->irq_in[i]);
> +        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_connect_irq(dev, i,
> +                           qdev_get_gpio_in_named(DEVICE(obj), "timer-in=
", i));
>      }

This feels a bit clunky but I think it's what we have to do,
since the various _pass_ APIs for forwarding GPIOs and
IRQs from a container to an inner device only work with
an entire set of IRQs.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

