Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4061802963
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wnN-0004VG-QD; Sun, 03 Dec 2023 19:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnC-0004Qm-8q; Sun, 03 Dec 2023 19:26:34 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wn8-00005i-Nk; Sun, 03 Dec 2023 19:26:33 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5d8d2b5d1b5so180167b3.0; 
 Sun, 03 Dec 2023 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649588; x=1702254388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mb12SLyYKgE+GLLI/c9J/vANlZ3FBQt3OE84lYGKOg=;
 b=F4X1ZIlUJA7tZX7qenq1nOuLacPKX+q8gR2+ZLz8C0su0MpPTolzY4cKt2IJPnpP6r
 j/re4B5qkKQNSPXtrjnPL5ldT1CE+xvcSfCLWPZTZ1Hd88tEhpwIlQiNXay0fwP7QsvP
 oZ99xq8/t7k5OANLN7Q03W+pi1AuyrKEpasTjzp9qaWM6veqnuKOo9lUZ5xk0jvh+qgY
 PpE27tnuslx/X6au4gOP8bUNe45Hq9m81zCnuJzsQiPnaWsCSlt63Y4JzS6GpWPJumq/
 QKt8R2sqM8mxosSzE40kEYsSXkY9GAW+oQ7mupfiDQREZdHvAk7s0kNdvyeMXY56Hlbx
 ydGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649588; x=1702254388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mb12SLyYKgE+GLLI/c9J/vANlZ3FBQt3OE84lYGKOg=;
 b=b8ZbsQfLx/QFamCkeqjRtoc7FKb9OzaBb8s9Ud0yT6H2j62kab1LikTt7Z9qMO4ZOi
 OYLQV+xWUtCXybjWhUgWm6ZvI/9NhWBKcweMHtBuemzKu5MH5GZrXpXikJQKwNG9owDo
 nqoI7JbWsJSW2ftDUKjAytM2pP0F+dmEeYEqBpKIQPAsJZoXwxmyUKz7HhtFO/viNINv
 OXiKSfHOoFob+OCxFm+XTvCr2Q8+GY2DnbUkeYpD3K9o2rxh7jhkl1XvkGWJijPr6nbx
 QXZc3CzfXDe3ygG3BVUsgDhcIay+yuDBqPmKnYTUlawTFKR9BPHc46WtTFKtDWPhOdUG
 LfGw==
X-Gm-Message-State: AOJu0Yz4KGP/Q9iBBhWaze3+VMv+6VVmEp/e3ahaTAHS5/G9dlWhlgn0
 57lAsLe7O9KJ4ihmlUxQY1Vq1SrHIx22Iw==
X-Google-Smtp-Source: AGHT+IHIE3eMTMvFqh30BVDYvcYsuoajUdB014bTzSH1Nb/oOd044WME3NOrLjI4kITHD66SwSo3Uw==
X-Received: by 2002:a81:ad14:0:b0:5ca:8f2c:28c5 with SMTP id
 l20-20020a81ad14000000b005ca8f2c28c5mr656171ywh.8.1701649588199; 
 Sun, 03 Dec 2023 16:26:28 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:27 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 03/45] Split out raspi machine common part
Date: Sun,  3 Dec 2023 18:25:37 -0600
Message-Id: <20231204002619.1367044-4-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112e.google.com
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

Pre-setup for raspberry pi 4 introduction

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/raspi.c                  | 112 ++++++++++++++++++--------------
 include/hw/arm/raspi_platform.h |  21 ++++++
 2 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index af866ebce2..7d04734cd2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
@@ -25,6 +26,9 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 
+#define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
+OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
+
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
@@ -37,25 +41,10 @@
 
 struct RaspiMachineState {
     /*< private >*/
-    MachineState parent_obj;
+    RaspiBaseMachineState parent_obj;
     /*< public >*/
     BCM283XState soc;
-    struct arm_boot_info binfo;
-};
-typedef struct RaspiMachineState RaspiMachineState;
-
-struct RaspiMachineClass {
-    /*< private >*/
-    MachineClass parent_obj;
-    /*< public >*/
-    uint32_t board_rev;
 };
-typedef struct RaspiMachineClass RaspiMachineClass;
-
-#define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
-DECLARE_OBJ_CHECKERS(RaspiMachineState, RaspiMachineClass,
-                     RASPI_MACHINE, TYPE_RASPI_MACHINE)
-
 
 /*
  * Board revision codes:
@@ -83,6 +72,11 @@ static const struct {
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
 };
 
+static void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc);
+static void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev);
+
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -200,13 +194,12 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
-                       size_t ram_size)
+static void setup_boot(MachineState *machine, ARMCPU *cpu,
+                       RaspiProcessorId processor_id, size_t ram_size)
 {
-    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineState *s = RASPI_BASE_MACHINE(machine);
     int r;
 
-    s->binfo.board_id = MACH_TYPE_BCM2708;
     s->binfo.ram_size = ram_size;
 
     if (processor_id <= PROCESSOR_ID_BCM2836) {
@@ -252,13 +245,13 @@ static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
         s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.parent_obj.cpu[0].core, machine, &s->binfo);
+    arm_load_kernel(cpu, machine, &s->binfo);
 }
 
-static void raspi_machine_init(MachineState *machine)
+static void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc)
 {
-    RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
-    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
@@ -279,19 +272,17 @@ static void raspi_machine_init(MachineState *machine)
                                         machine->ram, 0);
 
     /* Setup the SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
-                            board_soc_type(board_rev));
-    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine->ram));
-    object_property_set_int(OBJECT(&s->soc), "board-rev", board_rev,
+    object_property_add_const_link(OBJECT(soc), "ram", OBJECT(machine->ram));
+    object_property_set_int(OBJECT(soc), "board-rev", board_rev,
                             &error_abort);
-    object_property_set_str(OBJECT(&s->soc), "command-line",
+    object_property_set_str(OBJECT(soc), "command-line",
                             machine->kernel_cmdline, &error_abort);
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     /* Create and plug in the SD cards */
     di = drive_get(IF_SD, 0, 0);
     blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
+    bus = qdev_get_child_bus(DEVICE(soc), "sd-bus");
     if (bus == NULL) {
         error_report("No SD bus found in SOC object");
         exit(1);
@@ -300,19 +291,32 @@ static void raspi_machine_init(MachineState *machine)
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
-    vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
+    vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
-    setup_boot(machine, board_processor_id(mc->board_rev),
+    setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
                machine->ram_size - vcram_size);
 }
 
-static void raspi_machine_class_common_init(MachineClass *mc,
-                                            uint32_t board_rev)
+static void raspi_machine_init(MachineState *machine)
+{
+    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM283XState *soc = &s->soc;
+
+    s_base->binfo.board_id = MACH_TYPE_BCM2708;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev)
 {
     mc->desc = g_strdup_printf("Raspberry Pi %s (revision 1.%u)",
                                board_type(board_rev),
                                FIELD_EX32(board_rev, REV_CODE, REVISION));
-    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
@@ -322,50 +326,57 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_id = "ram";
 };
 
+static void raspi_machine_class_init(MachineClass *mc,
+                                     uint32_t board_rev)
+{
+    raspi_machine_class_common_init(mc, board_rev);
+    mc->init = raspi_machine_init;
+};
+
 static void raspi0_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x920092; /* Revision 1.2 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x900021; /* Revision 1.1 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0xa21041;
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 #ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0xa02082;
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 #endif /* TARGET_AARCH64 */
 
@@ -394,9 +405,14 @@ static const TypeInfo raspi_machine_types[] = {
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_RASPI_BASE_MACHINE,
         .instance_size  = sizeof(RaspiMachineState),
-        .class_size     = sizeof(RaspiMachineClass),
+        .abstract       = true,
+    }, {
+        .name           = TYPE_RASPI_BASE_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(RaspiBaseMachineState),
+        .class_size     = sizeof(RaspiBaseMachineClass),
         .abstract       = true,
     }
 };
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index ede98e63c3..3018e8fcf3 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -28,6 +28,27 @@
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
+#include "hw/boards.h"
+#include "hw/arm/boot.h"
+
+#define TYPE_RASPI_BASE_MACHINE MACHINE_TYPE_NAME("raspi-base")
+OBJECT_DECLARE_TYPE(RaspiBaseMachineState, RaspiBaseMachineClass,
+                    RASPI_BASE_MACHINE)
+
+struct RaspiBaseMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    struct arm_boot_info binfo;
+};
+
+struct RaspiBaseMachineClass {
+    /*< private >*/
+    MachineClass parent_obj;
+    /*< public >*/
+    uint32_t board_rev;
+};
+
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
 #define INTE_OFFSET             0x2000   /* VC Interrupt controller */
-- 
2.34.1


