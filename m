Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD27376B9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 23:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBj0z-0005GO-UE; Tue, 20 Jun 2023 17:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qBj0y-0005G2-2N; Tue, 20 Jun 2023 17:35:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qBj0v-0000oo-46; Tue, 20 Jun 2023 17:35:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f907f31247so33595915e9.2; 
 Tue, 20 Jun 2023 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687296946; x=1689888946;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dALzlanZSjV93GGBP2dp6nYkfxacJaNw0Q12gZSd7Pk=;
 b=EkWhqXsHYGVlgGNeXwHQ1Jra6pAvrlopPMcZz53rvSHw4ALiglYJ+gaCVwE0PzkYgB
 AtBT8Mmizivu194NFhBM66uavUMblSYR2Yy5opvX16ysOny+rDvEp6mSUQ3xqvxM7vKi
 OaZ5/nppeqoKh+l7ocTjaSinwaBGhX3z92FSrwT4sCcZ0t+WcP6EfhO3ch105pwQz5tp
 eptk5TNuW9pKYHRGXFmBSz9hGkFBx9hfz+uikkK10/N2lM5HDnRn8qcPl3ShlhjwcuYi
 wiEx6D5DZFN50tM/WzrdnLOgNbhpTuxQC7CIe5u/cJ+vdb8LtTG0aBJ74ptKZr5haa86
 Obsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687296946; x=1689888946;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dALzlanZSjV93GGBP2dp6nYkfxacJaNw0Q12gZSd7Pk=;
 b=WEtaFJcDeF947uiKzFJfOgjdLq7ym/YlEKuObZf5Ak66IarmusO+A/EwpJOVgv90dQ
 FJo6OmcwZZkkoLFN2WxYWN8WuMaGdVaGQLV6ox95w3MGyS/iEAB4V9+Dvvmw2KI2XbRB
 It9cL7WbIJyLi/mLZbqw82/ioatasRD8naxLZt9mfVBdh1e2Lkhrdvgxvl9zyoyh9GH6
 WQuyeh7n1H2kF0QKJ5UZnXOX9ZUzdJNLqeZI8WWGddPmzC1wgB046tZ0AMiI4TTlgKj6
 r8tPbOyH35IMDcBN8shfefmdpg2XCP3W+vmU8kJJr4kCAPszhaUrQR51ASsX3QPI4Qg5
 MQnA==
X-Gm-Message-State: AC+VfDwuk0DoE3lOba7BRiYBf5uhF5N0aw8ePrpNmHqW/lmhIxGYF2xc
 tyWehxFvhWg9jcto+KUJ5XY=
X-Google-Smtp-Source: ACHHUZ4oloDb8BYKjN0BOZAf7DmCVvcZq9k5x/t8D6weEBRn7BixPOjQ3miOb3xcw04L5Md89GMgkQ==
X-Received: by 2002:a1c:7715:0:b0:3f9:b06a:edc0 with SMTP id
 t21-20020a1c7715000000b003f9b06aedc0mr4560711wmi.29.1687296946034; 
 Tue, 20 Jun 2023 14:35:46 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-170-202.77.183.pool.telefonica.de.
 [77.183.170.202]) by smtp.gmail.com with ESMTPSA id
 l20-20020a7bc354000000b003f4248dcfcbsm14409214wmj.30.2023.06.20.14.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 14:35:45 -0700 (PDT)
Date: Tue, 20 Jun 2023 17:35:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
CC: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 12/12] hw/vmapple/vmapple: Add vmapple machine type
In-Reply-To: <20230614225734.806-3-graf@amazon.com>
References: <20230614224038.86148-1-graf>
 <20230614225734.806-1-graf@amazon.com> <20230614225734.806-3-graf@amazon.com>
Message-ID: <4854EBDC-AB24-45AD-A890-06382993F507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Am 14=2E Juni 2023 22:57:34 UTC schrieb Alexander Graf <graf@amazon=2Ecom>=
:
>Apple defines a new "vmapple" machine type as part of its proprietary
>macOS Virtualization=2EFramework vmm=2E This machine type is similar to t=
he
>virt one, but with subtle differences in base devices, a few special
>vmapple device additions and a vastly different boot chain=2E
>
>This patch reimplements this machine type in QEMU=2E To use it, you
>have to have a readily installed version of macOS for VMApple,
>run on macOS with -accel hvf, pass the Virtualization=2EFramework
>boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
>and pass aux and root volume as virtio drives=2E In addition, you also
>need to find the machine UUID and pass that as -M vmapple,uuid=3D paramet=
er:
>
>$ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \
>    -bios /System/Library/Frameworks/Virtualization=2Eframework/Versions/=
A/Resources/AVPBooter=2Evmapple2=2Ebin
>    -drive file=3Daux,if=3Dpflash,format=3Draw \
>    -drive file=3Droot,if=3Dpflash,format=3Draw \
>    -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
>    -device virtio-blk-pci,drive=3Daux,x-apple-type=3D2 \
>    -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
>    -device virtio-blk-pci,drive=3Droot,x-apple-type=3D1
>
>With all these in place, you should be able to see macOS booting
>successfully=2E

This documentation seems valuable for the QEMU manual=2E But AFAICS there =
is no documentation like this added to the QEMU manual in this series=2E Th=
is means that it'll get "lost"=2E How about adding it, possibly in this pat=
ch?

Note that I'm not able to test this series=2E I'm just seeing the valuable=
-information-in-the-commit-message-which-will-get-lost pattern=2E

>
>Signed-off-by: Alexander Graf <graf@amazon=2Ecom>
>---
> hw/vmapple/Kconfig     |  19 ++
> hw/vmapple/meson=2Ebuild |   1 +
> hw/vmapple/vmapple=2Ec   | 661 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 681 insertions(+)
> create mode 100644 hw/vmapple/vmapple=2Ec
>
>diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
>index ba37fc5b81=2E=2E7a2375dc95 100644
>--- a/hw/vmapple/Kconfig
>+++ b/hw/vmapple/Kconfig
>@@ -9,3 +9,22 @@ config VMAPPLE_CFG
>=20
> config VMAPPLE_PVG
>     bool
>+
>+config VMAPPLE
>+    bool
>+    depends on ARM && HVF
>+    default y if ARM && HVF
>+    imply PCI_DEVICES
>+    select ARM_GIC
>+    select PLATFORM_BUS
>+    select PCI_EXPRESS
>+    select PCI_EXPRESS_GENERIC_BRIDGE
>+    select PL011 # UART
>+    select PL031 # RTC
>+    select PL061 # GPIO
>+    select GPIO_PWR
>+    select PVPANIC_MMIO
>+    select VMAPPLE_AES
>+    select VMAPPLE_BDIF
>+    select VMAPPLE_CFG
>+    select VMAPPLE_PVG
>diff --git a/hw/vmapple/meson=2Ebuild b/hw/vmapple/meson=2Ebuild
>index 31fec87156=2E=2Ed732873d35 100644
>--- a/hw/vmapple/meson=2Ebuild
>+++ b/hw/vmapple/meson=2Ebuild
>@@ -2,3 +2,4 @@ softmmu_ss=2Eadd(when: 'CONFIG_VMAPPLE_AES',  if_true: fi=
les('aes=2Ec'))
> softmmu_ss=2Eadd(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif=2Ec')=
)
> softmmu_ss=2Eadd(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg=2Ec'))
> softmmu_ss=2Eadd(when: 'CONFIG_VMAPPLE_PVG',  if_true: [files('apple-gfx=
=2Em'), pvg, metal])
>+specific_ss=2Eadd(when: 'CONFIG_VMAPPLE',     if_true: files('vmapple=2E=
c'))
>diff --git a/hw/vmapple/vmapple=2Ec b/hw/vmapple/vmapple=2Ec
>new file mode 100644
>index 0000000000=2E=2E5d3fe54b96
>--- /dev/null
>+++ b/hw/vmapple/vmapple=2Ec
>@@ -0,0 +1,661 @@
>+/*
>+ * VMApple machine emulation
>+ *
>+ * Copyright =C2=A9 2023 Amazon=2Ecom, Inc=2E or its affiliates=2E All R=
ights Reserved=2E

Is an "All Rights Reserved" wording compatible with the GPL?

Best regards,
Bernhard

>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter=2E
>+ * See the COPYING file in the top-level directory=2E
>+ *
>+ * VMApple is the device model that the macOS built-in hypervisor called
>+ * "Virtualization=2Eframework" exposes to Apple Silicon macOS guests=2E=
 The
>+ * machine model in this file implements the same device model in QEMU, =
but
>+ * does not use any code from Virtualization=2EFramework=2E
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "qemu/help-texts=2Eh"
>+#include "qemu/datadir=2Eh"
>+#include "qemu/units=2Eh"
>+#include "qemu/option=2Eh"
>+#include "monitor/qdev=2Eh"
>+#include "qapi/error=2Eh"
>+#include "hw/sysbus=2Eh"
>+#include "hw/arm/boot=2Eh"
>+#include "hw/arm/primecell=2Eh"
>+#include "hw/boards=2Eh"
>+#include "net/net=2Eh"
>+#include "sysemu/sysemu=2Eh"
>+#include "sysemu/runstate=2Eh"
>+#include "sysemu/kvm=2Eh"
>+#include "sysemu/hvf=2Eh"
>+#include "hw/loader=2Eh"
>+#include "qapi/error=2Eh"
>+#include "qemu/bitops=2Eh"
>+#include "qemu/error-report=2Eh"
>+#include "qemu/module=2Eh"
>+#include "hw/pci-host/gpex=2Eh"
>+#include "hw/virtio/virtio-pci=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "hw/intc/arm_gic=2Eh"
>+#include "hw/intc/arm_gicv3_common=2Eh"
>+#include "hw/irq=2Eh"
>+#include "qapi/visitor=2Eh"
>+#include "qapi/qapi-visit-common=2Eh"
>+#include "standard-headers/linux/input=2Eh"
>+#include "target/arm/internals=2Eh"
>+#include "target/arm/kvm_arm=2Eh"
>+#include "hw/char/pl011=2Eh"
>+#include "qemu/guest-random=2Eh"
>+#include "sysemu/reset=2Eh"
>+#include "qemu/log=2Eh"
>+#include "hw/vmapple/cfg=2Eh"
>+#include "hw/misc/pvpanic=2Eh"
>+#include "hw/vmapple/bdif=2Eh"
>+
>+struct VMAppleMachineClass {
>+    MachineClass parent;
>+};
>+
>+struct VMAppleMachineState {
>+    MachineState parent;
>+    Notifier machine_done;
>+    struct arm_boot_info bootinfo;
>+    MemMapEntry *memmap;
>+    const int *irqmap;
>+    DeviceState *gic;
>+    DeviceState *cfg;
>+    Notifier powerdown_notifier;
>+    PCIBus *bus;
>+    MemoryRegion fw_mr;
>+    uint64_t uuid;
>+};
>+
>+#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
>+    static void vmapple##major##_##minor##_class_init(ObjectClass *oc, \
>+                                                    void *data) \
>+    { \
>+        MachineClass *mc =3D MACHINE_CLASS(oc); \
>+        vmapple_machine_##major##_##minor##_options(mc); \
>+        mc->desc =3D "QEMU " # major "=2E" # minor " Apple Virtual Machi=
ne"; \
>+        if (latest) { \
>+            mc->alias =3D "vmapple"; \
>+        } \
>+    } \
>+    static const TypeInfo machvmapple##major##_##minor##_info =3D { \
>+        =2Ename =3D MACHINE_TYPE_NAME("vmapple-" # major "=2E" # minor),=
 \
>+        =2Eparent =3D TYPE_VMAPPLE_MACHINE, \
>+        =2Eclass_init =3D vmapple##major##_##minor##_class_init, \
>+    }; \
>+    static void machvmapple_machine_##major##_##minor##_init(void) \
>+    { \
>+        type_register_static(&machvmapple##major##_##minor##_info); \
>+    } \
>+    type_init(machvmapple_machine_##major##_##minor##_init);
>+
>+#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
>+    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
>+#define DEFINE_VMAPPLE_MACHINE(major, minor) \
>+    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
>+
>+#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
>+OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass, VMAPPLE_MA=
CHINE)
>+
>+/* Number of external interrupt lines to configure the GIC with */
>+#define NUM_IRQS 256
>+
>+enum {
>+    VMAPPLE_FIRMWARE,
>+    VMAPPLE_CONFIG,
>+    VMAPPLE_MEM,
>+    VMAPPLE_GIC_DIST,
>+    VMAPPLE_GIC_REDIST,
>+    VMAPPLE_UART,
>+    VMAPPLE_RTC,
>+    VMAPPLE_PCIE,
>+    VMAPPLE_PCIE_MMIO,
>+    VMAPPLE_PCIE_ECAM,
>+    VMAPPLE_GPIO,
>+    VMAPPLE_PVPANIC,
>+    VMAPPLE_APV_GFX,
>+    VMAPPLE_APV_IOSFC,
>+    VMAPPLE_AES_1,
>+    VMAPPLE_AES_2,
>+    VMAPPLE_BDOOR,
>+    VMAPPLE_MEMMAP_LAST,
>+};
>+
>+static MemMapEntry memmap[] =3D {
>+    [VMAPPLE_FIRMWARE] =3D           { 0x00100000, 0x00100000 },
>+    [VMAPPLE_CONFIG] =3D             { 0x00400000, 0x00010000 },
>+
>+    [VMAPPLE_GIC_DIST] =3D           { 0x10000000, 0x00010000 },
>+    [VMAPPLE_GIC_REDIST] =3D         { 0x10010000, 0x00400000 },
>+
>+    [VMAPPLE_UART] =3D               { 0x20010000, 0x00010000 },
>+    [VMAPPLE_RTC] =3D                { 0x20050000, 0x00001000 },
>+    [VMAPPLE_GPIO] =3D               { 0x20060000, 0x00001000 },
>+    [VMAPPLE_PVPANIC] =3D            { 0x20070000, 0x00000002 },
>+    [VMAPPLE_BDOOR] =3D              { 0x30000000, 0x00200000 },
>+    [VMAPPLE_APV_GFX] =3D            { 0x30200000, 0x00010000 },
>+    [VMAPPLE_APV_IOSFC] =3D          { 0x30210000, 0x00010000 },
>+    [VMAPPLE_AES_1] =3D              { 0x30220000, 0x00004000 },
>+    [VMAPPLE_AES_2] =3D              { 0x30230000, 0x00004000 },
>+    [VMAPPLE_PCIE_ECAM] =3D          { 0x40000000, 0x10000000 },
>+    [VMAPPLE_PCIE_MMIO] =3D          { 0x50000000, 0x1fff0000 },
>+
>+    /* Actual RAM size depends on configuration */
>+    [VMAPPLE_MEM] =3D                { 0x70000000ULL, GiB},
>+};
>+
>+static const int irqmap[] =3D {
>+    [VMAPPLE_UART] =3D 1,
>+    [VMAPPLE_RTC] =3D 2,
>+    [VMAPPLE_GPIO] =3D 0x5,
>+    [VMAPPLE_APV_IOSFC] =3D 0x10,
>+    [VMAPPLE_APV_GFX] =3D 0x11,
>+    [VMAPPLE_AES_1] =3D 0x12,
>+    [VMAPPLE_PCIE] =3D 0x20,
>+};
>+
>+#define GPEX_NUM_IRQS 16
>+
>+static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    DeviceState *bdif;
>+    SysBusDevice *bdif_sb;
>+    DriveInfo *di_aux =3D drive_get(IF_PFLASH, 0, 0);
>+    DriveInfo *di_root =3D drive_get(IF_PFLASH, 0, 1);
>+
>+    if (!di_aux) {
>+        error_report("No AUX device found=2E Please specify one as pflas=
h drive");
>+        exit(1);
>+    }
>+
>+    if (!di_root) {
>+        /* Fall back to the first IF_VIRTIO device as root device */
>+        di_root =3D drive_get(IF_VIRTIO, 0, 0);
>+    }
>+
>+    if (!di_root) {
>+        error_report("No root device found=2E Please specify one as virt=
io drive");
>+        exit(1);
>+    }
>+
>+    /* PV backdoor device */
>+    bdif =3D qdev_new(TYPE_VMAPPLE_BDIF);
>+    bdif_sb =3D SYS_BUS_DEVICE(bdif);
>+    sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR]=2Ebase);
>+
>+    qdev_prop_set_drive(DEVICE(bdif), "aux", blk_by_legacy_dinfo(di_aux)=
);
>+    qdev_prop_set_drive(DEVICE(bdif), "root", blk_by_legacy_dinfo(di_roo=
t));
>+
>+    sysbus_realize_and_unref(bdif_sb, &error_fatal);
>+}
>+
>+static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    SysBusDevice *cfg;
>+
>+    vms->cfg =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
>+    cfg =3D SYS_BUS_DEVICE(vms->cfg);
>+    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_PVPANIC]=2Ebase);
>+
>+    sysbus_realize_and_unref(cfg, &error_fatal);
>+}
>+
>+static void create_cfg(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    SysBusDevice *cfg;
>+    MachineState *machine =3D MACHINE(vms);
>+    uint32_t rnd =3D 1;
>+
>+    vms->cfg =3D qdev_new(TYPE_VMAPPLE_CFG);
>+    cfg =3D SYS_BUS_DEVICE(vms->cfg);
>+    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG]=2Ebase);
>+
>+    qemu_guest_getrandom_nofail(&rnd, sizeof(rnd));
>+
>+    qdev_prop_set_uint32(vms->cfg, "nr-cpus", machine->smp=2Ecpus);
>+    qdev_prop_set_uint64(vms->cfg, "ecid", vms->uuid);
>+    qdev_prop_set_uint64(vms->cfg, "ram-size", machine->ram_size);
>+    qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
>+
>+    sysbus_realize_and_unref(cfg, &error_fatal);
>+}
>+
>+static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    int irq_gfx =3D vms->irqmap[VMAPPLE_APV_GFX];
>+    int irq_iosfc =3D vms->irqmap[VMAPPLE_APV_IOSFC];
>+    SysBusDevice *aes;
>+
>+    aes =3D SYS_BUS_DEVICE(qdev_new("apple-gfx"));
>+    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_APV_GFX]=2Ebase);
>+    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_APV_IOSFC]=2Ebase);
>+    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
>+    sysbus_connect_irq(aes, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
>+    sysbus_realize_and_unref(aes, &error_fatal);
>+}
>+
>+static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    int irq =3D vms->irqmap[VMAPPLE_AES_1];
>+    SysBusDevice *aes;
>+
>+    aes =3D SYS_BUS_DEVICE(qdev_new("apple-aes"));
>+    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1]=2Ebase);
>+    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2]=2Ebase);
>+    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
>+    sysbus_realize_and_unref(aes, &error_fatal);
>+}
>+
>+static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>+{
>+    return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;
>+}
>+
>+static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
>+{
>+    MachineState *ms =3D MACHINE(vms);
>+    /* We create a standalone GIC */
>+    SysBusDevice *gicbusdev;
>+    int i;
>+    unsigned int smp_cpus =3D ms->smp=2Ecpus;
>+
>+    vms->gic =3D qdev_new(gicv3_class_name());
>+    qdev_prop_set_uint32(vms->gic, "revision", 3);
>+    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
>+    /*
>+     * Note that the num-irq property counts both internal and external
>+     * interrupts; there are always 32 of the former (mandated by GIC sp=
ec)=2E
>+     */
>+    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
>+
>+    uint32_t redist0_capacity =3D
>+                vms->memmap[VMAPPLE_GIC_REDIST]=2Esize / GICV3_REDIST_SI=
ZE;
>+    uint32_t redist0_count =3D MIN(smp_cpus, redist0_capacity);
>+
>+    qdev_prop_set_uint32(vms->gic, "len-redist-region-count", 1);
>+    qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_cou=
nt);
>+
>+    gicbusdev =3D SYS_BUS_DEVICE(vms->gic);
>+    sysbus_realize_and_unref(gicbusdev, &error_fatal);
>+    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST]=2Ebase);
>+    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST]=2Ebase=
);
>+
>+    /*
>+     * Wire the outputs from each CPU's generic timer and the GICv3
>+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
>+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's in=
puts=2E
>+     */
>+    for (i =3D 0; i < smp_cpus; i++) {
>+        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
>+
>+        /* Map the virt timer to PPI 27 */
>+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
>+                              qdev_get_gpio_in(vms->gic,
>+                                               arm_gic_ppi_index(i, 27))=
);
>+
>+        /* Map the GIC IRQ and FIQ lines to CPU */
>+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CP=
U_IRQ));
>+        sysbus_connect_irq(gicbusdev, i + smp_cpus,
>+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>+    }
>+}
>+
>+static void create_uart(const VMAppleMachineState *vms, int uart,
>+                        MemoryRegion *mem, Chardev *chr)
>+{
>+    hwaddr base =3D vms->memmap[uart]=2Ebase;
>+    int irq =3D vms->irqmap[uart];
>+    DeviceState *dev =3D qdev_new(TYPE_PL011);
>+    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>+
>+    qdev_prop_set_chr(dev, "chardev", chr);
>+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>+    memory_region_add_subregion(mem, base,
>+                                sysbus_mmio_get_region(s, 0));
>+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
>+}
>+
>+static void create_rtc(const VMAppleMachineState *vms)
>+{
>+    hwaddr base =3D vms->memmap[VMAPPLE_RTC]=2Ebase;
>+    int irq =3D vms->irqmap[VMAPPLE_RTC];
>+
>+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq))=
;
>+}
>+
>+static DeviceState *gpio_key_dev;
>+static void vmapple_powerdown_req(Notifier *n, void *opaque)
>+{
>+    /* use gpio Pin 3 for power button event */
>+    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>+}
>+
>+static void create_gpio_devices(const VMAppleMachineState *vms, int gpio=
,
>+                                MemoryRegion *mem)
>+{
>+    DeviceState *pl061_dev;
>+    hwaddr base =3D vms->memmap[gpio]=2Ebase;
>+    int irq =3D vms->irqmap[gpio];
>+    SysBusDevice *s;
>+
>+    pl061_dev =3D qdev_new("pl061");
>+    /* Pull lines down to 0 if not driven by the PL061 */
>+    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
>+    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
>+    s =3D SYS_BUS_DEVICE(pl061_dev);
>+    sysbus_realize_and_unref(s, &error_fatal);
>+    memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0))=
;
>+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
>+    gpio_key_dev =3D sysbus_create_simple("gpio-key", -1,
>+                                        qdev_get_gpio_in(pl061_dev, 3));
>+}
>+
>+static void vmapple_firmware_init(VMAppleMachineState *vms,
>+                                  MemoryRegion *sysmem)
>+{
>+    hwaddr size =3D vms->memmap[VMAPPLE_FIRMWARE]=2Esize;
>+    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE]=2Ebase;
>+    const char *bios_name;
>+    int image_size;
>+    char *fname;
>+
>+    bios_name =3D MACHINE(vms)->firmware;
>+    if (!bios_name) {
>+        error_report("No firmware specified");
>+        exit(1);
>+    }
>+
>+    fname =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>+    if (!fname) {
>+        error_report("Could not find ROM image '%s'", bios_name);
>+        exit(1);
>+    }
>+
>+    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, NULL);
>+    image_size =3D load_image_mr(fname, &vms->fw_mr);
>+
>+    g_free(fname);
>+    if (image_size < 0) {
>+        error_report("Could not load ROM image '%s'", bios_name);
>+        exit(1);
>+    }
>+
>+    memory_region_add_subregion(get_system_memory(), base, &vms->fw_mr);
>+}
>+
>+static void create_pcie(VMAppleMachineState *vms)
>+{
>+    hwaddr base_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO]=2Ebase;
>+    hwaddr size_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO]=2Esize;
>+    hwaddr base_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM]=2Ebase;
>+    hwaddr size_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM]=2Esize;
>+    int irq =3D vms->irqmap[VMAPPLE_PCIE];
>+    MemoryRegion *mmio_alias;
>+    MemoryRegion *mmio_reg;
>+    MemoryRegion *ecam_alias;
>+    MemoryRegion *ecam_reg;
>+    DeviceState *dev;
>+    int i;
>+    PCIHostState *pci;
>+    DeviceState *virtio_tablet;
>+    DeviceState *virtio_keyboard;
>+
>+    dev =3D qdev_new(TYPE_GPEX_HOST);
>+    qdev_prop_set_uint32(dev, "nr-irqs", GPEX_NUM_IRQS);
>+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>+
>+    /* Map only the first size_ecam bytes of ECAM space */
>+    ecam_alias =3D g_new0(MemoryRegion, 1);
>+    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>+                             ecam_reg, 0, size_ecam);
>+    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_ali=
as);
>+
>+    /*
>+     * Map the MMIO window from [0x50000000-0x7fff0000] in PCI space int=
o
>+     * system address space at [0x50000000-0x7fff0000]=2E
>+     */
>+    mmio_alias =3D g_new0(MemoryRegion, 1);
>+    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
>+                             mmio_reg, base_mmio, size_mmio);
>+    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_ali=
as);
>+
>+    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
>+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>+                           qdev_get_gpio_in(vms->gic, irq + i));
>+        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
>+    }
>+
>+    pci =3D PCI_HOST_BRIDGE(dev);
>+    vms->bus =3D pci->bus;
>+    if (vms->bus) {
>+        for (i =3D 0; i < nb_nics; i++) {
>+            NICInfo *nd =3D &nd_table[i];
>+
>+            if (!nd->model) {
>+                nd->model =3D g_strdup("virtio");
>+            }
>+
>+            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>+        }
>+    }
>+
>+    virtio_tablet =3D qdev_new("virtio-tablet-pci");
>+    qdev_realize(virtio_tablet, BUS(pci->bus), &error_fatal);
>+    object_unref(virtio_tablet);
>+
>+    virtio_keyboard =3D qdev_new("virtio-keyboard-pci");
>+    qdev_realize(virtio_keyboard, BUS(pci->bus), &error_fatal);
>+    object_unref(virtio_keyboard);
>+}
>+
>+static void vmapple_reset(void *opaque)
>+{
>+    VMAppleMachineState *vms =3D opaque;
>+    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE]=2Ebase;
>+
>+    cpu_set_pc(first_cpu, base);
>+}
>+
>+static void mach_vmapple_init(MachineState *machine)
>+{
>+    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(machine);
>+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>+    const CPUArchIdList *possible_cpus;
>+    MemoryRegion *sysmem =3D get_system_memory();
>+    int n;
>+    unsigned int smp_cpus =3D machine->smp=2Ecpus;
>+    unsigned int max_cpus =3D machine->smp=2Emax_cpus;
>+
>+    vms->memmap =3D memmap;
>+
>+    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
>+    assert(possible_cpus->len =3D=3D max_cpus);
>+    for (n =3D 0; n < possible_cpus->len; n++) {
>+        Object *cpu;
>+        CPUState *cs;
>+
>+        if (n >=3D smp_cpus) {
>+            break;
>+        }
>+
>+        cpu =3D object_new(possible_cpus->cpus[n]=2Etype);
>+        object_property_set_int(cpu, "mp-affinity",
>+                                possible_cpus->cpus[n]=2Earch_id, NULL);
>+
>+        cs =3D CPU(cpu);
>+        cs->cpu_index =3D n;
>+
>+        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cp=
u),
>+                          &error_fatal);
>+
>+        object_property_set_bool(cpu, "has_el3", false, NULL);
>+        object_property_set_bool(cpu, "has_el2", false, NULL);
>+        object_property_set_int(cpu, "psci-conduit", QEMU_PSCI_CONDUIT_H=
VC,
>+                                NULL);
>+
>+        /* Secondary CPUs start in PSCI powered-down state */
>+        if (n > 0) {
>+            object_property_set_bool(cpu, "start-powered-off", true, NUL=
L);
>+        }
>+
>+        object_property_set_link(cpu, "memory", OBJECT(sysmem), &error_a=
bort);
>+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>+        object_unref(cpu);
>+    }
>+
>+    memory_region_add_subregion(sysmem, vms->memmap[VMAPPLE_MEM]=2Ebase,
>+                                machine->ram);
>+
>+    create_gic(vms, sysmem);
>+    create_bdif(vms, sysmem);
>+    create_pvpanic(vms, sysmem);
>+    create_aes(vms, sysmem);
>+    create_gfx(vms, sysmem);
>+    create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));
>+    create_rtc(vms);
>+    create_pcie(vms);
>+
>+    create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
>+
>+    vmapple_firmware_init(vms, sysmem);
>+    create_cfg(vms, sysmem);
>+
>+    /* connect powerdown request */
>+    vms->powerdown_notifier=2Enotify =3D vmapple_powerdown_req;
>+    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
>+
>+    vms->bootinfo=2Eram_size =3D machine->ram_size;
>+    vms->bootinfo=2Eboard_id =3D -1;
>+    vms->bootinfo=2Eloader_start =3D vms->memmap[VMAPPLE_MEM]=2Ebase;
>+    vms->bootinfo=2Eskip_dtb_autoload =3D true;
>+    vms->bootinfo=2Efirmware_loaded =3D true;
>+    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
>+
>+    qemu_register_reset(vmapple_reset, vms);
>+}
>+
>+static CpuInstanceProperties
>+vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>+{
>+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>+    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms)=
;
>+
>+    assert(cpu_index < possible_cpus->len);
>+    return possible_cpus->cpus[cpu_index]=2Eprops;
>+}
>+
>+
>+static int64_t vmapple_get_default_cpu_node_id(const MachineState *ms, i=
nt idx)
>+{
>+    return idx % ms->numa_state->num_nodes;
>+}
>+
>+static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState *=
ms)
>+{
>+    int n;
>+    unsigned int max_cpus =3D ms->smp=2Emax_cpus;
>+
>+    if (ms->possible_cpus) {
>+        assert(ms->possible_cpus->len =3D=3D max_cpus);
>+        return ms->possible_cpus;
>+    }
>+
>+    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
>+                                  sizeof(CPUArchId) * max_cpus);
>+    ms->possible_cpus->len =3D max_cpus;
>+    for (n =3D 0; n < ms->possible_cpus->len; n++) {
>+        ms->possible_cpus->cpus[n]=2Etype =3D ms->cpu_type;
>+        ms->possible_cpus->cpus[n]=2Earch_id =3D
>+            arm_cpu_mp_affinity(n, GICV3_TARGETLIST_BITS);
>+        ms->possible_cpus->cpus[n]=2Eprops=2Ehas_thread_id =3D true;
>+        ms->possible_cpus->cpus[n]=2Eprops=2Ethread_id =3D n;
>+    }
>+    return ms->possible_cpus;
>+}
>+
>+static void vmapple_get_uuid(Object *obj, Visitor *v, const char *name,
>+                             void *opaque, Error **errp)
>+{
>+    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
>+    uint64_t value =3D be64_to_cpu(vms->uuid);
>+
>+    visit_type_uint64(v, name, &value, errp);
>+}
>+
>+static void vmapple_set_uuid(Object *obj, Visitor *v, const char *name,
>+                             void *opaque, Error **errp)
>+{
>+    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
>+    Error *error =3D NULL;
>+    uint64_t value;
>+
>+    visit_type_uint64(v, name, &value, &error);
>+    if (error) {
>+        error_propagate(errp, error);
>+        return;
>+    }
>+
>+    vms->uuid =3D cpu_to_be64(value);
>+}
>+
>+static void vmapple_machine_class_init(ObjectClass *oc, void *data)
>+{
>+    MachineClass *mc =3D MACHINE_CLASS(oc);
>+
>+    mc->init =3D mach_vmapple_init;
>+    mc->max_cpus =3D 32;
>+    mc->block_default_type =3D IF_VIRTIO;
>+    mc->no_cdrom =3D 1;
>+    mc->pci_allow_0_address =3D true;
>+    mc->minimum_page_bits =3D 12;
>+    mc->possible_cpu_arch_ids =3D vmapple_possible_cpu_arch_ids;
>+    mc->cpu_index_to_instance_props =3D vmapple_cpu_index_to_props;
>+    if (hvf_enabled()) {
>+        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("host");
>+    } else {
>+        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
>+    }
>+

