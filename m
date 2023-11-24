Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229197F7137
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TEW-0005cF-DJ; Fri, 24 Nov 2023 05:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TET-0005b2-NA; Fri, 24 Nov 2023 05:16:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TEQ-0005WM-Fm; Fri, 24 Nov 2023 05:16:21 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AO8jgNr006164; Fri, 24 Nov 2023 10:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=p2K0ASXY66hPNHKGVtIRZEB+cswytpI7BeYIMs9R1hU=;
 b=ion4+bZptaWCa6F6VVc+s9OjQOHgMCox0apQmXt3B704Jiradt+cNEMycfIpQC0IelgO
 Pcr6PrT9KTRui05rtQoVMkSmLpi8TGE3+ClO2tCZJQBpB1EnjYEzdRYt4jQlwgjLRu3s
 KpZGVRaSaPhWD7mFKg8WgO6eJX6+2m7X5gXcihmAE7LzO+J+ZtWBeG5v/j2lOwlGffrx
 XnLmwys21bkVeKQpX51zEU4V4FJwJrHNmPNsO9m5Vr9MXujPAFobk9H1OcAeMU7d+8a6
 riTT4opvU4Bak1oKgopUwTJSLSQ8txruDq6iTCaimXMxPZR/dUC/yxrCaCOhkA/B9fJM VA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr9127wb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOAB99X004993;
 Fri, 24 Nov 2023 10:16:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujr9127w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AO9VvRT015492; Fri, 24 Nov 2023 10:16:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93mcrue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:16:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AOAG6Dv20906676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Nov 2023 10:16:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9D820074;
 Fri, 24 Nov 2023 10:16:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F37920078;
 Fri, 24 Nov 2023 10:16:04 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Nov 2023 10:16:04 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v5 2/3] hw/ppc: Add nest1 chiplet model
Date: Fri, 24 Nov 2023 04:15:33 -0600
Message-Id: <20231124101534.19454-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q7XL0PkxopjtXRZNOdluE8ughwIxeSFW
X-Proofpoint-GUID: J7YwtnBIRmm3mxP-C26my6-1H5aVt5BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240080
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

The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
The nest1 chiplet consists of PowerBus Fabric controller,
nest Memory Management Unit, chiplet control unit and more.

This commit creates a nest1 chiplet model and initialize and realize the
pervasive chiplet model where chiplet control registers are implemented.

This commit also implement the read/write method for the powerbus scom
registers

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_nest_chiplet.h |  36 ++++++
 include/hw/ppc/pnv_xscom.h        |   6 +
 hw/ppc/pnv_nest1_chiplet.c        | 197 ++++++++++++++++++++++++++++++
 hw/ppc/meson.build                |   1 +
 4 files changed, 240 insertions(+)
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c

diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
new file mode 100644
index 0000000000..845030fb1a
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_chiplet.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU PowerPC nest chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef PPC_PNV_NEST1_CHIPLET_H
+#define PPC_PNV_NEST1_CHIPLET_H
+
+#include "hw/ppc/pnv_pervasive.h"
+
+#define TYPE_PNV_NEST1 "pnv-nest1-chiplet"
+#define PNV_NEST1(obj) OBJECT_CHECK(PnvNest1, (obj), TYPE_PNV_NEST1)
+
+typedef struct pb_scom {
+    uint64_t mode;
+    uint64_t hp_mode2_curr;
+} pb_scom;
+
+typedef struct PnvNest1 {
+    DeviceState parent;
+    MemoryRegion xscom_pb_eq_regs;
+    MemoryRegion xscom_pb_es_regs;
+    /* common pervasive chiplet unit */
+    PnvPerv perv;
+    /* powerbus racetrack registers */
+    pb_scom eq[8];
+    pb_scom es[4];
+} PnvNest1;
+#endif /*PPC_PNV_NEST1 */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index d09d10f32b..df68a1c20e 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -173,6 +173,12 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
 #define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
 
+#define PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE      0x3011000
+#define PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE      0x200
+
+#define PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE      0x3011300
+#define PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE      0x100
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
new file mode 100644
index 0000000000..609d5f1be4
--- /dev/null
+++ b/hw/ppc/pnv_nest1_chiplet.c
@@ -0,0 +1,197 @@
+/*
+ * QEMU PowerPC nest1 chiplet model
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
+#include "hw/ppc/pnv_nest_chiplet.h"
+#include "hw/ppc/pnv_pervasive.h"
+#include "hw/ppc/fdt.h"
+#include <libfdt.h>
+
+/*
+ * The nest1 chiplet contains chiplet control unit,
+ * PowerBus/RaceTrack/Bridge logic, nest Memory Management Unit(nMMU)
+ * and more.
+ */
+
+#define PB_SCOM_EQ0_HP_MODE2_CURR      0xe
+#define PB_SCOM_ES3_MODE               0x8a
+
+static uint64_t pnv_nest1_pb_scom_eq_read(void *opaque, hwaddr addr,
+                                                  unsigned size)
+{
+    PnvNest1 *nest1 = PNV_NEST1(opaque);
+    int reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        val = nest1->eq[0].hp_mode2_curr;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_nest1_pb_scom_eq_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvNest1 *nest1 = PNV_NEST1(opaque);
+    int reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        nest1->eq[0].hp_mode2_curr = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nest1_pb_scom_eq_ops = {
+    .read = pnv_nest1_pb_scom_eq_read,
+    .write = pnv_nest1_pb_scom_eq_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_nest1_pb_scom_es_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvNest1 *nest1 = PNV_NEST1(opaque);
+    int reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        val = nest1->es[3].mode;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_nest1_pb_scom_es_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvNest1 *nest1 = PNV_NEST1(opaque);
+    int reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        nest1->es[3].mode = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_nest1_pb_scom_es_ops = {
+    .read = pnv_nest1_pb_scom_es_read,
+    .write = pnv_nest1_pb_scom_es_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_nest1_realize(DeviceState *dev, Error **errp)
+{
+    PnvNest1 *nest1 = PNV_NEST1(dev);
+
+    /* perv chiplet initialize and realize */
+    object_initialize_child(OBJECT(nest1), "perv", &nest1->perv, TYPE_PNV_PERV);
+    object_property_set_str(OBJECT(&nest1->perv), "parent-obj-name", "nest1",
+                                   errp);
+    if (!qdev_realize(DEVICE(&nest1->perv), NULL, errp)) {
+        return;
+    }
+
+    /* Nest1 chiplet power bus EQ xscom region */
+    pnv_xscom_region_init(&nest1->xscom_pb_eq_regs, OBJECT(nest1),
+                          &pnv_nest1_pb_scom_eq_ops, nest1,
+                          "xscom-nest1-pb-scom-eq-regs",
+                          PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE);
+
+    /* Nest1 chiplet power bus ES xscom region */
+    pnv_xscom_region_init(&nest1->xscom_pb_es_regs, OBJECT(nest1),
+                          &pnv_nest1_pb_scom_es_ops, nest1,
+                          "xscom-nest1-pb-scom-es-regs",
+                          PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE);
+}
+
+static int pnv_nest1_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvNest1 *nest1 = PNV_NEST1(dev);
+    g_autofree char *name = NULL;
+    int nest1_offset = 0;
+    const char compat[] = "ibm,power10-nest1-chiplet";
+    uint32_t reg[] = {
+        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE),
+        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE),
+        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE),
+        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE)
+    };
+
+    /* populate perv_chiplet control_regs */
+    pnv_perv_dt(&nest1->perv, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE, fdt, offset);
+
+    name = g_strdup_printf("nest1@%x", PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE);
+    nest1_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nest1_offset);
+
+    _FDT(fdt_setprop(fdt, nest1_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, nest1_offset, "compatible", compat, sizeof(compat)));
+    return 0;
+}
+
+static void pnv_nest1_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_nest1_dt_xscom;
+
+    dc->desc = "PowerNV nest1 chiplet";
+    dc->realize = pnv_nest1_realize;
+}
+
+static const TypeInfo pnv_nest1_info = {
+    .name          = TYPE_PNV_NEST1,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvNest1),
+    .class_init    = pnv_nest1_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_nest1_register_types(void)
+{
+    type_register_static(&pnv_nest1_info);
+}
+
+type_init(pnv_nest1_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37a7a8935d..7b8b87596a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -52,6 +52,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_homer.c',
   'pnv_pnor.c',
   'pnv_pervasive.c',
+  'pnv_nest1_chiplet.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


