Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEE37F7130
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:17:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TEU-0005bH-Kh; Fri, 24 Nov 2023 05:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TEP-0005Zs-IB; Fri, 24 Nov 2023 05:16:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TEL-0005Vw-PZ; Fri, 24 Nov 2023 05:16:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AO9BAoW008797; Fri, 24 Nov 2023 10:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v3//oxmMiyZCinILHE92O6prhDRPURDn5LQc2XivIBQ=;
 b=OYjiBIR/532GSy0DR5+VNNxm0ieAXRz1Kr+g7HM8GAHFdST5y+NcLV7xXfLvWxxdcPBn
 zUbduNqwgfx8pHAIgtGCFCqVl/exYmjpOJBsgEZ8f9HFiM2R+lXMOzQQTpXCJ11d2HFJ
 P83jaLTKFBpwcDNcc7IxcLlgFiwlhK1HatK2w94x1W9w/f/LtSNjQPAEvm0JbCJesVu2
 MtrlXTYArjj6g7donEGQ2meDyWPA1hCmZVIF1cxizEE9+r9+4VUIQbs3mt4ocsYdyn0I
 /rTxoLcaf6yocCCC9LzLliEIMYyxTwaoow54GHyBNSZuY0lVGiGFWfGAN0pZ0Py8jrZa hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr432euv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOA0mKw022439;
 Fri, 24 Nov 2023 10:16:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr432eug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AO9cvvv013526; Fri, 24 Nov 2023 10:16:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf80053yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AOAFxnR12517932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Nov 2023 10:15:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D91B20079;
 Fri, 24 Nov 2023 10:15:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E16D720077;
 Fri, 24 Nov 2023 10:15:57 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Nov 2023 10:15:57 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v5 1/3] hw/ppc: Add pnv pervasive common chiplet units
Date: Fri, 24 Nov 2023 04:15:32 -0600
Message-Id: <20231124101534.19454-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AU_k01m1oBqbjHR0g20JOnv8njlyGtPi
X-Proofpoint-GUID: vSFkOCu_rwb6q-t2ncGDKyl-7PDhsM7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

This part of the patchset creates a common pervasive chiplet model where it
houses the common units of a chiplets.

The chiplet control unit is common across chiplets and this commit implements
the pervasive chiplet model with chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_pervasive.h |  37 ++++++
 include/hw/ppc/pnv_xscom.h     |   3 +
 hw/ppc/pnv_pervasive.c         | 217 +++++++++++++++++++++++++++++++++
 hw/ppc/meson.build             |   1 +
 4 files changed, 258 insertions(+)
 create mode 100644 include/hw/ppc/pnv_pervasive.h
 create mode 100644 hw/ppc/pnv_pervasive.c

diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
new file mode 100644
index 0000000000..d83f86df7b
--- /dev/null
+++ b/include/hw/ppc/pnv_pervasive.h
@@ -0,0 +1,37 @@
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
+#define TYPE_PNV_PERV "pnv-pervasive-chiplet"
+#define PNV_PERV(obj) OBJECT_CHECK(PnvPerv, (obj), TYPE_PNV_PERV)
+
+typedef struct PnvPervCtrlRegs {
+#define CPLT_CTRL_SIZE 6
+    uint64_t cplt_ctrl[CPLT_CTRL_SIZE];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+} PnvPervCtrlRegs;
+
+typedef struct PnvPerv {
+    DeviceState parent;
+    char *parent_obj_name;
+    MemoryRegion xscom_perv_ctrl_regs;
+    PnvPervCtrlRegs control_regs;
+} PnvPerv;
+
+void pnv_perv_dt(PnvPerv *perv, uint32_t base_addr, void *fdt, int offset);
+#endif /*PPC_PNV_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..d09d10f32b 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,6 +170,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
+#define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
new file mode 100644
index 0000000000..c925070798
--- /dev/null
+++ b/hw/ppc/pnv_pervasive.c
@@ -0,0 +1,217 @@
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
+static uint64_t pnv_chiplet_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvPerv *perv = PNV_PERV(opaque);
+    int reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            return perv->control_regs.cplt_ctrl[i];
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
+        val = perv->control_regs.cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = perv->control_regs.cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%" PRIx64 "\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_STAT0:
+        val = perv->control_regs.cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = perv->control_regs.cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = perv->control_regs.ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = perv->control_regs.ctrl_atomic_lock;
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
+    PnvPerv *perv = PNV_PERV(opaque);
+    int reg = addr >> 3;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i < CPLT_CTRL_SIZE; i++) {
+        if (reg == i) {
+            perv->control_regs.cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            perv->control_regs.cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            perv->control_regs.cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        perv->control_regs.cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        perv->control_regs.cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        perv->control_regs.cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        perv->control_regs.cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        perv->control_regs.cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        perv->control_regs.cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        perv->control_regs.cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        perv->control_regs.cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        perv->control_regs.ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        perv->control_regs.ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                                 "write at 0x%" PRIx64 "\n",
+                                 __func__, (unsigned long)reg);
+    }
+}
+
+static const MemoryRegionOps pnv_perv_control_xscom_ops = {
+    .read = pnv_chiplet_ctrl_read,
+    .write = pnv_chiplet_ctrl_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_perv_realize(DeviceState *dev, Error **errp)
+{
+    PnvPerv *perv = PNV_PERV(dev);
+    g_autofree char *region_name = NULL;
+    region_name = g_strdup_printf("xscom-%s-control-regs",
+                                   perv->parent_obj_name);
+
+    /* Chiplet control scoms */
+    pnv_xscom_region_init(&perv->xscom_perv_ctrl_regs, OBJECT(perv),
+                          &pnv_perv_control_xscom_ops, perv, region_name,
+                          PNV10_XSCOM_CTRL_CHIPLET_SIZE);
+}
+
+void pnv_perv_dt(PnvPerv *perv, uint32_t base_addr, void *fdt, int offset)
+{
+    g_autofree char *name = NULL;
+    int perv_offset;
+    const char compat[] = "ibm,power10-perv-chiplet";
+    uint32_t reg[] = {
+        cpu_to_be32(base_addr),
+        cpu_to_be32(PNV10_XSCOM_CTRL_CHIPLET_SIZE)
+    };
+
+    name = g_strdup_printf("%s-perv@%x", perv->parent_obj_name, base_addr);
+    perv_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(perv_offset);
+
+    _FDT(fdt_setprop(fdt, perv_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, perv_offset, "compatible", compat, sizeof(compat)));
+}
+
+static Property pnv_perv_properties[] = {
+    DEFINE_PROP_STRING("parent-obj-name", PnvPerv, parent_obj_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_perv_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV perv chiplet";
+    dc->realize = pnv_perv_realize;
+    device_class_set_props(dc, pnv_perv_properties);
+}
+
+static const TypeInfo pnv_perv_info = {
+    .name          = TYPE_PNV_PERV,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvPerv),
+    .class_init    = pnv_perv_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_perv_register_types(void)
+{
+    type_register_static(&pnv_perv_info);
+}
+
+type_init(pnv_perv_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index ea44856d43..37a7a8935d 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


