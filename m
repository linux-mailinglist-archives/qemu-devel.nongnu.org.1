Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC1733AC6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 22:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAG0Y-0001X2-8x; Fri, 16 Jun 2023 16:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qAG0V-0001WZ-UX
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 16:25:19 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qAG0U-0002AP-5c
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 16:25:19 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f6170b1486so1522836e87.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686947116; x=1689539116;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhGOzu/CHw61oHeSsYWFifHh/iJXjflPDV+VQUI07Gg=;
 b=Ok24Mcqa4fqD0P+7P2onBhvfovl6BU2DVFwCz8GK9YjhDBwMxhCF3rqyujHvFJ8bfP
 a8BIfpWXPaNgl3DPUL/eXCvTIpG3V9/tUzIGK0gNQ/obB7ZEEZFjbnqPlee7BFkKIWYr
 ufY8CLRYET0+qzON0VY+zvYkfsjddOcHDH8OchiliRNqf5tyDZRwabgufM/amLxe1L86
 BfAk6uIhuKSYCzFjciLj9PklIfSVqAV6qvze9NLoyFXJViSQuYGYVqjVRAC9vwYls2wR
 jQFNmKkYUvtLUBGR1cu/wfBgTo2eAs6pPT09Wz4dD3otYxeactDbIA+6reSgKjQp7dkM
 pdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686947116; x=1689539116;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhGOzu/CHw61oHeSsYWFifHh/iJXjflPDV+VQUI07Gg=;
 b=X/oSYgICdJSTYD1wtfHdXoCbCe83A+ilBiQwhj+AYP+EKzEaoU3VLjgmrrJQueahS9
 Jf8RH94gyXa150JFTs5qGeUh+ygjcoIbPgP+NFQPcppN/9cNCA/S9oAlWv++G8n+1dOY
 fvW8UXPWK+79bvIeJdWaBXYi0BAk+EtCP5HHmzV6Fdp/Ce9FTv2unvNTCF2eUmhqBiGA
 c/FaBGt0qL8mhpDBbPJ/6B4jKIfUNW+VCcEKMLEcf2E7Vn0xHKwdTrcPf8XVX2Qb/kDF
 +zQwNn+OtYPV9RHKSPMqL5YsgXAebD9WjRkOFyVi0M0Au9NKJjMu6LTXfwsrubEc3999
 qRpg==
X-Gm-Message-State: AC+VfDybvS9AtEhDc/pqrlFdzQfKeOLUrGIVu5DwV8+JaWgEZqOC/oCm
 yfYj8izWZNMEpEvq/vn5mepzjum8HPM=
X-Google-Smtp-Source: ACHHUZ6m4vmQKpLKFiNG9AlQywW/YUF9JscEZ0VBl7up4aT2Wt8gTpOJxt4DgV92ijpzTeE1RHWZPg==
X-Received: by 2002:a05:6512:1289:b0:4f6:19c3:da30 with SMTP id
 u9-20020a056512128900b004f619c3da30mr3046532lfs.29.1686947115273; 
 Fri, 16 Jun 2023 13:25:15 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 n2-20020ac242c2000000b004f765b80008sm1279157lfl.44.2023.06.16.13.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 13:25:14 -0700 (PDT)
Date: Fri, 16 Jun 2023 22:25:13 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Kinsey Moore <kinsey.moore@oarcorp.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Message-ID: <20230616202511.GI6984@fralle-msi>
References: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Jun 16] Fri 09:38:03, Kinsey Moore wrote:
> The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> platforms have two priority queues with separate interrupt sources for
> each. If the interrupt source for the second priority queue is not
> connected, they work in polling mode only. This change connects the
> second interrupt source for platforms where it is available. This patch
> has been tested using the lwIP stack with a Xilinx-supplied driver from
> their embeddedsw repository.
> 
> Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/xlnx-versal.c         | 12 +++++++++++-
>  hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
>  include/hw/arm/xlnx-versal.h |  1 +
>  include/hw/arm/xlnx-zynqmp.h |  1 +
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 60bf5fe657..cb79b855fd 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -252,9 +252,13 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          NICInfo *nd = &nd_table[i];
>          DeviceState *dev;
>          MemoryRegion *mr;
> +        OrIRQState *or_irq;
>  
>          object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
>                                  TYPE_CADENCE_GEM);
> +        or_irq = &s->lpd.iou.gem_irq_orgate[i];
> +        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
> +                                or_irq, TYPE_OR_IRQ);
>          dev = DEVICE(&s->lpd.iou.gem[i]);
>          /* FIXME use qdev NIC properties instead of nd_table[] */
>          if (nd->used) {
> @@ -264,6 +268,11 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
>          object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
>                                  &error_abort);
> +        object_property_set_int(OBJECT(or_irq),
> +                                "num-lines", 2, &error_fatal);
> +        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
> +        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
> +
>          object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
>                                   &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> @@ -271,7 +280,8 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
>          g_free(name);
>      }
>  }
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 5905a33015..f7158e4fd3 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -392,6 +392,8 @@ static void xlnx_zynqmp_init(Object *obj)
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
> +        object_initialize_child(obj, "gem-irq-orgate[*]",
> +                                &s->gem_irq_orgate[i], TYPE_OR_IRQ);
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> @@ -629,12 +631,19 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                                  &error_abort);
>          object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
>                                  &error_abort);
> +        object_property_set_int(OBJECT(&s->gem_irq_orgate[i]),
> +                                "num-lines", 2, &error_fatal);
> +        qdev_realize(DEVICE(&s->gem_irq_orgate[i]), NULL, &error_fatal);
> +        qdev_connect_gpio_out(DEVICE(&s->gem_irq_orgate[i]), 0, gic_spi[gem_intr[i]]);
> +
>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
>              return;
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
> -                           gic_spi[gem_intr[i]]);
> +                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 0));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
> +                           qdev_get_gpio_in(DEVICE(&s->gem_irq_orgate[i]), 1));
>      }
>  
>      for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 39ee31185c..d34c763329 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -74,6 +74,7 @@ struct Versal {
>          struct {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
> +            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>              CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 687c75e3b0..7e5abce467 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -117,6 +117,7 @@ struct XlnxZynqMPState {
>      MemoryRegion mr_unimp[XLNX_ZYNQMP_NUM_UNIMP_AREAS];
>  
>      CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
> +    OrIRQState gem_irq_orgate[XLNX_ZYNQMP_NUM_GEMS];
>      CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
>      XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
>      SysbusAHCIState sata;
> -- 
> 2.30.2
> 
> 

