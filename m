Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04497F5C58
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z7-00066Q-Il; Thu, 23 Nov 2023 05:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66z5-000659-LM; Thu, 23 Nov 2023 05:30:59 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yx-0006i3-TZ; Thu, 23 Nov 2023 05:30:59 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cf7a8ab047so5452195ad.1; 
 Thu, 23 Nov 2023 02:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735442; x=1701340242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5PcUYHaLUNd4vv+8DqlIaHFfjyjazUsy6ptKg9dL1Q=;
 b=ms3m2eVS54apyssAlcHqJeVghuKhq4upHf/Dok/toWUvKYqE46FfSln1KAQpHOx9gl
 yp99wbAKFFo1jNsaP5CcjHtnM1MWQBCn3f1a/HXJcWFZmfwQpk/kmSUcLePK+SBG2SaC
 hjbN6abEbJLpi0q9hUjl8yRvzXU3ztix98BrgwW8bvleb9NQSlyKWUj//2Fpsl92whMO
 CTnQnR1gOuovWMLZOccQdwlgpgea5h5utmBvlFJWxj29aYc7wRjVVd42Jf3Vh42VAGWS
 ke1He3ICroj5lkZ8WM5j3vHjU2/zTl6GO9IFvqZlo6sxXxrSFbdxvyQA6jkspnGcA7Lj
 4KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735442; x=1701340242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5PcUYHaLUNd4vv+8DqlIaHFfjyjazUsy6ptKg9dL1Q=;
 b=fcwER62ABphkjghNyM0d+/DtvxkIT4bSGGxy/qxgeqa/qtqDKcy1ZE5lkSRUTrWbwW
 W+MEs+GcTepIFEVLsxjZZ5xXhiGJJbX35ajQsfUozsboM63LngiZTueNJo9UtP6hsLBx
 NLLKvceH9L7gD9EoJaDP1id38Asr95oQEouqtmftiERUSaCO2UBZsmBi+bOAAjjM8e7P
 yjzfbT3q3g+qCjL6ZrRh5UtGhQQo9KqU0o/9Izq5B/9TcaQfDvsjE8ofzyU2sMcV0OOq
 7IiPH62VIQCVOlhQqTQyWYenM71HDFT0n//e4EWsKqIyvPCKTSlXwONjtTLizdqBGPyy
 dnTQ==
X-Gm-Message-State: AOJu0YwedggCr7R+ZZR0nhkEbKMN6xmXvYsfId6PWFhx833K8KKdpH7G
 rO/ED4EbJA/C+MV7VTPKGvRSBUy8Fcg=
X-Google-Smtp-Source: AGHT+IEYZ5V3srY674Yo2jVFW4DFbyyBqFShJL14EgYK0sYdAtiA2HqP8GYwOYYpkfLY5MoFwZHuHg==
X-Received: by 2002:a17:902:a401:b0:1cf:59df:23d with SMTP id
 p1-20020a170902a40100b001cf59df023dmr4573153plq.67.1700735442141; 
 Thu, 23 Nov 2023 02:30:42 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 4/7] pnv/chiptod: Add POWER9/10 chiptod model
Date: Thu, 23 Nov 2023 20:30:15 +1000
Message-ID: <20231123103018.172383-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

The ChipTOD (for Time-Of-Day) is a pervasive facility that keeps the
clocks on multiple chips consistent which can keep TOD (time-of-day),
synchronise it across multiple chips, and can move that TOD to or from
the core timebase units.

This driver implements basic emulation of chiptod registers sufficient
to successfully run the skiboot chiptod synchronisation procedure
(with the following TFMR and timebase state-machine implementation).

The main way chiptod affects the rest of the system (relevant to the
powernv model) is to interact with the timebase facility in the cores,
influencing the timebase state machine and registers.

The way this chiptod driver implements that interaction is with two
new flags in the CPUPPCState env, one is use for the core timebase to
indicate it is ready to receive a TOD from chiptod, the other used
by chiptod to indicate that it has sent TOD to the core timebase. The
core timebase will be implemented in later changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  52 +++++
 include/hw/ppc/pnv_xscom.h   |   9 +
 hw/ppc/pnv.c                 |  30 +++
 hw/ppc/pnv_chiptod.c         | 417 +++++++++++++++++++++++++++++++++++
 hw/ppc/meson.build           |   1 +
 hw/ppc/trace-events          |   4 +
 7 files changed, 516 insertions(+)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..bfc4772cf3 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -2,6 +2,7 @@
 #define PPC_PNV_CHIP_H
 
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_chiptod.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_lpc.h"
@@ -78,6 +79,7 @@ struct Pnv9Chip {
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
@@ -110,6 +112,7 @@ struct Pnv10Chip {
     PnvXive2     xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
new file mode 100644
index 0000000000..e2765c3bfc
--- /dev/null
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef PPC_PNV_CHIPTOD_H
+#define PPC_PNV_CHIPTOD_H
+
+#include "qom/object.h"
+
+#define TYPE_PNV_CHIPTOD "pnv-chiptod"
+OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
+#define TYPE_PNV9_CHIPTOD TYPE_PNV_CHIPTOD "-POWER9"
+DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
+#define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
+DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
+
+enum tod_state {
+    tod_error = 0,
+    tod_not_set = 7,
+    tod_not_set_step = 11,
+    tod_running = 2,
+    tod_running_step = 10,
+    tod_running_sync = 14,
+    tod_wait_for_sync = 13,
+    tod_stopped = 1,
+};
+
+struct PnvChipTOD {
+    DeviceState xd;
+
+    PnvChip *chip;
+    MemoryRegion xscom_regs;
+
+    bool primary;
+    bool secondary;
+    enum tod_state tod_state;
+    uint64_t tod_error;
+    uint64_t pss_mss_ctrl_reg;
+};
+
+struct PnvChipTODClass {
+    DeviceClass parent_class;
+
+    int xscom_size;
+    const MemoryRegionOps *xscom_ops;
+};
+
+#endif /* PPC_PNV_CHIPTOD_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..6aa3ac745d 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -64,6 +64,9 @@ struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_PSIHB_BASE      0x2010900
 #define PNV_XSCOM_PSIHB_SIZE      0x20
 
+#define PNV_XSCOM_CHIPTOD_BASE    0x0040000
+#define PNV_XSCOM_CHIPTOD_SIZE    0x31
+
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
 
@@ -93,6 +96,9 @@ struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_I2CM_BASE      0xa0000
 #define PNV9_XSCOM_I2CM_SIZE      0x1000
 
+#define PNV9_XSCOM_CHIPTOD_BASE   PNV_XSCOM_CHIPTOD_BASE
+#define PNV9_XSCOM_CHIPTOD_SIZE   PNV_XSCOM_CHIPTOD_SIZE
+
 #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
 #define PNV9_XSCOM_OCC_SIZE       0x8000
 
@@ -155,6 +161,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
 #define PNV10_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
 
+#define PNV10_XSCOM_CHIPTOD_BASE   PNV9_XSCOM_CHIPTOD_BASE
+#define PNV10_XSCOM_CHIPTOD_SIZE   PNV9_XSCOM_CHIPTOD_SIZE
+
 #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
 #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..546266ae3d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1419,6 +1419,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
+    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
+
     object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
     object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
@@ -1565,6 +1567,19 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV9_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip9->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip9->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip9->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip9->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
+                            &chip9->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
         return;
@@ -1677,6 +1692,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
                               "xive-fabric");
     object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
     object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
+    object_initialize_child(obj, "chiptod", &chip10->chiptod,
+                            TYPE_PNV10_CHIPTOD);
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
@@ -1810,6 +1827,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV10_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip10->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip10->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip10->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_CHIPTOD_BASE,
+                            &chip10->chiptod.xscom_regs);
+
     /* Create the simplified OCC model */
     if (!qdev_realize(DEVICE(&chip10->occ), NULL, errp)) {
         return;
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
new file mode 100644
index 0000000000..a7bfe4298d
--- /dev/null
+++ b/hw/ppc/pnv_chiptod.c
@@ -0,0 +1,417 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some ChipTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ * ChipTOD (aka TOD) is a facility implemented in the nest / pervasive. The
+ * purpose is to keep time-of-day across chips and cores.
+ *
+ * There is a master chip TOD, which sends signals to slave chip TODs to
+ * keep them synchronized. There are two sets of configuration registers
+ * called primary and secondary, which can be used fail over.
+ *
+ * The chip TOD also distributes synchronisation signals to the timebase
+ * facility in each of the cores on the chip. In particular there is a
+ * feature that can move the TOD value in the ChipTOD to and from the TB.
+ *
+ * Initialisation typically brings all ChipTOD into sync (see tod_state),
+ * and then brings each core TB into sync with the ChipTODs (see timebase
+ * state and TFMR). This model is a very basic simulation of the init sequence
+ * performed by skiboot.
+ */
+
+#include "qemu/osdep.h"
+#include "target/ppc/cpu.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/ppc.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_chip.h"
+#include "hw/ppc/pnv_core.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_chiptod.h"
+#include "trace.h"
+
+#include <libfdt.h>
+
+/* TOD chip XSCOM addresses */
+#define TOD_M_PATH_CTRL_REG             0x00000000 /* Master Path ctrl reg */
+#define TOD_PRI_PORT_0_CTRL_REG         0x00000001 /* Primary port0 ctrl reg */
+#define TOD_PRI_PORT_1_CTRL_REG         0x00000002 /* Primary port1 ctrl reg */
+#define TOD_SEC_PORT_0_CTRL_REG         0x00000003 /* Secondary p0 ctrl reg */
+#define TOD_SEC_PORT_1_CTRL_REG         0x00000004 /* Secondary p1 ctrl reg */
+#define TOD_S_PATH_CTRL_REG             0x00000005 /* Slave Path ctrl reg */
+#define TOD_I_PATH_CTRL_REG             0x00000006 /* Internal Path ctrl reg */
+
+/* -- TOD primary/secondary master/slave control register -- */
+#define TOD_PSS_MSS_CTRL_REG            0x00000007
+
+/* -- TOD primary/secondary master/slave status register -- */
+#define TOD_PSS_MSS_STATUS_REG          0x00000008
+
+/* TOD chip XSCOM addresses */
+#define TOD_CHIP_CTRL_REG               0x00000010 /* Chip control reg */
+
+#define TOD_TX_TTYPE_0_REG              0x00000011
+#define TOD_TX_TTYPE_1_REG              0x00000012 /* PSS switch reg */
+#define TOD_TX_TTYPE_2_REG              0x00000013 /* Enable step checkers */
+#define TOD_TX_TTYPE_3_REG              0x00000014 /* Request TOD reg */
+#define TOD_TX_TTYPE_4_REG              0x00000015 /* Send TOD reg */
+#define TOD_TX_TTYPE_5_REG              0x00000016 /* Invalidate TOD reg */
+
+#define TOD_MOVE_TOD_TO_TB_REG          0x00000017
+#define TOD_LOAD_TOD_MOD_REG            0x00000018
+#define TOD_LOAD_TOD_REG                0x00000021
+#define TOD_FSM_REG                     0x00000024
+
+#define TOD_TX_TTYPE_CTRL_REG           0x00000027 /* TX TTYPE Control reg */
+#define   TOD_TX_TTYPE_PIB_SLAVE_ADDR      PPC_BITMASK(26, 31)
+
+/* -- TOD Error interrupt register -- */
+#define TOD_ERROR_REG                   0x00000030
+
+/* PC unit PIB address which recieves the timebase transfer from TOD */
+#define   PC_TOD                        0x4A3
+
+static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    uint32_t offset = addr >> 3;
+    uint64_t val = 0;
+
+    switch (offset) {
+    case TOD_PSS_MSS_STATUS_REG:
+        /*
+         * ChipTOD does not support configurations other than primary
+         * master, does not support errors, etc.
+         */
+        val |= PPC_BITMASK(6, 10); /* STEP checker validity */
+        val |= PPC_BIT(12); /* Primary config master path select */
+        val |= PPC_BIT(20); /* Is running */
+        val |= PPC_BIT(21); /* Is using primary config */
+        val |= PPC_BIT(26); /* Is using master path select */
+
+        if (chiptod->primary) {
+            val |= PPC_BIT(23); /* Is active master */
+        } else if (chiptod->secondary) {
+            val |= PPC_BIT(24); /* Is backup master */
+        }
+        break;
+    case TOD_PSS_MSS_CTRL_REG:
+        val = chiptod->pss_mss_ctrl_reg;
+        break;
+    case TOD_TX_TTYPE_CTRL_REG:
+        val = 0;
+        break;
+    case TOD_ERROR_REG:
+        val = chiptod->tod_error;
+        break;
+    case TOD_FSM_REG:
+        if (chiptod->tod_state == tod_running) {
+            val |= PPC_BIT(4);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+
+    trace_pnv_chiptod_xscom_read(addr >> 3, val);
+
+    return val;
+}
+
+static void chiptod_power9_send_remotes(PnvChipTOD *chiptod)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
+        if (&chip9->chiptod != chiptod) {
+            chip9->chiptod.tod_state = tod_running;
+        }
+    }
+}
+
+static void chiptod_power10_send_remotes(PnvChipTOD *chiptod)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+        if (&chip10->chiptod != chiptod) {
+            chip10->chiptod.tod_state = tod_running;
+        }
+    }
+}
+
+static void chiptod_power9_invalidate_remotes(PnvChipTOD *chiptod)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
+        if (&chip9->chiptod != chiptod) {
+            chip9->chiptod.tod_state = tod_not_set;
+        }
+    }
+}
+
+static void chiptod_power10_invalidate_remotes(PnvChipTOD *chiptod)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+        if (&chip10->chiptod != chiptod) {
+            chip10->chiptod.tod_state = tod_not_set;
+        }
+    }
+}
+
+static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size,
+                                    bool is_power9)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    uint32_t offset = addr >> 3;
+
+    trace_pnv_chiptod_xscom_write(addr >> 3, val);
+
+    switch (offset) {
+    case TOD_PSS_MSS_CTRL_REG:
+        /* Is this correct? */
+        if (chiptod->primary) {
+            val |= PPC_BIT(1); /* TOD is master */
+        } else {
+            val &= ~PPC_BIT(1);
+        }
+        val |= PPC_BIT(2); /* Drawer is master (don't simulate multi-drawer) */
+        chiptod->pss_mss_ctrl_reg = val & PPC_BITMASK(0, 31);
+        break;
+
+    case TOD_ERROR_REG:
+        chiptod->tod_error &= ~val;
+        break;
+    case TOD_LOAD_TOD_MOD_REG:
+        if (!(val & PPC_BIT(0))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_LOAD_TOD_MOD_REG with bad val 0x%016lx\n", val);
+        } else {
+            chiptod->tod_state = tod_not_set;
+        }
+        break;
+    case TOD_LOAD_TOD_REG:
+        chiptod->tod_state = tod_running;
+        break;
+    case TOD_TX_TTYPE_4_REG:
+        if (is_power9) {
+            chiptod_power9_send_remotes(chiptod);
+        } else {
+            chiptod_power10_send_remotes(chiptod);
+        }
+        break;
+    case TOD_TX_TTYPE_5_REG:
+        if (is_power9) {
+            chiptod_power9_invalidate_remotes(chiptod);
+        } else {
+            chiptod_power10_invalidate_remotes(chiptod);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+}
+
+static void pnv_chiptod_power9_xscom_write(void *opaque, hwaddr addr,
+                                           uint64_t val, unsigned size)
+{
+    pnv_chiptod_xscom_write(opaque, addr, val, size, true);
+}
+
+static const MemoryRegionOps pnv_chiptod_power9_xscom_ops = {
+    .read = pnv_chiptod_xscom_read,
+    .write = pnv_chiptod_power9_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static int pnv_chiptod_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                                int xscom_offset,
+                                const char compat[], size_t compat_size)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+    g_autofree char *name = NULL;
+    int offset;
+    uint32_t lpc_pcba = PNV9_XSCOM_CHIPTOD_BASE;
+    uint32_t reg[] = {
+        cpu_to_be32(lpc_pcba),
+        cpu_to_be32(PNV9_XSCOM_CHIPTOD_SIZE)
+    };
+
+    name = g_strdup_printf("chiptod@%x", lpc_pcba);
+    offset = fdt_add_subnode(fdt, xscom_offset, name);
+    _FDT(offset);
+
+    if (chiptod->primary) {
+        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
+    } else if (chiptod->secondary) {
+        _FDT((fdt_setprop(fdt, offset, "secondary", NULL, 0)));
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
+    _FDT((fdt_setprop(fdt, offset, "compatible", compat, compat_size)));
+    return 0;
+}
+
+static int pnv_chiptod_power9_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] = "ibm,power-chiptod\0ibm,power9-chiptod";
+
+    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
+}
+
+static Property pnv_chiptod_properties[] = {
+    DEFINE_PROP_BOOL("primary", PnvChipTOD, primary, false),
+    DEFINE_PROP_BOOL("secondary", PnvChipTOD, secondary, false),
+    DEFINE_PROP_LINK("chip", PnvChipTOD , chip, TYPE_PNV_CHIP, PnvChip *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
+{
+    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    dc->desc = "PowerNV ChipTOD Controller (POWER9)";
+    device_class_set_props(dc, pnv_chiptod_properties);
+
+    xdc->dt_xscom = pnv_chiptod_power9_dt_xscom;
+
+    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
+    pctc->xscom_ops = &pnv_chiptod_power9_xscom_ops;
+}
+
+static const TypeInfo pnv_chiptod_power9_type_info = {
+    .name          = TYPE_PNV9_CHIPTOD,
+    .parent        = TYPE_PNV_CHIPTOD,
+    .instance_size = sizeof(PnvChipTOD),
+    .class_init    = pnv_chiptod_power9_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_chiptod_power10_xscom_write(void *opaque, hwaddr addr,
+                                           uint64_t val, unsigned size)
+{
+    pnv_chiptod_xscom_write(opaque, addr, val, size, false);
+}
+
+static const MemoryRegionOps pnv_chiptod_power10_xscom_ops = {
+    .read = pnv_chiptod_xscom_read,
+    .write = pnv_chiptod_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static int pnv_chiptod_power10_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] = "ibm,power-chiptod\0ibm,power10-chiptod";
+
+    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
+}
+
+static void pnv_chiptod_power10_class_init(ObjectClass *klass, void *data)
+{
+    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    dc->desc = "PowerNV ChipTOD Controller (POWER10)";
+    device_class_set_props(dc, pnv_chiptod_properties);
+
+    xdc->dt_xscom = pnv_chiptod_power10_dt_xscom;
+
+    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
+    pctc->xscom_ops = &pnv_chiptod_power10_xscom_ops;
+}
+
+static const TypeInfo pnv_chiptod_power10_type_info = {
+    .name          = TYPE_PNV10_CHIPTOD,
+    .parent        = TYPE_PNV_CHIPTOD,
+    .instance_size = sizeof(PnvChipTOD),
+    .class_init    = pnv_chiptod_power10_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+    PnvChipTODClass *pctc = PNV_CHIPTOD_GET_CLASS(chiptod);
+
+    if (chiptod->primary) {
+        chiptod->pss_mss_ctrl_reg |= PPC_BIT(1); /* TOD is master */
+    }
+
+    /* Drawer is master (we do not simulate multi-drawer) */
+    chiptod->pss_mss_ctrl_reg |= PPC_BIT(2);
+    chiptod->tod_state = tod_running;
+
+    /* XScom regions for ChipTOD registers */
+    pnv_xscom_region_init(&chiptod->xscom_regs, OBJECT(dev),
+                          pctc->xscom_ops, chiptod, "xscom-chiptod",
+                          pctc->xscom_size);
+}
+
+static void pnv_chiptod_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = pnv_chiptod_realize;
+    dc->desc = "PowerNV ChipTOD Controller";
+    dc->user_creatable = false;
+}
+
+static const TypeInfo pnv_chiptod_type_info = {
+    .name          = TYPE_PNV_CHIPTOD,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvChipTOD),
+    .class_init    = pnv_chiptod_class_init,
+    .class_size    = sizeof(PnvChipTODClass),
+    .abstract      = true,
+};
+
+static void pnv_chiptod_register_types(void)
+{
+    type_register_static(&pnv_chiptod_type_info);
+    type_register_static(&pnv_chiptod_power9_type_info);
+    type_register_static(&pnv_chiptod_power10_type_info);
+}
+
+type_init(pnv_chiptod_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ea44856d43..b1f4e65d24 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -46,6 +46,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_i2c.c',
   'pnv_lpc.c',
   'pnv_psi.c',
+  'pnv_chiptod.c',
   'pnv_occ.c',
   'pnv_sbe.c',
   'pnv_bmc.c',
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f670e8906c..57c4f265ef 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -95,6 +95,10 @@ vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
 vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 
+# pnv_chiptod.c
+pnv_chiptod_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+pnv_chiptod_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
+
 # pnv_sbe.c
 pnv_sbe_xscom_ctrl_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
 pnv_sbe_xscom_ctrl_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
-- 
2.42.0


