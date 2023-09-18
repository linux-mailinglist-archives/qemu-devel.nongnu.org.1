Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786137A47BB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:02:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiC03-0001KJ-04; Mon, 18 Sep 2023 07:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBzc-0001Im-3u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:00:42 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBzZ-0001ls-T4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:00:39 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso5308582a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695034836; x=1695639636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0T0yJm6zI1w+R1+ybu5R7i+AEkND4xDj9k8IkFVSN4=;
 b=U+HTg00GBe0anhN37CaRLthiWFhomjnU3OH9gKCzv3CPSKIcdMmMERrYsb3aEcI6Oo
 HYM1Dwu4+X6inwl6hO3Vy3EPeuczd9Lm4pQNXlu5ktGdbCv6lTvufIh0ONRYAy26trVO
 T59muk9xRCyYVZ5jhXbGiMzwXSZNAFrfC/H7mKl0Uft440lEqmbgfU7d81X1tUFoHxqX
 +d2tNg4KkH93/K8v2LHJt5FRi85IRVsQyADMcsQz7BkzfHVGwNCw2x1wGOniK66GEWme
 QEW43NqAfO9i5CEFWk6+PRijC1RbUX2vtkZPJ6UM12gzF5lkeszrduZnc+COcyV5fV7X
 P15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034836; x=1695639636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0T0yJm6zI1w+R1+ybu5R7i+AEkND4xDj9k8IkFVSN4=;
 b=M1QbB9bM86d1ddkDBNKfxubHfnJUEmDgmYK1QgxGfU2gC/VPO0vyH2v1kwOZjTPFNG
 +TCp32ww2rRhkwImUcED5s+RIcuj2Jkb8qu5gfs0WegASV9mgop0qyu15yVaUkk8mwxJ
 PY/Mz2OfitFHlv2qFh//eQvjOxm+av21h0SHsQ1tQr6cpZHYlr9WIZf2lYueU+sTpA/o
 l6yymRWmyw27TzHiDl1eB6o4zBvs+N2xJC31s4k8iSyLcLug8ktLkvcLNS6r1YWxGqXW
 GM+cS4hBVnr8V2WgJQkdDK1djpHgAIlvsn7YH3nLcOXDzr7DP4Js095Q1pymp2GiWG3t
 g28A==
X-Gm-Message-State: AOJu0Yw761o8GYWhWP9cdDmBBVmcScscq1vYcPm7sYpMu7HV3w+FMdCI
 BGdk3MthXpQNWN3oyTfGgc6M7iAnf2yrvHCZzfVz1Q==
X-Google-Smtp-Source: AGHT+IH9/9Q0nTbkQACKsPIzqG0pVIabhS8zIFVUjGrALFvU2SEjO82kx8gNlDTjGJOKgv9oK85tb3rDyONzVrVrAD0=
X-Received: by 2002:a05:6402:644:b0:523:aef9:3b7b with SMTP id
 u4-20020a056402064400b00523aef93b7bmr7770583edx.4.1695034835976; Mon, 18 Sep
 2023 04:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230918101736.23905-1-philmd@linaro.org>
 <20230918101736.23905-2-philmd@linaro.org>
In-Reply-To: <20230918101736.23905-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 12:00:17 +0100
Message-ID: <CAFEAcA89z1vCwDzzB_GjbUBtcOCz4vU7r_zC4nMmunp5BGVWxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sd/omap_mmc: Do not reset SDCard until being fully
 realized
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, 
 Alessandro Di Federico <ale@rev.ng>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 18 Sept 2023 at 11:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> We shouldn't call QDev DeviceReset() before DeviceRealize().
>
> Since the OMAP MMC model is not QDev'ified, it has to manually
> call the SDCard reset() handler. This breaks QDev assumptions
> that DeviceReset() is never called before a device is fully
> realized. In order to avoid that, pass a 'realized' argument
> to omap_mmc_reset(). All cases are explicit manual resets,
> except in omap_mmc_write() where we expect the sdcard to be
> realized.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/arm/omap.h |  2 +-
>  hw/arm/omap1.c        |  2 +-
>  hw/arm/omap2.c        |  2 +-
>  hw/sd/omap_mmc.c      | 21 ++++++++++++---------
>  4 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 067e9419f7..d331467946 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -808,7 +808,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
>  struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
>                  BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
>                  omap_clk fclk, omap_clk iclk);
> -void omap_mmc_reset(struct omap_mmc_s *s);
> +void omap_mmc_reset(struct omap_mmc_s *s, bool realized);
>  void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover=
);
>  void omap_mmc_enable(struct omap_mmc_s *s, int enable);
>
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index d5438156ee..3afeba6f86 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -3728,7 +3728,7 @@ static void omap1_mpu_reset(void *opaque)
>      omap_uart_reset(mpu->uart[0]);
>      omap_uart_reset(mpu->uart[1]);
>      omap_uart_reset(mpu->uart[2]);
> -    omap_mmc_reset(mpu->mmc);
> +    omap_mmc_reset(mpu->mmc, false);
>      omap_mpuio_reset(mpu->mpuio);
>      omap_uwire_reset(mpu->microwire);
>      omap_pwl_reset(mpu->pwl);
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index d5a2ae7af6..ef9b0dd60a 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2253,7 +2253,7 @@ static void omap2_mpu_reset(void *opaque)
>      omap_uart_reset(mpu->uart[0]);
>      omap_uart_reset(mpu->uart[1]);
>      omap_uart_reset(mpu->uart[2]);
> -    omap_mmc_reset(mpu->mmc);
> +    omap_mmc_reset(mpu->mmc, false);
>      omap_mcspi_reset(mpu->mcspi[0]);
>      omap_mcspi_reset(mpu->mcspi[1]);
>      cpu_reset(CPU(mpu->cpu));

These are reset functions registered via qemu_register_reset().
They should be OK to assume the SD card is realized.
This matters, because this is the only place that the SD
card will get reset -- as the comment in omap_mmc_reset() notes,
the SD card object isn't going to be plugged into any bus, so
it won't get auto-reset when the simulation starts, and these
reset function are the place that does the manual reset.

> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index edd3cf2a1e..3c906993eb 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -287,7 +287,7 @@ static void omap_mmc_pseudo_reset(struct omap_mmc_s *=
host)
>      host->fifo_len =3D 0;
>  }
>
> -void omap_mmc_reset(struct omap_mmc_s *host)
> +void omap_mmc_reset(struct omap_mmc_s *host, bool realized)
>  {
>      host->last_cmd =3D 0;
>      memset(host->rsp, 0, sizeof(host->rsp));
> @@ -314,11 +314,14 @@ void omap_mmc_reset(struct omap_mmc_s *host)
>
>      omap_mmc_pseudo_reset(host);
>
> -    /* Since we're still using the legacy SD API the card is not plugged
> -     * into any bus, and we must reset it manually. When omap_mmc is
> -     * QOMified this must move into the QOM reset function.
> -     */
> -    device_cold_reset(DEVICE(host->card));
> +    if (realized) {
> +        /*
> +         * Since we're still using the legacy SD API the card is not plu=
gged
> +         * into any bus, and we must reset it manually. When omap_mmc is
> +         * QOMified this must move into the QOM reset function.
> +         */
> +        device_cold_reset(DEVICE(host->card));
> +    }
>  }
>
>  static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size=
)
> @@ -556,7 +559,7 @@ static void omap_mmc_write(void *opaque, hwaddr offse=
t,
>          break;
>      case 0x64: /* MMC_SYSC */
>          if (value & (1 << 2))                                  /* SRTS *=
/
> -            omap_mmc_reset(s);
> +            omap_mmc_reset(s, true);
>          break;
>      case 0x68: /* MMC_SYSS */
>          OMAP_RO_REG(offset);
> @@ -613,7 +616,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
>          exit(1);
>      }
>
> -    omap_mmc_reset(s);
> +    omap_mmc_reset(s, false);
>
>      return s;
>  }
> @@ -643,7 +646,7 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_=
agent_s *ta,
>      s->cdet =3D qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
>      sd_set_cb(s->card, NULL, s->cdet);
>
> -    omap_mmc_reset(s);
> +    omap_mmc_reset(s, false);

These calls from omap_mmc_init() are probably safe to remove, but I
don't understand why they result in our resetting a non-realized
SD card object. In both cases, the call happens after we call
sd_init(). sd_init() both creates and realizes the SD card, so
it should be realized at the point when it gets reset.

In a truly ideal world we would QOMify the omap-mmc device: it
is the only remaining user of the legacy sd_init function...

thanks
-- PMM

