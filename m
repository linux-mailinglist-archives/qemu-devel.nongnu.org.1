Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 178307C55B8
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZTq-00027k-7h; Wed, 11 Oct 2023 09:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZTn-000273-R5; Wed, 11 Oct 2023 09:42:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqZTb-00016C-DZ; Wed, 11 Oct 2023 09:42:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2567374632B;
 Wed, 11 Oct 2023 15:41:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D61AD7456AA; Wed, 11 Oct 2023 15:41:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D48A6745681;
 Wed, 11 Oct 2023 15:41:16 +0200 (CEST)
Date: Wed, 11 Oct 2023 15:41:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/5] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
In-Reply-To: <20231011132427.65001-5-philmd@linaro.org>
Message-ID: <8ce1ba6a-f4e0-44ce-d895-81f9ff236ce5@eik.bme.hu>
References: <20231011132427.65001-1-philmd@linaro.org>
 <20231011132427.65001-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1588952597-1697031676=:10652"
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

--3866299591-1588952597-1697031676=:10652
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
> ppc4xx_pci.c is moved from the target specific ppc_ss[] meson
> source set to pci_ss[] which is common to all targets: the
> object is built once.

At this point I'm not sure. This device is only used for PPC machines so 
it's kind of target specific. Why do you want to compile it for other 
targets?

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS                       | 1 +
> hw/{ppc => pci-host}/ppc4xx_pci.c | 0
> hw/pci-host/ppce500.c             | 2 +-
> hw/pci-host/meson.build           | 1 +
> hw/pci-host/trace-events          | 4 ++++
> hw/ppc/meson.build                | 1 -
> hw/ppc/trace-events               | 4 ----
> 7 files changed, 7 insertions(+), 6 deletions(-)
> rename hw/{ppc => pci-host}/ppc4xx_pci.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 158896d03e..d7af23c1be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1358,6 +1358,7 @@ Bamboo
> L: qemu-ppc@nongnu.org
> S: Orphan
> F: hw/ppc/ppc440_bamboo.c
> +F: hw/pci-host/ppc4xx_pci.c
> F: tests/avocado/ppc_bamboo.py
>
> e500
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
> similarity index 100%
> rename from hw/ppc/ppc4xx_pci.c
> rename to hw/pci-host/ppc4xx_pci.c
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index 38814247f2..c16bc255ed 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -5,7 +5,7 @@
>  *
>  * Author: Yu Liu,     <yu.liu@freescale.com>
>  *
> - * This file is derived from hw/ppc4xx_pci.c,
> + * This file is derived from ppc4xx_pci.c,
>  * the copyright for that material belongs to the original owners.
>  *
>  * This is free software; you can redistribute it and/or modify
> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
> index 64eada76fe..9cabac5d63 100644
> --- a/hw/pci-host/meson.build
> +++ b/hw/pci-host/meson.build
> @@ -14,6 +14,7 @@ pci_ss.add(when: 'CONFIG_REMOTE_PCIHOST', if_true: files('remote.c'))
> pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
>
> # PPC devices
> +pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
> pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
> pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
> # NewWorld PowerMac
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 9d216bb89f..f8afb28a01 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -37,6 +37,10 @@ unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64
> unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
> unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
>
> +# ppc4xx_pci.c
> +ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> +ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
> +
> # pnv_phb4.c
> pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
> pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 6931ba88b4..a4821da094 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -61,7 +61,6 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
> ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
>   'ppc4xx_devs.c',
>   'ppc4xx_sdram.c'))
> -ppc_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
> ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
> # PReP
> ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index f670e8906c..b59fbf340f 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -146,10 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
> rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
> rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>
> -# ppc4xx_pci.c
> -ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> -ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
> -
> # ppc440_pcix.c
> ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
> ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
>
--3866299591-1588952597-1697031676=:10652--

