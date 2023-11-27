Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453D7FA7C6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7fB7-0001VE-Vn; Mon, 27 Nov 2023 12:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7fB0-0001Qv-J1; Mon, 27 Nov 2023 12:13:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7fAn-0005j6-Ad; Mon, 27 Nov 2023 12:13:42 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARHB07X004331; Mon, 27 Nov 2023 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ldg9uwUXBiEFdYS4BQvub8l/8idfdHYPglRQn1WG5ks=;
 b=e5rrqKLVTCSsZ5KlTIOxSvGoyDs/F6IY3VnOM2cLaeb02z7M6HdUBFvObjl3pB9dzhog
 LqVCkpS3LkLMY7iinD4RIsLnyMt+UNxpw1FrdLLME5XL4XpxZHg/PdfgRjtX2ZM2XSWp
 EJPl90e/JfBF4+siB93UpkzUgIjHabsYO+MUpq+QbtTumH5aedzDJanEA9dYhm9KvR+N
 rAhNKkhVf2N7+PNM1mAyXh2eE/Q7GVsVvTDr7k4YmGOSsulHTpDFAL55NVpnZpHCHuPe
 AdC9kcXeRQ+yIGplcgrBzFAgQL1JPlm7GYrIxl9FuYME56Hp79sar2XENataTfPgQA5L 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd79u0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARHB9mS005424;
 Mon, 27 Nov 2023 17:13:19 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umxd79u09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGr5XT001739; Mon, 27 Nov 2023 17:13:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1hmhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARHDFW966847032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 17:13:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A95CE20043;
 Mon, 27 Nov 2023 17:13:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 033C520040;
 Mon, 27 Nov 2023 17:13:14 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 17:13:13 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v6 1/3] hw/ppc: Add pnv nest pervasive common chiplet model
Date: Mon, 27 Nov 2023 11:13:05 -0600
Message-Id: <20231127171307.5237-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
References: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7zEeWQWsqForaYYw2P9PbqROtZPaOjGY
X-Proofpoint-ORIG-GUID: e_RYZa7WhatXTRRJEFTes2FDhQwm8fpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A POWER10 chip is divided into logical pieces called chiplets. Chiplets
are broadly divided into "core chiplets" (with the processor cores) and
"nest chiplets" (with everything else). Each chiplet has an attachment
to the pervasive bus (PIB) and with chiplet-specific registers. All nest
chiplets have a common basic set of registers and This model will provide
the registers functionality for common registers of nest chiplet (Pervasive
Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)

This commit implement the read/write functions of chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_nest_pervasive.h |  36 +++++
 include/hw/ppc/pnv_xscom.h          |   3 +
 hw/ppc/pnv_nest_pervasive.c         | 219 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   1 +
 4 files changed, 259 insertions(+)
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 hw/ppc/pnv_nest_pervasive.c

diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
new file mode 100644
index 0000000000..9f11531f52
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_pervasive.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_NEST_PERVASIVE_H
+#define PPC_PNV_NEST_PERVASIVE_H
+
+#define TYPE_PNV_NEST_PERVASIVE "pnv-nest-chiplet-pervasive"
+#define PNV_NEST_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_PERVASIVE)
+
+typedef struct PnvPervasiveCtrlRegs {
+#define CPLT_CTRL_SIZE 6
+    uint64_t cplt_ctrl[CPLT_CTRL_SIZE];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} PnvPervasiveCtrlRegs;
+
+typedef struct PnvNestChipletPervasive {
+    DeviceState             parent;
+    char                    *parent_obj_name;
+    MemoryRegion            xscom_ctrl_regs;
+    PnvPervasiveCtrlRegs    control_regs;
+} PnvNestChipletPervasive;
+
+#endif /*PPC_PNV_NEST_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..3e15706dec 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
+#define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
new file mode 100644
index 0000000000..0575f87e8f
--- /dev/null
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -0,0 +1,219 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+/*
+ * Status, configuration, and control units in POWER chips is provided
+ * by the pervasive subsystem, which connects registers to the SCOM bus,
+ * which can be programmed by processor cores, other units on the chip,
+ * BMCs, or other POWER chips.
+ *
+ * A POWER10 chip is divided into logical pieces called chiplets. Chiplets
+ * are broadly divided into "core chiplets" (with the processor cores) and
+ * "nest chiplets" (with everything else). Each chiplet has an attachment
+ * to the nest_pervasiveasive bus (PIB) and with chiplet-specific registers.
+ * All nest chiplets have a common basic set of registers.
+ *
+ * This model will provide the registers fuctionality for common registers of
+ * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
+ *
+ * Currently this model provide the read/write fuctionality of chiplet control
+ * scom registers.
+ */
+
+#define CPLT_CONF0               0x08
+#define CPLT_CONF0_OR            0x18
+#define CPLT_CONF0_CLEAR         0x28
+#define CPLT_CONF1               0x09
+#define CPLT_CONF1_OR            0x19
+#define CPLT_CONF1_CLEAR         0x29
+#define CPLT_STAT0               0x100
+#define CPLT_MASK0               0x101
+#define CPLT_PROTECT_MODE        0x3FE
+#define CPLT_ATOMIC_CLOCK        0x3FF
+
+static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_PERVASIVE(opaque);
+    int reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            return nest_pervasive->control_regs.cplt_ctrl[i];
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%" PRIx64 "\n",
+                                           __func__, (unsigned long)reg);
+            return val;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        val = nest_pervasive->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = nest_pervasive->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_STAT0:
+        val = nest_pervasive->control_regs.cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = nest_pervasive->control_regs.cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = nest_pervasive->control_regs.ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = nest_pervasive->control_regs.ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%" PRIx64 "\n", __func__, (unsigned long)reg);
+    }
+    return val;
+}
+
+static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_PERVASIVE(opaque);
+    int reg = addr >> 3;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            nest_pervasive->control_regs.cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            nest_pervasive->control_regs.cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        nest_pervasive->control_regs.cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        nest_pervasive->control_regs.cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        nest_pervasive->control_regs.cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        nest_pervasive->control_regs.cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        nest_pervasive->control_regs.cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        nest_pervasive->control_regs.cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        nest_pervasive->control_regs.cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        nest_pervasive->control_regs.ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        nest_pervasive->control_regs.ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                                 "write at 0x%" PRIx64 "\n",
+                                 __func__, (unsigned long)reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nest_pervasive_control_xscom_ops = {
+    .read = pnv_chiplet_ctrl_read,
+    .write = pnv_chiplet_ctrl_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_PERVASIVE(dev);
+    g_autofree char *region_name = NULL;
+    region_name = g_strdup_printf("xscom-%s-control-regs",
+                                   nest_pervasive->parent_obj_name);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs,
+                          OBJECT(nest_pervasive),
+                          &pnv_nest_pervasive_control_xscom_ops,
+                          nest_pervasive, region_name,
+                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
+}
+
+static Property pnv_nest_pervasive_properties[] = {
+    DEFINE_PROP_STRING("parent-obj-name", PnvNestChipletPervasive,
+                        parent_obj_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV nest_pervasive chiplet";
+    dc->realize = pnv_nest_pervasive_realize;
+    device_class_set_props(dc, pnv_nest_pervasive_properties);
+}
+
+static const TypeInfo pnv_nest_pervasive_info = {
+    .name          = TYPE_PNV_NEST_PERVASIVE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNestChipletPervasive),
+    .class_init    = pnv_nest_pervasive_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nest_pervasive_register_types(void)
+{
+    type_register_static(&pnv_nest_pervasive_info);
+}
+
+type_init(pnv_nest_pervasive_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ea44856d43..d6f6f94fcc 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_nest_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


