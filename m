Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15957AEA20
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql55R-000055-Mp; Tue, 26 Sep 2023 06:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql55I-0008NI-72; Tue, 26 Sep 2023 06:14:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql55F-0005UM-AK; Tue, 26 Sep 2023 06:14:27 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwX24Jgfz6D8cB;
 Tue, 26 Sep 2023 18:12:02 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:14:04 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 29/37] arm/virt: Update the guest(via GED) about CPU
 hot-(un)plug events
Date: Tue, 26 Sep 2023 11:04:28 +0100
Message-ID: <20230926100436.28284-30-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926100436.28284-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

During any vCPU hot-(un)plug, running guest VM needs to be intimated about the
new vCPU being added or request the deletion of the vCPU which is already part
of the guest VM. This is done using the ACPI GED event which eventually gets
demultiplexed to a CPU hotplug event and further to specific hot-(un)plug event
of a particular vCPU.

This change adds the ACPI calls to the existing hot-(un)plug hooks to trigger
ACPI GED events from QEMU to guest VM.

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b447e86fb6..6f5ee4a1c6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3157,6 +3157,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     CPUState *cs = CPU(dev);
+    Error *local_err = NULL;
     CPUArchId *cpu_slot;
 
     /* insert the cold/hot-plugged vcpu in the slot */
@@ -3169,12 +3170,20 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * plugged, guest is also notified.
      */
     if (vms->acpi_dev) {
-        /* TODO: update acpi hotplug state. Send cpu hotplug event to guest */
+        HotplugHandlerClass *hhc;
+        /* update acpi hotplug state and send cpu hotplug event to guest */
+        hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
+        hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
+        if (local_err) {
+            goto fail;
+        }
         /* TODO: register cpu for reset & update F/W info for the next boot */
     }
 
     cs->disabled = false;
     return;
+fail:
+    error_propagate(errp, local_err);
 }
 
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
@@ -3182,8 +3191,10 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    HotplugHandlerClass *hhc;
     ARMCPU *cpu = ARM_CPU(dev);
     CPUState *cs = CPU(dev);
+    Error *local_err = NULL;
 
     if (!vms->acpi_dev || !dev->realized) {
         error_setg(errp, "GED does not exists or device is not realized!");
@@ -3202,9 +3213,16 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
         return;
     }
 
-    /* TODO: request cpu hotplug from guest */
+    /* request cpu hotplug from guest */
+    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
+    hhc->unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
+    if (local_err) {
+        goto fail;
+    }
 
     return;
+fail:
+    error_propagate(errp, local_err);
 }
 
 static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -3212,7 +3230,9 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
+    HotplugHandlerClass *hhc;
     CPUState *cs = CPU(dev);
+    Error *local_err = NULL;
     CPUArchId *cpu_slot;
 
     if (!vms->acpi_dev || !dev->realized) {
@@ -3222,7 +3242,12 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
 
-    /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
+    /* update the acpi cpu hotplug state for cpu hot-unplug */
+    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
+    hhc->unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
+    if (local_err) {
+        goto fail;
+    }
 
     unwire_gic_cpu_irqs(vms, cs);
     virt_update_gic(vms, cs);
@@ -3236,6 +3261,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     cs->disabled = true;
 
     return;
+fail:
+    error_propagate(errp, local_err);
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
-- 
2.34.1


