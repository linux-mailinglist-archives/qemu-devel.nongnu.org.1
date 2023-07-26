Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA07637A8
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWp-0002zG-5R; Wed, 26 Jul 2023 09:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWH-0002ja-EV; Wed, 26 Jul 2023 09:25:37 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWF-0003DJ-LR; Wed, 26 Jul 2023 09:25:37 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so10670405e87.2; 
 Wed, 26 Jul 2023 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377933; x=1690982733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKhEuIKwITdrcIVOAcQ7yfs/MBUjfcLpaxFMigaCLxc=;
 b=KkJOHJ2rlnEJRHDAhTs7R3YySgc87niv6qLGcSV3UcThqYr0SBk9xsiu7yZMLjUoyI
 MO9NGc7dIJoEkynOz47G5ODo5P5DBrhT1PbLGL6qP8Rvb4zmgykcdeFnPQGDv6ebUr8w
 0CG/D7sSuOOhkRH8rHy14dxIYnpgcv2ekGmEteMSTgMPAuDkEoDllbwmL40ACY9D+mj/
 qxuKSXzeb83+RdYBhMnE2qwzGf4FoivqFg8ou8DDy5zESScuRk1SdFg7n4FTyLLxt/pJ
 WNfUC9fVVJvtkqUbCO6OUhmPqKnrvs88le7pscFGu4H3rNIF01R9k6rZldbMh71YpzIT
 Nrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377933; x=1690982733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKhEuIKwITdrcIVOAcQ7yfs/MBUjfcLpaxFMigaCLxc=;
 b=JrPe9qgTTI1KrKdwk+/3B9vyhsfEVeuD0fVAMV7ZMWofruMpB9m+4/SZeQSpe033qM
 Dp47k0wrdlP5wXbJlfxDue33WmFL1bj+PZMg+8i/DgiI0nmLjMj7giPiEAU7sp/Pe2ld
 aacnFiTBQ1XhGVPVHAsB5YsV/mpeP366RXShWwWj24sLibn7KwYfNg6z/w8RMxq/N3j+
 0TbpWQo/CqHD5N5DGINw0T2bBC+pMd4XdSUmwY4HJKFUBkQCHONTc32nKo99IRqoygiu
 hohR5mEbKRLtqgt/f/qENR4X0Mj3qxOPhzwyUQRtWwQaxFsIkiOsLwzPTa9YcF4icCTH
 hgbg==
X-Gm-Message-State: ABy/qLaGJ/fpeEnEJmmPygEKxkgao/qdrZmSuZB5wrNk9Vapx//S9UCW
 j6OCSMQ1DdixhyXC0gR469LC3W22jWY=
X-Google-Smtp-Source: APBJJlHGWdDSph4jyCvLnu/RIjX/ux+31ira7SyHzNE19T04raV2MctnfsZN+Arphyf51LDwhBEwrQ==
X-Received: by 2002:ac2:4d17:0:b0:4fe:f24:cbf3 with SMTP id
 r23-20020ac24d17000000b004fe0f24cbf3mr1296650lfi.63.1690377933009; 
 Wed, 26 Jul 2023 06:25:33 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:32 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 12/44] Temporary disable unimplemented rpi4b devices
Date: Wed, 26 Jul 2023 16:24:40 +0300
Message-Id: <20230726132512.149618-13-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12e.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/raspi.c                  |  2 +-
 hw/arm/raspi4b.c                | 63 +++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h |  1 +
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index da1e9e7c13..cffdd8de4e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -75,7 +75,7 @@ static const struct {
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static uint64_t board_ram_size(uint32_t board_rev)
+uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 4096522d85..d2053c9380 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -21,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
+#include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-common")
 OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
@@ -34,6 +35,61 @@ struct Raspi4bMachineState {
     uint32_t vcram_size;
 };
 
+
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
+    /* Temporary disable following devices until they are implemented*/
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
+    if (ram_size > UPPER_RAM_BASE) {
+        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
+    }
+}
+
 static void raspi4b_machine_init(MachineState *machine)
 {
     Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
@@ -41,6 +97,13 @@ static void raspi4b_machine_init(MachineState *machine)
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     BCM2838State *soc = &s->soc;
 
+    s_base->binfo.modify_dtb = raspi4_modify_dtb;
+    /*
+     * Hack to get board revision during device tree modification without
+     * changes of common code.
+     * The correct way is to set board_id to MACH_TYPE_BCM2708 and add board_rev
+     * to the arm_boot_info structure.
+     */
     s_base->binfo.board_id = mc->board_rev;
 
     object_initialize_child(OBJECT(machine), "soc", soc,
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 45003e2425..30b114f6e0 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -59,6 +59,7 @@ void raspi_base_machine_init(MachineState *machine,
 
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev);
+uint64_t board_ram_size(uint32_t board_rev);
 
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
-- 
2.34.1


