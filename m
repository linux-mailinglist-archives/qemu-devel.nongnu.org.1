Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74A7C559B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZR7-0008J7-Tt; Wed, 11 Oct 2023 09:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZQi-0008Gx-Aa; Wed, 11 Oct 2023 09:39:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZQf-0000Lk-A8; Wed, 11 Oct 2023 09:39:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7395574632B;
 Wed, 11 Oct 2023 15:38:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3E33F7456AA; Wed, 11 Oct 2023 15:38:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3C821745681;
 Wed, 11 Oct 2023 15:38:14 +0200 (CEST)
Date: Wed, 11 Oct 2023 15:38:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/5] hw/ppc/ppc4xx_pci: Extract PCI host definitions to
 hw/pci-host/ppc4xx.h
In-Reply-To: <20231011132427.65001-3-philmd@linaro.org>
Message-ID: <df403047-ee4c-6092-3bca-d64167f3de13@eik.bme.hu>
References: <20231011132427.65001-1-philmd@linaro.org>
 <20231011132427.65001-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-802047450-1697031494=:10652"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-802047450-1697031494=:10652
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> ---
> MAINTAINERS                  |  1 +
> include/hw/pci-host/ppc4xx.h | 17 +++++++++++++++++
> include/hw/ppc/ppc4xx.h      |  5 -----
> hw/ppc/ppc440_bamboo.c       |  1 +
> hw/ppc/ppc440_pcix.c         |  2 +-
> hw/ppc/ppc440_uc.c           |  1 +
> hw/ppc/ppc4xx_pci.c          |  2 +-
> hw/ppc/sam460ex.c            |  1 +
> 8 files changed, 23 insertions(+), 7 deletions(-)
> create mode 100644 include/hw/pci-host/ppc4xx.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c07d07927..158896d03e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1969,6 +1969,7 @@ L: qemu-ppc@nongnu.org
> S: Orphan
> F: hw/ppc/ppc4*.c
> F: hw/i2c/ppc4xx_i2c.c
> +F: include/hw/pci-host/ppc4xx.h
> F: include/hw/ppc/ppc4xx.h
> F: include/hw/i2c/ppc4xx_i2c.h
> F: hw/intc/ppc-uic.c
> diff --git a/include/hw/pci-host/ppc4xx.h b/include/hw/pci-host/ppc4xx.h
> new file mode 100644
> index 0000000000..dc36e1ea29
> --- /dev/null
> +++ b/include/hw/pci-host/ppc4xx.h
> @@ -0,0 +1,17 @@
> +/*
> + * QEMU PowerPC 4xx PCI-host definitions
> + *
> + * Copyright (c) 2007 Jocelyn Mayer
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_PCIHOST_PPC4XX_H
> +#define HW_PCIHOST_PPC4XX_H
> +
> +#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
> +#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
> +#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
> +#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
> +
> +#endif
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index ea7740239b..1bd9b8821b 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -29,11 +29,6 @@
> #include "exec/memory.h"
> #include "hw/sysbus.h"
>
> -#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
> -#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
> -#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
> -#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
> -
> /*
>  * Generic DCR device
>  */
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 45f409c838..2049ff0eef 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -24,6 +24,7 @@
> #include "elf.h"
> #include "hw/char/serial.h"
> #include "hw/ppc/ppc.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "ppc405.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/reset.h"
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index e4dadbc84d..418dff6590 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -25,7 +25,7 @@
> #include "qemu/module.h"
> #include "qemu/units.h"
> #include "hw/irq.h"
> -#include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/pci/pci_device.h"
> #include "hw/pci/pci_host.h"
> #include "trace.h"
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 643a79e330..3a66b0c7f7 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -14,6 +14,7 @@
> #include "qemu/log.h"
> #include "hw/irq.h"
> #include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/qdev-properties.h"
> #include "hw/pci/pci.h"
> #include "sysemu/reset.h"
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 51c265f0ba..d2434a93ac 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -24,7 +24,7 @@
> #include "qemu/osdep.h"
> #include "qemu/log.h"
> #include "hw/irq.h"
> -#include "hw/ppc/ppc4xx.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> #include "sysemu/reset.h"
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1e615b8d35..a28498f39c 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -25,6 +25,7 @@
> #include "elf.h"
> #include "exec/memory.h"
> #include "ppc440.h"
> +#include "hw/pci-host/ppc4xx.h"
> #include "hw/block/flash.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/reset.h"
>
--3866299591-802047450-1697031494=:10652--

