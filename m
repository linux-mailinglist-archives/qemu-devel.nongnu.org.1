Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7B7BC04E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorQT-00044I-WF; Fri, 06 Oct 2023 16:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qoo9f-0005Dj-S0; Fri, 06 Oct 2023 12:58:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qoo9c-0005nR-BC; Fri, 06 Oct 2023 12:58:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 396GiwGC009394; Fri, 6 Oct 2023 16:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HxAf6BMSQx01RvMdWc7C9WXuNyCwZrllMvLeAmcYLNY=;
 b=AQgUIpePnVHuFquYWGTElMjnChwmR2K1T2OxoHNJ49uzxf5uIu6vf1lvqhfARZXsO65i
 dUgaTwUuTPC0aSzieiLptrqu7+w6rP5UnCX3VBtO5SqNvMHShnDkcXxoBtlq3aJWQyTo
 25+tf4YMDvejv6JB/XXgnEQ4adlSG/cau3BOST7zKvpAkzjht8501aaBZCATFThwNB4Z
 VE8Tvy5+YBTA2SyivhlmOU+bggNOfB9bkL38MalYf3/OVEEyPquOe3LBq0bSmSZzIs/R
 p48xUSZUGs4CBRE/xUTH7mxtKksbFNSxDgacOiZrpxSd9dUy5D2H/iB2kKQrShMZLc/1 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjp1crbnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Oct 2023 16:58:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396GrTpB012266;
 Fri, 6 Oct 2023 16:58:13 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjp1crbnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Oct 2023 16:58:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 396GsDxR006730; Fri, 6 Oct 2023 16:58:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07mh5ur-48
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Oct 2023 16:58:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 396GYqoO24248802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Oct 2023 16:34:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DA0E2004E;
 Fri,  6 Oct 2023 16:34:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109502004D;
 Fri,  6 Oct 2023 16:34:51 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Oct 2023 16:34:50 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH] hw/ppc: Add nest1 chiplet control scoms
Date: Fri,  6 Oct 2023 11:34:46 -0500
Message-Id: <20231006163446.3370-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0NIS5qdoAOmZ8fy-AfrFO1S5fExjgC0h
X-Proofpoint-ORIG-GUID: ISjKL5NQMd_9j5OkZNxSjp-rT2cZ6tcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=890 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060125
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
X-Mailman-Approved-At: Fri, 06 Oct 2023 16:27:55 -0400
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

-Create nest1 chiplet model and add nest1 chiplet control scoms.
-Implementation of chiplet control scoms are put in pnv_pervasive.c
 as control scoms are common for all chiplets.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build                |   2 +
 hw/ppc/pnv.c                      |  11 +++
 hw/ppc/pnv_nest1_chiplet.c        | 141 +++++++++++++++++++++++++++++
 hw/ppc/pnv_pervasive.c            | 146 ++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h         |   2 +
 include/hw/ppc/pnv_nest_chiplet.h |  27 ++++++
 include/hw/ppc/pnv_pervasive.h    |  30 ++++++
 include/hw/ppc/pnv_xscom.h        |   3 +
 8 files changed, 362 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 include/hw/ppc/pnv_pervasive.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..541d69cf94 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -50,6 +50,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_nest1_chiplet.c',
+  'pnv_pervasive.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eb54f93986..0e1c944753 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1660,6 +1660,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
+    object_initialize_child(obj, "nest1_chiplet", &chip10->nest1_chiplet,
+                            TYPE_PNV_NEST1_CHIPLET);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -1829,6 +1831,15 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
                                 &chip10->homer.regs);
 
+    /* nest1 chiplet control regs */
+    object_property_set_link(OBJECT(&chip10->nest1_chiplet), "chip",
+                             OBJECT(chip), &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->nest1_chiplet), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
+                           &chip10->nest1_chiplet.xscom_ctrl_regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
new file mode 100644
index 0000000000..c679428213
--- /dev/null
+++ b/hw/ppc/pnv_nest1_chiplet.c
@@ -0,0 +1,141 @@
+/*
+ * QEMU PowerPC nest1 chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_nest_chiplet.h"
+#include "hw/ppc/pnv_pervasive.h"
+#include "hw/ppc/fdt.h"
+
+#include <libfdt.h>
+
+/* This chiplet contains nest1 chiplet control unit. More to come later */
+
+static uint64_t pnv_nest1_chiplet_xscom_read(void *opaque, hwaddr addr,
+                                             unsigned size)
+{
+    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(opaque);
+    int reg = addr >> 3;
+    uint64_t val = 0;
+
+    switch (reg) {
+    case 0x000 ... 0x3FF:
+        val = pnv_chiplet_ctrl_read(&nest1_chiplet->ctrl_regs, reg, size);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+
+    return val;
+}
+
+static void pnv_nest1_chiplet_xscom_write(void *opaque, hwaddr addr,
+                                          uint64_t val, unsigned size)
+{
+    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(opaque);
+    int reg = addr >> 3;
+
+    switch (reg) {
+    case 0x000 ... 0x3FF:
+        pnv_chiplet_ctrl_write(&nest1_chiplet->ctrl_regs, reg, val, size);
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+        return;
+    }
+    return;
+}
+
+static const MemoryRegionOps pnv_nest1_chiplet_xscom_ops = {
+    .read = pnv_nest1_chiplet_xscom_read,
+    .write = pnv_nest1_chiplet_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nest1_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(dev);
+
+    assert(nest1_chiplet->chip);
+
+    /* NMMU xscom region */
+    pnv_xscom_region_init(&nest1_chiplet->xscom_ctrl_regs,
+                          OBJECT(nest1_chiplet), &pnv_nest1_chiplet_xscom_ops,
+                          nest1_chiplet, "xscom-nest1-chiplet",
+                          PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE);
+}
+
+static int pnv_nest1_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    char *name;
+    int nest1_chiplet_offset;
+    const char compat[] = "ibm,power10-nest1-chiplet";
+    uint32_t reg[2] = {
+        cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE),
+        cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE)
+    };
+
+    name = g_strdup_printf("nest1_chiplet@%x",
+                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
+    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nest1_chiplet_offset);
+    g_free(name);
+
+    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "compatible",
+                            compat, sizeof(compat)));
+    return 0;
+}
+
+static Property pnv_nest1_chiplet_properties[] = {
+    DEFINE_PROP_LINK("chip", PnvNest1Chiplet, chip, TYPE_PNV_CHIP, PnvChip *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_nest1_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_nest1_chiplet_dt_xscom;
+
+    dc->desc = "PowerNV nest1 chiplet";
+    dc->realize = pnv_nest1_chiplet_realize;
+    device_class_set_props(dc, pnv_nest1_chiplet_properties);
+}
+
+static const TypeInfo pnv_nest1_chiplet_info = {
+    .name          = TYPE_PNV_NEST1_CHIPLET,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNest1Chiplet),
+    .class_init    = pnv_nest1_chiplet_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nest1_chiplet_register_types(void)
+{
+    type_register_static(&pnv_nest1_chiplet_info);
+}
+
+type_init(pnv_nest1_chiplet_register_types);
diff --git a/hw/ppc/pnv_pervasive.c b/hw/ppc/pnv_pervasive.c
new file mode 100644
index 0000000000..292a2b31a0
--- /dev/null
+++ b/hw/ppc/pnv_pervasive.c
@@ -0,0 +1,146 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_pervasive.h"
+#include "hw/ppc/fdt.h"
+
+#include <libfdt.h>
+
+#define CPLT_CONF0               0x08
+#define CPLT_CONF0_OR            0x18
+#define CPLT_CONF0_CLEAR         0x28
+
+#define CPLT_CONF1               0x09
+#define CPLT_CONF1_OR            0x19
+#define CPLT_CONF1_CLEAR         0x29
+
+#define CPLT_STAT0               0x100
+#define CPLT_MASK0               0x101
+#define CPLT_PROTECT_MODE        0x3FE
+#define CPLT_ATOMIC_CLOCK        0x3FF
+
+uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+              unsigned size)
+{
+    uint64_t val = 0xffffffffffffffffull;
+
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            val = ctrl_regs->cplt_ctrl[i];
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
+        val = ctrl_regs->cplt_cfg0;
+        break;
+    case CPLT_CONF0_OR:
+    case CPLT_CONF0_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_CONF1:
+        val = ctrl_regs->cplt_cfg1;
+        break;
+    case CPLT_CONF1_OR:
+    case CPLT_CONF1_CLEAR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                                   "xscom read at 0x%016lx\n",
+                                   __func__, (unsigned long)reg);
+        break;
+    case CPLT_STAT0:
+        val = ctrl_regs->cplt_stat0;
+        break;
+    case CPLT_MASK0:
+        val = ctrl_regs->cplt_mask0;
+        break;
+    case CPLT_PROTECT_MODE:
+        val = ctrl_regs->ctrl_protect_mode;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        val = ctrl_regs->ctrl_atomic_lock;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                 "read at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+
+    return val;
+}
+
+void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                                 uint64_t val, unsigned size)
+{
+    /* CPLT_CTRL0 to CPLT_CTRL5 */
+    for (int i = 0; i <= 5; i++) {
+        if (reg == i) {
+            ctrl_regs->cplt_ctrl[i] = val;
+            return;
+        } else if (reg == (i + 0x10)) {
+            ctrl_regs->cplt_ctrl[i] |= val;
+            return;
+        } else if (reg == (i + 0x20)) {
+            ctrl_regs->cplt_ctrl[i] &= ~val;
+            return;
+        }
+    }
+
+    switch (reg) {
+    case CPLT_CONF0:
+        ctrl_regs->cplt_cfg0 = val;
+        break;
+    case CPLT_CONF0_OR:
+        ctrl_regs->cplt_cfg0 |= val;
+        break;
+    case CPLT_CONF0_CLEAR:
+        ctrl_regs->cplt_cfg0 &= ~val;
+        break;
+    case CPLT_CONF1:
+        ctrl_regs->cplt_cfg1 = val;
+        break;
+    case CPLT_CONF1_OR:
+        ctrl_regs->cplt_cfg1 |= val;
+        break;
+    case CPLT_CONF1_CLEAR:
+        ctrl_regs->cplt_cfg1 &= ~val;
+        break;
+    case CPLT_STAT0:
+        ctrl_regs->cplt_stat0 = val;
+        break;
+    case CPLT_MASK0:
+        ctrl_regs->cplt_mask0 = val;
+        break;
+    case CPLT_PROTECT_MODE:
+        ctrl_regs->ctrl_protect_mode = val;
+        break;
+    case CPLT_ATOMIC_CLOCK:
+        ctrl_regs->ctrl_atomic_lock = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Chiplet_control_regs: Invalid xscom "
+                       "write at 0x%016lx\n", __func__, (unsigned long)reg);
+    }
+
+    return;
+}
+
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 53e1d921d7..4bcb92595a 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -4,6 +4,7 @@
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_nest_chiplet.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -109,6 +110,7 @@ struct Pnv10Chip {
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
+    PnvNest1Chiplet nest1_chiplet;
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
new file mode 100644
index 0000000000..76fa58342e
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_chiplet.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU PowerPC nest chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_NEST1_CHIPLET_H
+#define PPC_PNV_NEST1_CHIPLET_H
+
+#include "hw/ppc/pnv_pervasive.h"
+
+#define TYPE_PNV_NEST1_CHIPLET "pnv-nest1-chiplet"
+#define PNV_NEST1CHIPLET(obj) OBJECT_CHECK(PnvNest1Chiplet, (obj), TYPE_PNV_NEST1_CHIPLET)
+
+typedef struct PnvNest1Chiplet {
+    DeviceState parent;
+
+    struct PnvChip *chip;
+
+    MemoryRegion xscom_ctrl_regs;
+    PnvChipletControlRegs ctrl_regs;
+} PnvNest1Chiplet;
+
+#endif /*PPC_PNV_NEST1_CHIPLET_H */
diff --git a/include/hw/ppc/pnv_pervasive.h b/include/hw/ppc/pnv_pervasive.h
new file mode 100644
index 0000000000..1df5883291
--- /dev/null
+++ b/include/hw/ppc/pnv_pervasive.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU PowerPC pervasive common chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_PNV_PERVASIVE_H
+#define PPC_PNV_PERVASIVE_H
+
+
+typedef struct PnvChipletControlRegs {
+
+    uint64_t cplt_ctrl[6];
+    uint64_t cplt_cfg0;
+    uint64_t cplt_cfg1;
+    uint64_t cplt_stat0;
+    uint64_t cplt_mask0;
+    uint64_t ctrl_protect_mode;
+    uint64_t ctrl_atomic_lock;
+
+} PnvChipletControlRegs;
+
+uint64_t pnv_chiplet_ctrl_read(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                unsigned size);
+void pnv_chiplet_ctrl_write(PnvChipletControlRegs *ctrl_regs, hwaddr reg,
+                uint64_t val, unsigned size);
+#endif /*PPC_PNV_PERVASIVE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 9bc6463547..c19042256b 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -164,6 +164,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
+#define PNV10_XSCOM_NEST1_CTRL_CHIPLET_SIZE      0x400
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
-- 
2.31.1


