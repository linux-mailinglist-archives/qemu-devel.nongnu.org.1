Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C874BA3C
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 01:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHvHP-0006AE-Qm; Fri, 07 Jul 2023 19:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qHvHN-00069m-O3; Fri, 07 Jul 2023 19:54:25 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qHvHL-0001P9-SK; Fri, 07 Jul 2023 19:54:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C855D61AC1;
 Fri,  7 Jul 2023 23:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57684C433C7;
 Fri,  7 Jul 2023 23:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688774053;
 bh=RW2S9upzfXkfAXnXepYERJxv4cTYcGMyd9C31IJsVto=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=fGHVLB0KOTFGifeAUiKec1zRwb2DwozlNIhvt3kz10z0yS3WWdb9trHySgSOULx1p
 PjQf3rrueB8xELQRPtft+IctYab7WJ6x5xmWeZ3MXlC35EW9pa7Nr1OuzXZwbwxnDl
 fxi2vkvCWnxtBGaNiDkSa78MyVH/K4Bv8vDV3zDLQI622i3x9nkgk9ffSQvvl46DDT
 V7pvdCftJhQ/VoIrc1u/cqzy6kjXlRi8Xh2RN4XMrQ0MclMlzvrN8CgNNEAC/BTif1
 GjiCS+I6r6kSpZjZ5LUd8oaXqy40pxp6dKqGakO36OiaEVvsp8o00SqM9BXoF/BIW2
 dI7k23eXww4qA==
Date: Fri, 7 Jul 2023 16:54:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [QEMU][PATCH v2 1/2] xen_arm: Create virtio-mmio devices during
 initialization
In-Reply-To: <20230707220358.920-2-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2307071654030.761183@ubuntu-linux-20-04-desktop>
References: <20230707220358.920-1-vikram.garhwal@amd.com>
 <20230707220358.920-2-vikram.garhwal@amd.com>
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
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 7 Jul 2023, Vikram Garhwal wrote:
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

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 044093fec7..e700829654 100644
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
> @@ -59,6 +60,38 @@ struct XenArmState {
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
> @@ -110,6 +143,8 @@ static void xen_arm_init(MachineState *machine)
>  
>      xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
>  
> +    xen_create_virtio_mmio_devices(xam);
> +
>  #ifdef CONFIG_TPM
>      if (xam->cfg.tpm_base_addr) {
>          xen_enable_tpm(xam);
> -- 
> 2.25.1
> 

