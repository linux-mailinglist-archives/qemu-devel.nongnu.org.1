Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF52804378
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:35:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJOb-0004U5-QX; Mon, 04 Dec 2023 19:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJOa-0004TF-Fl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:34:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJOY-000206-MR
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:34:40 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B50YZXf024891; Tue, 5 Dec 2023 00:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=KmUIUjtXb1n+ltDZCqSdX4Qg0PXpmKV/JTMCdf5AzMk=;
 b=YWvGYi8b+cT6ahDUAsJDUe0dEa/tRapuJlzGYHgiZEjmIsEbda/PkMoSUdWukMSnTG5f
 exQGjivhEJzSpojOYBMlO9oELr7c2+G1B1xrX3mEGBUxFSg3l0tJUxwY7/KAuuCtLzVc
 onx6sD0f7QSd3011ft8FMqV5ldluFpQdXDVf/BBMpmfsZGKxV+hF6mzW2oMZ/SUqHoge
 bHgQRuuNKKPJ5dzpqBCnoFeES3+1LV5JKwmGEpi2FO4fhzRpENGCajDy/kbHbsjpR3/B
 Yr1xhKzT8Ecs74IA8j/bFNkEMxkuK9H6n1Kx2I1voCS+JXC6x7pQsMDgIzea/rsrBWKv 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usrvc00y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:34:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIYYu004946; Tue, 5 Dec 2023 00:30:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16df21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:30:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50U19W021214;
 Tue, 5 Dec 2023 00:30:01 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16df01-1; Tue, 05 Dec 2023 00:30:01 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 09/11] hw/arm: enable sleep support for arm/virt
Date: Tue,  5 Dec 2023 00:29:55 +0000
Message-Id: <20231205002955.367-1-annie.li@oracle.com>
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
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050003
X-Proofpoint-GUID: 8rZNSSwtpuvMi0WGUJTkPY54a2A-HdCo
X-Proofpoint-ORIG-GUID: 8rZNSSwtpuvMi0WGUJTkPY54a2A-HdCo
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

From: Miguel Luis <miguel.luis@oracle.com>

Include the ACPI control method device into arm/virt ACPI tables and the
corresponding handling which enables triggering the event.

Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/arm/virt-acpi-build.c | 13 +++++++++++++
 hw/arm/virt.c            | 13 ++++++++++++-
 include/hw/arm/virt.h    |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bc35a483c..15e00cc5dc 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -42,6 +42,7 @@
 #include "hw/acpi/pci.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/acpi/control_method_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
 #include "hw/pci/pcie_host.h"
@@ -816,6 +817,17 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
         .rev = 6,
         .minor_ver = 0,
         .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
+        /* ACPI 5.0: 4.8.3.7 Sleep Control and Status Registers */
+        .sleep_ctl = {
+            .space_id = AML_AS_SYSTEM_MEMORY,
+            .bit_width = 8,
+            .address = vms->memmap[VIRT_ACPI_GED].base + ACPI_GED_REG_SLEEP_CTL,
+        },
+        .sleep_sts = {
+            .space_id = AML_AS_SYSTEM_MEMORY,
+            .bit_width = 8,
+            .address = vms->memmap[VIRT_ACPI_GED].base + ACPI_GED_REG_SLEEP_STS,
+        },
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
     };
 
@@ -890,6 +902,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    acpi_dsdt_add_sleep_button(scope);
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018..8b9a328360 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -644,7 +644,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_SLEEP_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -931,6 +931,14 @@ static void create_rtc(const VirtMachineState *vms)
     g_free(nodename);
 }
 
+static void virt_sleep_req(Notifier *n, void *opaque)
+{
+    VirtMachineState *s = container_of(n, VirtMachineState, sleep_notifier);
+
+    if (s->acpi_dev) {
+        acpi_send_event(s->acpi_dev, ACPI_SLEEP_STATUS);
+    }
+}
 static DeviceState *gpio_key_dev;
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
@@ -2299,6 +2307,9 @@ static void machvirt_init(MachineState *machine)
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
     }
 
+     /* connect sleep request */
+     vms->sleep_notifier.notify = virt_sleep_req;
+
      /* connect powerdown request */
      vms->powerdown_notifier.notify = virt_powerdown_req;
      qemu_register_powerdown_notifier(&vms->powerdown_notifier);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index f69239850e..82598c1879 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -170,6 +170,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    Notifier sleep_notifier;
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
-- 
2.34.3


