Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A8804357
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:26:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJGT-0007Qw-W7; Mon, 04 Dec 2023 19:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJGQ-0007QZ-K4
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:26:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJGO-0000hd-WC
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:26:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B503dqN007441; Tue, 5 Dec 2023 00:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=to5ibbp6gAN/HwF6WWVXndYPBAr+vJG5Ff7IzVdx5iM=;
 b=VtTFiBjyeK38k+sAtUdfgPPH1QxtxohmclrZ43bi1RFp7OhJPFgURQof7+2BQG83B/hn
 vOSKUZnCoPYsw50L7GWRwjQdXavxYZebkCmArwzonc5hk0s3odg54Qo3wPpJzydYybok
 e19jGz+lw6+vd0qJtMHCSOHO0rBixQLiY4M6ZYhimpaa+h1DFdxXpJOrRKQO3QL20m2b
 h/yGCwnb2LKjDf5a0WpUuxLDomoMSxhhAK0hVxLH1gm2MgHW3TtCZpX08iiLj+6jKBFU
 R8oJz+/txLdKTS+3LigQSTRBlZj3Vo+ONfo30Y7dUggUqxRXPsCopXvvR9kOvsyASyrN 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usrvcg13w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:26:11 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIrVB018494; Tue, 5 Dec 2023 00:26:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16knn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:26:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50QANS027632;
 Tue, 5 Dec 2023 00:26:10 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16knm1-1; Tue, 05 Dec 2023 00:26:09 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 02/11] acpi: Implement control method sleep button
Date: Tue,  5 Dec 2023 00:26:03 +0000
Message-Id: <20231205002603.545-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <20231205002143.562-1-annie.li@oracle.com>
References: <20231205002143.562-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_23,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050002
X-Proofpoint-GUID: Mf7td2tHTFE0nU2RFK2ZAGa40ecyol6F
X-Proofpoint-ORIG-GUID: Mf7td2tHTFE0nU2RFK2ZAGa40ecyol6F
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The control method sleep button is added, as well as its GPE event
handler.

Co-Developed-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/control_method_device.c         | 49 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 20 ++++++++++
 3 files changed, 70 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
new file mode 100644
index 0000000000..9e4841b8e2
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,49 @@
+/*
+ * Control method devices
+ *
+ * Copyright (C) 2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/control_method_device.h"
+#include "hw/mem/nvdimm.h"
+
+void acpi_dsdt_add_sleep_button(Aml *scope)
+{
+    Aml *dev = aml_device("\\_SB."ACPI_SLEEP_BUTTON_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
+    Aml *pkg = aml_package(2);
+    aml_append(pkg, aml_int(0x01));
+    aml_append(pkg, aml_int(0x04));
+    aml_append(dev, aml_name_decl("_PRW", pkg));
+    aml_append(dev, aml_operation_region("\\Boo", AML_SYSTEM_IO,
+                                         aml_int(0x201), 0x1));
+    Aml *field = aml_field("\\Boo", AML_BYTE_ACC, AML_NOLOCK,
+                           AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("SBP", 1));
+    aml_append(field, aml_named_field("SBW", 1));
+    aml_append(dev, field);
+    aml_append(scope, dev);
+}
+
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope)
+{
+     Aml *method = aml_method("_L07", 0, AML_NOTSERIALIZED);
+     Aml *condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
+     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));
+     aml_append(condition,
+                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x80)));
+     aml_append(method, condition);
+     condition = aml_if(aml_name("\\_SB.SLPB.SBW"));
+     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBW")));
+     aml_append(condition,
+                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x2)));
+     aml_append(method, condition);
+     aml_append(scope, method);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fc1b952379..486d28cf42 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -16,6 +16,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
new file mode 100644
index 0000000000..bce20512c4
--- /dev/null
+++ b/include/hw/acpi/control_method_device.h
@@ -0,0 +1,20 @@
+/*
+ * Control method devices
+ *
+ * Copyright (C) 2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+
+#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
+#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
+
+#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
+
+void acpi_dsdt_add_sleep_button(Aml *scope);
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope);
+
+#endif
-- 
2.34.3


