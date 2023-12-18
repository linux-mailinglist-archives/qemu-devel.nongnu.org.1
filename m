Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9248177B2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:39:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGdS-0004hk-Kv; Mon, 18 Dec 2023 11:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGdQ-0004hJ-Km
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:38:28 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGdO-0000y9-Nt
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:38:28 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cc6acf5e3dso17913961fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702917505; x=1703522305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=toBNsCFDoFPx4hkIUBYvrnKvlfiFFUob+jY0w+gvlPA=;
 b=Yb2ugNzFWxJ1sQv0wJLALuKnNqsRx3MvDKxvzcuWWDkSVzA4DAFNRBzouvItaQgKkr
 YXnVSnDVcPo2KVWQ8mtVliSI9HxwNrkMBMpkQkv9ALRLl6Ayxtp7UWfTXT76tBq5hEG7
 jSxFiCCpGADhnRqSm/6cqQtVOz3dOj8rJPaqQVbAyE3libUB/KxQUINCNhcEwFI0JKJi
 M+QNtI0mfIFw5Pnu7xWVMxxqgtOlLbjOI1CuECTedpa53TYSpte4i5khVer94QqsaBhN
 zvrs4KXIAuC6g3t3xMjzHbBWkd33H/CwpGtRd55iUQgIIYb5KE8nXt+3yAoAheBudtZ+
 vzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702917505; x=1703522305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=toBNsCFDoFPx4hkIUBYvrnKvlfiFFUob+jY0w+gvlPA=;
 b=QnS9T6TY8JsnD0GpogHJdVBoRmWwJpEH7nGOYLkS7ynd0/wJ62vUpTVRMHT4jeBpng
 W7jS4oqF7RVpW94Xfd4rfm8vmwcddT1W+uIWs/P8mLl/Vz974I2qa7Ue8Mw8B83LTu03
 U8xVMtDVWoTWFdxen5rieE7b/ZpQaRQIrE/BRrzPmMBCVt1UyT9whJyK23r5mMGYzDyH
 AoKUiwc/MuktYgPYR7OGTUZVWY85oAbVIW3wbMf7kaRTdIu2eU5VjUiYxAHnoouk4wZt
 QL3JrYRGwASO1werI2Kvc/wAzg82ELRyylIZtjwXn6bQd/OBNR+irn+ixGkWVnKq6yv2
 T23w==
X-Gm-Message-State: AOJu0Yy0JSzQpa6zA9p+H6fFPqngcnnZihd5KzdK7CwBWpz+99/d4BDN
 KZjDlpC21Z8vpYLfb8WT0bZppDdGexm3iia2TVXrIQ==
X-Google-Smtp-Source: AGHT+IHO5PNpjfFWlb1eBdVH/2zUUsRMPugVH0CLeYgaPPi2UJI3c9T+0S2Nbiw98Q2+x/LONbH/eIAmwqFB5x/4o+E=
X-Received: by 2002:a05:651c:1696:b0:2cc:6d6e:b1f8 with SMTP id
 bd22-20020a05651c169600b002cc6d6eb1f8mr514816ljb.205.1702917504884; Mon, 18
 Dec 2023 08:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-9-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-9-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:38:13 +0000
Message-ID: <CAFEAcA8+BrvRERoZ5xpPedKYfQEJUVDYRwLmvp6SUTB_ZGaKmA@mail.gmail.com>
Subject: Re: [PATCH v4 08/45] Connect SD controller to BCM2838 GPIO
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c         | 59 +++++++++++++++++++++++++++++++---
>  include/hw/gpio/bcm2838_gpio.h |  5 +++
>  2 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
> index 51eb55b00a..f166ce7959 100644
> --- a/hw/gpio/bcm2838_gpio.c
> +++ b/hw/gpio/bcm2838_gpio.c
> @@ -17,9 +17,10 @@
>  #include "qemu/timer.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> -#include "migration/vmstate.h"
> +#include "hw/sd/sd.h"
>  #include "hw/gpio/bcm2838_gpio.h"
>  #include "hw/irq.h"
> +#include "migration/vmstate.h"

Put the #include in the order you want in the first place,
please, rather than putting it in one place in one patch and
then moving it around in a second patch.

>
>  #define GPFSEL0   0x00
>  #define GPFSEL1   0x04
> @@ -64,6 +65,16 @@

> @@ -302,15 +343,25 @@ static void bcm2838_gpio_init(Object *obj)
>      DeviceState *dev = DEVICE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>
> -    memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
> -                          "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
> +    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
> +
> +    memory_region_init_io(
> +        &s->iomem, obj,
> +        &bcm2838_gpio_ops, s, "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);

Oddly placed newline after the "(" here.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

