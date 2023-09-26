Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D739A7AE9EC
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4xW-0004RM-Cs; Tue, 26 Sep 2023 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4xH-0004Lh-A1; Tue, 26 Sep 2023 06:06:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4xD-00042c-PG; Tue, 26 Sep 2023 06:06:10 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwMl5nWwz6K8fg;
 Tue, 26 Sep 2023 18:04:51 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:05:47 +0100
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
Subject: [PATCH RFC V2 02/37] cpus-common: Add common CPU utility for possible
 vCPUs
Date: Tue, 26 Sep 2023 11:04:01 +0100
Message-ID: <20230926100436.28284-3-salil.mehta@huawei.com>
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

Adds various utility functions which might be required to fetch or check the
state of the possible vCPUs. This also introduces concept of *disabled* vCPUs,
which are part of the *possible* vCPUs but are not part of the *present* vCPU.
This state shall be used during machine init time to check the presence of
vcpus.

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpus-common.c         | 31 +++++++++++++++++++++++++
 include/hw/core/cpu.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 45c745ecf6..24c04199a1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
+#include "hw/boards.h"
 
 QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)
     cpu_list_generation_id++;
 }
 
+CPUState *qemu_get_possible_cpu(int index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    assert((index >= 0) && (index < possible_cpus->len));
+
+    return CPU(possible_cpus->cpus[index].cpu);
+}
+
+bool qemu_present_cpu(CPUState *cpu)
+{
+    return cpu;
+}
+
+bool qemu_enabled_cpu(CPUState *cpu)
+{
+    return cpu && !cpu->disabled;
+}
+
+uint64_t qemu_get_cpu_archid(int cpu_index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+
+    assert((cpu_index >= 0) && (cpu_index < possible_cpus->len));
+
+    return possible_cpus->cpus[cpu_index].arch_id;
+}
+
 CPUState *qemu_get_cpu(int index)
 {
     CPUState *cpu;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe87352..e5af79950c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -413,6 +413,17 @@ struct CPUState {
     SavedIOTLB saved_iotlb;
 #endif
 
+    /*
+     * Some architectures do not allow *presence* of vCPUs to be changed
+     * after guest has booted using information specified by VMM/firmware
+     * via ACPI MADT at the boot time. Thus to enable vCPU hotplug on these
+     * architectures possible vCPU can have CPUState object in 'disabled'
+     * state or can also not have CPUState object at all. This is possible
+     * when vCPU Hotplug is supported and vCPUs are 'yet-to-be-plugged' in
+     * the QOM or have been hot-unplugged.
+     * By default every CPUState is enabled as of now across all archs.
+     */
+    bool disabled;
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
@@ -770,6 +781,48 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
  */
 CPUState *qemu_get_cpu(int index);
 
+/**
+ * qemu_get_possible_cpu:
+ * @index: The CPUState@cpu_index value of the CPU to obtain.
+ *         Input index MUST be in range [0, Max Possible CPUs)
+ *
+ * If CPUState object exists,then it gets a CPU matching
+ * @index in the possible CPU array.
+ *
+ * Returns: The possible CPU or %NULL if CPU does not exist.
+ */
+CPUState *qemu_get_possible_cpu(int index);
+
+/**
+ * qemu_present_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU is amongst the present possible vcpus.
+ *
+ * Returns: True if it is present possible vCPU else false
+ */
+bool qemu_present_cpu(CPUState *cpu);
+
+/**
+ * qemu_enabled_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vCPU is enabled.
+ *
+ * Returns: True if it is 'enabled' else false
+ */
+bool qemu_enabled_cpu(CPUState *cpu);
+
+/**
+ * qemu_get_cpu_archid:
+ * @cpu_index: possible vCPU for which arch-id needs to be retreived
+ *
+ * Fetches the vCPU arch-id from the present possible vCPUs.
+ *
+ * Returns: arch-id of the possible vCPU
+ */
+uint64_t qemu_get_cpu_archid(int cpu_index);
+
 /**
  * cpu_exists:
  * @id: Guest-exposed CPU ID to lookup.
-- 
2.34.1


