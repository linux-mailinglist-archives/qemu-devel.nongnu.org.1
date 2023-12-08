Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1A80A73A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 16:22:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBcf1-0003QC-AT; Fri, 08 Dec 2023 10:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBce9-000380-BK; Fri, 08 Dec 2023 10:20:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBce7-0003kJ-AJ; Fri, 08 Dec 2023 10:20:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8F6r7p027888; Fri, 8 Dec 2023 15:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QL+k8UAZBE58dx1l2KdcqekH2WUB3VE3FhrHlJh34Ds=;
 b=GvR5kb/Tg8hytEqvMIce0908sW3zGO/7YW5CuJKwsGjo680m/cDmLBRsSD2uuePELBHM
 il0lvnZnxWBZsV+ZvDC0dmqOXYWzKZ1AffLB4WZPBHlfEtlHarMPuk07Iy0cOjv5wTsj
 Anchztz3TdAG4cIKb8gmr2pK64u8V0gHjqcDvHP/H1rUCy82T/PXf2CtD70x1ztBA4z6
 krMqujEfVQlx/zgzVdKHw66UTW1LjEWoO6RYKRCZ/FcXxyp+iEeKGawpF5zKgExRKi4y
 /cLPpYHnH7WLujoI8V9O4DTCG1TuMrTGBrLOqUbUsu52WlDZt1csY0eHmrLLtEr7V+/t lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv2vbcwvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B8FB1CC009997;
 Fri, 8 Dec 2023 15:19:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv2vbcwvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8D7A0L004687; Fri, 8 Dec 2023 15:19:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4tauk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B8FJt7L2163250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 15:19:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17F0E2004D;
 Fri,  8 Dec 2023 15:19:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 722F020040;
 Fri,  8 Dec 2023 15:19:53 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 15:19:53 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v8 1/3] hw/ppc: Add pnv nest pervasive common chiplet model
Date: Fri,  8 Dec 2023 09:19:45 -0600
Message-Id: <20231208151947.26951-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231208151947.26951-1-chalapathi.v@linux.ibm.com>
References: <20231208151947.26951-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oEmvzH2s3ARVhydj_NCKLozJLOsypuyh
X-Proofpoint-GUID: K-UjrmwlVKHm-nTcOyUuMgaE9lgaENYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A POWER10 chip is divided into logical units called chiplets. Chiplets
are broadly divided into "core chiplets" (with the processor cores) and
"nest chiplets" (with everything else). Each chiplet has an attachment
to the pervasive bus (PIB) and with chiplet-specific registers. All nest
chiplets have a common basic set of registers and This model will provide
the registers functionality for common registers of nest chiplet (Pervasive
Chiplet, PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)

This commit implement the read/write functions of chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
 include/hw/ppc/pnv_xscom.h          |   3 +
 hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   1 +
 4 files changed, 244 insertions(+)
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 hw/ppc/pnv_nest_pervasive.c

diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
new file mode 100644
index 0000000000..73cacf3823
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_pervasive.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+#define PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+
+#define TYPE_PNV_NEST_CHIPLET_PERVASIVE "pnv-nest-chiplet-pervasive"
+#define PNV_NEST_CHIPLET_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_CHIPLET_PERVASIVE)
+
+typedef struct PnvPervasiveCtrlRegs {
+#define PNV_CPLT_CTRL_SIZE 6
+    uint64_t cplt_ctrl[PNV_CPLT_CTRL_SIZE];
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
+    MemoryRegion            xscom_ctrl_regs_mr;
+    PnvPervasiveCtrlRegs    control_regs;
+} PnvNestChipletPervasive;
+
+#endif /*PPC_PNV_NEST_CHIPLET_PERVASIVE_H */
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
index 0000000000..77476753a4
--- /dev/null
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -0,0 +1,208 @@
+/*
+ * QEMU PowerPC nest pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+ * A POWER10 chip is divided into logical units called chiplets. Chiplets
+ * are broadly divided into "core chiplets" (with the processor cores) and
+ * "nest chiplets" (with everything else). Each chiplet has an attachment
+ * to the pervasive bus (PIB) and with chiplet-specific registers.
+ * All nest chiplets have a common basic set of registers.
+ *
+ * This model will provide the registers functionality for common registers of
+ * nest unit (PB Chiplet, PCI Chiplets, MC Chiplet, PAU Chiplets)
+ *
+ * Currently this model provide the read/write functionality of chiplet control
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
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            return nest_pervasive->control_regs.cplt_ctrl[i];
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%" PRIx32 "\n",
+                                           __func__, reg);
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
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
+        break;
+    case CPLT_CONF1:
+        val = nest_pervasive->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx32 "\n",
+                                   __func__, reg);
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
+                 "read at 0x%" PRIx32 "\n", __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(
+                                              opaque);
+    uint32_t reg = addr >> 3;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < PNV_CPLT_CTRL_SIZE; i++) {
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
+                                 "write at 0x%" PRIx32 "\n",
+                                 __func__, reg);
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
+    PnvNestChipletPervasive *nest_pervasive = PNV_NEST_CHIPLET_PERVASIVE(dev);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
+                          OBJECT(nest_pervasive),
+                          &pnv_nest_pervasive_control_xscom_ops,
+                          nest_pervasive, "pervasive-control",
+                          PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
+}
+
+static void pnv_nest_pervasive_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV nest pervasive chiplet";
+    dc->realize = pnv_nest_pervasive_realize;
+}
+
+static const TypeInfo pnv_nest_pervasive_info = {
+    .name          = TYPE_PNV_NEST_CHIPLET_PERVASIVE,
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


