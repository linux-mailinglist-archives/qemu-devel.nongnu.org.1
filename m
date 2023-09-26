Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423097AEA0C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql529-0007c4-5x; Tue, 26 Sep 2023 06:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql525-0007DA-1y; Tue, 26 Sep 2023 06:11:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql520-0004v6-Lk; Tue, 26 Sep 2023 06:11:08 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwSB4340z6D8bS;
 Tue, 26 Sep 2023 18:08:42 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:10:43 +0100
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
Subject: [PATCH RFC V2 18/37] arm/virt: Make ARM vCPU *present* status ACPI
 *persistent*
Date: Tue, 26 Sep 2023 11:04:17 +0100
Message-ID: <20230926100436.28284-19-salil.mehta@huawei.com>
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

ARM arch does not allow CPUs presence to be changed [1] after kernel has booted.
Hence, firmware/ACPI/Qemu must ensure persistent view of the vCPUs to the Guest
kernel even when they are not present in the QoM i.e. are unplugged or are
yet-to-be-plugged

References:
[1] Check comment 5 in the bugzilla entry
   Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpus-common.c         |  6 ++++++
 hw/arm/virt.c         |  7 +++++++
 include/hw/core/cpu.h | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 24c04199a1..d64aa63b19 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -128,6 +128,12 @@ bool qemu_enabled_cpu(CPUState *cpu)
     return cpu && !cpu->disabled;
 }
 
+bool qemu_persistent_cpu(CPUState *cpu)
+{
+    /* cpu state can be faked to the guest via acpi */
+    return cpu->acpi_persistent;
+}
+
 uint64_t qemu_get_cpu_archid(int cpu_index)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cbb6199ec6..f1bee569d5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3006,6 +3006,13 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
     virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
+
+    /*
+     * To give persistent presence view of vCPUs to the guest, ACPI might need
+     * to fake the presence of the vCPUs to the guest but keep them disabled.
+     * This shall be used during the init of ACPI Hotplug state and hot-unplug
+     */
+     cs->acpi_persistent = true;
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b2201a98ee..dab572c9bd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -425,6 +425,13 @@ struct CPUState {
      * By default every CPUState is enabled as of now across all archs.
      */
     bool disabled;
+    /*
+     * On certain architectures, to give persistent view of the 'presence' of
+     * vCPUs to the guest, ACPI might need to fake the 'presence' of the vCPUs
+     * but keep them ACPI disabled to the guest. This is done by returning
+     * _STA.PRES=True and _STA.Ena=False for the unplugged vCPUs in QEMU QoM.
+     */
+    bool acpi_persistent;
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
@@ -814,6 +821,19 @@ bool qemu_present_cpu(CPUState *cpu);
  */
 bool qemu_enabled_cpu(CPUState *cpu);
 
+/**
+ * qemu_persistent_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU state should always be reflected as *present* via ACPI
+ * to the Guest. By default, this is False on all architectures and has to be
+ * explicity set during initialization.
+ *
+ * Returns: True if it is ACPI 'persistent' CPU
+ *
+ */
+bool qemu_persistent_cpu(CPUState *cpu);
+
 /**
  * qemu_get_cpu_archid:
  * @cpu_index: possible vCPU for which arch-id needs to be retreived
-- 
2.34.1


