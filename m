Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C66804366
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:29:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJIn-0001BA-2T; Mon, 04 Dec 2023 19:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJIh-0001AF-QO
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:28:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJIg-0001Bq-3N
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:28:35 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B508b96009511; Tue, 5 Dec 2023 00:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=vJGWJpqaoGkncz2LdiHua+5A37UysX7gJKYAnyBVjcw=;
 b=JXBvaJh0fl9LezOHjLin5ulwxM0JkS5iPmNP7+5ZQTliIwRhVkvZT7CDmWqcYnZKHRpB
 mzm6Tzx4mPLWSUgFX1CayujJPppFRne8n20f9sTYpgxKtbdzEm8ZHvDoh8ggCgJSuc9i
 hWIXrATyTOiY1qvSRGDfWT1kFG2EKY0XkSMYbCQoMwy9QSPdQk/MClwfHea2AmTXc9X6
 bZSjalBNc9zNTRkqnFRRfwfH5EGygJFgU+UOptio0X6TvuJzoDqcvk4WDoPkJPGMvIHe
 my0/Col59TiIwA2YaIXb0wei1VPvT6d6qx1KWdGco12yx7EGpgi693/9ardZUOBlPxl4 wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uss2cg13n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:28:31 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIWKD004832; Tue, 5 Dec 2023 00:28:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16ddw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:28:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50SUln017577;
 Tue, 5 Dec 2023 00:28:30 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16ddv1-1; Tue, 05 Dec 2023 00:28:30 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 06/11] acpi: Send the GPE event of suspend and wakeup for
 x86
Date: Tue,  5 Dec 2023 00:28:15 +0000
Message-Id: <20231205002815.1456-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <20231205002143.562-1-annie.li@oracle.com>
References: <20231205002143.562-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_23,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=949 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050003
X-Proofpoint-GUID: upvkkgaQ_a1q9WmYjgWRyyeeYDf7gZar
X-Proofpoint-ORIG-GUID: upvkkgaQ_a1q9WmYjgWRyyeeYDf7gZar
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

The GPE event is triggered to notify the guest to suspend or
wakeup itself. This patch removes the previous implementation
of QEMU_WAKEUP_REASON_OTHER pretending the resume was caused
by power button.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/core.c                       | 17 +++++++++++++----
 hw/core/machine-qmp-cmds.c           |  2 ++
 include/hw/acpi/acpi.h               |  1 +
 include/hw/acpi/acpi_dev_interface.h |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ec5e127d17..e5c3ff9a54 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -354,6 +354,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
     return -1;
 }
 
+void acpi_send_sleep_wakeup_event(void)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+
+    if (obj) {
+        /* Send _GPE.L07 event */
+        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
+    }
+}
+
 static void acpi_notify_wakeup(Notifier *notifier, void *data)
 {
     ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
@@ -369,10 +379,9 @@ static void acpi_notify_wakeup(Notifier *notifier, void *data)
             (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_TIMER_STATUS);
         break;
     case QEMU_WAKEUP_REASON_OTHER:
-        /* ACPI_BITMASK_WAKE_STATUS should be set on resume.
-           Pretend that resume was caused by power button */
-        ar->pm1.evt.sts |=
-            (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_POWER_BUTTON_STATUS);
+        /* ACPI_BITMASK_WAKE_STATUS should be set on resume. */
+        ar->pm1.evt.sts |= ACPI_BITMASK_WAKE_STATUS;
+        acpi_send_sleep_wakeup_event();
         break;
     default:
         break;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9f1e636c90..d51802214b 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/acpi.h"
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
@@ -264,6 +265,7 @@ void qmp_system_sleep(Error **errp)
                    "suspend from running is not supported by this guest");
         return;
     }
+    acpi_send_sleep_wakeup_event();
 }
 
 void qmp_system_powerdown(Error **errp)
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index e0e51e85b4..07e31aa138 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -181,6 +181,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
 
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status);
+void acpi_send_sleep_wakeup_event(void);
 
 void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
 
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..1cb050cd3a 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_SLEEP_STATUS = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
-- 
2.34.3


