Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C7802923
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:47:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w6h-0006yJ-LH; Sun, 03 Dec 2023 18:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6c-0006sr-5r; Sun, 03 Dec 2023 18:42:35 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6a-0002jz-6d; Sun, 03 Dec 2023 18:42:33 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d3644ca426so34927907b3.1; 
 Sun, 03 Dec 2023 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646950; x=1702251750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wmi1AJ5sdVkVMe4G4xOT7WMN2sIuUaWUGckgKMqr68s=;
 b=fxdtzb4jRS6vZWU8hOvcue+WvDYhykmNQw+Uybky5M96ChE7AJjzjN3PjRyVCpDkzS
 v/MFD0cRScgniitRbAFmrZo+h/Pj2s8mEyOxNOGhUJLBENaxO9/K8gWs6e++W/H0D3ZI
 H1bez89PoyuJaErsoW4zEgogdn6bKLuWR9JwHlXlK5TnHXdQqh5ZOrkpXhaptJYvUwrU
 iZ7tk1oSaoC/nEMvGkGwQkYw9OPBbl0/K+nnpyuT31/YxQ/jwsf3oR5Q2PKGsif9pwag
 XKBrjbEA5r7ygXsP5QAJOC4cPnj2k+BguGRs1QJoFwzmh/kpyQyTIwT6nlTGXSTp06wc
 LqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646950; x=1702251750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wmi1AJ5sdVkVMe4G4xOT7WMN2sIuUaWUGckgKMqr68s=;
 b=jgtgocJZE1A3mw3jqNXwhX7LPdACoMc5qFIr4BT9GqXOdUryXZtgcpD4pWK59yBQk9
 oYWWgolCLpy0aJJ8EVvIWzEn+ouWcQKGxTZOTh8W+2aajbPyoTqcIg1npY6n/yFpV4P7
 JzFiZeAPyJ3k3ZtNwNMSjB+YLtBuDlE5dzc4BlbJAJGF7w5WpYKSyJR/iou/41wcvGIp
 Jqaqd85+RITr6IROJ35S/ZRnGP46uLXf02ppT2U2d/5WF/5QPoZ9UckIfgKHl4zYqryo
 1UAy/dTD1+QKUFYtHd8nHS6QpzXcKH8qMj2XKdroawX/4nJoCGlCaKVaAkWzxy9TqJwo
 TAog==
X-Gm-Message-State: AOJu0YyRpl1C9EQaK5I6DFtlmnrqJutlFSHPw7oir7TFay5rKcIkzF6w
 fbi4ZJgOBLrg23xQIH1CASEVPOg9Vx+Mfw==
X-Google-Smtp-Source: AGHT+IHBexQa+qLwnjJkSSzFtsIklU2Ya+2qrkZB5PC4+NNKrJgR8bdQuy4W9tYddrNqF1DpPoISPw==
X-Received: by 2002:a0d:fcc3:0:b0:5cc:765e:f4fe with SMTP id
 m186-20020a0dfcc3000000b005cc765ef4femr1658963ywf.27.1701646950291; 
 Sun, 03 Dec 2023 15:42:30 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:30 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 12/45] Temporarily disable unimplemented rpi4b devices
Date: Sun,  3 Dec 2023 17:41:40 -0600
Message-Id: <20231203234213.1366214-13-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit adds RPi4B device tree modifications:
- disable pcie, rng200, thermal sensor and genet devices
  (they're going to be re-enabled in the following commits)
- create additional memory region in device tree
  if RAM amount exceeds VC base address.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/raspi.c                  |  5 +--
 hw/arm/raspi4b.c                | 60 +++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h |  4 +++
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index da1e9e7c13..895c305122 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -37,9 +37,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
 #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
-/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
-#define MACH_TYPE_BCM2708   3138
-
 struct RaspiMachineState {
     /*< private >*/
     RaspiBaseMachineState parent_obj;
@@ -75,7 +72,7 @@ static const struct {
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static uint64_t board_ram_size(uint32_t board_rev)
+uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 2d33861c57..10376b62dc 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -21,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
+#include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-2g")
 OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
@@ -32,6 +33,64 @@ struct Raspi4bMachineState {
     BCM2838State soc;
 };
 
+/* Add second memory region if board RAM amount exceeds VC base address
+ * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
+ * 1.2 Address Map)
+ */
+static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
+{
+    int ret;
+    uint32_t acells, scells;
+    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+                                   NULL, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+                                   NULL, &error_fatal);
+    if (acells == 0 || scells == 0) {
+        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        ret = -1;
+    } else {
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                           acells, mem_base,
+                                           scells, mem_len);
+    }
+
+    g_free(nodename);
+    return ret;
+}
+
+static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+
+    /* Temporarily disable following devices until they are implemented*/
+    const char *to_be_removed_from_dt_as_wa[] = {
+        "brcm,bcm2711-pcie",
+        "brcm,bcm2711-rng200",
+        "brcm,bcm2711-thermal",
+        "brcm,bcm2711-genet-v5",
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(to_be_removed_from_dt_as_wa); i++) {
+        const char *dev_str = to_be_removed_from_dt_as_wa[i];
+
+        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        if (offset >= 0) {
+            if (!fdt_nop_node(fdt, offset)) {
+                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
+            }
+        }
+    }
+
+    uint64_t ram_size = board_ram_size(info->board_id);
+
+    if (info->ram_size > UPPER_RAM_BASE) {
+        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
+    }
+}
+
 static void raspi4b_machine_init(MachineState *machine)
 {
     Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
@@ -39,6 +98,7 @@ static void raspi4b_machine_init(MachineState *machine)
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     BCM2838State *soc = &s->soc;
 
+    s_base->binfo.modify_dtb = raspi4_modify_dtb;
     s_base->binfo.board_id = mc->board_rev;
 
     object_initialize_child(OBJECT(machine), "soc", soc,
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 45003e2425..0db146e592 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -31,6 +31,9 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 
+/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
+#define MACH_TYPE_BCM2708   3138
+
 #define TYPE_RASPI_BASE_MACHINE MACHINE_TYPE_NAME("raspi-base")
 OBJECT_DECLARE_TYPE(RaspiBaseMachineState, RaspiBaseMachineClass,
                     RASPI_BASE_MACHINE)
@@ -59,6 +62,7 @@ void raspi_base_machine_init(MachineState *machine,
 
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev);
+uint64_t board_ram_size(uint32_t board_rev);
 
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
-- 
2.34.1


