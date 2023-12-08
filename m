Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD680A73D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 16:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBcf3-0003TG-Mx; Fri, 08 Dec 2023 10:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBceK-0003C0-Hi; Fri, 08 Dec 2023 10:20:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBceE-0003le-RS; Fri, 08 Dec 2023 10:20:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8FCBPt025007; Fri, 8 Dec 2023 15:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=32WsXcjPXNIXsOXmpNaAF7Bv1EiGR97/N0WV2cYUfqE=;
 b=UHMEGsBnrhl0fZRwjAaZK3W3R8diQYXvznQ56e05pmIObjjUWDgYKmZ87b3Kwjaqm+la
 Ag8S2gzciXPnp/hs9xvYupYogWpm8CRXc4HeAyfNLgCJVkxrwU0ePEWF+4gCYMIdfi7n
 VqxYGDJ4EHsJHp8TztDSjOH3EZJvtCRsrV5/KiXOvEGQYtx1EwZ4dVa5I+gFaYfKyMAn
 PMy9krR5LZFqNew3WIBJML92q5xfiLsE8wmwX1oclqACE432jiMzuJJ6Ij59Oe1x9rCY
 jjdm2vrwZZ1VGXCXQ66/t3GFgIQ4ARknIlOidWMI1Ilv4BSK90w1A/j4m0TJ7TxMPAhS Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv5jtr64j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:20:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B8FCUHr025720;
 Fri, 8 Dec 2023 15:20:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv5jtr63w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:20:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8DJhs2001549; Fri, 8 Dec 2023 15:20:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utav2t91k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:20:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B8FJwWA44302788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 15:19:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AE2E20043;
 Fri,  8 Dec 2023 15:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75CBB20040;
 Fri,  8 Dec 2023 15:19:56 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 15:19:56 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v8 2/3] hw/ppc: Add N1 chiplet model
Date: Fri,  8 Dec 2023 09:19:46 -0600
Message-Id: <20231208151947.26951-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231208151947.26951-1-chalapathi.v@linux.ibm.com>
References: <20231208151947.26951-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u3Bt7xk-XOwv9PwGylzc4ZqmbtAYbXPB
X-Proofpoint-ORIG-GUID: 720LezrNCQ-mQnO3l2HdpSzwncrHteCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312080125
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

The N1 chiplet handle the high speed i/o traffic over PCIe and others.
The N1 chiplet consists of PowerBus Fabric controller,
nest Memory Management Unit, chiplet control unit and more.

This commit creates a N1 chiplet model and initialize and realize the
pervasive chiplet model where chiplet control registers are implemented.

This commit also implement the read/write method for the powerbus scom
registers

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_n1_chiplet.h |  32 ++++++
 include/hw/ppc/pnv_xscom.h      |   6 ++
 hw/ppc/pnv_n1_chiplet.c         | 173 ++++++++++++++++++++++++++++++++
 hw/ppc/meson.build              |   1 +
 4 files changed, 212 insertions(+)
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
 create mode 100644 hw/ppc/pnv_n1_chiplet.c

diff --git a/include/hw/ppc/pnv_n1_chiplet.h b/include/hw/ppc/pnv_n1_chiplet.h
new file mode 100644
index 0000000000..a7ad039668
--- /dev/null
+++ b/include/hw/ppc/pnv_n1_chiplet.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU PowerPC N1 chiplet model
+ *
+ * Copyright (c) 2023, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_PNV_N1_CHIPLET_H
+#define PPC_PNV_N1_CHIPLET_H
+
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+#define TYPE_PNV_N1_CHIPLET "pnv-N1-chiplet"
+#define PNV_N1_CHIPLET(obj) OBJECT_CHECK(PnvN1Chiplet, (obj), TYPE_PNV_N1_CHIPLET)
+
+typedef struct PnvPbScom {
+    uint64_t mode;
+    uint64_t hp_mode2_curr;
+} PnvPbScom;
+
+typedef struct PnvN1Chiplet {
+    DeviceState  parent;
+    MemoryRegion xscom_pb_eq_mr;
+    MemoryRegion xscom_pb_es_mr;
+    PnvNestChipletPervasive nest_pervasive; /* common pervasive chiplet unit */
+#define PNV_PB_SCOM_EQ_SIZE 8
+    PnvPbScom eq[PNV_PB_SCOM_EQ_SIZE];
+#define PNV_PB_SCOM_ES_SIZE 4
+    PnvPbScom es[PNV_PB_SCOM_ES_SIZE];
+} PnvN1Chiplet;
+#endif /*PPC_PNV_N1_CHIPLET_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 3e15706dec..535ae1dab0 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -173,6 +173,12 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE      0x3000000
 #define PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE         0x400
 
+#define PNV10_XSCOM_N1_PB_SCOM_EQ_BASE      0x3011000
+#define PNV10_XSCOM_N1_PB_SCOM_EQ_SIZE      0x200
+
+#define PNV10_XSCOM_N1_PB_SCOM_ES_BASE      0x3011300
+#define PNV10_XSCOM_N1_PB_SCOM_ES_SIZE      0x100
+
 #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
 #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
 
diff --git a/hw/ppc/pnv_n1_chiplet.c b/hw/ppc/pnv_n1_chiplet.c
new file mode 100644
index 0000000000..03ff9fbad0
--- /dev/null
+++ b/hw/ppc/pnv_n1_chiplet.c
@@ -0,0 +1,173 @@
+/*
+ * QEMU PowerPC N1 chiplet model
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
+#include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+
+/*
+ * The n1 chiplet contains chiplet control unit,
+ * PowerBus/RaceTrack/Bridge logic, nest Memory Management Unit(nMMU)
+ * and more.
+ *
+ * In this model Nest1 chiplet control registers are modelled via common
+ * nest pervasive model and few PowerBus racetrack registers are modelled.
+ */
+
+#define PB_SCOM_EQ0_HP_MODE2_CURR      0xe
+#define PB_SCOM_ES3_MODE               0x8a
+
+static uint64_t pnv_n1_chiplet_pb_scom_eq_read(void *opaque, hwaddr addr,
+                                                  unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        val = n1_chiplet->eq[0].hp_mode2_curr;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_n1_chiplet_pb_scom_eq_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_EQ0_HP_MODE2_CURR:
+        n1_chiplet->eq[0].hp_mode2_curr = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_n1_chiplet_pb_scom_eq_ops = {
+    .read = pnv_n1_chiplet_pb_scom_eq_read,
+    .write = pnv_n1_chiplet_pb_scom_eq_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_n1_chiplet_pb_scom_es_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        val = n1_chiplet->es[3].mode;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+    return val;
+}
+
+static void pnv_n1_chiplet_pb_scom_es_write(void *opaque, hwaddr addr,
+                                               uint64_t val, unsigned size)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(opaque);
+    uint32_t reg = addr >> 3;
+
+    switch (reg) {
+    case PB_SCOM_ES3_MODE:
+        n1_chiplet->es[3].mode = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
+                      __func__, reg);
+    }
+}
+
+static const MemoryRegionOps pnv_n1_chiplet_pb_scom_es_ops = {
+    .read = pnv_n1_chiplet_pb_scom_es_read,
+    .write = pnv_n1_chiplet_pb_scom_es_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_n1_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(dev);
+
+    /* Realize nest pervasive common chiplet model */
+    if (!qdev_realize(DEVICE(&n1_chiplet->nest_pervasive), NULL, errp)) {
+        return;
+    }
+
+    /* Nest1 chiplet power bus EQ xscom region */
+    pnv_xscom_region_init(&n1_chiplet->xscom_pb_eq_mr, OBJECT(n1_chiplet),
+                          &pnv_n1_chiplet_pb_scom_eq_ops, n1_chiplet,
+                          "xscom-n1-chiplet-pb-scom-eq",
+                          PNV10_XSCOM_N1_PB_SCOM_EQ_SIZE);
+
+    /* Nest1 chiplet power bus ES xscom region */
+    pnv_xscom_region_init(&n1_chiplet->xscom_pb_es_mr, OBJECT(n1_chiplet),
+                          &pnv_n1_chiplet_pb_scom_es_ops, n1_chiplet,
+                          "xscom-n1-chiplet-pb-scom-es",
+                          PNV10_XSCOM_N1_PB_SCOM_ES_SIZE);
+}
+
+static void pnv_n1_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV n1 chiplet";
+    dc->realize = pnv_n1_chiplet_realize;
+}
+
+static void pnv_n1_chiplet_instance_init(Object *obj)
+{
+    PnvN1Chiplet *n1_chiplet = PNV_N1_CHIPLET(obj);
+
+    object_initialize_child(OBJECT(n1_chiplet), "nest-pervasive-common",
+                            &n1_chiplet->nest_pervasive,
+                            TYPE_PNV_NEST_CHIPLET_PERVASIVE);
+}
+
+static const TypeInfo pnv_n1_chiplet_info = {
+    .name          = TYPE_PNV_N1_CHIPLET,
+    .parent        = TYPE_DEVICE,
+    .instance_init = pnv_n1_chiplet_instance_init,
+    .instance_size = sizeof(PnvN1Chiplet),
+    .class_init    = pnv_n1_chiplet_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_n1_chiplet_register_types(void)
+{
+    type_register_static(&pnv_n1_chiplet_info);
+}
+
+type_init(pnv_n1_chiplet_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index d6f6f94fcc..256e453c0c 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -52,6 +52,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_homer.c',
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
+  'pnv_n1_chiplet.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


