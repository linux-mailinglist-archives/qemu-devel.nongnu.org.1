Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3477005A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRu5a-0000Ru-9F; Fri, 04 Aug 2023 08:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRu5X-0000R9-J3
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:39:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRu5V-0005vu-M3
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:39:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5222bc916acso2603136a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691152764; x=1691757564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=naOmLennGTxHrohODDi5gs9ofcm0ixIk7U39lYwPomo=;
 b=x1K+baHq1bvTcYXDFjUaWXD/kv1Uv13CbTwSF6QpWuNIL5RQLo12YLygQO6x9vqvPT
 2DQlVYmRhEveT3PwvLhd/JocbAf2KGiOosWMyh4xPm/6rI4zrc2YxalfLN4UthwnIhb8
 LDgGiz4IXrc4GkJwQ6++z4B/uPqtHRd4qz9LIEfr2ERb0NvZOjEo6qJB5Jk9T0WGlyjn
 mJsEV/TOUdjPhXPjD2akqqCstTwQiu+zVDykqnR2BfO0dFejdSLXCTZZNGyYFUDABgg9
 k8FSmj2meb8oCaXIjXVuPbdqo/nGPPtbMQM6KPMgCpcpM0n4ooarwh7gIhWbpB7vOqdY
 zOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691152764; x=1691757564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=naOmLennGTxHrohODDi5gs9ofcm0ixIk7U39lYwPomo=;
 b=BEwkhnFH3NGM8YhGatNXtArEqAJGAdbP/jG37VvreiVEl6WLAtTLEFMExAeQLsWpzU
 XQ2L+MazTc+qeyDLfPEl8jIohxZlaKutRxl2P2i0x6OdjAPJGX8yZKcj7HWP7jj0YFcS
 8IfPgyiyshXpDfEIX/YaWD08fPmM/TZzO+U/8ZTFMnaXCsnjnE7SqTQVBtB7H8UbSBoh
 aBfFX9tSqgUgVcn4fxhBM8ndCadz1jbmPy09T2iE2J+UXOE3aZWpZqJMT31B5wj6wo/W
 IHUSu/UrCvDDYZeox3alDsrVVoYdv/PFHxwUg5Qu3A1ISRLP4khaiNS2pSklcFdRJSw8
 /9GA==
X-Gm-Message-State: AOJu0YzIl/3WgjSO33i5Etv+t1/vGaVyX1b8vcc3YGUVxaJf/U+Kysba
 0LXPE9XowwOXud2WbVS2sD0p7eSufosahsXMUnDKNfRgmm+XkOtY
X-Google-Smtp-Source: AGHT+IGcLo83y/envAAqQEmZ56aVn/s8Q6eQ92EqzFOlJXuMKqG6JgrC2Lo7zFHRmRAHuM+AURpX85ANL4MjRFxHaPQ=
X-Received: by 2002:a05:6402:12d9:b0:51d:8aaf:5adc with SMTP id
 k25-20020a05640212d900b0051d8aaf5adcmr1526340edx.14.1691152764042; Fri, 04
 Aug 2023 05:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-12-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-12-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:39:13 +0100
Message-ID: <CAFEAcA95uedoxQf2aGLr++AJdmBALgGxNXTCHYrzGLO1QVyqUQ@mail.gmail.com>
Subject: Re: [PATCH 11/44] Introduce Raspberry PI 4 machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 26 Jul 2023 at 14:52, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2835_peripherals.c    |  20 +++-
>  hw/arm/bcm2836.c                |   2 +
>  hw/arm/bcm2838.c                |   2 +
>  hw/arm/meson.build              |   2 +-
>  hw/arm/raspi.c                  |  28 +++--
>  hw/arm/raspi4b.c                | 182 ++++++++++++++++++++++++++++++++
>  include/hw/arm/raspi_platform.h |  11 ++
>  include/hw/display/bcm2835_fb.h |   2 +
>  8 files changed, 235 insertions(+), 14 deletions(-)
>  create mode 100644 hw/arm/raspi4b.c


> +static void raspi4b_machine_class_init(MachineClass *mc, uint32_t board_rev)
> +{
> +    object_class_property_add(OBJECT_CLASS(mc), "vcram-size", "uint32",
> +                              get_vcram_size, set_vcram_size, NULL, NULL);
> +    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-size",
> +                                            "VideoCore RAM base address");
> +    object_class_property_add(OBJECT_CLASS(mc), "vcram-base", "uint32",
> +                              get_vcram_base, set_vcram_base, NULL, NULL);
> +    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-base",
> +                                            "VideoCore RAM size");

What are these properties for? I assume you can't change them
on a real raspi 4b board, so why do we need to expose them
to users?

> +
> +    raspi_machine_class_common_init(mc, board_rev);
> +    mc->init = raspi4b_machine_init;
> +}
> +
> +static void raspi4b1g_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev = 0xa03111;
> +    raspi4b_machine_class_init(mc, rmc->board_rev);
> +}
> +
> +static void raspi4b2g_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev = 0xb03112;
> +    raspi4b_machine_class_init(mc, rmc->board_rev);
> +}
> +
> +static void raspi4b4g_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev = 0xc03114;
> +    raspi4b_machine_class_init(mc, rmc->board_rev);
> +}
> +
> +static void raspi4b8g_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev = 0xd03114;
> +    raspi4b_machine_class_init(mc, rmc->board_rev);
> +}

The only differences between these machine types are the
amount of RAM, right? We shouldn't expose that to users
via different board names. Provide a single board
"raspi4b", give it whichever default amount of memory
seems reasonable (I would suggest 1GB or 2GB, it avoids
annoying problems with "make check" on 32-bit hosts), and
let the user pick a different amount of RAM with the -m option
as they usually would. (You can sanitize that to check they
only picked a valid amount of RAM.)

This seems also like a good point to ask for an extra patch
which updates docs/system/arm/raspi.rst to document the
new board type.

thanks
-- PMM

