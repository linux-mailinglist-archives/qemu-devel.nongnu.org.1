Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFB800ABF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:19:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92T9-00064A-WD; Fri, 01 Dec 2023 07:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S8-0005Xo-S3; Fri, 01 Dec 2023 07:17:05 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S5-0006MJ-VM; Fri, 01 Dec 2023 07:17:04 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cb749044a2so2055810b3a.0; 
 Fri, 01 Dec 2023 04:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433019; x=1702037819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCnRGS5HPdnNI9SGD5Wcso4HL/SplUlvD0sVKolReIU=;
 b=RpdslPZRbH72Kf8k6HSD4FN46bwuDFxpXvNomC9qQ/MhPHM+fmN63emI7H5LpzmDKy
 8bz4qbMM2GuQs7ScoDxl4Drf2G1nyVPsR/NdMZTvZn3piyiCn8w4a42OjBBWCcm1PZtA
 Edsek1EL/d8sN2TlQ8a93fKLMkjvKF/spiEXuqh5fpThrSitvNOKcs/SR/BpIQ5miDuy
 g4RsoQZd2Pk/IpMdPiJO481M4Lkuu2poq9f8dlQrLyi9RvUk9imOIQpYMMaQ8TRpqK2E
 ydh0epEJ3u1U5SFaLJmOJpH34DYLcScCGPdbCMmarkAvv6C8LAUEfJW4qdD6XWtMMc8p
 Ialw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433019; x=1702037819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCnRGS5HPdnNI9SGD5Wcso4HL/SplUlvD0sVKolReIU=;
 b=rOVdFOaHVP7Oa2EW4t/05tmC7qpjGDOOrkDBpBFtEthB0ZwLZK+YqH/epZtfyk0UZg
 U/UCM5mYbJzz2ZlHMLE8QtTLYD/VUzZnedTKNBfYtzwsB2kBUtOECrMrqyHEEgUVjr9P
 3ui12X0wwyl4CcKflDfnxAQ0eq/uSzVt/i0QDBF+9CGOtR1zqunDfeUuuSpskO6G+Wkh
 jhqyf3NVSTtXY1cxD2g7mOirUF7Wy2JFZVSGcdcHMhANRLeN9nJftt4ity5uds2K8mT9
 4DF0loH+EcA0Ur2R9h2OGxLSyvvilEIbSKtRuEgB6cbdOAvIBhADB5a6ACw501KSfGAE
 xS3w==
X-Gm-Message-State: AOJu0YzHlsJac/wFgUL9mFQWFCvbS4ITQJP0GkiO98t2Oie/zKQ3Jg+B
 gwfv6+r3hmVHA7nN402tVuG5rt/gwT8=
X-Google-Smtp-Source: AGHT+IFbwy2TE+9jOjrwKFBvdh424nf4oEm0/DH4POWpHciyLWopu/tw6vq+VTVelVFFvy2CnowHaA==
X-Received: by 2002:a05:6a20:13c8:b0:18b:c96b:a433 with SMTP id
 ho8-20020a056a2013c800b0018bc96ba433mr22847228pzc.56.1701433019467; 
 Fri, 01 Dec 2023 04:16:59 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:16:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] pnv/chiptod: Add POWER9/10 chiptod model
Date: Fri,  1 Dec 2023 22:16:32 +1000
Message-ID: <20231201121636.142694-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

The ChipTOD (for Time-Of-Day) is a chip pervasive facility in IBM POWER
(powernv) processors that keeps a time of day clock.

In particular for this model are facilities that initialise and start
the time of day clock, and that synchronise that clock to cores on the
chip, and to other chips. In this way, all cores on all chips can
synchronise timebase (TB).

This model implements functionality sufficient to run the skiboot
chiptod synchronisation procedure (with the following core timebase
state machine implementation). It does not modify the TB in the cores
where the real hardware would, because the QEMU ppc timebase
implementation is always synchronised acros all cores.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chiptod.h |  49 ++++
 include/hw/ppc/pnv_xscom.h   |   9 +
 hw/ppc/pnv_chiptod.c         | 454 +++++++++++++++++++++++++++++++++++
 hw/ppc/meson.build           |   1 +
 hw/ppc/trace-events          |   4 +
 5 files changed, 517 insertions(+)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c

diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
new file mode 100644
index 0000000000..ca770525d9
--- /dev/null
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -0,0 +1,49 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+    tod_running = 2,
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
+    void (*broadcast_ttype)(PnvChipTOD *sender, uint32_t trigger);
+
+    int xscom_size;
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
 
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
new file mode 100644
index 0000000000..6ac3eac9d0
--- /dev/null
+++ b/hw/ppc/pnv_chiptod.c
@@ -0,0 +1,454 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of some ChipTOD behaviour
+ *
+ * Copyright (c) 2022-2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+#include "sysemu/reset.h"
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
+#define TOD_START_TOD_REG               0x00000022
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
+/*
+ * The TOD FSM:
+ * - The reset state is 0 error.
+ * - A hardware error detected will transition to state 0 from any state.
+ * - LOAD_TOD_MOD and TTYPE5 will transition to state 7 from any state.
+ *
+ * | state      | action                       | new |
+ * |------------+------------------------------+-----|
+ * | 0 error    | LOAD_TOD_MOD                 |  7  |
+ * | 0 error    | Recv TTYPE5 (invalidate TOD) |  7  |
+ * | 7 not_set  | LOAD_TOD (bit-63 = 0)        |  2  |
+ * | 7 not_set  | LOAD_TOD (bit-63 = 1)        |  1  |
+ * | 7 not_set  | Recv TTYPE4 (send TOD)       |  2  |
+ * | 2 running  |                              |     |
+ * | 1 stopped  | START_TOD                    |  2  |
+ *
+ * Note the hardware has additional states but they relate to the sending
+ * and receiving and waiting on synchronisation signals between chips and
+ * are not described or modeled here.
+ */
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
+        if (chiptod->tod_state == tod_running) {
+            val |= PPC_BIT(20); /* Is running */
+        }
+        val |= PPC_BIT(21); /* Is using primary config */
+        val |= PPC_BIT(26); /* Is using master path select */
+
+        if (chiptod->primary) {
+            val |= PPC_BIT(23); /* Is active master */
+        } else if (chiptod->secondary) {
+            val |= PPC_BIT(24); /* Is backup master */
+        } else {
+            val |= PPC_BIT(25); /* Is slave (should backup master set this?) */
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
+static void chiptod_receive_ttype(PnvChipTOD *chiptod, uint32_t trigger)
+{
+    switch (trigger) {
+    case TOD_TX_TTYPE_4_REG:
+        if (chiptod->tod_state != tod_not_set) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: received TTYPE4 in "
+                          " state %d, should be in 7 (TOD_NOT_SET)\n",
+                          chiptod->tod_state);
+        } else {
+            chiptod->tod_state = tod_running;
+        }
+        break;
+    case TOD_TX_TTYPE_5_REG:
+        /* Works from any state */
+        chiptod->tod_state = tod_not_set;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: received unimplemented "
+                      " TTYPE %u\n", trigger);
+        break;
+    }
+}
+
+static void chiptod_power9_broadcast_ttype(PnvChipTOD *sender,
+                                            uint32_t trigger)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
+        PnvChipTOD *chiptod = &chip9->chiptod;
+
+        if (chiptod != sender) {
+            chiptod_receive_ttype(chiptod, trigger);
+        }
+    }
+}
+
+static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
+                                            uint32_t trigger)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+        PnvChipTOD *chiptod = &chip10->chiptod;
+
+        if (chiptod != sender) {
+            chiptod_receive_ttype(chiptod, trigger);
+        }
+    }
+}
+
+static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    PnvChipTODClass *pctc = PNV_CHIPTOD_GET_CLASS(chiptod);
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
+                          " TOD_LOAD_TOD_MOD_REG with bad val 0x%" PRIx64"\n",
+                          val);
+        } else {
+            chiptod->tod_state = tod_not_set;
+        }
+        break;
+    case TOD_LOAD_TOD_REG:
+        if (chiptod->tod_state != tod_not_set) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: LOAD_TOG_REG in "
+                          " state %d, should be in 7 (TOD_NOT_SET)\n",
+                          chiptod->tod_state);
+        } else {
+            if (val & PPC_BIT(63)) {
+                chiptod->tod_state = tod_stopped;
+            } else {
+                chiptod->tod_state = tod_running;
+            }
+        }
+        break;
+    case TOD_START_TOD_REG:
+        if (chiptod->tod_state != tod_stopped) {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: LOAD_TOG_REG in "
+                          " state %d, should be in 1 (TOD_STOPPED)\n",
+                          chiptod->tod_state);
+        } else {
+            chiptod->tod_state = tod_running;
+        }
+        break;
+    case TOD_TX_TTYPE_4_REG:
+    case TOD_TX_TTYPE_5_REG:
+        pctc->broadcast_ttype(chiptod, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+}
+
+static const MemoryRegionOps pnv_chiptod_xscom_ops = {
+    .read = pnv_chiptod_xscom_read,
+    .write = pnv_chiptod_xscom_write,
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
+    uint32_t chiptod_pcba = PNV9_XSCOM_CHIPTOD_BASE;
+    uint32_t reg[] = {
+        cpu_to_be32(chiptod_pcba),
+        cpu_to_be32(PNV9_XSCOM_CHIPTOD_SIZE)
+    };
+
+    name = g_strdup_printf("chiptod@%x", chiptod_pcba);
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
+    pctc->broadcast_ttype = chiptod_power9_broadcast_ttype;
+
+    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
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
+    pctc->broadcast_ttype = chiptod_power10_broadcast_ttype;
+
+    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
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
+static void pnv_chiptod_reset(void *dev)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+
+    chiptod->pss_mss_ctrl_reg = 0;
+    if (chiptod->primary) {
+        chiptod->pss_mss_ctrl_reg |= PPC_BIT(1); /* TOD is master */
+    }
+    /* Drawer is master (we do not simulate multi-drawer) */
+    chiptod->pss_mss_ctrl_reg |= PPC_BIT(2);
+
+    chiptod->tod_error = 0;
+    chiptod->tod_state = tod_error;
+}
+
+static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+    PnvChipTODClass *pctc = PNV_CHIPTOD_GET_CLASS(chiptod);
+
+    /* XScom regions for ChipTOD registers */
+    pnv_xscom_region_init(&chiptod->xscom_regs, OBJECT(dev),
+                          &pnv_chiptod_xscom_ops, chiptod, "xscom-chiptod",
+                          pctc->xscom_size);
+
+    qemu_register_reset(pnv_chiptod_reset, chiptod);
+}
+
+static void pnv_chiptod_unrealize(DeviceState *dev)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
+
+    qemu_unregister_reset(pnv_chiptod_reset, chiptod);
+}
+
+static void pnv_chiptod_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = pnv_chiptod_realize;
+    dc->unrealize = pnv_chiptod_unrealize;
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


