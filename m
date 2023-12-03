Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA01802918
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:44:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w6k-00071N-A0; Sun, 03 Dec 2023 18:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6b-0006re-Dq; Sun, 03 Dec 2023 18:42:33 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6Y-0002jh-RE; Sun, 03 Dec 2023 18:42:32 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d226f51f71so42744917b3.3; 
 Sun, 03 Dec 2023 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646949; x=1702251749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mb+gBOAGJHmc0xq2NNLfwE4TknnwiidC5qQtn1CrDao=;
 b=gMyCUiqtjukZMssLOiFGqsFkLVm0aUJa4n0+ejo4EmA90Th7q4Xzf3npUk85usR+8+
 Lm+D/8zwRz7rRVb/hIhw2vuD9KBY5VSu3qCdK2XsDOO4GTDag3Bx3FkPfF5YcQkmK5kB
 n1BZI3EAoVDYpXQIfF0NzuLx/35LKx6nwPB00kl8ggnDxn2zPkG5zCKrrlIeKzEbbL8d
 Hr9vbOWLeZJfAhmbcJKBC1JueTg9gL9JVodI6tmPn6nLU/6oBNR/SVdOD+rNoZcBMGXb
 ibRhpxhsX0v/wkHUTZHgdKpxRckmRbuud6wO48QGAgE0m88sYmbSg2MDGwqn5Mp4kzBa
 xK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646949; x=1702251749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mb+gBOAGJHmc0xq2NNLfwE4TknnwiidC5qQtn1CrDao=;
 b=Go/Y5/jcwkpt8vMyLEjjbWqVveMmI5oQiU2uANHSAWcE1VGNeKdQVWYxa+gn7UQkUF
 hBKY/TlwDL7qxShN9DMeUpf0zG2a1UCHeGZ1FvQKjdI+8tj0PYzGi4r/Nsi3phdsRPpD
 tX9s+cE8K2qX4IcgbwqnP6NEgJoORqmRkPYN0I+kOErUVAu7di7c4lb1Iu931Spjr1gR
 SMldxSmynP0vTBpaRZK5LnkroljwO+iq5KY/lFfJWdmkLwSNIid1Bu4pCEsNCDx0+rnm
 NexzSVu5ieEGzwVuvO+K0ZYGENNQDIYa/3pgwvqqpdz+tzozRCwA1PjDJIDXcuqvFdQp
 efaw==
X-Gm-Message-State: AOJu0YytAYBrbwMrqy9BnczXAcZFPB255Tbps03e+G98YneGGApT9Lsk
 awmd2ANhw8CRRoskip9QCIX8XRmlDWrQJg==
X-Google-Smtp-Source: AGHT+IE4yYpPvYJ+cW3r+3wiUltzP8ZWFdvxMQjRAArx/zxh7s8CvBdDbBzDZ90VqX+OcvDtCtR7rQ==
X-Received: by 2002:a0d:ef06:0:b0:5c9:80ec:53ce with SMTP id
 y6-20020a0def06000000b005c980ec53cemr1912815ywe.37.1701646949227; 
 Sun, 03 Dec 2023 15:42:29 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:29 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 11/45] Introduce Raspberry PI 4 machine
Date: Sun,  3 Dec 2023 17:41:39 -0600
Message-Id: <20231203234213.1366214-12-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1133.google.com
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
 hw/arm/bcm2835_peripherals.c    | 20 +++++++--
 hw/arm/bcm2836.c                |  2 +
 hw/arm/bcm2838.c                |  2 +
 hw/arm/meson.build              |  2 +-
 hw/arm/raspi.c                  | 28 ++++++++-----
 hw/arm/raspi4b.c                | 72 +++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h | 11 +++++
 include/hw/display/bcm2835_fb.h |  2 +
 8 files changed, 125 insertions(+), 14 deletions(-)
 create mode 100644 hw/arm/raspi4b.c

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index fd70cde123..ae8117961e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -108,6 +108,7 @@ static void raspi_peripherals_base_init(Object *obj)
     /* Framebuffer */
     object_initialize_child(obj, "fb", &s->fb, TYPE_BCM2835_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->fb), "vcram-base");
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
@@ -225,7 +226,7 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
-    uint64_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size, vcram_base;
     int n;
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
@@ -329,11 +330,24 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
-                                  ram_size - vcram_size, errp)) {
+    vcram_base = object_property_get_uint(OBJECT(s), "vcram-base", &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
 
+    if (vcram_base == 0) {
+        vcram_base = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
+            - vcram_size;
+    } else {
+        if (vcram_base + vcram_size > UPPER_RAM_BASE) {
+            vcram_base = UPPER_RAM_BASE - vcram_size;
+        }
+    }
+    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base", vcram_base,
+                                  errp)) {
+        return;
+    }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
         return;
     }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 18675c896c..ee890f3d35 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -64,6 +64,8 @@ static void bcm283x_init(Object *obj)
                               "command-line");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
 }
 
 bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 8925957c6c..89cd9d5d8c 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -54,6 +54,8 @@ static void bcm2838_init(Object *obj)
                               "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 551ab6abf5..27e6797de2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,7 +39,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7d04734cd2..da1e9e7c13 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/arm/bcm2838.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
@@ -61,6 +62,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
+    PROCESSOR_ID_BCM2838 = 3,
 } RaspiProcessorId;
 
 static const struct {
@@ -70,13 +72,9 @@ static const struct {
     [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static void raspi_base_machine_init(MachineState *machine,
-                             BCM283XBaseState *soc);
-static void raspi_machine_class_common_init(MachineClass *mc,
-                                     uint32_t board_rev);
-
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -93,7 +91,7 @@ static RaspiProcessorId board_processor_id(uint32_t board_rev)
     return proc_id;
 }
 
-static const char *board_soc_type(uint32_t board_rev)
+const char *board_soc_type(uint32_t board_rev)
 {
     return soc_property[board_processor_id(board_rev)].type;
 }
@@ -248,13 +246,14 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
     arm_load_kernel(cpu, machine, &s->binfo);
 }
 
-static void raspi_base_machine_init(MachineState *machine,
+void raspi_base_machine_init(MachineState *machine,
                              BCM283XBaseState *soc)
 {
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
-    uint32_t vcram_size;
+    uint32_t vcram_base, vcram_size;
+    size_t boot_ram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
@@ -293,11 +292,20 @@ static void raspi_base_machine_init(MachineState *machine,
 
     vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
+    vcram_base = object_property_get_uint(OBJECT(soc), "vcram-base",
+                                          &error_abort);
+    if (!vcram_base) {
+        boot_ram_size = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
+            - vcram_size;
+    } else {
+        boot_ram_size = (vcram_base + vcram_size > UPPER_RAM_BASE ?
+                                UPPER_RAM_BASE - vcram_size : vcram_base);
+    }
     setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
-               machine->ram_size - vcram_size);
+               boot_ram_size);
 }
 
-static void raspi_machine_init(MachineState *machine)
+void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
     RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
new file mode 100644
index 0000000000..2d33861c57
--- /dev/null
+++ b/hw/arm/raspi4b.c
@@ -0,0 +1,72 @@
+/*
+ * Raspberry Pi 4B emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/display/bcm2835_fb.h"
+#include "hw/registerfields.h"
+#include "qemu/error-report.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/arm/boot.h"
+#include "qom/object.h"
+#include "hw/arm/bcm2838.h"
+
+#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-2g")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+
+struct Raspi4bMachineState {
+    /*< private >*/
+    RaspiBaseMachineState parent_obj;
+    /*< public >*/
+    BCM2838State soc;
+};
+
+static void raspi4b_machine_init(MachineState *machine)
+{
+    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM2838State *soc = &s->soc;
+
+    s_base->binfo.board_id = mc->board_rev;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+    mc->init = raspi4b_machine_init;
+}
+
+static const TypeInfo raspi4b_machine_type = {
+    .name           = TYPE_RASPI4B_MACHINE,
+    .parent         = TYPE_RASPI_BASE_MACHINE,
+    .instance_size  = sizeof(Raspi4bMachineState),
+    .class_init     = raspi4b_machine_class_init,
+};
+
+static void raspi4b_machine_register_type(void)
+{
+    type_register_static(&raspi4b_machine_type);
+}
+
+type_init(raspi4b_machine_register_type)
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 3018e8fcf3..45003e2425 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -49,6 +49,17 @@ struct RaspiBaseMachineClass {
     uint32_t board_rev;
 };
 
+/* Common functions for raspberry pi machines */
+const char *board_soc_type(uint32_t board_rev);
+void raspi_machine_init(MachineState *machine);
+
+typedef struct BCM283XBaseState BCM283XBaseState;
+void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc);
+
+void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev);
+
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
 #define INTE_OFFSET             0x2000   /* VC Interrupt controller */
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 38671afffd..49541bf08f 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -16,6 +16,8 @@
 #include "ui/console.h"
 #include "qom/object.h"
 
+#define UPPER_RAM_BASE 0x40000000
+
 #define TYPE_BCM2835_FB "bcm2835-fb"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835FBState, BCM2835_FB)
 
-- 
2.34.1


