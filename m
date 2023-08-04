Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C376FF03
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRsOI-0006fz-8W; Fri, 04 Aug 2023 06:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRsOD-0006dd-2e
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:50:37 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRsOB-0000lC-Jq
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:50:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52229f084beso2553660a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691146234; x=1691751034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CBte90KkZE5akt8HAMxjmTRMK5nngpTSTOeX7Qep2eI=;
 b=uuHp4LVpapRvZ3ntfxgISF01/QFw/eRrLtCduYv7DrGyO7vUajnQ972zcZnV9SWquv
 4JmzCP1DptYAwZ4lhhqbGCs/DJA+WRWUAfSXKvVD0LNfPCzAwT3e8c2n+Hn+Sm434vjX
 aXLRuVEzJbh35MGoaU6B86QbQ3mOzfyvdQpJuFlf3UKij2RtCvPNyj5KVjuXge9bvrUg
 GvHGlED2fs+yT6lC88+ZYBcwwyQLzcx57Rnibkn3BfPW7qRwTbdXiIkxvkx4qgVwFVzy
 b8Dv10Bizbur0v19VzU95yYGS6bl72vkRU7nmqsSHV/C65SOqCi57Gi5veyqY7MP/t8t
 qV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691146234; x=1691751034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBte90KkZE5akt8HAMxjmTRMK5nngpTSTOeX7Qep2eI=;
 b=MKqqt3mkXsc2VFehRpCRL23dL/AnbfHX2VIgqEISndIuUXrVhk88LflcQBMvvR34Sr
 NJzayICHjZC1gToc0Wylm1tFnfwUvEiQ3Wt6jTZW19Gm9zorsZhI2ACvmt5v5jYhCUKC
 4HGeiASnrwkEH886V38RtyTGcFC4WxXs5OoWKQaXRrJP+lblsAgZ3EPn0HH4+bSXEuwx
 vBHNIPhvCswtQnURruxgamTKxCAKNiiZig2jj8eZgAlIZRNCkGQa5UKxmjpaft8BxUkI
 5EOR4ZRjfplrkgBnl0kXBmPmgLO0D8sG3Dhfm30ILzvELiezc8irF1z+0j/z546lWBKt
 1mIQ==
X-Gm-Message-State: AOJu0YyHEWHOXjlFLQzS7T5EcrIqnSqQ+EW3rLMr7wllDyUyXs17eeza
 M5F4duPvwKGR/FgX2huxnCc4jWDzkR4Y8jkioHJlLg==
X-Google-Smtp-Source: AGHT+IHYltIM1xS2jxniC0FMhAFo+DvbdALpKvb352Z6QfBKnY8UL/sp3PFM5A/xgu9IVyEUowTWLDM6WYLETDnktws=
X-Received: by 2002:aa7:c7cf:0:b0:522:2ba9:6fce with SMTP id
 o15-20020aa7c7cf000000b005222ba96fcemr1407505eds.8.1691146233891; Fri, 04 Aug
 2023 03:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-6-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-6-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 11:50:22 +0100
Message-ID: <CAFEAcA9pw9_EY_muZLvsD5mzp0oK-ootvTxhkumBZWvTxkw6Rw@mail.gmail.com>
Subject: Re: [PATCH 05/44] Add GIC-400 to BCM2838 SoC
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 26 Jul 2023 at 15:37, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838.c                     | 167 +++++++++++++++++++++++++++
>  hw/arm/trace-events                  |   2 +
>  include/hw/arm/bcm2838.h             |   2 +
>  include/hw/arm/bcm2838_peripherals.h |  39 +++++++
>  4 files changed, 210 insertions(+)
>
> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
> index dd650c8148..c687f38a39 100644
> --- a/hw/arm/bcm2838.c
> +++ b/hw/arm/bcm2838.c
> @@ -22,8 +22,36 @@ struct BCM2838Class {
>      hwaddr gic_base; /* GIC base address inside ARM local peripherals region */
>  };
>
> +#define GIC400_MAINTAINANCE_IRQ      9

"MAINTENANCE"

> diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
> index 8214003baf..0aed6f1bec 100644
> --- a/include/hw/arm/bcm2838_peripherals.h
> +++ b/include/hw/arm/bcm2838_peripherals.h
> @@ -11,6 +11,41 @@
>
>  #include "hw/arm/bcm2835_peripherals.h"
>
> +#define GENET_OFFSET            0x1580000

I'm guessing this #define ought to be in a later patch.

Otherwise:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

