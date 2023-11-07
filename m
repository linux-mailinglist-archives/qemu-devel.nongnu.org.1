Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405D7E45BA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:17:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0OkZ-00080I-BK; Tue, 07 Nov 2023 11:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gip-0006A6-I8; Tue, 07 Nov 2023 02:42:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gil-0006aM-RE; Tue, 07 Nov 2023 02:42:03 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A77dYWv005208; Tue, 7 Nov 2023 07:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L1ClE4VlduS+G+kPgQVP6fikB0d0uRwuoYKhEgnsMbY=;
 b=gYVNSlP3EixAxYTcl4CBsn07pWKsJF047zwJaj1fKGDhaRH37zpvibCDLl/+UxOgvtBd
 +ftX7TjKeRRMuAKitFRFBLpjOD72EBVRsfLG6duWIq3bm6oe0peytQw2/9b8yGYxkuwm
 2qCp33OoA5SYH5d9jyDuFtLWWKc3MMaBPOfb2i8v7uneCCql111485pB+c4ZDxOpE+zj
 5KXt31XFq6wb3evPqnXFe4Sg4ODpN0WdQWOnTGWZi5lmqt3MdpCGnu2lkPv3qfx15Vp0
 ECMKzFuTPu11CY4WtT+WnBuMP6YwXpNe2BtFFrr3eGWD5SQ19TuWNe4K5KHgIuLVy/TC Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1sr2yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:38 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77ePEw009339;
 Tue, 7 Nov 2023 07:41:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1sr2y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A77W0Nq007926; Tue, 7 Nov 2023 07:41:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skexuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A77fXXf9896686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 07:41:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1440D58053;
 Tue,  7 Nov 2023 07:41:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E601658043;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: by gfwr516.rchland.ibm.com (Postfix, from userid 607334)
 id 3E82C22003D; Tue,  7 Nov 2023 01:41:32 -0600 (CST)
From: Chalapathi V <chalap1@gfwr516.rchland.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com, Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PATCH v4 1/3] hw/ppc: Add pnv pervasive common chiplet units
Date: Tue,  7 Nov 2023 01:41:25 -0600
Message-Id: <20231107074127.31821-2-chalap1@gfwr516.rchland.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SWECbtEgy-tdAeWForSgYbB_HTE_1jLo
X-Proofpoint-ORIG-GUID: 1tio3JuKNGW40DLQm3eiD8wvHRAATOx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1034 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=chalap1@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Nov 2023 11:16:20 -0500
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

This part of the patchset creates a common pervasive chiplet model where it
houses the common units of a chiplets.

The chiplet control unit is common across chiplets and this commit implements
the pervasive chiplet model with chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build             |   1 +
 hw/ppc/pnv_pervasive.c         | 213 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_pervasive.h |  39 ++++++++
 include/hw/ppc/pnv_xscom.h     |   3 +
 4 files changed, 256 insertions(+)
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c524..c80d2f6 100644
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
index 0000000..40f60b5
--- /dev/null
+++ b/hw/ppc/pnv_pervasive.c
@@ -0,0 +1,213 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
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
+    uint64_t val = ~0ull;
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            val = perv_chiplet->control_regs.cplt_ctrl[i];
+            return val;
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
+        val = perv_chiplet->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = perv_chiplet->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
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
+                 "read at 0x%" PRIx64 "\n", __func__, (unsigned long)reg);
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
+                                 "write at 0x%" PRIx64 "\n",
+                                 __func__, (unsigned long)reg);
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
+void pnv_perv_dt(uint32_t base_addr, void *fdt,
+                             int offset)
+{
+    g_autofree char *name = NULL;
+    int perv_chiplet_offset;
+
+    const char compat[] = "ibm,power10-perv-chiplet";
+    uint32_t reg[] = {
+        base_addr,
+        cpu_to_be32(PNV10_XSCOM_CTRL_CHIPLET_SIZE)
+    };
+    name = g_strdup_printf("perv_chiplet@%x", base_addr);
+    perv_chiplet_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(perv_chiplet_offset);
+
+    _FDT(fdt_setprop(fdt, perv_chiplet_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, perv_chiplet_offset, "compatible",
+                     compat, sizeof(compat)));
+}
+
+static void pnv_perv_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV perv chiplet";
+    dc->realize = pnv_perv_chiplet_realize;
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
index 0000000..61be4cf
--- /dev/null
+++ b/include/hw/ppc/pnv_pervasive.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
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
+
+void pnv_perv_dt(uint32_t base, void *fdt, int offset);
+#endif /*PPC_PNV_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 35b1961..87bbee8 100644
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
1.8.3.1


