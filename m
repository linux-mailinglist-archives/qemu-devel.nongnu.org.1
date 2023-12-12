Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886280F3F8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 18:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD6AQ-0005Xn-UI; Tue, 12 Dec 2023 12:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD69b-0005Ax-JA
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:02:49 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD69X-0004is-6o
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:02:43 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-551c03adfc6so834708a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702400557; x=1703005357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqEohpn65OtyUXLlXMPdQICP6Ozkd4Jm1At+Kp9oMm8=;
 b=k6nu3HH6qv86k7sptDkLgilAe567BWfROVkE8zhkmEnJeIAHxuz2JihTyx+CPyh3uE
 +BpZiHMP9iMG27kmfJsTRSQhRd9Hcq81SMjS6xq7zdRdW2SdG+h/D5nuK2RkFqAXwfZ/
 3RBns+zu8U+yyz3SHslcHkRd6thVKCAEbbudgS1WW4LvfSc60IaAGtyGrkT+7CWxzyGe
 Ey/ehNRADRLOGYQzLJMjSTc/CJNUjNBtSrvPD7pXBjRHwgmJnBYAIFWuKR2Ou9ah45gF
 uhh6ZENRQrthiMawAIzDoDbl3WVgvI6SSeJdnHJcqWCUiYnwMJ8kqTbg/WIMSIGUd+xR
 pGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400557; x=1703005357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqEohpn65OtyUXLlXMPdQICP6Ozkd4Jm1At+Kp9oMm8=;
 b=TQVj/bQmE9EiEv8ymmvxRpqq3Hs4ZhWHQzNYx+ZzcWKZqiHrMvP7XF7zdNgesP6AxH
 pFf6+G8E6Xa2I4yia9VxOVJMx8mQq2cZxQro2pNZXlWhP23Dgh3Zc24k63qA9jIpjGjC
 W7CsKhJZ+lH4Sg+MQbNFifWgouSI/+nHs/Jh9GXK86BWUch6LN9vUAWf1RMORcEZ8igJ
 Qlq6FF6uwZucd7tQ5io6pIlGX9HyFmK8yiQiTiDC1uXTBmn8KMto29vmfNEZCqCgYDuC
 2roOqp2TZ+Kw/WCz5rhXFe0clyq0thVeqiBp4BYiUiefT2uRlv/GxYDB0SUWCZw1yhWd
 8ttA==
X-Gm-Message-State: AOJu0YwxaoDQXCuFinwaXNPHXkNN9qgDyU7dEaI2SNfa0ewOKD/HDd62
 gDHv9fbzMZ0YVMWMM21rCBIipupsa0Tn7Iyra2BeCw==
X-Google-Smtp-Source: AGHT+IETpMQCWfp1Wg/R8Ye0cxHF+nJBswsuePrPEc/jx9M1uQG8puUlN1H5SDbhrJR7tF8V6THIvQ2ydPY7yjMp6+8=
X-Received: by 2002:a50:99cf:0:b0:54c:d3cd:c831 with SMTP id
 n15-20020a5099cf000000b0054cd3cdc831mr2581017edb.47.1702400557059; Tue, 12
 Dec 2023 09:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-8-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 17:02:24 +0000
Message-ID: <CAFEAcA_Y9UCakRg0rhH_pL_xvGWCd47gjgufA4QjDHtf20tspA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 7/8] hw/arm/bcm2836: Move code after error
 checks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 23 Nov 2023 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> First run the code that can return errors, then on success
> run what alters the instance state.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/bcm2836.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 03e6eb2fb2..e56935f3e5 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -119,13 +119,6 @@ static void bcm2836_realize(DeviceState *dev, Error =
**errp)
>          return;
>      }
>
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
> -
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
> -        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
> -        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
> -
>      for (n =3D 0; n < BCM283X_NCPUS; n++) {
>          object_property_set_int(OBJECT(&s->cpu[n].core), "mp-affinity",
>                                  (bc->clusterid << 8) | n, &error_abort);
> @@ -158,6 +151,13 @@ static void bcm2836_realize(DeviceState *dev, Error =
**errp)
>          qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
>                  qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", =
n));
>      }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
> +                    qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq=
", 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
> +                    qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq=
", 0));
>  }
>

There's no particular harm in moving the code, but given the loop
we are already doing some IRQ-connection work before doing some
things which might fail.

We don't in general do a particularly consistent job with
tidying up in realize methods that fail halfway through, but
in general "connect an IRQ between two devices both of which
are owned by this container device" and "map an MR of this device
we own into a container region we also own" are not things
which affect the overall simulation, and in theory should
be cleanup-able later (maybe even automatically by refcount
if we're really lucky).

-- PMM

