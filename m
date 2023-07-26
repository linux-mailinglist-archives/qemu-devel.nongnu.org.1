Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B12763832
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWo-0002wK-FE; Wed, 26 Jul 2023 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWH-0002im-61; Wed, 26 Jul 2023 09:25:37 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWE-0003Cs-ML; Wed, 26 Jul 2023 09:25:36 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so10518087e87.2; 
 Wed, 26 Jul 2023 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377932; x=1690982732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7biyRujPtM3NOYIeI8gaS38CDX45zdlkT33++UCSsI=;
 b=WtKOH2opt2V8xp7J0A6j7Mwiq4w0gJiC8F5GuN3EUIPOlal5XUEn7QYzmFVNZ4zMcV
 UEn79OIpBb/N5AFPBdjvzhMo4E4n8LASJj9e7WGp2UfNfpIlX5MLMPClM2WMGaSedMol
 k5TRbAVEeO9WneTneLvKVV1/UeZN9ajrryEqtgDXdknFRIumQ+u5As2JMsdjRNsQqRss
 1gjsW5cU1OUBix+7kaMpkrT1SDk2pgxoOtw9YIkcPldvIVgCrJ7Jh0kALYOgG6XVcw9Q
 DRasvRkqVw1Ti3VAGBdm/OWbrGDehhWpAwDrp5Xu+CC9jdNgwmf/qUL1hokMEdwDtbQm
 7pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377932; x=1690982732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7biyRujPtM3NOYIeI8gaS38CDX45zdlkT33++UCSsI=;
 b=ld4QkPx7kAllLElxA3Gx/Mu3MVEFj8pZ25I0FJNdAwZ9JDioDt3dt7jdTR1VttOTrp
 wR+j4f4qiUdp9sKGSTlj0hh9D2rWShsEuSonQjdx7chI72Fyb1OFEakTdSqQ5EnZFe54
 Buy5IMYZCUlI7aVZSB0a4yNG9g+rXqTsLhquE5KmG/CUqfeqJI/19tJXOXvWZWqjKrxI
 U0XcQRBfRVV/RzgGBamS76lYyY7LqVWAWRkyiEoaG+nd2he3xvZ1sYLqcM1SQcwMdEyP
 JwOeWzFZknd1Z5veyhx/THh2mCjJAif1TK/PBpTDGFIKC0PH9BRejqjauXD3ym3Uv/xT
 1b3Q==
X-Gm-Message-State: ABy/qLZOn4Pc7OVix0t/6hlirPrK+vn/oaWEPKsA4SRJPVB/ms+m5/u6
 9aJgbSK6WSOpX8l4wGxBwds8zKRgDVg=
X-Google-Smtp-Source: APBJJlG/wAJVTRfpdCqBxZEsxRsh/EZPHcI60UFFW2S80oXH+o7zUdWK3Ong7GKwlSWlGmrMB+KABQ==
X-Received: by 2002:a05:6512:200d:b0:4f8:66e1:14e8 with SMTP id
 a13-20020a056512200d00b004f866e114e8mr1517654lfb.69.1690377931677; 
 Wed, 26 Jul 2023 06:25:31 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:31 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 11/44] Introduce Raspberry PI 4 machine
Date: Wed, 26 Jul 2023 16:24:39 +0300
Message-Id: <20230726132512.149618-12-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12a.google.com
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
 hw/arm/bcm2835_peripherals.c    |  20 +++-
 hw/arm/bcm2836.c                |   2 +
 hw/arm/bcm2838.c                |   2 +
 hw/arm/meson.build              |   2 +-
 hw/arm/raspi.c                  |  28 +++--
 hw/arm/raspi4b.c                | 182 ++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h |  11 ++
 include/hw/display/bcm2835_fb.h |   2 +
 8 files changed, 235 insertions(+), 14 deletions(-)
 create mode 100644 hw/arm/raspi4b.c

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 4c0c0b1e7d..9e4153936f 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -108,6 +108,7 @@ static void raspi_peripherals_base_init(Object *obj)
     /* Framebuffer */
     object_initialize_child(obj, "fb", &s->fb, TYPE_BCM2835_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->fb), "vcram-base");
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
@@ -225,7 +226,7 @@ void raspi_peripherals_common_realize(DeviceState *dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
-    uint64_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size, vcram_base;
     int n;
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
@@ -329,11 +330,24 @@ void raspi_peripherals_common_realize(DeviceState *dev, Error **errp)
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
index 8beafb97f0..34883d29ff 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -64,6 +64,8 @@ static void bcm283x_init(Object *obj)
                               "command-line");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
 }
 
 bool bcm283x_common_realize(DeviceState *dev, RaspiPeripheralBaseState *ps,
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c687f38a39..a1980cc181 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -62,6 +62,8 @@ static void bcm2838_init(Object *obj)
                               "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 071819b527..768b2608c1 100644
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
index 0000000000..4096522d85
--- /dev/null
+++ b/hw/arm/raspi4b.c
@@ -0,0 +1,182 @@
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
+#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-common")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+
+struct Raspi4bMachineState {
+    /*< private >*/
+    RaspiBaseMachineState parent_obj;
+    /*< public >*/
+    BCM2838State soc;
+    uint32_t vcram_base;
+    uint32_t vcram_size;
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
+    if (s->vcram_base) {
+        object_property_set_uint(OBJECT(soc), "vcram-base",
+                                        s->vcram_base, NULL);
+    }
+
+    if (s->vcram_size) {
+        object_property_set_uint(OBJECT(soc), "vcram-size",
+                                 s->vcram_size, NULL);
+    }
+
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+static void get_vcram_base(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value = ms->vcram_base;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void set_vcram_base(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    ms->vcram_base = value;
+}
+
+static void get_vcram_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value = ms->vcram_size;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void set_vcram_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    ms->vcram_size = value;
+}
+
+static void raspi4b_machine_class_init(MachineClass *mc, uint32_t board_rev)
+{
+    object_class_property_add(OBJECT_CLASS(mc), "vcram-size", "uint32",
+                              get_vcram_size, set_vcram_size, NULL, NULL);
+    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-size",
+                                            "VideoCore RAM base address");
+    object_class_property_add(OBJECT_CLASS(mc), "vcram-base", "uint32",
+                              get_vcram_base, set_vcram_base, NULL, NULL);
+    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-base",
+                                            "VideoCore RAM size");
+
+    raspi_machine_class_common_init(mc, board_rev);
+    mc->init = raspi4b_machine_init;
+}
+
+static void raspi4b1g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa03111;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b2g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xb03112;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b4g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xc03114;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b8g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xd03114;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static const TypeInfo raspi4b_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("raspi4b1g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b1g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b2g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b2g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b4g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b4g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b8g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b8g_machine_class_init,
+    }, {
+        .name           = TYPE_RASPI4B_MACHINE,
+        .parent         = TYPE_RASPI_BASE_MACHINE,
+        .instance_size  = sizeof(Raspi4bMachineState),
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(raspi4b_machine_types)
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


