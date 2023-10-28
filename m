Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24E7DA6BB
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 13:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwhWs-0000dk-Ga; Sat, 28 Oct 2023 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWm-0000c3-Hu; Sat, 28 Oct 2023 07:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWj-0005UJ-UP; Sat, 28 Oct 2023 07:30:52 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SBKoA3022190; Sat, 28 Oct 2023 11:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=e/4eGNo1oGSEqGo4KdhgktmXcxPbcojD4A8Hcn5sVkU=;
 b=IdfF1vwMKRdryBo/PicW9MuewRYM4e4IQZd9fkwBP4FCytgSkcl/ZvVGABV6AO63r80c
 xiFCretqIoiqNyDroDkGWso2ZXKceanjbN8zfQC3YdjGSLHSIMbcm6LIl9pcwlJxB2TI
 Ln9ZkPCidZWp8qDiUfQw4ljW87ox2iYVDyJ4YNGCWnQadTONV7/x5/4icPIPgrmP0V3T
 SazwZ5/JigQcsK/KeRCjRR/0QtAoRFhyrYdkMdRVfZDCvScUalhgKAf4Crs2gpQnEoBh
 ewhrW6WQ7UMrVQ/RegXUoQ1vpSdADoP0Eo5AHtExgEogdZ8Am5dv3nf7Atr71O8yQ2Td lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u104j97mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:45 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39SBU7Zf009503;
 Sat, 28 Oct 2023 11:30:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u104j97m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SBBBYh011341; Sat, 28 Oct 2023 11:30:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqrbh2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39SBUg0A4915812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Oct 2023 11:30:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDE1E2004B;
 Sat, 28 Oct 2023 11:30:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72A9620040;
 Sat, 28 Oct 2023 11:30:40 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Oct 2023 11:30:40 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 2/3] hw/ppc: Add nest1 chiplet model
Date: Sat, 28 Oct 2023 06:30:25 -0500
Message-Id: <20231028113026.23510-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
References: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sAlG8c-IfExLkfjq48PXTWG57bWz9-3Z
X-Proofpoint-ORIG-GUID: h2CIsw9cvyNUxU3WafEQip2hdfQ9fCz5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310280088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
The nest1 chiplet consists of PowerBus Fabric controller,
nest Memory Management Unit, chiplet control unit and more.

This commit creates a nest1 chiplet model and initialize and realize the
pervasive chiplet model where chiplet control registers are implemented.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build                |   1 +
 hw/ppc/pnv_nest1_chiplet.c        | 104 ++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_nest_chiplet.h |  39 +++++++++++
 3 files changed, 144 insertions(+)
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
index 0000000000..160e2ba4cb
--- /dev/null
+++ b/hw/ppc/pnv_nest1_chiplet.c
@@ -0,0 +1,104 @@
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
+static void pnv_nest1_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(dev);
+
+    assert(nest1_chiplet->chip);
+
+    object_initialize_child(OBJECT(nest1_chiplet), "perv_chiplet",
+                            &nest1_chiplet->perv_chiplet,
+                            TYPE_PNV_PERV_CHIPLET);
+
+    if (!qdev_realize(DEVICE(&nest1_chiplet->perv_chiplet), NULL, errp)) {
+        return;
+    }
+}
+
+static int pnv_nest1_chiplet_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    char *name;
+    int nest1_chiplet_offset;
+    const char compat[] = "ibm,power10-nest1-chiplet";
+
+    name = g_strdup_printf("nest1_chiplet@%x",
+                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
+    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nest1_chiplet_offset);
+    g_free(name);
+
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
index 0000000000..b2ffe128bd
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
+    /* common pervasive chiplet unit */
+    PnvPervChiplet perv_chiplet;
+} PnvNest1Chiplet;
+
+#endif /*PPC_PNV_NEST1_CHIPLET_H */
-- 
2.31.1


