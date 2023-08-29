Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418078BC1E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 02:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qamXM-0004nu-Ig; Mon, 28 Aug 2023 20:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qamXK-0004nX-Ef
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:24:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qamXH-0005Tw-LQ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:24:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 54FD36423C;
 Tue, 29 Aug 2023 00:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2894BC433C7;
 Tue, 29 Aug 2023 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693268685;
 bh=f5A9kKZDP9wfvP6nDeDfRLpi2VU1b0Eoni0h7dP5Bew=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=YeqPalOcpDPNiIQhmn3pQnakQTq3yvg704Yuc5dXn6dYwl21CsSkxPqaKbfWo+DgL
 h5i1ro+2h3jlYXpV1EG6wot/QA7OOsO3C8N6lCJpIXdqAKgTLnjZDOK+NPH75bsO+/
 4YP7ptXI2YlZaybKFnx99jX912c8nZn2f+9Gg18+3m1/C9Kwrk3jGwaWy2BiUmChOJ
 osBh9rwrZORjFYbdmNV66Atz4Nl+9gbe3+mSqEQEPjEHer/lLivZyiqMVUcZfHrjoF
 bgtyzz4Bf+R7Ad7pplfWRzCVTEAJlA3eEoqmeVME+8eSLhUGoe9MbVbfK4Drycm9hN
 Zh19F+TGvr4/A==
Date: Mon, 28 Aug 2023 17:24:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v3 2/2] xen_arm: Initialize RAM and add hi/low
 memory regions
In-Reply-To: <20230825225326.9438-3-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2308281724140.6458@ubuntu-linux-20-04-desktop>
References: <20230825225326.9438-1-vikram.garhwal@amd.com>
 <20230825225326.9438-3-vikram.garhwal@amd.com>
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
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
> ---
>  hw/arm/xen_arm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index d1e9f7b488..aa8b6171ad 100644
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
> @@ -80,6 +82,14 @@ static int xendevicemodel_set_irq_level(
>  }
>  #endif
>  
> +#if defined(__i386__) || defined(__x86_64__)
> +#define GUEST_RAM_BANKS   2
> +#define GUEST_RAM0_BASE   0x40000000ULL /* 3GB of low RAM @ 1GB */
> +#define GUEST_RAM0_SIZE   0xc0000000ULL
> +#define GUEST_RAM1_BASE   0x0200000000ULL /* 1016GB of RAM @ 8GB */
> +#define GUEST_RAM1_SIZE   0xfe00000000ULL
> +#endif

Also here please move to include/hw/xen/xen_native.h


>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
>  #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
>  #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
> @@ -108,6 +118,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
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
> @@ -157,6 +200,14 @@ static void xen_arm_init(MachineState *machine)
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
> @@ -204,6 +255,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = xen_arm_init;
>      mc->max_cpus = 1;
>      mc->default_machine_opts = "accel=xen";
> +    /* Set explicitly here to make sure that real ram_size is passed */
> +    mc->default_ram_size = 0;
>  
>  #ifdef CONFIG_TPM
>      object_class_property_add(oc, "tpm-base-addr", "uint64_t",
> -- 
> 2.17.1
> 

