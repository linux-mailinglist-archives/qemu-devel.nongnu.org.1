Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED080F3A4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:53:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5zY-0007ZC-4K; Tue, 12 Dec 2023 11:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.young@oracle.com>)
 id 1rD5zH-0007Yq-2J
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:52:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.young@oracle.com>)
 id 1rD5zB-0000wV-KR
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:52:02 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BCDipSd001504; Tue, 12 Dec 2023 16:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=eFr0HYurBKNIBssjjjVDjua1m6XV0DrqXiP4hDDwNKs=;
 b=DiR88T8YlbB6/cojEobTVkTj9XIqVDlpJQAKiO6iPZ+ggXRaCwPtrnoNsNsB7TZtiQce
 gt/JsyjCs/or0YvjvzFf1tcPvRi09F1021vu3p4x2w+5wTF+ErgovRJDt9PuzcCk/qT4
 QFhLgkhYMSxIAM6Dy/VY6PYX4pHzNyRtrshrIZ4rIeVXT+6NGUwqNbSzz18thiTmB5np
 ZtR4a5lgptYzGmKPzFadOOjcIixeCIc0I3wWxjKaCOhhdL243Q59mvbqo2SOMYXyPTi1
 IhC8m2KwlBXJrsJNTqa5ZiudmPtw8eeTFOLhTj89YzkIxcAYqd2ECXpwZkR+8j4R4N7L uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu262km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Dec 2023 16:51:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BCFlkr9018632; Tue, 12 Dec 2023 16:51:52 GMT
Received: from lobi7.us.oracle.com (dhcp-10-65-129-96.vpn.oracle.com
 [10.65.129.96])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3uvep6ugth-1; Tue, 12 Dec 2023 16:51:52 +0000
From: Aaron Young <Aaron.Young@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com
Subject: [PATCH] hw/acpi: propagate vcpu hotplug after switch to modern
 interface
Date: Tue, 12 Dec 2023 08:51:43 -0800
Message-Id: <0e8a9baebbb29f2a6c87fd08e43dc2ac4019759a.1702398644.git.Aaron.Young@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1702398644.git.Aaron.Young@oracle.com>
References: <cover.1702398644.git.Aaron.Young@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120130
X-Proofpoint-ORIG-GUID: dmD_qm5PCNPlPtX1c6ft8l4HJgT2-Bts
X-Proofpoint-GUID: dmD_qm5PCNPlPtX1c6ft8l4HJgT2-Bts
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=aaron.young@oracle.com; helo=mx0a-00069f02.pphosted.com
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

If a vcpu with an apic-id that is not supported by the legacy
interface (>255) is hot-plugged, the legacy code will dynamically switch
to the modern interface. However, the hotplug event is not forwarded to
the new interface resulting in the vcpu not being fully/properly added
to the machine config. This BUG is evidenced by OVMF when it
it attempts to count the vcpus and reports an inconsistent vcpu count
reported by the fw_cfg interface and the modern hotpug interface.

Fix is to propagate the hotplug event after making the switch from
the legacy interface to the modern interface.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Aaron Young <aaron.young@oracle.com>
---
 hw/acpi/cpu_hotplug.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 634bbec..6f78db0 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -59,7 +59,8 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
     },
 };
 
-static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
+static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
+                                     bool *swtchd_to_modern)
 {
     CPUClass *k = CPU_GET_CLASS(cpu);
     int64_t cpu_id;
@@ -68,23 +69,34 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
     if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
         object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
+        *swtchd_to_modern = true;
         return;
     }
 
+    *swtchd_to_modern = false;
     g->sts[cpu_id / 8] |= (1 << (cpu_id % 8));
 }
 
 void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
 {
-    acpi_set_cpu_present_bit(g, CPU(dev));
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    bool swtchd_to_modern;
+    Error *local_err = NULL;
+
+    acpi_set_cpu_present_bit(g, CPU(dev), &swtchd_to_modern);
+    if (swtchd_to_modern) {
+        /* propagate the hotplug to the modern interface */
+        hotplug_handler_plug(hotplug_dev, dev, &local_err);
+    } else {
+        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    }
 }
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
                                   AcpiCpuHotplug *gpe_cpu, uint16_t base)
 {
     CPUState *cpu;
+    bool swtchd_to_modern;
 
     memory_region_init_io(&gpe_cpu->io, owner, &AcpiCpuHotplug_ops,
                           gpe_cpu, "acpi-cpu-hotplug", ACPI_GPE_PROC_LEN);
@@ -92,7 +104,7 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     gpe_cpu->device = owner;
 
     CPU_FOREACH(cpu) {
-        acpi_set_cpu_present_bit(gpe_cpu, cpu);
+        acpi_set_cpu_present_bit(gpe_cpu, cpu, &swtchd_to_modern);
     }
 }
 
-- 
1.8.3.1


