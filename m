Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BC7430CC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 00:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF0Xu-0006vU-Ry; Thu, 29 Jun 2023 18:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qF0Xs-0006uf-Jq; Thu, 29 Jun 2023 18:55:24 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qF0Xq-0005FE-M8; Thu, 29 Jun 2023 18:55:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 868116154A;
 Thu, 29 Jun 2023 22:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26916C433C0;
 Thu, 29 Jun 2023 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688079319;
 bh=5CbRGVmEg7+h+/ULxccQ+hCw+r8cR8IokMTPkEESj2M=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Nda6+B3l4ABd8QfIfja6GMqQjmi17Vn1YF2bt1Z39Mcl6nwMDLoSTsBu0aLjke9Jk
 4LpgR7LLFJT/P8GmyWxokhdPsPzqQ+fVj9AQY5tkjg4TDHCAL9sG8uxPh9kNb/GtIX
 9WEUpBVHErIiksjn1wUSovzZofUFxzdMFRFs4HeGVunnHMMgl4xi0+Xg6qZt8nsgRp
 nb3UYfLefCmFy5MfY9ViRU8jBKJjHCwbDCvJGh3yOAU1rBW4Girs1Xo9U8pCsQpj0A
 djyLYozMmBV5ngw6l9l4XRTl4u+PqCSnhIiVowQUS88IBswE5aAe93sAdiAHeld0kB
 YEpitVnC2P6mw==
Date: Thu, 29 Jun 2023 15:55:17 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RESEND][PATCH v1 1/2] xen_arm: Create virtio-mmio devices during
 initialization
In-Reply-To: <20230629174310.14434-2-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2306291552070.3936094@ubuntu-linux-20-04-desktop>
References: <20230629174310.14434-1-vikram.garhwal@amd.com>
 <20230629174310.14434-2-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Jun 2023, Vikram Garhwal wrote:
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
>  hw/arm/xen_arm.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 60dcd1bcc7..c0a93f2c9d 100644
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
> @@ -59,6 +60,32 @@ struct XenArmState {
>      } cfg;
>  };
>  
> +#define VIRTIO_MMIO_DEV_SIZE   0x200

Is this coming from QEMU? Or is it standard virtio?

Just asking to make sure that we don't run into a virtio device that
needs more than 0x200 of MMIO size.


> +#define NR_VIRTIO_MMIO_DEVICES   \
> +   (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
> +
> +static void xen_set_irq(void *opaque, int irq, int level)
> +{
> +    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
> +}

Just a note: likely the xendevicemodel_set_irq_level call needs
privileges. Just something to keep in mind for when we try to run QEMU
in a domain other than Dom0. No need to do anything for now.

Everything looks good. If we can be sure 0x200 is the right MMIO size
for virtio devices then I would provide by Ack.


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
> @@ -110,6 +137,8 @@ static void xen_arm_init(MachineState *machine)
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

