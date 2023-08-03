Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5776EF81
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbEs-00028D-0o; Thu, 03 Aug 2023 12:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRbEn-00020K-7w
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:31:45 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRbEl-0004z1-HW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:31:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52164adea19so1459927a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691080299; x=1691685099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ML4c12rEx1eZW5TZLSmBhtPzewN8g7REXOd4fE7o8Y=;
 b=Rz5nBSiAzbBus3cJF9UAHmrqvQSf41WNfxdQX3Hvex/OA+NTezCzk6DkGmVnF1Q4N4
 wet9iswzKF581gNq+ZnZ9kmDK2jusp3JIL3iE9tTBg5jAA5J3eIyEhbf5t9XBw5ID6Ys
 ZZS9O7AZlKLlGuYOaqlR9nX5fN7QLbc8kArGvlaIJpusI0MFPOJ/EKBjcfLVGrDu3VxX
 Yamk1QAYYb5A1LESAjDM2CzqH/ZoC0w7GPoY/TToJyj8ubDMnLQiylGkqssrlf3ZckDq
 4bWgYKGLO5WVvFhqqSq0MCcl4OWd5nLaH2WDHV0ObJBRC7vMLCMOzHtg/7xGsO5KRWfe
 F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691080299; x=1691685099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ML4c12rEx1eZW5TZLSmBhtPzewN8g7REXOd4fE7o8Y=;
 b=HcaVo/xYBjJHzWP/e084/xkc4sOpbkpCco6AwBugMRWmApNKo2KxRjHBpsy9RHdCqI
 /T3h/RdhGSBqDsDPhwC9XfRBtj/zx/AWYi+F1nppe7Nke8i0f+z4QdI8Xk8NGWHNKMXi
 +bmZlHC3hYo149aspfZ0OAN35mhz1wPFpw0RxtmEdY15HTkFHaasVxSz/P5P1x24D0EX
 dr8ejJzakFa0auVcS+TvVeRuHH03HFFE77+USs96qtZpLh/5Re+29Rkptaf7/d21t4Ni
 L7Aivoio51FD/cJpgMxfsHkZPzufS/B0QmnW+ewbK5r32Yf5pgEmZGrl6gFHwfii4mXV
 Fe7w==
X-Gm-Message-State: ABy/qLZZyG2ll3mSL3HFJQhWtA9E74ow3mgKrMljjnqyjteCpik0EZ4h
 D4qMfroZKbU/XzY5sGC0XkXSst0UPxpl+dN9Tuu7bw==
X-Google-Smtp-Source: APBJJlGP6/NbHPMQ73kdh+jb2r67+6nMZlZzAO2Gc//9K2n2uhDsKFRVgXfX5rUdKZx73jzdAknl84VjDpIDIs1l24Q=
X-Received: by 2002:aa7:cd74:0:b0:521:9d92:5863 with SMTP id
 ca20-20020aa7cd74000000b005219d925863mr6323146edb.42.1691080298772; Thu, 03
 Aug 2023 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-5-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-5-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 17:31:27 +0100
Message-ID: <CAFEAcA8h3Kv1oSOeidufLAjjmDanp-nR=YJRutejNWOXTS8u8Q@mail.gmail.com>
Subject: Re: [PATCH 04/44] Introduce BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 26 Jul 2023 at 14:52, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 110 +++++++++++++++++++++++++++
>  hw/arm/bcm2838_peripherals.c         |  72 ++++++++++++++++++
>  hw/arm/meson.build                   |   2 +
>  include/hw/arm/bcm2838.h             |  26 +++++++
>  include/hw/arm/bcm2838_peripherals.h |  36 +++++++++
>  5 files changed, 246 insertions(+)
>  create mode 100644 hw/arm/bcm2838.c
>  create mode 100644 hw/arm/bcm2838_peripherals.c
>  create mode 100644 include/hw/arm/bcm2838.h
>  create mode 100644 include/hw/arm/bcm2838_peripherals.h
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> new file mode 100644
> index 0000000000..dd650c8148
> --- /dev/null
> +++ b/hw/arm/bcm2838.c
> @@ -0,0 +1,110 @@
> +/*
> + * BCM2838 SoC emulation
> + *
> + * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/arm/raspi_platform.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/bcm2838.h"
> +#include "trace.h"
> +
> +struct BCM2838Class {
> +    /*< private >*/
> +    BCM283XBaseClass parent_class;
> +    /*< public >*/
> +    hwaddr peri_low_base; /* Lower peripheral base address seen by the CPU */
> +    hwaddr gic_base; /* GIC base address inside ARM local peripherals region */

Are these actually variable across different BCM2838 versions?
If not, don't bother making them configurable like this, just
have a #define of the address values and use it directly.
The BCM283[567] code only does this for peri_base and
ctrl_base so it can have one class that handles all three SoCs.

> +};

thanks
-- PMM

