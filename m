Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14F78F8E8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 09:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbyFq-0006IZ-RQ; Fri, 01 Sep 2023 03:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbyFP-0006F8-5R; Fri, 01 Sep 2023 03:07:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbyFK-0003IC-T6; Fri, 01 Sep 2023 03:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LGToadwRYtgEcu87UjY4Pv4J97i1Au7X11sOJmjlX90=; b=Gc7h5lCC1xJfQnywuhj7TYf8lG
 77CVIS315HE75Y4eSvlie5U/Oa8H06yNGzhYiKSZ/3LZhkjqOFkyG6p4WCRXvF5q4DBMBMKD0xq32
 Z3Nvnl7fZCCDnXk8HMeiQgotUY5ikj5d8XkvhdC+kgtweVJGTD1oQPcNZ3cREANefLfoOsTt61grk
 TFu1vPbVxqXKgkIrDKvLEly4jlTHdYZItBVFkGTgC/cpRqgIk2vSj6GM/y8jWF5GHA2v6PaNXQqbs
 hzLDsEprDU1ixHjqQWxW/6Lk0AVRYV5sphNlKO8kjKWbhgCPjk64pSdpm4d4B1X9QOFVqAkn1aI0f
 2sRpVKUS5s0F3i59J5sc28lwtEVCAB4LJl4hWWo2ClqsaKJVV5pKrFXbY7jBPjIezBL5xNEMzd75X
 lypoAzovQaStMOr4J4txyp1wGBpcZLVNe9piyN1d8fD73Eir8vMGfyo5ivksIs9tCPm5QcsW4Fogf
 TN5joEW7tfSHpmvmCS70FB53iQPFlvdPEYpbctO2rrn88Q5FnsWqQEDdsohm5stg/YvqJWDPwExtq
 Q+xd6985xVkQF2UKqTHrufB6ur4hXP1TU0PKO6nuH8RVhnHb7v+G9O+CI1jcR8VvLej6uAByVrkjC
 zhLCbFJldpkg1OZHmHqnIqoMnkCV+KfKlkpnL47Ak=;
Received: from [2a00:23c4:8bae:9a00:dd88:5208:9abb:2b35]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qbyEi-0000nF-7Z; Fri, 01 Sep 2023 08:06:36 +0100
Message-ID: <53eb9f91-8df0-373e-87c2-e3af25a910ae@ilande.co.uk>
Date: Fri, 1 Sep 2023 08:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-13-graf@amazon.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230830161425.91946-13-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:9a00:dd88:5208:9abb:2b35
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 12/12] hw/vmapple/vmapple: Add vmapple machine type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 30/08/2023 17:14, Alexander Graf wrote:

Hi Alex,

> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>    - Adapt to system_ss meson.build target
>    - Add documentation
> ---
>   MAINTAINERS                 |   1 +
>   docs/system/arm/vmapple.rst |  63 ++++
>   docs/system/target-arm.rst  |   1 +
>   hw/vmapple/vmapple.c        | 661 ++++++++++++++++++++++++++++++++++++
>   hw/vmapple/Kconfig          |  19 ++
>   hw/vmapple/meson.build      |   1 +
>   6 files changed, 746 insertions(+)
>   create mode 100644 docs/system/arm/vmapple.rst
>   create mode 100644 hw/vmapple/vmapple.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3104e58eff..1d3b1e0034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2578,6 +2578,7 @@ M: Alexander Graf <agraf@csgraf.de>
>   S: Maintained
>   F: hw/vmapple/*
>   F: include/hw/vmapple/*
> +F: docs/system/arm/vmapple.rst
>   
>   Subsystems
>   ----------
> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> new file mode 100644
> index 0000000000..c7486b21d9
> --- /dev/null
> +++ b/docs/system/arm/vmapple.rst
> @@ -0,0 +1,63 @@
> +VMApple machine emulation
> +========================================================================================
> +
> +VMApple is the device model that the macOS built-in hypervisor called "Virtualization.framework"
> +exposes to Apple Silicon macOS guests. The "vmapple" machine model in QEMU implements the same
> +device model, but does not use any code from Virtualization.Framework.
> +
> +Prerequisites
> +-------------
> +
> +To run the vmapple machine model, you need to
> +
> + * Run on Apple Silicon
> + * Run on macOS 12.0 or above
> + * Have an already installed copy of a Virtualization.Framework macOS virtual machine. I will
> +   assume that you installed it using the macosvm CLI.
> +
> +First, we need to extract the UUID from the virtual machine that you installed. You can do this
> +by running the following shell script:
> +
> +.. code-block:: bash
> +  :caption: uuid.sh script to extract the UUID from a macosvm.json file
> +
> +  #!/bin/bash
> +
> +  MID=$(cat "$1" | python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj["machineId"]);')
> +  echo "$MID" | base64 -d | plutil -extract ECID raw -
> +
> +Now we also need to trim the aux partition. It contains metadata that we can just discard:
> +
> +.. code-block:: bash
> +  :caption: Command to trim the aux file
> +
> +  $ dd if="aux.img" of="aux.img.trimmed" bs=$(( 0x4000 )) skip=1
> +
> +How to run
> +----------
> +
> +Then, we can launch QEMU with the Virtualization.Framework pre-boot environment and the readily
> +installed target disk images. I recommend to port forward the VM's ssh and vnc ports to the host
> +to get better interactive access into the target system:
> +
> +.. code-block:: bash
> +  :caption: Example execution command line
> +
> +  $ UUID=$(uuid.sh macosvm.json)
> +  $ AVPBOOTER=/System/Library/Frameworks/Virtualization.framework/Resources/AVPBooter.vmapple2.bin
> +  $ AUX=aux.img.trimmed
> +  $ DISK=disk.img
> +  $ qemu-system-aarch64 \
> +  	-serial mon:stdio \
> +  	-m 4G \
> +  	-accel hvf \
> +  	-M vmapple,uuid=$UUID \
> +  	-bios $AVPBOOTER \
> +        -drive file="$AUX",if=pflash,format=raw \
> +        -drive file="$DISK",if=pflash,format=raw \
> +  	-drive file="$AUX",if=none,id=aux,format=raw \
> +  	-drive file="$DISK",if=none,id=root,format=raw \
> +  	-device vmapple-virtio-aux,drive=aux \
> +  	-device vmapple-virtio-root,drive=root \
> +  	-net user,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
> +  	-net nic,model=virtio \
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 790ac1b8a2..bf663df4a6 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -106,6 +106,7 @@ undocumented; you can get a complete list by running
>      arm/stellaris
>      arm/stm32
>      arm/virt
> +   arm/vmapple
>      arm/xlnx-versal-virt
>      arm/xenpvh
>   
> diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> new file mode 100644
> index 0000000000..5d3fe54b96
> --- /dev/null
> +++ b/hw/vmapple/vmapple.c
> @@ -0,0 +1,661 @@
> +/*
> + * VMApple machine emulation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * VMApple is the device model that the macOS built-in hypervisor called
> + * "Virtualization.framework" exposes to Apple Silicon macOS guests. The
> + * machine model in this file implements the same device model in QEMU, but
> + * does not use any code from Virtualization.Framework.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/help-texts.h"
> +#include "qemu/datadir.h"
> +#include "qemu/units.h"
> +#include "qemu/option.h"
> +#include "monitor/qdev.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/primecell.h"
> +#include "hw/boards.h"
> +#include "net/net.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/hvf.h"
> +#include "hw/loader.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/intc/arm_gic.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "hw/irq.h"
> +#include "qapi/visitor.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "standard-headers/linux/input.h"
> +#include "target/arm/internals.h"
> +#include "target/arm/kvm_arm.h"
> +#include "hw/char/pl011.h"
> +#include "qemu/guest-random.h"
> +#include "sysemu/reset.h"
> +#include "qemu/log.h"
> +#include "hw/vmapple/cfg.h"
> +#include "hw/misc/pvpanic.h"
> +#include "hw/vmapple/bdif.h"
> +
> +struct VMAppleMachineClass {
> +    MachineClass parent;

This should be parent_class.

> +};
> +
> +struct VMAppleMachineState {
> +    MachineState parent;

This should be parent_obj, followed by a newline.

> +    Notifier machine_done;
> +    struct arm_boot_info bootinfo;
> +    MemMapEntry *memmap;
> +    const int *irqmap;
> +    DeviceState *gic;
> +    DeviceState *cfg;
> +    Notifier powerdown_notifier;
> +    PCIBus *bus;
> +    MemoryRegion fw_mr;
> +    uint64_t uuid;
> +};
> +
> +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
> +    static void vmapple##major##_##minor##_class_init(ObjectClass *oc, \
> +                                                    void *data) \
> +    { \
> +        MachineClass *mc = MACHINE_CLASS(oc); \
> +        vmapple_machine_##major##_##minor##_options(mc); \
> +        mc->desc = "QEMU " # major "." # minor " Apple Virtual Machine"; \
> +        if (latest) { \
> +            mc->alias = "vmapple"; \
> +        } \
> +    } \
> +    static const TypeInfo machvmapple##major##_##minor##_info = { \
> +        .name = MACHINE_TYPE_NAME("vmapple-" # major "." # minor), \
> +        .parent = TYPE_VMAPPLE_MACHINE, \
> +        .class_init = vmapple##major##_##minor##_class_init, \
> +    }; \
> +    static void machvmapple_machine_##major##_##minor##_init(void) \
> +    { \
> +        type_register_static(&machvmapple##major##_##minor##_info); \
> +    } \
> +    type_init(machvmapple_machine_##major##_##minor##_init);
> +
> +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
> +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
> +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
> +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
> +
> +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
> +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass, VMAPPLE_MACHINE)

I think it would be helpful to move the above MachineState definition and macros into 
a separate vmapple.h header.

> +/* Number of external interrupt lines to configure the GIC with */
> +#define NUM_IRQS 256
> +
> +enum {
> +    VMAPPLE_FIRMWARE,
> +    VMAPPLE_CONFIG,
> +    VMAPPLE_MEM,
> +    VMAPPLE_GIC_DIST,
> +    VMAPPLE_GIC_REDIST,
> +    VMAPPLE_UART,
> +    VMAPPLE_RTC,
> +    VMAPPLE_PCIE,
> +    VMAPPLE_PCIE_MMIO,
> +    VMAPPLE_PCIE_ECAM,
> +    VMAPPLE_GPIO,
> +    VMAPPLE_PVPANIC,
> +    VMAPPLE_APV_GFX,
> +    VMAPPLE_APV_IOSFC,
> +    VMAPPLE_AES_1,
> +    VMAPPLE_AES_2,
> +    VMAPPLE_BDOOR,
> +    VMAPPLE_MEMMAP_LAST,
> +};
> +
> +static MemMapEntry memmap[] = {
> +    [VMAPPLE_FIRMWARE] =           { 0x00100000, 0x00100000 },
> +    [VMAPPLE_CONFIG] =             { 0x00400000, 0x00010000 },
> +
> +    [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
> +    [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
> +
> +    [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
> +    [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
> +    [VMAPPLE_GPIO] =               { 0x20060000, 0x00001000 },
> +    [VMAPPLE_PVPANIC] =            { 0x20070000, 0x00000002 },
> +    [VMAPPLE_BDOOR] =              { 0x30000000, 0x00200000 },
> +    [VMAPPLE_APV_GFX] =            { 0x30200000, 0x00010000 },
> +    [VMAPPLE_APV_IOSFC] =          { 0x30210000, 0x00010000 },
> +    [VMAPPLE_AES_1] =              { 0x30220000, 0x00004000 },
> +    [VMAPPLE_AES_2] =              { 0x30230000, 0x00004000 },
> +    [VMAPPLE_PCIE_ECAM] =          { 0x40000000, 0x10000000 },
> +    [VMAPPLE_PCIE_MMIO] =          { 0x50000000, 0x1fff0000 },
> +
> +    /* Actual RAM size depends on configuration */
> +    [VMAPPLE_MEM] =                { 0x70000000ULL, GiB},
> +};
> +
> +static const int irqmap[] = {
> +    [VMAPPLE_UART] = 1,
> +    [VMAPPLE_RTC] = 2,
> +    [VMAPPLE_GPIO] = 0x5,
> +    [VMAPPLE_APV_IOSFC] = 0x10,
> +    [VMAPPLE_APV_GFX] = 0x11,
> +    [VMAPPLE_AES_1] = 0x12,
> +    [VMAPPLE_PCIE] = 0x20,
> +};
> +
> +#define GPEX_NUM_IRQS 16
> +
> +static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    DeviceState *bdif;
> +    SysBusDevice *bdif_sb;
> +    DriveInfo *di_aux = drive_get(IF_PFLASH, 0, 0);
> +    DriveInfo *di_root = drive_get(IF_PFLASH, 0, 1);
> +
> +    if (!di_aux) {
> +        error_report("No AUX device found. Please specify one as pflash drive");
> +        exit(1);
> +    }
> +
> +    if (!di_root) {
> +        /* Fall back to the first IF_VIRTIO device as root device */
> +        di_root = drive_get(IF_VIRTIO, 0, 0);
> +    }
> +
> +    if (!di_root) {
> +        error_report("No root device found. Please specify one as virtio drive");
> +        exit(1);
> +    }
> +
> +    /* PV backdoor device */
> +    bdif = qdev_new(TYPE_VMAPPLE_BDIF);
> +    bdif_sb = SYS_BUS_DEVICE(bdif);
> +    sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base);
> +
> +    qdev_prop_set_drive(DEVICE(bdif), "aux", blk_by_legacy_dinfo(di_aux));
> +    qdev_prop_set_drive(DEVICE(bdif), "root", blk_by_legacy_dinfo(di_root));
> +
> +    sysbus_realize_and_unref(bdif_sb, &error_fatal);
> +}
> +
> +static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    SysBusDevice *cfg;
> +
> +    vms->cfg = qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> +    cfg = SYS_BUS_DEVICE(vms->cfg);
> +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_PVPANIC].base);
> +
> +    sysbus_realize_and_unref(cfg, &error_fatal);
> +}
> +
> +static void create_cfg(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    SysBusDevice *cfg;
> +    MachineState *machine = MACHINE(vms);
> +    uint32_t rnd = 1;
> +
> +    vms->cfg = qdev_new(TYPE_VMAPPLE_CFG);
> +    cfg = SYS_BUS_DEVICE(vms->cfg);
> +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
> +
> +    qemu_guest_getrandom_nofail(&rnd, sizeof(rnd));
> +
> +    qdev_prop_set_uint32(vms->cfg, "nr-cpus", machine->smp.cpus);
> +    qdev_prop_set_uint64(vms->cfg, "ecid", vms->uuid);
> +    qdev_prop_set_uint64(vms->cfg, "ram-size", machine->ram_size);
> +    qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
> +
> +    sysbus_realize_and_unref(cfg, &error_fatal);
> +}
> +
> +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    int irq_gfx = vms->irqmap[VMAPPLE_APV_GFX];
> +    int irq_iosfc = vms->irqmap[VMAPPLE_APV_IOSFC];
> +    SysBusDevice *aes;
> +
> +    aes = SYS_BUS_DEVICE(qdev_new("apple-gfx"));

This really should be a TYPE_ macro (I haven't looked at the Apple-specific parts to 
see why this is the case here).

> +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
> +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
> +    sysbus_connect_irq(aes, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
> +    sysbus_realize_and_unref(aes, &error_fatal);
> +}
> +
> +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    int irq = vms->irqmap[VMAPPLE_AES_1];
> +    SysBusDevice *aes;
> +
> +    aes = SYS_BUS_DEVICE(qdev_new("apple-aes"));

Same comment here as per the original patch re: hardcoded type names (once the QOM 
type declaration is in a separate header file this is no longer a problem).

> +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
> +    sysbus_realize_and_unref(aes, &error_fatal);
> +}
> +
> +static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
> +{
> +    return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;
> +}
> +
> +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    /* We create a standalone GIC */
> +    SysBusDevice *gicbusdev;
> +    int i;
> +    unsigned int smp_cpus = ms->smp.cpus;
> +
> +    vms->gic = qdev_new(gicv3_class_name());
> +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> +    /*
> +     * Note that the num-irq property counts both internal and external
> +     * interrupts; there are always 32 of the former (mandated by GIC spec).
> +     */
> +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> +
> +    uint32_t redist0_capacity =
> +                vms->memmap[VMAPPLE_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
> +
> +    qdev_prop_set_uint32(vms->gic, "len-redist-region-count", 1);
> +    qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_count);
> +
> +    gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
> +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < smp_cpus; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +
> +        /* Map the virt timer to PPI 27 */
> +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> +                              qdev_get_gpio_in(vms->gic,
> +                                               arm_gic_ppi_index(i, 27)));
> +
> +        /* Map the GIC IRQ and FIQ lines to CPU */
> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +    }
> +}
> +
> +static void create_uart(const VMAppleMachineState *vms, int uart,
> +                        MemoryRegion *mem, Chardev *chr)
> +{
> +    hwaddr base = vms->memmap[uart].base;
> +    int irq = vms->irqmap[uart];
> +    DeviceState *dev = qdev_new(TYPE_PL011);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    memory_region_add_subregion(mem, base,
> +                                sysbus_mmio_get_region(s, 0));
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> +}
> +
> +static void create_rtc(const VMAppleMachineState *vms)
> +{
> +    hwaddr base = vms->memmap[VMAPPLE_RTC].base;
> +    int irq = vms->irqmap[VMAPPLE_RTC];
> +
> +    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
> +}
> +
> +static DeviceState *gpio_key_dev;
> +static void vmapple_powerdown_req(Notifier *n, void *opaque)
> +{
> +    /* use gpio Pin 3 for power button event */
> +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> +}
> +
> +static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
> +                                MemoryRegion *mem)
> +{
> +    DeviceState *pl061_dev;
> +    hwaddr base = vms->memmap[gpio].base;
> +    int irq = vms->irqmap[gpio];
> +    SysBusDevice *s;
> +
> +    pl061_dev = qdev_new("pl061");

Why is this hardcoded? Is it because the pl061 device doesn't have a separate header 
file for the QOM definition?

> +    /* Pull lines down to 0 if not driven by the PL061 */
> +    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
> +    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
> +    s = SYS_BUS_DEVICE(pl061_dev);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> +    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
> +                                        qdev_get_gpio_in(pl061_dev, 3));
> +}
> +
> +static void vmapple_firmware_init(VMAppleMachineState *vms,
> +                                  MemoryRegion *sysmem)
> +{
> +    hwaddr size = vms->memmap[VMAPPLE_FIRMWARE].size;
> +    hwaddr base = vms->memmap[VMAPPLE_FIRMWARE].base;
> +    const char *bios_name;
> +    int image_size;
> +    char *fname;
> +
> +    bios_name = MACHINE(vms)->firmware;
> +    if (!bios_name) {
> +        error_report("No firmware specified");
> +        exit(1);
> +    }
> +
> +    fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!fname) {
> +        error_report("Could not find ROM image '%s'", bios_name);
> +        exit(1);
> +    }
> +
> +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, NULL);
> +    image_size = load_image_mr(fname, &vms->fw_mr);
> +
> +    g_free(fname);
> +    if (image_size < 0) {
> +        error_report("Could not load ROM image '%s'", bios_name);
> +        exit(1);
> +    }
> +
> +    memory_region_add_subregion(get_system_memory(), base, &vms->fw_mr);
> +}
> +
> +static void create_pcie(VMAppleMachineState *vms)
> +{
> +    hwaddr base_mmio = vms->memmap[VMAPPLE_PCIE_MMIO].base;
> +    hwaddr size_mmio = vms->memmap[VMAPPLE_PCIE_MMIO].size;
> +    hwaddr base_ecam = vms->memmap[VMAPPLE_PCIE_ECAM].base;
> +    hwaddr size_ecam = vms->memmap[VMAPPLE_PCIE_ECAM].size;
> +    int irq = vms->irqmap[VMAPPLE_PCIE];
> +    MemoryRegion *mmio_alias;
> +    MemoryRegion *mmio_reg;
> +    MemoryRegion *ecam_alias;
> +    MemoryRegion *ecam_reg;
> +    DeviceState *dev;
> +    int i;
> +    PCIHostState *pci;
> +    DeviceState *virtio_tablet;
> +    DeviceState *virtio_keyboard;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    qdev_prop_set_uint32(dev, "nr-irqs", GPEX_NUM_IRQS);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    /* Map only the first size_ecam bytes of ECAM space */
> +    ecam_alias = g_new0(MemoryRegion, 1);

I'd recommend adding this to VMAppleMachineState similar to all the others rather 
than allocating directly with ecam_alias (it helps enforce the lifecycle of the 
MemoryRegion within its parent).

> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, size_ecam);
> +    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
> +
> +    /*
> +     * Map the MMIO window from [0x50000000-0x7fff0000] in PCI space into
> +     * system address space at [0x50000000-0x7fff0000].
> +     */
> +    mmio_alias = g_new0(MemoryRegion, 1);

Similar comment here re: VMAppleMachineState.

> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, base_mmio, size_mmio);
> +    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> +                           qdev_get_gpio_in(vms->gic, irq + i));
> +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> +    }
> +
> +    pci = PCI_HOST_BRIDGE(dev);
> +    vms->bus = pci->bus;
> +    if (vms->bus) {
> +        for (i = 0; i < nb_nics; i++) {
> +            NICInfo *nd = &nd_table[i];
> +
> +            if (!nd->model) {
> +                nd->model = g_strdup("virtio");
> +            }
> +
> +            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
> +        }
> +    }
> +
> +    virtio_tablet = qdev_new("virtio-tablet-pci");

Again is this a problem that the virtio-tablet-pci QOM declaration isn't in a 
separate header file?

> +    qdev_realize(virtio_tablet, BUS(pci->bus), &error_fatal);
> +    object_unref(virtio_tablet);

For this case you can use qdev_realize_and_unref().

> +
> +    virtio_keyboard = qdev_new("virtio-keyboard-pci");

Same header file problem?

> +    qdev_realize(virtio_keyboard, BUS(pci->bus), &error_fatal);
> +    object_unref(virtio_keyboard);

And again here for qdev_realize_and_unref().

> +}
> +
> +static void vmapple_reset(void *opaque)
> +{
> +    VMAppleMachineState *vms = opaque;
> +    hwaddr base = vms->memmap[VMAPPLE_FIRMWARE].base;
> +
> +    cpu_set_pc(first_cpu, base);
> +}
> +
> +static void mach_vmapple_init(MachineState *machine)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(machine);
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const CPUArchIdList *possible_cpus;
> +    MemoryRegion *sysmem = get_system_memory();
> +    int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +    unsigned int max_cpus = machine->smp.max_cpus;
> +
> +    vms->memmap = memmap;
> +
> +    possible_cpus = mc->possible_cpu_arch_ids(machine);
> +    assert(possible_cpus->len == max_cpus);
> +    for (n = 0; n < possible_cpus->len; n++) {
> +        Object *cpu;
> +        CPUState *cs;
> +
> +        if (n >= smp_cpus) {
> +            break;
> +        }
> +
> +        cpu = object_new(possible_cpus->cpus[n].type);
> +        object_property_set_int(cpu, "mp-affinity",
> +                                possible_cpus->cpus[n].arch_id, NULL);
> +
> +        cs = CPU(cpu);
> +        cs->cpu_index = n;
> +
> +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpu),
> +                          &error_fatal);
> +
> +        object_property_set_bool(cpu, "has_el3", false, NULL);
> +        object_property_set_bool(cpu, "has_el2", false, NULL);
> +        object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_HVC,
> +                                NULL);
> +
> +        /* Secondary CPUs start in PSCI powered-down state */
> +        if (n > 0) {
> +            object_property_set_bool(cpu, "start-powered-off", true, NULL);
> +        }
> +
> +        object_property_set_link(cpu, "memory", OBJECT(sysmem), &error_abort);
> +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> +        object_unref(cpu);

qdev_realize_and_unref() again.

> +    }
> +
> +    memory_region_add_subregion(sysmem, vms->memmap[VMAPPLE_MEM].base,
> +                                machine->ram);
> +
> +    create_gic(vms, sysmem);
> +    create_bdif(vms, sysmem);
> +    create_pvpanic(vms, sysmem);
> +    create_aes(vms, sysmem);
> +    create_gfx(vms, sysmem);
> +    create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));
> +    create_rtc(vms);
> +    create_pcie(vms);
> +
> +    create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
> +
> +    vmapple_firmware_init(vms, sysmem);
> +    create_cfg(vms, sysmem);
> +
> +    /* connect powerdown request */
> +    vms->powerdown_notifier.notify = vmapple_powerdown_req;
> +    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> +
> +    vms->bootinfo.ram_size = machine->ram_size;
> +    vms->bootinfo.board_id = -1;
> +    vms->bootinfo.loader_start = vms->memmap[VMAPPLE_MEM].base;
> +    vms->bootinfo.skip_dtb_autoload = true;
> +    vms->bootinfo.firmware_loaded = true;
> +    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
> +
> +    qemu_register_reset(vmapple_reset, vms);
> +}
> +
> +static CpuInstanceProperties
> +vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}
> +
> +
> +static int64_t vmapple_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    return idx % ms->numa_state->num_nodes;
> +}
> +
> +static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    int n;
> +    unsigned int max_cpus = ms->smp.max_cpus;
> +
> +    if (ms->possible_cpus) {
> +        assert(ms->possible_cpus->len == max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len = max_cpus;
> +    for (n = 0; n < ms->possible_cpus->len; n++) {
> +        ms->possible_cpus->cpus[n].type = ms->cpu_type;
> +        ms->possible_cpus->cpus[n].arch_id =
> +            arm_cpu_mp_affinity(n, GICV3_TARGETLIST_BITS);
> +        ms->possible_cpus->cpus[n].props.has_thread_id = true;
> +        ms->possible_cpus->cpus[n].props.thread_id = n;
> +    }
> +    return ms->possible_cpus;
> +}
> +
> +static void vmapple_get_uuid(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +    uint64_t value = be64_to_cpu(vms->uuid);
> +
> +    visit_type_uint64(v, name, &value, errp);
> +}
> +
> +static void vmapple_set_uuid(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_uint64(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    vms->uuid = cpu_to_be64(value);
> +}
> +
> +static void vmapple_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->init = mach_vmapple_init;
> +    mc->max_cpus = 32;
> +    mc->block_default_type = IF_VIRTIO;
> +    mc->no_cdrom = 1;
> +    mc->pci_allow_0_address = true;
> +    mc->minimum_page_bits = 12;
> +    mc->possible_cpu_arch_ids = vmapple_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props = vmapple_cpu_index_to_props;
> +    if (hvf_enabled()) {
> +        mc->default_cpu_type = ARM_CPU_TYPE_NAME("host");
> +    } else {
> +        mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
> +    }
> +    mc->get_default_cpu_node_id = vmapple_get_default_cpu_node_id;
> +    mc->default_ram_id = "mach-vmapple.ram";
> +
> +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy",
> +                               "on", true);
> +
> +    object_class_property_add(oc, "uuid", "uint64", vmapple_get_uuid,
> +                              vmapple_set_uuid, NULL, NULL);
> +    object_class_property_set_description(oc, "uuid", "Machine UUID (SDOM)");
> +}
> +
> +static void vmapple_instance_init(Object *obj)
> +{
> +    VMAppleMachineState *vms = VMAPPLE_MACHINE(obj);
> +
> +    vms->irqmap = irqmap;
> +}
> +
> +static const TypeInfo vmapple_machine_info = {
> +    .name          = TYPE_VMAPPLE_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .abstract      = true,
> +    .instance_size = sizeof(VMAppleMachineState),
> +    .class_size    = sizeof(VMAppleMachineClass),
> +    .class_init    = vmapple_machine_class_init,
> +    .instance_init = vmapple_instance_init,
> +};
> +
> +static void machvmapple_machine_init(void)
> +{
> +    type_register_static(&vmapple_machine_info);
> +}
> +type_init(machvmapple_machine_init);
> +
> +static void vmapple_machine_8_1_options(MachineClass *mc)
> +{
> +}

DEFINE_TYPES() macro can be used here aswell.

> +DEFINE_VMAPPLE_MACHINE_AS_LATEST(8, 1)
> +
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index f06eae8039..920b590561 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -12,3 +12,22 @@ config VMAPPLE_PVG
>   
>   config VMAPPLE_VIRTIO_BLK
>       bool
> +
> +config VMAPPLE
> +    bool
> +    depends on ARM && HVF
> +    default y if ARM && HVF
> +    imply PCI_DEVICES
> +    select ARM_GIC
> +    select PLATFORM_BUS
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select GPIO_PWR
> +    select PVPANIC_MMIO
> +    select VMAPPLE_AES
> +    select VMAPPLE_BDIF
> +    select VMAPPLE_CFG
> +    select VMAPPLE_PVG
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index 3b4a16f619..45201cbde5 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -3,3 +3,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
>   system_ss.add(when: 'CONFIG_VMAPPLE_PVG',  if_true: [files('apple-gfx.m'), pvg, metal])
>   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true: files('virtio-blk.c'))
> +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true: files('vmapple.c'))


ATB,

Mark.


