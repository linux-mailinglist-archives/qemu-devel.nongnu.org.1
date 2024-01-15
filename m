Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9182DB58
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPO29-0001wh-1b; Mon, 15 Jan 2024 09:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPO1l-0001jI-5n
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:33:25 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPO1h-0003Cl-2y
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:33:24 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50eabbc3dccso9977412e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705329197; x=1705933997; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C+rR/Ri1VueJq3MAoPWB/at6jw6sTqJJCLYEh4Et3H8=;
 b=Smn5br2qmxLfJ9T56au0kHwzzBm867Ex8C2OYWLpg/4g0qhdBWpqVmDvuN3biP7Ofl
 tAAK9NQa2LrFCXMryo7QwgkQ83q82ioyf5Fo+JsmUEWwGyMUGkHz6bW7LUnBk/pU6QoE
 cKNVmmn57NxcOX4BjcKstFMV4LawQO6Hv4dhL6uIxFLyPmIwq0ZBNqyVERlnHeddit0x
 O0crYQ7AhoTEXYuYND/lxQgTBvGgLl7AiG+ocW0ZyTUdaBT/3HGCfVcOtQkyNEWl3qS4
 91qSFj4GVOp4Ackp3Ca2Wz9NS4yCjEZqrfgVBlkJetZkF3CKAgXtw70EuJq3FWrPkNnO
 lIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705329197; x=1705933997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+rR/Ri1VueJq3MAoPWB/at6jw6sTqJJCLYEh4Et3H8=;
 b=dNnoK18UNyMMHx2TcrF8p9hOWmy3m9GActs6Wdm0dYUyu/GHNLBD0FH2IRro/Qiv9e
 ncP3/hRIeOEWg1aSF+S/5I2A2bUdeszsxTzsk/PO+X+w0r4KqvPEIMcHWAnlcEI3Qg3v
 rzNHzSiwpnqfGvTHWqWOHT4Bh6SslsQtqWNWwZCBFw3CtDCbQL3WKcxaRZfF39ATxsG+
 p7vhxjSfL7+M1uZBf2JdffklpHykKt3XMNBcHdDUqQLni5rGb9T/3UN/lxMBnEQlrw5/
 Hd7k8xWbLY/V33s3hs3lQiJWoldk3Hmm9bnnyl9GiUJeAhJhecedHro14XnIwLyL7KC4
 w3JA==
X-Gm-Message-State: AOJu0YwwuC5o/tyLk1Lw2OLp1yNSDB2A9GgvWiYa2nNMNdXSOviF8Ica
 SfWKA4WASQ/nvVgvIZz5GelFTxQ91LwlMskHWMYxq2iIRJs97Q==
X-Google-Smtp-Source: AGHT+IGxPJZZcDp6p+JRAKl8bJqUa0iKvvhb1Wei89Y4qBDgUp88nLQu6oPXOuGSqgn4QV1PBsp/Vc/xRJd1YI0TLhM=
X-Received: by 2002:a05:6512:1247:b0:50e:9353:5344 with SMTP id
 fb7-20020a056512124700b0050e93535344mr1493690lfb.79.1705329196972; Mon, 15
 Jan 2024 06:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-20-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-20-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:33:06 +0000
Message-ID: <CAFEAcA-BQERFsYfbvDgxvyrGdGtvhW7dbVxKS9pNPnR+r5iJbg@mail.gmail.com>
Subject: Re: [PATCH v4 19/45] Get rid of RNG200 timer
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Fri, 8 Dec 2023 at 02:34, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>

The commit message doesn't seem to match the changes here.

> ---
>  hw/arm/bcm2838_peripherals.c         | 14 +++++
>  hw/arm/raspi4b.c                     |  1 -
>  hw/misc/bcm2838_rng200.c             | 78 ++++++++++++++++------------
>  include/hw/arm/bcm2838_peripherals.h |  2 +
>  include/hw/misc/bcm2838_rng200.h     |  4 +-
>  5 files changed, 63 insertions(+), 36 deletions(-)
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index ee06214715..7c489c8e8a 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -34,6 +34,9 @@ static void bcm2838_peripherals_init(Object *obj)
>                         bc->peri_low_size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
>
> +    /* Random Number Generator */
> +    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
> +
>      /* PCIe Host Bridge */
>      object_initialize_child(obj, "pcie-host", &s->pcie_host,
>                              TYPE_BCM2838_PCIE_HOST);
> @@ -85,6 +88,17 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>                                          BCM2838_VC_PERI_LOW_BASE,
>                                          &s->peri_low_mr_alias, 1);
>
> +    /* Random Number Generator */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(
> +        &s_base->peri_mr, RNG_OFFSET,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
> +                               INTERRUPT_RNG));
> +
>      /* Extended Mass Media Controller 2 */
>      object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
>                               &error_abort);
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 2e8474e1c5..7b5385b8dd 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -67,7 +67,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
>
>      /* Temporarily disable following devices until they are implemented*/
>      const char *to_be_removed_from_dt_as_wa[] = {
> -        "brcm,bcm2711-rng200",
>          "brcm,bcm2711-thermal",
>          "brcm,bcm2711-genet-v5",
>      };

These changes above here are all "add the rng200 device to the SoC".
They shouldn't be in the same patch as changes below which seem
to be adding/changing functionality in the device implementation.
I think the changes below (other than the change to
include/hw/arm/bcm2838_peripherals.h) should be in the previous patch(es).

> diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
> index f91ea0754c..1b334b94d5 100644
> --- a/hw/misc/bcm2838_rng200.c
> +++ b/hw/misc/bcm2838_rng200.c
> @@ -9,6 +9,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qom/object_interfaces.h"
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/bcm2838_rng200.h"
> @@ -64,10 +65,7 @@ static const VMStateDescription vmstate_bcm2838_rng200 = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(rbg_period, BCM2838Rng200State),
>          VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
> -        VMSTATE_BOOL(use_timer, BCM2838Rng200State),
> -
>          VMSTATE_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS, 0,
>                        vmstate_info_uint32, uint32_t),
>

thanks
-- PMM

