Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775678E448
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 03:22:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbWN9-0003uV-5j; Wed, 30 Aug 2023 21:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbWN7-0003tp-Tr
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:21:21 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbWN5-0005IV-0y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:21:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id D993FCE1F52;
 Thu, 31 Aug 2023 01:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7384BC433C8;
 Thu, 31 Aug 2023 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693444873;
 bh=1W2dwato+cMipbrf3KqufgJM8ww8MZMwe8GfsrLCKkY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=UjuseZSmw7KegvK3hxh+2dinBDZYR/C1PBblWB3pICy25yWK4ZqyT7yJfGV5EEQce
 /Lj54W7HOYgNRdGQzm87qyezMuApxDVyUHLje09KWg30zDyeGPWmLd3soKxUrqvOEs
 r5yMZ+AxqatAaRQX1ZdYH6ghT/H/K1ASoL4iRsxIYkIog+oaFLsD//45CBwamP//2+
 LkI+U7OQ2Dxhj3In6S8vWrDL6aovwlJy34QUv54AMegsNOZ95oq+uywQatGg/9qI6d
 Nb7CetZGtP2q3G6+vzGnXUrbGpHYg1vTKfTTkwXksX2Ewu41aSB18MSM2tSvfRNLsD
 yO9W91t/NtUIA==
Date: Wed, 30 Aug 2023 18:21:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v4 2/2] xen_arm: Initialize RAM and add hi/low
 memory regions
In-Reply-To: <20230830043518.21584-3-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2308301821030.6458@ubuntu-linux-20-04-desktop>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
 <20230830043518.21584-3-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
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

On Tue, 29 Aug 2023, Vikram Garhwal wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> In order to use virtio backends we need to initialize RAM for the
> xen-mapcache (which is responsible for mapping guest memory using foreign
> mapping) to work. Calculate and add hi/low memory regions based on
> machine->ram_size.
> 
> Use the constants defined in public header arch-arm.h to be aligned with the xen
> toolstack.
> 
> While using this machine, the toolstack should then pass real ram_size using
> "-m" arg. If "-m" is not given, create a QEMU machine without IOREQ and other
> emulated devices like TPM and VIRTIO. This is done to keep this QEMU machine
> usable for /etc/init.d/xencommons.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c            | 45 +++++++++++++++++++++++++++++++++++++
>  include/hw/xen/xen_native.h |  8 +++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 7393b37355..f83b983ec5 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -60,6 +60,8 @@ struct XenArmState {
>      } cfg;
>  };
>  
> +static MemoryRegion ram_lo, ram_hi;
> +
>  /*
>   * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
>   * repository.
> @@ -92,6 +94,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
>      }
>  }
>  
> +static void xen_init_ram(MachineState *machine)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
> +
> +    if (machine->ram_size <= GUEST_RAM0_SIZE) {
> +        ram_size[0] = machine->ram_size;
> +        ram_size[1] = 0;
> +        block_len = GUEST_RAM0_BASE + ram_size[0];
> +    } else {
> +        ram_size[0] = GUEST_RAM0_SIZE;
> +        ram_size[1] = machine->ram_size - GUEST_RAM0_SIZE;
> +        block_len = GUEST_RAM1_BASE + ram_size[1];
> +    }
> +
> +    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
> +                           &error_fatal);
> +
> +    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
> +                             GUEST_RAM0_BASE, ram_size[0]);
> +    memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
> +    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
> +            GUEST_RAM0_BASE, ram_size[0]);
> +
> +    if (ram_size[1] > 0) {
> +        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
> +                                 GUEST_RAM1_BASE, ram_size[1]);
> +        memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
> +        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
> +                GUEST_RAM1_BASE, ram_size[1]);
> +    }
> +}
> +
>  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
>  {
>      hw_error("Invalid ioreq type 0x%x\n", req->type);
> @@ -141,6 +176,14 @@ static void xen_arm_init(MachineState *machine)
>  
>      xam->state =  g_new0(XenIOState, 1);
>  
> +    if (machine->ram_size == 0) {
> +        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
> +                "(no emulated devices including Virtio)\n");
> +        return;
> +    }
> +
> +    xen_init_ram(machine);
> +
>      xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
>  
>      xen_create_virtio_mmio_devices(xam);
> @@ -188,6 +231,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = xen_arm_init;
>      mc->max_cpus = 1;
>      mc->default_machine_opts = "accel=xen";
> +    /* Set explicitly here to make sure that real ram_size is passed */
> +    mc->default_ram_size = 0;
>  
>  #ifdef CONFIG_TPM
>      object_class_property_add(oc, "tpm-base-addr", "uint64_t",
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index a4b1aa9e5d..5d2718261f 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -539,4 +539,12 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
>  #define GUEST_VIRTIO_MMIO_SPI_LAST    43
>  #endif
>  
> +#if defined(__i386__) || defined(__x86_64__)
> +#define GUEST_RAM_BANKS   2
> +#define GUEST_RAM0_BASE   0x40000000ULL /* 3GB of low RAM @ 1GB */
> +#define GUEST_RAM0_SIZE   0xc0000000ULL
> +#define GUEST_RAM1_BASE   0x0200000000ULL /* 1016GB of RAM @ 8GB */
> +#define GUEST_RAM1_SIZE   0xfe00000000ULL
> +#endif
> +
>  #endif /* QEMU_HW_XEN_NATIVE_H */
> -- 
> 2.17.1
> 

