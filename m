Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11AC7C720E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyDA-0002u9-Cw; Thu, 12 Oct 2023 12:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyCu-0002n4-De; Thu, 12 Oct 2023 12:06:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyCp-0005ka-82; Thu, 12 Oct 2023 12:06:40 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CG0ZtP029602; Thu, 12 Oct 2023 16:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=85LWzasRMM75JHgMgp7zipKvMWo5MdWQYTmlxoN3QlM=;
 b=jau0w17tnpx2rZlDttTd4NizMSblNUBKeYhC55EgYF2vlv0oG0/daC8+dnfVAJjNOy+B
 ksEyjz3cGHL1CbaEvGkh69Mds4XRlWJ5zhHG1Ey5+IOaLD41rw/n1TMCT39kdSkwDkRH
 vlX7guomg3I+y5QMNbOWD79UOrcIwifVWxzfhELxcS7Y3ZaZVjTrcPIO8P5cYxYE41Mw
 4458MJ6Y5VbsWDc/KOkupR412j0K+rbIbHMWpqBlFhj0RgQL/14WZM6jLPtUP8xJx0A5
 kO1v726ksii8ZF4Y5qaE+mnpcsu2A4uJacy3ZB3wLF3ca+vQSl+SNROm59mvu9fIhsjZ 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkxj07mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:26 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CG0bq3029728;
 Thu, 12 Oct 2023 16:06:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkxj07m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CDVrDO000640; Thu, 12 Oct 2023 16:06:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m0dqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CG6Lvo21955226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 16:06:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAB7C20040;
 Thu, 12 Oct 2023 16:06:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399A12004B;
 Thu, 12 Oct 2023 16:06:20 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 16:06:20 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 2/3] hw/ppc: Add nest1 chiplet model
Date: Thu, 12 Oct 2023 11:06:09 -0500
Message-Id: <20231012160610.2428-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
References: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ePRMExQE6CzxnZ4fLy8dqsCdilBooeWR
X-Proofpoint-ORIG-GUID: Wmd9Uu3fpeq7M21DkD5Y7M-qUA8QDcc0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120133
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit implements nest1 chiplet control registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build                |   1 +
 hw/ppc/pnv_nest1_chiplet.c        | 153 ++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_nest_chiplet.h |  39 ++++++++
 include/hw/ppc/pnv_xscom.h        |   3 +
 4 files changed, 196 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index c80d2f6cfb..4e45e5c1a7 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -51,6 +51,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_homer.c',
   'pnv_pnor.c',
   'pnv_pervasive.c',
+  'pnv_nest1_chiplet.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
new file mode 100644
index 0000000000..d98d145dde
--- /dev/null
+++ b/hw/ppc/pnv_nest1_chiplet.c
@@ -0,0 +1,153 @@
+/*
+ * QEMU PowerPC nest1 chiplet model
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
diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
new file mode 100644
index 0000000000..3eed36d253
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_chiplet.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU PowerPC nest chiplet model
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


