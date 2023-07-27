Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A6765A26
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4BY-0003AD-Lz; Thu, 27 Jul 2023 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP4BV-00037s-RE
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:49:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP4BU-0006vq-3Q
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:49:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5217bb5ae05so1489605a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690476590; x=1691081390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Gog43nmYGFaOfneXZzqhRpcKKnJfPIUhs1hwzsNkXM=;
 b=pHuuaLg3SRndfzM+A1Eq6ZRvtLL/wY4K7jxog0OAH4Y62kY8wJzUfOjD6NOLpd1VSi
 V+oz0n8JbxdgFfal3pNQ4CuDVrZMn8o+NdF2NP25+FlcDgUgbBlGHPF7Oxwj1vpratLs
 nj2H4e2//df+Ii6Quq7t2F8yTerlAjljVzr3OHESYgQbty2vYd1ShbM0Ex1yZUVo1tG6
 zP4yJzbpPBGG/FLzQzFC6THt8dn29Na/HTml1ekFocEbI0cWB8SEI5Hs2GnXpooaZK61
 vOd5oo0EeGiGgicJd+eCiwmYhLBN8CEi+I/UMOlgzWysjoOCM5ap/shlpqUc7lrarJTs
 hh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690476590; x=1691081390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Gog43nmYGFaOfneXZzqhRpcKKnJfPIUhs1hwzsNkXM=;
 b=dl7GaprM4ovS/nrVn9s5i5j5TN9feiV2Pk7KSoNLoxmWs4RYkbEC0liAalSCC8kTGw
 oqINqlVxKhSrQ1gOe5uNDUIyWktShgH4Z5EVU1FW2h1nzGWS2e4dVY3OaBbQhhYHRIkT
 LewSocMvju9E6KFosqt+dijH+KWjtvC0R8gAA1e/RqfP45VC7WGa+hPIFgR9WJNvh3+K
 WafMnAoH2QqB5WPlNytgaMkE3rn5VaZwwZspbEl3OQHkajRzZtPneGXd/nlIRr382YzR
 GCd7k7y4Aq0kpkX4UYscc59S8P1pgPqlRcTgCx/wxOwmU24GH2ZeCBaf9XdFOwvrf3uk
 Ds2w==
X-Gm-Message-State: ABy/qLZlqyaslGnMYmqGKOLl+h2Cw1GpRmh76iqRx44bByvry6OBBElJ
 lEOUtWSSemkdg1RtQiCRXuRf85vnfFWgPb9m5hvqPg==
X-Google-Smtp-Source: APBJJlERfmm6rtttDc+rUhDjyKucN8BUeBmjwi66vrNq+21J9pp04fYp9F/cp3c86tEFTKuMMEthALzVUSZvE+xEQxM=
X-Received: by 2002:aa7:d303:0:b0:522:1eab:e466 with SMTP id
 p3-20020aa7d303000000b005221eabe466mr1978291edq.28.1690476590202; Thu, 27 Jul
 2023 09:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690385928.git.jcd@tribudubois.net>
 <d620c9fcf72507db73a3f31df9065bd417f72704.1690385928.git.jcd@tribudubois.net>
In-Reply-To: <d620c9fcf72507db73a3f31df9065bd417f72704.1690385928.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:49:39 +0100
Message-ID: <CAFEAcA_4wa5afcgSz6uZ3wHSj0oxjum60V5g9RBxkaX6LyTY+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Add i.MX7 SRC device implementation
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 26 Jul 2023 at 16:54, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
>
> From: jcdubois <jcd@tribudubois.net>
>
> The SRC device is normaly used to start the secondary CPU.
>
> When running Linux directly, Qemu is emulating a PSCI interface that UBOOT
> is installing at boot time and therefore the fact that the SRC device is
> unimplemented is hidden as Qemu respond directly to PSCI requets without
> using the SRC device.
>
> But if you try to run a more bare metal application (maybe uboot itself),
> then it is not possible to start the secondary CPU as the SRC is an
> unimplemented device.
>
> This patch adds the ability to start the secondary CPU through the SRC
> device so that you can use this feature in bare metal application.
>
> Signed-off-by: jcdubois <jcd@tribudubois.net>

I have a few style-type comments below, but overall this looks good.

> ---
>  hw/arm/fsl-imx7.c          |   9 +-
>  hw/misc/imx7_src.c         | 289 +++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build        |   1 +
>  include/hw/arm/fsl-imx7.h  |   2 +
>  include/hw/misc/imx7_src.h |  68 +++++++++
>  5 files changed, 368 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/imx7_src.c
>  create mode 100644 include/hw/misc/imx7_src.h
>
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 05cdd4831e..db103069e1 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -82,6 +82,11 @@ static void fsl_imx7_init(Object *obj)
>       */
>      object_initialize_child(obj, "gpcv2", &s->gpcv2, TYPE_IMX_GPCV2);
>
> +    /*
> +     * SRC
> +     */
> +    object_initialize_child(obj, "src", &s->src, TYPE_IMX7_SRC);
> +
>      /*
>       * ECSPIs
>       */
> @@ -90,6 +95,7 @@ static void fsl_imx7_init(Object *obj)
>          object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
>      }
>
> +
>      /*
>       * I2Cs
>       */

Stray whitespace change.

> @@ -490,7 +496,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>      /*
>       * SRC
>       */
> -    create_unimplemented_device("src", FSL_IMX7_SRC_ADDR, FSL_IMX7_SRC_SIZE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->src), &error_abort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX7_SRC_ADDR);
>
>      /*
>       * Watchdogs


> +#define DPRINTF(fmt, args...) \
> +    do { \
> +        if (DEBUG_IMX7_SRC) { \
> +            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX7_SRC, \
> +                                             __func__, ##args); \
> +        } \
> +    } while (0)

Please don't add DEBUG/DPRINTF macros in new code. Use
tracepoints instead.

> +#define EXTRACT(value, name) extract32(value, name##_SHIFT, name##_LENGTH)

Please don't define new wrappers around extract32() and
friends. If you want to have something name based, use
FIELD_EX32() from hw/registerfields.h.

thanks
-- PMM

