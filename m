Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C17770356
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvxW-0001Ii-0H; Fri, 04 Aug 2023 10:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRvxU-0001IT-PY
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:39:16 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRvxT-0005Ba-9S
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:39:16 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so2668412a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691159954; x=1691764754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nX5Maeg6RmQRSsbIs4jnLskz8NvE7Q7ToV8RPzYLre0=;
 b=QvLoqSAntAsHiTaa1mjGQee2uFvUQotFidbbMaADOElhDnjqs+mrPisqYW7nhZprfb
 DTfY1DSVfoBRmyvfCvnS0x9VCsQvTgk3hLIHx3No+2+KEh0Txssr1zjmY/IVWLdvdfBS
 q2cSFGJI0yKqJIf7MEiLiiv4U1Qy4gyd/E5fPDVVLAfaKcKgBvRSCWaGf8o7TqwkJ+A7
 b2GGqCJ6hpHGQ69jXZBxNUDoolL5Q223q6lCwBl20VPYwPbB5RKtytIyaoW/23R5bsjM
 QtKePc+RD3Gg3NQ/ey9ydxoEYF9oMV+VItXBQ8oIpljtKm+zpvYutGOIdaLu8iJIOK2T
 UzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691159954; x=1691764754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nX5Maeg6RmQRSsbIs4jnLskz8NvE7Q7ToV8RPzYLre0=;
 b=Y0j/bm7tmmIbWeJ/prg9gvjekecoG2Z1KYuW0UdGAdZVWr3qOMDwjS/sqcEhZIs07A
 NWqBOg9yEBvrkiNI4Q6ARmB92THwrMoWZBsmGEh8w6qiGtbx7FOjsbXzEKFhmhdGTWHv
 DzrJtkST6qWLWC0HxnUHjcIAtnwuKg0BweEI+T6YPUDmD2cKi+uf0fbtqyGyOkze9g4S
 sQLarsMtVdh1QGHKaGz4hao99Sz1n6+5xrou+EMsx/Tv1qaDsyE0KFV/k0Zy/S5XiT1W
 jQL9QwMgP+qfQz8G7NmqJ6nt1JYZMEFlfRywXvk+uTr76kZ2pXGDYzFxSFn5kj8qG1ND
 by5w==
X-Gm-Message-State: AOJu0YxGo+Zpn6EF8lAHilrS7P8r6xV1VrP3ZZoNDubn8uexdLpSn75Y
 eXVvqReFBqMAaifSQc5tjesk352avggdy5dWsWCamQ==
X-Google-Smtp-Source: AGHT+IF61QCCZUH8qkoXesBbNBU9lMMxl6MgccV13pGMxBJwiFAOP8rgBOufvEiTpUUX/H9cVoCFxqZu1bBB3qgs6GM=
X-Received: by 2002:a05:6402:493:b0:521:7779:d918 with SMTP id
 k19-20020a056402049300b005217779d918mr1736605edv.19.1691159953808; Fri, 04
 Aug 2023 07:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-22-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-22-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:39:02 +0100
Message-ID: <CAFEAcA-X3Kz3=MiC4m2MvH40LcjW9rggixVJ7mVj36VLMQrszw@mail.gmail.com>
Subject: Re: [PATCH 21/44] Add clock_isp stub
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 26 Jul 2023 at 14:55, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 6 ++++++
>  include/hw/arm/bcm2838_peripherals.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index e7a9db97ab..60ed535673 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -17,6 +17,9 @@
>  #define PCIE_MMIO_ARM_OFFSET    0x600000000
>  #define PCIE_MMIO_SIZE          0x40000000
>
> +#define CLOCK_ISP_OFFSET        0xc11000
> +#define CLOCK_ISP_SIZE          0x100
> +
>  /* Lower peripheral base address on the VC (GPU) system bus */
>  #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
>
> @@ -224,6 +227,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
>                                  &s->pcie_mmio_alias);
>
> +    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
> +                 CLOCK_ISP_SIZE);
> +
>      /* GPIO */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
>          return;


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

