Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DAE7DA6BA
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 13:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwhWp-0000cJ-P1; Sat, 28 Oct 2023 07:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWm-0000br-2j; Sat, 28 Oct 2023 07:30:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWj-0005UI-OY; Sat, 28 Oct 2023 07:30:51 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SBN1HU002636; Sat, 28 Oct 2023 11:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=yqpNtec4bJCX6foLj3qSUwOxjOjoaJRFYt/OAR9lNv8=;
 b=T+O5BiJmq4CJQDi5TzbKMiKzhP4z+V2MK3CvjlgN1aHEDW73Ur9Lzzr7Gc4KAm/Qp/ur
 whCsV7w/5q9C5kv4eCL2Sc6wH8vCZ19P3BciPCozmJXWimymTSDJlRWf5xIwLl2h0VAi
 qEBcVx+l2KlKDzgRGvfrPV0xbU4D1aihX/6+tBu+h1i7q7O67NI96la2/r2dj6J7CvIx
 Tp29+HJJTuFCFdJOFXJqYxsBLD3Ifn4QQB9x/xVSHf9L35f81O3EtucIJUaGNO7IYIy/
 wcUHWV+1TY4dBLi2+Tm/nJMIwuW22Od16D+bm02khEC6u8qRXseVXS7D8MVdTJ9Yq3oS AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u1169r93u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39SBUYXO020103;
 Sat, 28 Oct 2023 11:30:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u1169r93m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SAhWRP021478; Sat, 28 Oct 2023 11:30:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqrkj67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39SBUbO218350730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Oct 2023 11:30:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C9632004B;
 Sat, 28 Oct 2023 11:30:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01D8320040;
 Sat, 28 Oct 2023 11:30:36 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Oct 2023 11:30:35 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 1/3] hw/ppc: Add pnv pervasive common chiplet units
Date: Sat, 28 Oct 2023 06:30:24 -0500
Message-Id: <20231028113026.23510-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
References: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QdltaT5ubIY_pOMYHak9Yk3iGacMg3NO
X-Proofpoint-ORIG-GUID: zJn03LyxdPsSTWX2X82X4JynNv757qnM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310280088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This part of the patchset creates a common pervasive chiplet model where it
houses the common units of a chiplets.

The chiplet control unit is common across chiplets and this commit implements
the pervasive chiplet model with chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build             |   1 +
 hw/ppc/pnv_pervasive.c         | 237 +++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_pervasive.h |  47 +++++++
 include/hw/ppc/pnv_xscom.h     |   3 +
 4 files changed, 288 insertions(+)
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..c80d2f6cfb 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -50,6 +50,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
new file mode 100644
index 0000000000..794978756c
--- /dev/null
+++ b/hw/ppc/pnv_pervasive.c
@@ -0,0 +1,237 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
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
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_pervasive.h"
+#include "hw/ppc/fdt.h"
+#include <libfdt.h>
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
+static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr,
+                                 unsigned size)
+{
+    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(opaque);
+    int reg = addr >> 3;
+    uint64_t val = 0xffffffffffffffffull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            val = perv_chiplet->control_regs.cplt_ctrl[i];
+            return val;
+        } else if ((reg == (i + 0x10)) || (reg == (i + 0x20))) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                           "xscom read at 0x%016lx\n",
+                                          __func__, (unsigned long)reg);
+            return val;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        val = perv_chiplet->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = perv_chiplet->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_STAT0:
+        val = perv_chiplet->control_regs.cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = perv_chiplet->control_regs.cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = perv_chiplet->control_regs.ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = perv_chiplet->control_regs.ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+    return val;
+}
+
+static void pnv_chiplet_ctrl_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(opaque);
+    int reg = addr >> 3;
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            perv_chiplet->control_regs.cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            perv_chiplet->control_regs.cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            perv_chiplet->control_regs.cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        perv_chiplet->control_regs.cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        perv_chiplet->control_regs.cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        perv_chiplet->control_regs.cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        perv_chiplet->control_regs.cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        perv_chiplet->control_regs.cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        perv_chiplet->control_regs.cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        perv_chiplet->control_regs.cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        perv_chiplet->control_regs.cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        perv_chiplet->control_regs.ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        perv_chiplet->control_regs.ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                       "write at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+    return;
+}
+
+static const MemoryRegionOps pnv_perv_chiplet_control_xscom_ops = {
+    .read = pnv_chiplet_ctrl_read,
+    .write = pnv_chiplet_ctrl_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_perv_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvPervChiplet *perv_chiplet = PNV_PERVCHIPLET(dev);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&perv_chiplet->xscom_perv_ctrl_regs,
+                          OBJECT(perv_chiplet),
+                          &pnv_perv_chiplet_control_xscom_ops,
+                          perv_chiplet, "xscom-chiplet-control-regs",
+                          PNV10_XSCOM_CTRL_CHIPLET_SIZE);
+}
+
+static int pnv_perv_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    char *name;
+    static int perv_chiplet_offset;
+
+    const char compat[] = "ibm,power10-perv-chiplet";
+    uint32_t reg[] = {
+        cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE),
+        cpu_to_be32(PNV10_XSCOM_CTRL_CHIPLET_SIZE)
+    };
+    if (perv_chiplet_offset == 0) {
+        name = g_strdup_printf("perv_chiplet@%x",
+                                PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
+        perv_chiplet_offset = fdt_add_subnode(fdt, offset, name);
+        _FDT(perv_chiplet_offset);
+        g_free(name);
+
+        _FDT(fdt_setprop(fdt, perv_chiplet_offset, "reg", reg, sizeof(reg)));
+        _FDT(fdt_setprop(fdt, perv_chiplet_offset, "compatible", compat,
+                         sizeof(compat)));
+    }
+    return 0;
+}
+
+static Property pnv_perv_chiplet_properties[] = {
+    DEFINE_PROP_LINK("chip", PnvPervChiplet, chip, TYPE_PNV_CHIP, PnvChip *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_perv_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_perv_chiplet_dt_xscom;
+
+    dc->desc = "PowerNV perv chiplet";
+    dc->realize = pnv_perv_chiplet_realize;
+    device_class_set_props(dc, pnv_perv_chiplet_properties);
+}
+
+static const TypeInfo pnv_perv_chiplet_info = {
+    .name          = TYPE_PNV_PERV_CHIPLET,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvPervChiplet),
+    .class_init    = pnv_perv_chiplet_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_perv_chiplet_register_types(void)
+{
+    type_register_static(&pnv_perv_chiplet_info);
+}
+
+type_init(pnv_perv_chiplet_register_types);
diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
new file mode 100644
index 0000000000..9432461b7b
--- /dev/null
+++ b/include/hw/ppc/pnv_pervasive.h
@@ -0,0 +1,47 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
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
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_PERVASIVE_H
+#define PPC_PNV_PERVASIVE_H
+
+#define TYPE_PNV_PERV_CHIPLET "pnv-pervasive-chiplet"
+#define PNV_PERVCHIPLET(obj) OBJECT_CHECK(PnvPervChiplet, (obj), TYPE_PNV_PERV_CHIPLET)
+
+typedef struct ControlRegs {
+
+    uint64_t cplt_ctrl[6];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} ControlRegs;
+
+typedef struct PnvPervChiplet {
+
+    DeviceState parent;
+    struct PnvChip *chip;
+    MemoryRegion xscom_perv_ctrl_regs;
+    ControlRegs control_regs;
+
+} PnvPervChiplet;
+#endif /*PPC_PNV_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 9bc6463547..4027dcadb9 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -164,6 +164,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
+#define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
-- 
2.31.1


