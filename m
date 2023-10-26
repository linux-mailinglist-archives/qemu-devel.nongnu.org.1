Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DC7D8705
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3Yp-0006nn-J9; Thu, 26 Oct 2023 12:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3Ya-0006TV-4r; Thu, 26 Oct 2023 12:50:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qw3YX-000893-7i; Thu, 26 Oct 2023 12:50:03 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QGfJgU016098; Thu, 26 Oct 2023 16:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K00Dlx2uJPJAwsDtp7bY4JE+xgry1yNmf64QCGv1nAk=;
 b=G8MXM4rjI7JCGaftXRIG+LpFdO2mvQ31dU/4Lx2tknmgjs1OYpfLdbaAA4Ni+9sQaayJ
 nq0A8ENwmXhyG2sSAmb4m7KR/9h0Wt5LHFJRDMny23XVhLO3oaHcEuUIbPoKj2yZAn9Y
 kkXcPmFXn+rXx9ivT4XRg5dD0cg8152MIJiNp8YzF17tJSK0gI+aYwoxYtP79jLFCSyP
 IAPEyq57y/FwhuIbYEaPIZgi6LWyi8MZLW4+ujm0oUcorZsNU8pUjsMEUXbhASMPSj73
 WdLFPgF8L/mEO/JNyf7IQ/iCYTmed2A3pguWXYLmpv/MAT0nggpbOIA11j439AVskBeU 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyu2g9mkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:49:41 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QGfHGN015869;
 Thu, 26 Oct 2023 16:49:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyu2g9mfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:49:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QGlP5F010290; Thu, 26 Oct 2023 16:47:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyymra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 16:47:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QGln8P15205106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 16:47:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E6F058059;
 Thu, 26 Oct 2023 16:47:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64BF758043;
 Thu, 26 Oct 2023 16:47:48 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 16:47:48 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v7 05/10] hw/fsi: IBM's On-chip Peripheral Bus
Date: Thu, 26 Oct 2023 11:47:36 -0500
Message-Id: <20231026164741.1184058-6-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026164741.1184058-1-ninad@linux.ibm.com>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QJuGjiBJE3qovFx6PTDkpHOvbipQ5IIr
X-Proofpoint-GUID: vAb3HWs_S4w-zVas8yzax3CcuTbyseXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_15,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=902 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

This is a part of patchset where IBM's Flexible Service Interface is
introduced.

The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
POWER processors. This now makes an appearance in the ASPEED SoC due
to tight integration of the FSI master IP with the OPB, mainly the
existence of an MMIO-mapping of the CFAM address straight onto a
sub-region of the OPB address space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v2:
- Incorporated review comment by Joel.
v5:
- Incorporated review comments by Cedric.
v6:
- Incorporated review comments by Cedric & Daniel
v7:
- Incorporated review comments by Cedric.
---
 include/hw/fsi/opb.h | 33 ++++++++++++++++++++
 hw/fsi/fsi-master.c  |  3 +-
 hw/fsi/opb.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++
 hw/fsi/Kconfig       |  4 +++
 hw/fsi/meson.build   |  1 +
 5 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/fsi/opb.h
 create mode 100644 hw/fsi/opb.c

diff --git a/include/hw/fsi/opb.h b/include/hw/fsi/opb.h
new file mode 100644
index 0000000000..8b71bb55c2
--- /dev/null
+++ b/include/hw/fsi/opb.h
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-Chip Peripheral Bus
+ */
+#ifndef FSI_OPB_H
+#define FSI_OPB_H
+
+#include "exec/memory.h"
+#include "hw/fsi/fsi-master.h"
+
+#define TYPE_OP_BUS "opb"
+OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
+
+typedef struct OPBus {
+        /*< private >*/
+        BusState bus;
+
+        /*< public >*/
+        MemoryRegion mr;
+        AddressSpace as;
+
+        /* Model OPB as dumb enough just to provide an address-space */
+        /* TODO: Maybe don't store device state in the bus? */
+        FSIMasterState fsi;
+} OPBus;
+
+typedef struct OPBusClass {
+        BusClass parent_class;
+} OPBusClass;
+
+#endif /* FSI_OPB_H */
diff --git a/hw/fsi/fsi-master.c b/hw/fsi/fsi-master.c
index bb7a893003..ec092b42ea 100644
--- a/hw/fsi/fsi-master.c
+++ b/hw/fsi/fsi-master.c
@@ -11,8 +11,7 @@
 #include "trace.h"
 
 #include "hw/fsi/fsi-master.h"
-
-#define TYPE_OP_BUS "opb"
+#include "hw/fsi/opb.h"
 
 #define TO_REG(x)                               ((x) >> 2)
 
diff --git a/hw/fsi/opb.c b/hw/fsi/opb.c
new file mode 100644
index 0000000000..04771b4b27
--- /dev/null
+++ b/hw/fsi/opb.c
@@ -0,0 +1,74 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2023 IBM Corp.
+ *
+ * IBM On-chip Peripheral Bus
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/log.h"
+
+#include "hw/fsi/opb.h"
+
+static void fsi_opb_realize(BusState *bus, Error **errp)
+{
+    OPBus *opb = OP_BUS(bus);
+
+    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
+                          NULL, UINT32_MAX);
+    address_space_init(&opb->as, &opb->mr, "opb");
+
+    if (!object_property_set_bool(OBJECT(&opb->fsi), "realized", true, errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&opb->mr, 0x80000000, &opb->fsi.iomem);
+
+    /* OPB2FSI region */
+    /*
+     * Avoid endianness issues by mapping each slave's memory region directly.
+     * Manually bridging multiple address-spaces causes endian swapping
+     * headaches as memory_region_dispatch_read() and
+     * memory_region_dispatch_write() correct the endianness based on the
+     * target machine endianness and not relative to the device endianness on
+     * either side of the bridge.
+     */
+    /*
+     * XXX: This is a bit hairy and will need to be fixed when I sort out the
+     * bus/slave relationship and any changes to the CFAM modelling (multiple
+     * slaves, LBUS)
+     */
+    memory_region_add_subregion(&opb->mr, 0xa0000000, &opb->fsi.opb2fsi);
+}
+
+static void fsi_opb_init(Object *o)
+{
+    OPBus *opb = OP_BUS(o);
+
+    object_initialize_child(o, "fsi-master", &opb->fsi, TYPE_FSI_MASTER);
+    qdev_set_parent_bus(DEVICE(&opb->fsi), BUS(o), &error_abort);
+}
+
+static void fsi_opb_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *bc = BUS_CLASS(klass);
+    bc->realize = fsi_opb_realize;
+}
+
+static const TypeInfo opb_info = {
+    .name = TYPE_OP_BUS,
+    .parent = TYPE_BUS,
+    .instance_init = fsi_opb_init,
+    .instance_size = sizeof(OPBus),
+    .class_init = fsi_opb_class_init,
+    .class_size = sizeof(OPBusClass),
+};
+
+static void fsi_opb_register_types(void)
+{
+    type_register_static(&opb_info);
+}
+
+type_init(fsi_opb_register_types);
diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
index 8d712e77ed..0f6e6d331a 100644
--- a/hw/fsi/Kconfig
+++ b/hw/fsi/Kconfig
@@ -1,3 +1,7 @@
+config FSI_OPB
+    bool
+    select FSI_CFAM
+
 config FSI_CFAM
     bool
     select FSI
diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
index f617943b4a..407b8c2775 100644
--- a/hw/fsi/meson.build
+++ b/hw/fsi/meson.build
@@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
 system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
 system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
 system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
+system_ss.add(when: 'CONFIG_FSI_OPB', if_true: files('opb.c'))
-- 
2.39.2


