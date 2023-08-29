Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F478BC1F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 02:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qamWo-0004kA-L6; Mon, 28 Aug 2023 20:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qamWl-0004k2-A5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:24:15 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qamWi-0005Qa-Pz
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:24:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4D3D62CBC;
 Tue, 29 Aug 2023 00:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5DDC433C7;
 Tue, 29 Aug 2023 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693268649;
 bh=MlpqsXl5WGMvG25wBmKwo8fvGjYImjzpF8ackHzpaPo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=jF6BhOcXNQCrAAxPBw3AB42rbj9DmyjQH9WMDD3DdhrEdwA8pb2exqDHrYBF0qCbN
 /OAR4eCqGQN7Qur0w7a30R58pu63aJBn+cdlWAbgSczwy0tVCy+xHM40NX4I4NBfea
 fVsqQpCV4Q6LVVYrSuTcY4I/7OVYzLTwcQgo0WmRDfid7QH6WGnbRifq4yspFkRAjZ
 wBgRgF46cgFZWwTPRO83jweGMB2yHJlKza+mMIeBaBWsue+6Q93caEwM6SvcH8QOGt
 zCmmZB6M8dOfOHTgNi4U42G1lEdm2NHP54yLFOhLTveDzdIQVOeQhMdHg1Vi7L+kBg
 hstMq7Acvty8Q==
Date: Mon, 28 Aug 2023 17:24:06 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v3 1/2] xen_arm: Create virtio-mmio devices during
 initialization
In-Reply-To: <20230825225326.9438-2-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2308281723120.6458@ubuntu-linux-20-04-desktop>
References: <20230825225326.9438-1-vikram.garhwal@amd.com>
 <20230825225326.9438-2-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, 25 Aug 2023, Vikram Garhwal wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> In order to use virtio backends we need to allocate virtio-mmio
> parameters (irq and base) and register corresponding buses.
> 
> Use the constants defined in public header arch-arm.h to be
> aligned with the toolstack. So the number of current supported
> virtio-mmio devices is 10.
> 
> For the interrupts triggering use already existing on Arm
> device-model hypercall.
> 
> The toolstack should then insert the same amount of device nodes
> into guest device-tree.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> ---
>  hw/arm/xen_arm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 1d3e6d481a..d1e9f7b488 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -26,6 +26,7 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/visitor.h"
>  #include "hw/boards.h"
> +#include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/tpm_backend.h"
> @@ -59,6 +60,54 @@ struct XenArmState {
>      } cfg;
>  };
>  
> +/*
> + * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
> + * repository.
> + *
> + * Origin: git://xenbits.xen.org/xen.git 2128143c114c
> + */
> +#define VIRTIO_MMIO_DEV_SIZE   0x200
> +
> +#define NR_VIRTIO_MMIO_DEVICES   \
> +   (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
> +
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
> +static int xendevicemodel_set_irq_level(
> +    xendevicemodel_handle *dmod, domid_t domid, uint32_t irq,
> +    unsigned int level)
> +{
> +    return 0;
> +}
> +#endif
> +
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> +#define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
> +#define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
> +#define GUEST_VIRTIO_MMIO_SPI_FIRST   33
> +#define GUEST_VIRTIO_MMIO_SPI_LAST    43
> +#endif

Thanks Vikram. Please move this compat definitions to
include/hw/xen/xen_native.h


> +static void xen_set_irq(void *opaque, int irq, int level)
> +{
> +    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
> +}
> +
> +static void xen_create_virtio_mmio_devices(XenArmState *xam)
> +{
> +    int i;
> +
> +    for (i = 0; i < NR_VIRTIO_MMIO_DEVICES; i++) {
> +        hwaddr base = GUEST_VIRTIO_MMIO_BASE + i * VIRTIO_MMIO_DEV_SIZE;
> +        qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
> +                                         GUEST_VIRTIO_MMIO_SPI_FIRST + i);
> +
> +        sysbus_create_simple("virtio-mmio", base, irq);
> +
> +        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
> +                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
> +    }
> +}
> +
>  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
>  {
>      hw_error("Invalid ioreq type 0x%x\n", req->type);
> @@ -110,6 +159,8 @@ static void xen_arm_init(MachineState *machine)
>  
>      xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
>  
> +    xen_create_virtio_mmio_devices(xam);
> +
>  #ifdef CONFIG_TPM
>      if (xam->cfg.tpm_base_addr) {
>          xen_enable_tpm(xam);
> -- 
> 2.17.1
> 

