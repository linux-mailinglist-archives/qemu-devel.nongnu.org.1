Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7293B7E4A18
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Szs-0006YC-8r; Tue, 07 Nov 2023 15:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szp-0006Vx-8J; Tue, 07 Nov 2023 15:48:25 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szg-0006RX-FS; Tue, 07 Nov 2023 15:48:25 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cb615c6fbso39046391cf.1; 
 Tue, 07 Nov 2023 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390095; x=1699994895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+QMcQvAJFFcKXttw1mmwXFabfyT79u3qwaW15teDe4=;
 b=YGJJW+xY/+2NxlU0Qd2jvpvs7+nArP1wUvGpXrxejbLWYoKEFh+0HKnIFj7D1H67yB
 X2CxAEQaxFHNesX8z1tUH/7YYg5EBKAhVA0Bwi3+jYty5FVmdNcaOb0cjRjqdJzqZjab
 nBeBDtg8IyOF9VgGwoEvngPtnIkRvNeFrQnsMdBzhZb+MGQMM2K4Lsd03cFjD+yhf/43
 Gn2fgJhYqCKATMFXkYtVbojwiKJBxpSWQ5Nru2dw2Bv/mKUhKURzUAFQitrnyKhXbuwE
 5utqyCxsL67H//lUv01dxXcpUCAuSt7aUsiBX3pwLMkjeYleC9LcYXLQI+V3b169oN9h
 flLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390095; x=1699994895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+QMcQvAJFFcKXttw1mmwXFabfyT79u3qwaW15teDe4=;
 b=M1QIon5i20ZbdvoisuzdJ0wmHZQkcoMB2lzlnjW9DQ5wWzkGguEAI3N5DD571iAz4G
 YP9jbG9NoOAs2Jxv1Fh/KLuJmvOHkeCw9tIlL9f6Gc4jMzcM3TZOIcfw699Ksu2zW8Y4
 kTKAad3VDPW+B4yXz1shUaQ3zOSH38SU+rLsXP6ylatlLEnZDNxuEPmlSKun0Cb5V/t2
 Zk3bTvbm3LRUYLGjbOI5HMu/SdOqasBBLuksakDm2jY6iqVqTVtEjw9gO0/25Q9YwngP
 IYQojd+kmLdnJus8RzUS1A8sHxxgqBcW5jFcg/+zljehUMWfyJTvoR1qGpXOTv54KU+J
 90OA==
X-Gm-Message-State: AOJu0YygvLJ1QHTG2JcrBhRbz7HFZ+xMpmBtPQQOJsWYg516LLrSPNow
 s4dAYORsTJ1kBymXZygjnfmKy6Iih70=
X-Google-Smtp-Source: AGHT+IFR4ZYHcx+0hzjcqQeNq2Uob8jegwbHh3J+YcF3rfS4ZvDu/q3vYRy9Y4KaFgKoNTWdT4D5cw==
X-Received: by 2002:a05:622a:1885:b0:418:1f52:1421 with SMTP id
 v5-20020a05622a188500b004181f521421mr6483qtc.9.1699390094935; 
 Tue, 07 Nov 2023 12:48:14 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:14 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 BALATON Zoltan <balaton@eik.bme.hu>, Rene Engel <ReneEngel80@emailn.de>
Subject: [PULL 2/9] hw/ppc: Add emulation of AmigaOne XE board
Date: Tue,  7 Nov 2023 17:47:59 -0300
Message-ID: <20231107204806.8507-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
with patches to support AmigaOS and is very similar to pegasos2 so can
be easily emulated sharing most code with pegasos2. The reason to
emulate it is that AmigaOS comes in different versions for AmigaOne
and PegasosII which only have drivers for one machine and firmware so
these only run on the specific machine. Adding this board allows
another AmigaOS version to be used reusing already existing peagasos2
emulation. (The AmigaOne was the first of these boards so likely most
widespread which then inspired Pegasos that was later replaced with
PegasosII due to problems with Articia S, so these have a lot of
similarity. Pegasos mainly ran MorphOS while the PegasosII version of
AmigaOS was added later and therefore less common than the AmigaOne
version.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Acked-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <804935e7a5921548d630576159ae2c758fe6e275.1699382232.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 MAINTAINERS                             |   8 ++
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 166 ++++++++++++++++++++++++
 hw/ppc/meson.build                      |   2 +
 5 files changed, 184 insertions(+)
 create mode 100644 hw/ppc/amigaone.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b86ea7f75a..3d0aec7ffa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1536,6 +1536,14 @@ F: hw/pci-host/mv64361.c
 F: hw/pci-host/mv643xx.h
 F: include/hw/pci-host/mv64361.h
 
+amigaone
+M: BALATON Zoltan <balaton@eik.bme.hu>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/amigaone.c
+F: hw/pci-host/articia.c
+F: include/hw/pci-host/articia.h
+
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
 R: David Gibson <david@gibson.dropbear.id.au>
diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index a887f5438b..b85fd2bcd7 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -14,6 +14,7 @@ CONFIG_SAM460EX=y
 CONFIG_MAC_OLDWORLD=y
 CONFIG_MAC_NEWWORLD=y
 
+CONFIG_AMIGAONE=y
 CONFIG_PEGASOS2=y
 
 # For PReP
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5dfbf47ef5..56f0475a8e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -69,6 +69,13 @@ config SAM460EX
     select USB_OHCI
     select FDT_PPC
 
+config AMIGAONE
+    bool
+    imply ATI_VGA
+    select ARTICIA
+    select VT82C686
+    select SMBUS_EEPROM
+
 config PEGASOS2
     bool
     imply ATI_VGA
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
new file mode 100644
index 0000000000..992a55e632
--- /dev/null
+++ b/hw/ppc/amigaone.c
@@ -0,0 +1,166 @@
+/*
+ * QEMU Eyetech AmigaOne/Mai Logic Teron emulation
+ *
+ * Copyright (c) 2023 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/datadir.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/ppc/ppc.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/pci-host/articia.h"
+#include "hw/isa/vt82c686.h"
+#include "hw/ide/pci.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "hw/ppc/ppc.h"
+#include "sysemu/qtest.h"
+#include "sysemu/reset.h"
+#include "kvm_ppc.h"
+
+#define BUS_FREQ_HZ 100000000
+
+/*
+ * Firmware binary available at
+ * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
+ * then "tail -c 524288 updater.image >u-boot-amigaone.bin"
+ *
+ * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it, use
+ * -device VGA,romfile=VGABIOS-lgpl-latest.bin
+ * from http://www.nongnu.org/vgabios/ instead.
+ */
+#define PROM_FILENAME "u-boot-amigaone.bin"
+#define PROM_ADDR 0xfff00000
+#define PROM_SIZE (512 * KiB)
+
+static void amigaone_cpu_reset(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+    cpu_ppc_tb_reset(&cpu->env);
+}
+
+static void fix_spd_data(uint8_t *spd)
+{
+    uint32_t bank_size = 4 * MiB * spd[31];
+    uint32_t rows = bank_size / spd[13] / spd[17];
+    spd[3] = ctz32(rows) - spd[4];
+}
+
+static void amigaone_init(MachineState *machine)
+{
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
+    MemoryRegion *rom, *pci_mem, *mr;
+    const char *fwname = machine->firmware ?: PROM_FILENAME;
+    char *filename;
+    ssize_t sz;
+    PCIBus *pci_bus;
+    Object *via;
+    DeviceState *dev;
+    I2CBus *i2c_bus;
+    uint8_t *spd_data;
+    int i;
+
+    /* init CPU */
+    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    env = &cpu->env;
+    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
+        error_report("Incompatible CPU, only 6xx bus supported");
+        exit(1);
+    }
+    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
+    qemu_register_reset(amigaone_cpu_reset, cpu);
+
+    /* RAM */
+    if (machine->ram_size > 2 * GiB) {
+        error_report("RAM size more than 2 GiB is not supported");
+        exit(1);
+    }
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    if (machine->ram_size < 1 * GiB + 32 * KiB) {
+        /* Firmware uses this area for startup */
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
+    }
+
+    /* allocate and load firmware */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
+    if (filename) {
+        rom = g_new(MemoryRegion, 1);
+        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
+        if (sz <= 0 || sz > PROM_SIZE) {
+            error_report("Could not load firmware '%s'", filename);
+            exit(1);
+        }
+        g_free(filename);
+    } else if (!qtest_enabled()) {
+        error_report("Could not find firmware '%s'", fwname);
+        exit(1);
+    }
+
+    /* Articia S */
+    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
+
+    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
+    if (machine->ram_size > 512 * MiB) {
+        spd_data = spd_data_generate(SDR, machine->ram_size / 2);
+    } else {
+        spd_data = spd_data_generate(SDR, machine->ram_size);
+    }
+    fix_spd_data(spd_data);
+    smbus_eeprom_init_one(i2c_bus, 0x51, spd_data);
+    if (machine->ram_size > 512 * MiB) {
+        smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
+    }
+
+    pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
+                             0, 0x1000000);
+    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
+                             0x80000000, 0x7d000000);
+    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
+    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
+
+    /* VIA VT82c686B South Bridge (multifunction PCI device) */
+    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
+                                                 TYPE_VT82C686B_ISA));
+    object_property_add_alias(OBJECT(machine), "rtc-time",
+                              object_resolve_path_component(via, "rtc"),
+                              "date");
+    qdev_connect_gpio_out(DEVICE(via), 0,
+                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
+                                                             "pirq", i));
+    }
+    pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
+    pci_vga_init(pci_bus);
+}
+
+static void amigaone_machine_init(MachineClass *mc)
+{
+    mc->desc = "Eyetech AmigaOne/Mai Logic Teron";
+    mc->init = amigaone_init;
+    mc->block_default_type = IF_IDE;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
+    mc->default_display = "std";
+    mc->default_ram_id = "ram";
+    mc->default_ram_size = 512 * MiB;
+}
+
+DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..7338f9432a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -81,6 +81,8 @@ ppc_ss.add(when: 'CONFIG_E500', if_true: files(
 ))
 # PowerPC 440 Xilinx ML507 reference board.
 ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
+# AmigaOne
+ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
 # Pegasos2
 ppc_ss.add(when: 'CONFIG_PEGASOS2', if_true: files('pegasos2.c'))
 
-- 
2.41.0


