Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF397213C9
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ani-0005T7-96; Sat, 03 Jun 2023 19:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anR-0005Lz-Qw; Sat, 03 Jun 2023 19:36:33 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5anN-0003Ru-Uu; Sat, 03 Jun 2023 19:36:32 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-39a505b901dso3076386b6e.0; 
 Sat, 03 Jun 2023 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685835388; x=1688427388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCWihGtif0VZO2H4MHbdTzv4mez4gyt4TRP+nVwNLkY=;
 b=hqGT8zPFfofl9l4vqUBPKYpBjXTTVXng762Zd4sQBNyfHcC5tytbR1UiQ/169Che9A
 rb8n9poFRiyNRiMf0V99PYqIH8qkwLnH0JhsjxvSnK1UJ1a7nNAvRSe4PYTkc1t5kO+Q
 +ZPmAGJ0x70CaIh/N3bBBDFuqV70gPTChw1p3zJuK9OXGdPeGMBYO8hRrvAcg1ceSKWV
 j2zALFiWR4shXRchBu3lMo/NOmpvvO9DphR7fAJ9sxIvwwQkFz4K96JP1IXSRDnhf7Pr
 SiQrbmecGFcx5zoe7IvL70xHQfhCLRfNS9unTrIGK5d25ur/Q0kbT3vxlWh3cjbubEdo
 k1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685835388; x=1688427388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCWihGtif0VZO2H4MHbdTzv4mez4gyt4TRP+nVwNLkY=;
 b=ICWpFe0U+7PPNkHxXIbOAaWkXoxfkyBS4+fhFNZxwo0LMwVBYKhUkIDOZBcJQWGux6
 4dcTqfRs91TmtBfkULiujL5+hKz9p8xC/v0GVf7RDm0fGwPADXBpXQdkx1xH+Aw3kK0o
 SWXsG2e/UDmlGvYl+SHMcLlQ/bajA5jEgvVdiDp4KXyALG02sYIMRU3Dmw0VLeBP3ZCc
 Jt+HHSsfP6uM5QzACtZGGhgKW05D9ISPINMQoUKF02APL7hPqtGEfIjWw/eHCDdk71yV
 jwecYBg2PLDVPSttFrz4Haizm3/gXBdgeXB9phDZtk+2NPQFYkGBFJGqtjqMk7e3ABNd
 WEeg==
X-Gm-Message-State: AC+VfDzb9aEO/jbT5AwOH3WD1vZrlPlOeGSUfLoXK3rO0qZIwTYFZXCT
 //lI8SbkDeK9Mzm+VzL14UDpvfi8OO4=
X-Google-Smtp-Source: ACHHUZ4Ycqoxd8aoY4gCGi9jClyKx3RoWyRuif1JgeH7+tGyVYX+i4toBIa/WXYxH+5LW9+IcNs0jw==
X-Received: by 2002:aca:1805:0:b0:396:11b3:5851 with SMTP id
 h5-20020aca1805000000b0039611b35851mr3541627oih.54.1685835387806; 
 Sat, 03 Jun 2023 16:36:27 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 io23-20020a17090312d700b001aface7bdd8sm3743533plb.31.2023.06.03.16.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 16:36:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] pnv/chiptod: Add POWER9/10 chiptod model
Date: Sun,  4 Jun 2023 09:36:09 +1000
Message-Id: <20230603233612.125879-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603233612.125879-1-npiggin@gmail.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
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

The chiptod is a pervasive facility which can keep TOD (time-of-day),
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
 hw/ppc/meson.build           |   1 +
 hw/ppc/pnv.c                 |  38 +++
 hw/ppc/pnv_chiptod.c         | 488 +++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c           |   2 +
 hw/ppc/trace-events          |   4 +
 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  64 +++++
 include/hw/ppc/pnv_core.h    |   3 +
 include/hw/ppc/pnv_xscom.h   |   9 +
 target/ppc/cpu.h             |   6 +
 10 files changed, 618 insertions(+)
 create mode 100644 hw/ppc/pnv_chiptod.c
 create mode 100644 include/hw/ppc/pnv_chiptod.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index c927337da0..afbf90e6da 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -45,6 +45,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_core.c',
   'pnv_lpc.c',
   'pnv_psi.c',
+  'pnv_chiptod.c',
   'pnv_occ.c',
   'pnv_sbe.c',
   'pnv_bmc.c',
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index dbdeba6c31..ce5e7d7582 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1414,6 +1414,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
 
+    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
+
     object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
 
     object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
@@ -1558,6 +1560,15 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV9_LPCM_BASE(chip));
 
+    /* ChipTOD */
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
@@ -1644,6 +1655,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
                               "xive-fabric");
     object_initialize_child(obj, "psi", &chip10->psi, TYPE_PNV10_PSI);
     object_initialize_child(obj, "lpc", &chip10->lpc, TYPE_PNV10_LPC);
+    object_initialize_child(obj, "chiptod", &chip10->chiptod, TYPE_PNV10_CHIPTOD);
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
@@ -1773,6 +1785,15 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV10_LPCM_BASE(chip));
 
+    /* ChipTOD */
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
@@ -1938,6 +1959,23 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 }
 
+PnvCore *pnv_get_vcpu_by_xscom_base(PnvChip *chip, uint32_t xscom_base)
+{
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+        int core_hwid = cc->core_id;
+
+        if (pcc->xscom_core_base(chip, core_hwid) == xscom_base) {
+            return pc;
+        }
+    }
+    return NULL;
+}
+
 static void pnv_chip_realize(DeviceState *dev, Error **errp)
 {
     PnvChip *chip = PNV_CHIP(dev);
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
new file mode 100644
index 0000000000..04ef703e0f
--- /dev/null
+++ b/hw/ppc/pnv_chiptod.c
@@ -0,0 +1,488 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
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
+        val |= PPC_BITMASK(6,10); /* STEP checker validity */
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
+	break;
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
+    case TOD_TX_TTYPE_CTRL_REG:
+        if (val & PPC_BIT(35)) { /* SCOM addressing */
+            uint32_t addr = val >> 32;
+            uint32_t reg = addr & 0xfff;
+            PnvCore *pc;
+
+            if (reg != PC_TOD) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
+                              "unimplemented slave register 0x%" PRIx32 "\n",
+                              reg);
+                return;
+            }
+
+            /*
+             * This may not deal with P10 big-core addressing at the moment.
+             * The big-core code in skiboot syncs small cores, but it targets
+             * the even PIR (first small-core) when syncing second small-core.
+             */
+            pc = pnv_get_vcpu_by_xscom_base(chiptod->chip, addr & ~0xfff);
+            if (pc) {
+                /*
+                 * If TCG implements SMT, TFMR is a per-core SPR and should
+                 * be updated such that it is reflected in all threads.
+                 * Same for TB if the chiptod model ever actually adjusted it.
+                 */
+                chiptod->slave_cpu_target = pc->threads[0];
+            } else {
+                chiptod->slave_cpu_target = NULL;
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
+                              " invalid slave PIR\n", val);
+            }
+
+        } else { /* PIR addressing */
+            uint32_t pir;
+
+            if (!is_power9) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: PIR addressing"
+                              " is only implemented for POWER9\n");
+                return;
+            }
+
+            pir = (GETFIELD(TOD_TX_TTYPE_PIB_SLAVE_ADDR, val) & 0x1f) << 2;
+            chiptod->slave_cpu_target = ppc_get_vcpu_by_pir(pir);
+            if (chiptod->slave_cpu_target == NULL) {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
+                              " invalid slave PIR 0x%" PRIx32 "\n", val, pir);
+            }
+        }
+        break;
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
+    case TOD_MOVE_TOD_TO_TB_REG:
+        if (!(val & PPC_BIT(0))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with bad val 0x%016lx\n",
+                          val);
+        } else if (chiptod->slave_cpu_target == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                          " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
+        } else {
+            PowerPCCPU *cpu = chiptod->slave_cpu_target;
+            CPUPPCState *env = &cpu->env;
+
+            if (env->tb_ready_for_tod) {
+                env->tod_sent_to_tb = 1;
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
+                              " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
+                              " receive TOD\n");
+            }
+        }
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
+    static bool got_primary = false;
+    static bool got_secondary = false;
+
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+    PnvChipTODClass *pctc = PNV_CHIPTOD_GET_CLASS(chiptod);
+
+    if (!got_primary) {
+        got_primary = true;
+        chiptod->primary = true;
+        chiptod->pss_mss_ctrl_reg |= PPC_BIT(1); /* TOD is master */
+    } else if (!got_secondary) {
+        got_secondary = true;
+        chiptod->secondary = true;
+    }
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
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index d820e05e40..5bbbd3a7a9 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -298,6 +298,8 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
     _FDT((fdt_setprop(fdt, xscom_offset, "scom-controller", NULL, 0)));
     if (chip->chip_id == 0) {
         _FDT((fdt_setprop(fdt, xscom_offset, "primary", NULL, 0)));
+    } else if (chip->chip_id == 1) {
+        _FDT((fdt_setprop(fdt, xscom_offset, "secondary", NULL, 0)));
     }
 
     args.fdt = fdt;
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
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 53e1d921d7..d22c013e7d 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -2,6 +2,7 @@
 #define PPC_PNV_CHIP_H
 
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_chiptod.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_lpc.h"
@@ -77,6 +78,7 @@ struct Pnv9Chip {
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
@@ -106,6 +108,7 @@ struct Pnv10Chip {
     PnvXive2     xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvChipTOD   chiptod;
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
new file mode 100644
index 0000000000..6723b07d93
--- /dev/null
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -0,0 +1,64 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
+    PowerPCCPU *slave_cpu_target;
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
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3d75706e95..832b339ed6 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -69,4 +69,7 @@ struct PnvQuad {
     uint32_t quad_id;
     MemoryRegion xscom_regs;
 };
+
+PnvCore *pnv_get_vcpu_by_xscom_base(PnvChip *chip, uint32_t xscom_base);
+
 #endif /* PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index cbe848d27b..530f89af55 100644
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
 
@@ -90,6 +93,9 @@ struct PnvXScomInterfaceClass {
     ((uint64_t)(((core) & 0x1C) + 0x40) << 22)
 #define PNV9_XSCOM_EQ_SIZE        0x100000
 
+#define PNV9_XSCOM_CHIPTOD_BASE   PNV_XSCOM_CHIPTOD_BASE
+#define PNV9_XSCOM_CHIPTOD_SIZE   PNV_XSCOM_CHIPTOD_SIZE
+
 #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
 #define PNV9_XSCOM_OCC_SIZE       0x8000
 
@@ -138,6 +144,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
 
+#define PNV10_XSCOM_CHIPTOD_BASE   PNV9_XSCOM_CHIPTOD_BASE
+#define PNV10_XSCOM_CHIPTOD_SIZE   PNV9_XSCOM_CHIPTOD_SIZE
+
 #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
 #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8c30c59a56..d73cce8474 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1172,6 +1172,12 @@ struct CPUArchState {
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
+
+#if defined(TARGET_PPC64)
+    /* PowerNV chiptod / timebase facility state. */
+    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
+    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
+#endif
 #endif
 
     /* Other registers */
-- 
2.40.1


