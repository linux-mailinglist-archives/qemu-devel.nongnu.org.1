Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD97A4777
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBm2-0008Gt-LA; Mon, 18 Sep 2023 06:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBll-0008FK-7h
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:46:30 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBlj-0006rt-2J
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:46:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so5003765a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033976; x=1695638776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJ/64b4swMyjvK8kPqgOOGCl81yHEYjOn1hgLk+o2TQ=;
 b=kk7mBAKkpp7xWPtTHM1F23s4IWsGBe/qkLIOUtEQI2nildqIR8WuwdAPbjwWoPFs+c
 UDtYdvkqZJlueV7A59zWYaNGk3QrAWNLS4KswUdWSjDFNihlyjT/Uq/ig175NIgIAaM5
 M5NL3uZ9ipZhBSxSZEXPGrSJwG5bCNpqy48x8i1Tu4wiB96DowZZ+xsWCDwF8J5bMWQN
 gxOfh/ElKvm9yNtPFghfw1JDyE589+pGEG9pGGfhk6fbjIsqlZeXIuRF42I8LSvQ1ppE
 wNSOsClsFEDkupJ4aWKK6FuGQMNMcAq5R5TWDzBcY/6ZCaFxakmPQUU/8apOABPvIxQr
 RuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033976; x=1695638776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJ/64b4swMyjvK8kPqgOOGCl81yHEYjOn1hgLk+o2TQ=;
 b=JiXbivp+oNmmwZp9cjFIhISDvX6c5NsidANxdtvWC3r00oCuFoqrt/gXcyKfrLU1jX
 Aq5+dvEmKPi0Ooec/QKr0PYUZ+zZHeapznpp63gXIOlN8I4FHLlqZ4T6M1K56loi44of
 v9rpZJCQ5XqPnbkI6VGnBemulBpoJ60umKXkKPViGgEAIe9MUQcVjUHc9ZwmeEo+AHCB
 iEl9bc0lQ9b9TAT1fvVBIUSbLgzyNL7cGzTgaOF6yT58xwX1053r9xZ7l7V4rt1yPt5a
 OvJMnlRxEqeEwuKEl6ux0MrFpzEJMGNmmZnjByxRHKAH1awZcMssM95hY2WFw67Vzcbh
 5kNw==
X-Gm-Message-State: AOJu0YyvTOUkomPezj2rCBHb6e5vFsDEKOZ3F0AJK/Sz2HS8VI8tcAkJ
 xPkhMtD07Rh2mMayaQl/uwdsHf+YzFqZMU71kfJ3kA==
X-Google-Smtp-Source: AGHT+IH4EHSDbNQP8Uj2965WjyL7gwlM2X6BM6y1xo0ZTlsBzmHkjXt20oefZJtCGZfCxq2YyrpCQuaL1F+mmCsj6as=
X-Received: by 2002:a05:6402:b73:b0:530:bdb0:6cb3 with SMTP id
 cb19-20020a0564020b7300b00530bdb06cb3mr5170705edb.28.1695033976568; Mon, 18
 Sep 2023 03:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230915115535.129834-1-quic_llindhol@quicinc.com>
 <20230915115535.129834-4-quic_llindhol@quicinc.com>
In-Reply-To: <20230915115535.129834-4-quic_llindhol@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 11:45:57 +0100
Message-ID: <CAFEAcA9avj+vMb1gAzzcJKFJbqC10T_QAyOvRW=i3LWO35LVkQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] hw/arm/sbsa-ref: use bsa.h for PPI definitions
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 15 Sept 2023 at 12:55, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> Use the private peripheral interrupt definitions from bsa.h instead of
> defining them locally. Refactor to use PPI() to convert from INTID macro
> where necessary.
>
> Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
> ---
>  hw/arm/sbsa-ref.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index bc89eb4806..3a4ea4dfdd 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -2,6 +2,7 @@
>   * ARM SBSA Reference Platform emulation
>   *
>   * Copyright (c) 2018 Linaro Limited
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
>   *
>   * This program is free software; you can redistribute it and/or modify it
> @@ -30,6 +31,7 @@
>  #include "exec/hwaddr.h"
>  #include "kvm_arm.h"
>  #include "hw/arm/boot.h"
> +#include "hw/arm/bsa.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/block/flash.h"
> @@ -55,13 +57,6 @@
>  #define NUM_SMMU_IRQS   4
>  #define NUM_SATA_PORTS  6
>
> -#define VIRTUAL_PMU_IRQ        7
> -#define ARCH_GIC_MAINT_IRQ     9
> -#define ARCH_TIMER_VIRT_IRQ    11
> -#define ARCH_TIMER_S_EL1_IRQ   13
> -#define ARCH_TIMER_NS_EL1_IRQ  14
> -#define ARCH_TIMER_NS_EL2_IRQ  10
> -
>  enum {
>      SBSA_FLASH,
>      SBSA_MEM,
> @@ -494,15 +489,19 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
>          for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
>              qdev_connect_gpio_out(cpudev, irq,
>                                    qdev_get_gpio_in(sms->gic,
> -                                                   ppibase + timer_irq[irq]));
> +                                                   ppibase
> +                                                   + PPI(timer_irq[irq])));
>          }
>
>          qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
> -                                    qdev_get_gpio_in(sms->gic, ppibase
> -                                                     + ARCH_GIC_MAINT_IRQ));
> +                                    qdev_get_gpio_in(sms->gic,
> +                                                     ppibase
> +                                                     + PPI(ARCH_GIC_MAINT_IRQ)));
> +
>          qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
> -                                    qdev_get_gpio_in(sms->gic, ppibase
> -                                                     + VIRTUAL_PMU_IRQ));
> +                                    qdev_get_gpio_in(sms->gic,
> +                                                     ppibase
> +                                                     + PPI(VIRTUAL_PMU_IRQ)));
>
>          sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>          sysbus_connect_irq(gicbusdev, i + smp_cpus,

You could also change the definition of ppibase not to add GIC_NR_SGIS
(perhaps renaming it) and then you wouldn't need to use the PPI() macro here...

-- PMM

