Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 477277E45BB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:17:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0OkY-00080B-LX; Tue, 07 Nov 2023 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gio-0006A3-Tj; Tue, 07 Nov 2023 02:42:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gil-0006aS-GS; Tue, 07 Nov 2023 02:42:01 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A77daCA015841; Tue, 7 Nov 2023 07:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ROneKfetjv7MOg6E7Xwieoj9DKIkG4xKjOiMs94S/m4=;
 b=thFVDW70xokY/OeDoo88WoJBCNNV8OfD4WHB6/R5miojnbEef5D0e9Z4uecQxMuImK8J
 98jHz3YzebakiqmJsD+Lt/pj0YQZMIATA5t7H8GdMnhOKYoWEhm20C2w0SMQrZpLvOL4
 gg09yz9S+6yLjDGjdSwtrsmNwQDzkD4z23ckRGFz9QFrAglBWagxjdcj2f+ELyERs46y
 oRAVuXrd4RMNSJtPEzHBuTplTqtuaK1vPQTKjRE7ETuPWNmf5rWC7O5pexxpmJVUsE7d
 /zYuF4diYsJ5cii8DQYgWSUE6Gtkhz7AG8vuryLOTO4vFsoqDpnBEuyatIrB3tx87WnJ Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1tg2nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:38 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77fcfj023759;
 Tue, 7 Nov 2023 07:41:38 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1tg2mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A767blJ016950; Tue, 7 Nov 2023 07:41:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301phwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A77fWfP23397100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 07:41:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF44C58055;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC3D158043;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: by gfwr516.rchland.ibm.com (Postfix, from userid 607334)
 id 431CC220040; Tue,  7 Nov 2023 01:41:32 -0600 (CST)
From: Chalapathi V <chalap1@gfwr516.rchland.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com, Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PATCH v4 2/3] hw/ppc: Add nest1 chiplet model
Date: Tue,  7 Nov 2023 01:41:26 -0600
Message-Id: <20231107074127.31821-3-chalap1@gfwr516.rchland.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m1BaXaJQwFJECaDOW4ARNaBkbPSY0HH1
X-Proofpoint-ORIG-GUID: JNzXzCnhTZz8_mSOKTxEanDmtsuRjdB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070062
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

The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
The nest1 chiplet consists of PowerBus Fabric controller,
nest Memory Management Unit, chiplet control unit and more.

This commit creates a nest1 chiplet model and initialize and realize the
pervasive chiplet model where chiplet control registers are implemented.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/meson.build                |  1 +
 hw/ppc/pnv_nest1_chiplet.c        | 94 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_nest_chiplet.h | 41 +++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index c80d2f6..4e45e5c 100644
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
index 0000000..e078076
--- /dev/null
+++ b/hw/ppc/pnv_nest1_chiplet.c
@@ -0,0 +1,94 @@
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
+static void pnv_nest1_chiplet_realize(DeviceState *dev, Error **errp)
+{
+    PnvNest1Chiplet *nest1_chiplet = PNV_NEST1CHIPLET(dev);
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
+    g_autofree char *name = NULL;
+    int nest1_chiplet_offset;
+    const char compat[] = "ibm,power10-nest1-chiplet";
+
+    name = g_strdup_printf("nest1_chiplet@%x",
+                           PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
+    nest1_chiplet_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(nest1_chiplet_offset);
+
+    _FDT(fdt_setprop(fdt, nest1_chiplet_offset, "compatible",
+                            compat, sizeof(compat)));
+    return 0;
+}
+
+static void pnv_nest1_dt_populate(void *fdt)
+{
+
+    uint32_t nest1_base = cpu_to_be32(PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE);
+    pnv_perv_dt(nest1_base, fdt, 0);
+}
+
+static void pnv_nest1_chiplet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvNest1Class *nest1_class = PNV_NEST1CHIPLET_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_nest1_chiplet_dt_xscom;
+
+    dc->desc = "PowerNV nest1 chiplet";
+    dc->realize = pnv_nest1_chiplet_realize;
+    nest1_class->nest1_dt_populate = pnv_nest1_dt_populate;
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
index 0000000..12525d3
--- /dev/null
+++ b/include/hw/ppc/pnv_nest_chiplet.h
@@ -0,0 +1,41 @@
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
+#define TYPE_PNV_NEST1_CHIPLET "pnv-nest1-chiplet"
+typedef struct PnvNest1Class PnvNest1Class;
+typedef struct PnvNest1Chiplet PnvNest1Chiplet;
+DECLARE_OBJ_CHECKERS(PnvNest1Chiplet, PnvNest1Class,
+                     PNV_NEST1CHIPLET, TYPE_PNV_NEST1_CHIPLET)
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
+struct PnvNest1Class {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+
+    void (*nest1_dt_populate)(void *fdt);
+};
+
+#endif /*PPC_PNV_NEST1_CHIPLET_H */
-- 
1.8.3.1


