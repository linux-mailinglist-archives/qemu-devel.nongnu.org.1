Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0B7D5338
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHnT-00022C-Pm; Tue, 24 Oct 2023 09:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qvHnG-0001u7-Vt
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qvHnE-0000hx-VC
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698155398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uz79ENvKJy3IcFQoj7GTONP9olciBa4kGEF7DUaeOE0=;
 b=YsCLhJFuUy1alPCPfsA8g16ar7uA3CUMGaJg9lu+uL2inNTSno03JUPHD2A2q3Ba6Nd4UH
 n5XId4PCa3ihkSUrxZRSW7LkcrA6Jv1c7xX9qvzCKzfPLn3G7rwXRHzoErIUC86NH+zk+V
 sB/2HckCbagmh5kAgeQSBjk2HRygsaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ZuQlgaePMzqtBaIllCiwQA-1; Tue, 24 Oct 2023 09:49:57 -0400
X-MC-Unique: ZuQlgaePMzqtBaIllCiwQA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5C63802891;
 Tue, 24 Oct 2023 13:49:56 +0000 (UTC)
Received: from [10.39.195.39] (unknown [10.39.195.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15BE0492BD9;
 Tue, 24 Oct 2023 13:49:52 +0000 (UTC)
Message-ID: <a6cda7bb-ccf0-b701-eed6-90f1826beba3@redhat.com>
Date: Tue, 24 Oct 2023 15:49:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] hw/arm/virt: allow creation of a second NonSecure UART
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Axel Heider <axel.heider@hensoldt.net>, Ard Biesheuvel <ardb@kernel.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231023161532.2729084-1-peter.maydell@linaro.org>
 <20231023161532.2729084-4-peter.maydell@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231023161532.2729084-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/23 18:15, Peter Maydell wrote:
> For some use-cases, it is helpful to have more than one UART
> available to the guest. If the second UART slot is not already
> used for a TrustZone Secure-World-only UART, create it as a
> NonSecure UART only when the user provides a serial backend
> (e.g. via a second -serial command line option).
> 
> This avoids problems where existing guest software only expects
> a single UART, and gets confused by the second UART in the DTB.
> The major example of this is older EDK2 firmware, which will
> send the GRUB bootloader output to UART1 and the guest
> serial output to UART0. Users who want to use both UARTs
> with a guest setup including EDK2 are advised to update
> to a newer EDK2.
> 
> TODO: give specifics of which EDK2 version has this fix,
> once the patches which fix EDK2 are upstream.

The patches should hopefully land in edk2-stable202311 (i.e., in the
November release).

The new ArmVirtQemu behavior is as follows:

- just one UART: same as before

- two UARTs: the UEFI console is on the "chosen" UART, and the edk2
DEBUG log is on the "first non-chosen" UART (i.e., on the "other" UART,
in practice).

series
Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


> 
> Inspired-by: Axel Heider <axel.heider@hensoldt.net>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This patch was originally based on the one from Axel Heider
> that aimed to do the same thing:
> https://lore.kernel.org/qemu-devel/166990501232.22022.16582561244534011083-1@git.sr.ht/
> but by the time I had added the ACPI support and dealt with
> the EDK2 compatibility awkwardness, I found I had pretty
> much rewritten it. So this combination of author and tags
> seemed to me the most appropriate, but I'm happy to adjust
> if people (esp. Axel!) would prefer otherwise.
> 
> It is in theory possible to slightly work around the
> incorrect behaviour of old EDK2 binaries by listing the
> two UARTs in the opposite order in the DTB. However since
> old EDK2 ends up using the two UARTs in different orders
> depending on which phase of boot it is in (and in particular
> with EDK2 debug builds debug messages go to a mix of both
> UARTs) this doesn't seem worthwhile. I think most users
> who are interested in the second UART are likely to be
> using a bare-metal or direct Linux boot anyway.
> ---
>  docs/system/arm/virt.rst |  6 +++++-
>  include/hw/arm/virt.h    |  1 +
>  hw/arm/virt-acpi-build.c | 12 ++++++++----
>  hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++---
>  4 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e1697ac8f48..028d2416d5b 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -26,7 +26,7 @@ The virt board supports:
>  
>  - PCI/PCIe devices
>  - Flash memory
> -- One PL011 UART
> +- Either one or two PL011 UARTs for the NonSecure World
>  - An RTC
>  - The fw_cfg device that allows a guest to obtain data from QEMU
>  - A PL061 GPIO controller
> @@ -48,6 +48,10 @@ The virt board supports:
>    - A secure flash memory
>    - 16MB of secure RAM
>  
> +The second NonSecure UART only exists if a backend is configured
> +explicitly (e.g. with a second -serial command line option) and
> +TrustZone emulation is not enabled.
> +
>  Supported guest CPU types:
>  
>  - ``cortex-a7`` (32-bit)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 0de58328b2f..da15eb342bd 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -150,6 +150,7 @@ struct VirtMachineState {
>      bool ras;
>      bool mte;
>      bool dtb_randomness;
> +    bool second_ns_uart_present;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 54f26640982..b812f33c929 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -77,11 +77,11 @@ static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
>  }
>  
>  static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> -                                           uint32_t uart_irq)
> +                               uint32_t uart_irq, int uartidx)
>  {
> -    Aml *dev = aml_device("COM0");
> +    Aml *dev = aml_device("COM%d", uartidx);
>      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0011")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
>  
>      Aml *crs = aml_resource_template();
>      aml_append(crs, aml_memory32_fixed(uart_memmap->base,
> @@ -860,7 +860,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      scope = aml_scope("\\_SB");
>      acpi_dsdt_add_cpus(scope, vms);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
> -                       (irqmap[VIRT_UART0] + ARM_SPI_BASE));
> +                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
> +    if (vms->second_ns_uart_present) {
> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
> +                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
> +    }
>      if (vmc->acpi_expose_flash) {
>          acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
>      }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index fd524aed6b6..7f60df7d7b2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -856,7 +856,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>  }
>  
>  static void create_uart(const VirtMachineState *vms, int uart,
> -                        MemoryRegion *mem, Chardev *chr)
> +                        MemoryRegion *mem, Chardev *chr, bool secure)
>  {
>      char *nodename;
>      hwaddr base = vms->memmap[uart].base;
> @@ -894,6 +894,8 @@ static void create_uart(const VirtMachineState *vms, int uart,
>          qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
>      } else {
>          qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
> +    }
> +    if (secure) {
>          /* Mark as not usable by the normal world */
>          qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
>          qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
> @@ -2269,11 +2271,41 @@ static void machvirt_init(MachineState *machine)
>  
>      fdt_add_pmu_nodes(vms);
>  
> -    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0));
> +    /*
> +     * The first UART always exists. If the security extensions are
> +     * enabled, the second UART also always exists. Otherwise, it only exists
> +     * if a backend is configured explicitly via '-serial <backend>'.
> +     * This avoids potentially breaking existing user setups that expect
> +     * only one NonSecure UART to be present (for instance, older EDK2
> +     * binaries).
> +     *
> +     * The nodes end up in the DTB in reverse order of creation, so we must
> +     * create UART0 last to ensure it appears as the first node in the DTB,
> +     * for compatibility with guest software that just iterates through the
> +     * DTB to find the first UART, as older versions of EDK2 do.
> +     * DTB readers that follow the spec, as Linux does, should honour the
> +     * aliases node information and /chosen/stdout-path regardless of
> +     * the order that nodes appear in the DTB.
> +     *
> +     * For similar back-compatibility reasons, if UART1 is the secure UART
> +     * we create it second (and so it appears first in the DTB), because
> +     * that's what QEMU has always done.
> +     */
> +    if (!vms->secure) {
> +        Chardev *serial1 = serial_hd(1);
> +
> +        if (serial1) {
> +            vms->second_ns_uart_present = true;
> +            create_uart(vms, VIRT_UART1, sysmem, serial1, false);
> +        }
> +    }
> +    create_uart(vms, VIRT_UART0, sysmem, serial_hd(0), false);
> +    if (vms->secure) {
> +        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1), true);
> +    }
>  
>      if (vms->secure) {
>          create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
> -        create_uart(vms, VIRT_UART1, secure_sysmem, serial_hd(1));
>      }
>  
>      if (tag_sysmem) {


