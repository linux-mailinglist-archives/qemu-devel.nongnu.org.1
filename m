Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720A995E16
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 05:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNIu-0002jt-9M; Tue, 08 Oct 2024 23:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNIq-0002h8-CF; Tue, 08 Oct 2024 23:23:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNIo-0004gY-Cc; Tue, 08 Oct 2024 23:23:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdWq5Wlyz6K998;
 Wed,  9 Oct 2024 11:23:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 693C6140A90;
 Wed,  9 Oct 2024 11:23:52 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:23:33 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 13/33] arm/virt: Init PMU at host for all possible vCPUs
Date: Wed, 9 Oct 2024 04:17:55 +0100
Message-ID: <20241009031815.250096-14-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PMU for all possible vCPUs must be initialized during VM initialization.
Refactor the existing code to accommodate possible vCPUs. This assumes that all
processors being used are identical. It is an architectural constraint of ARM
CPUs that all vCPUs MUST have identical feature sets, at least until the ARM
specification is updated to allow otherwise.

Past discussion for reference:
Link: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 9 +++++----
 include/hw/arm/virt.h | 1 +
 include/hw/core/cpu.h | 5 +++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e40e6c23e4..696e0a9f75 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2033,12 +2033,13 @@ static void finalize_gic_version(VirtMachineState *vms)
  */
 static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
 {
+    CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
     int max_cpus = MACHINE(vms)->smp.max_cpus;
-    bool aarch64, pmu, steal_time;
+    bool aarch64, steal_time;
     CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
-    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    vms->pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
     steal_time = object_property_get_bool(OBJECT(first_cpu),
                                           "kvm-steal-time", NULL);
 
@@ -2065,8 +2066,8 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
         }
 
-        CPU_FOREACH(cpu) {
-            if (pmu) {
+        CPU_FOREACH_POSSIBLE(cpu, possible_cpus) {
+            if (vms->pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
                     kvm_arm_pmu_set_irq(ARM_CPU(cpu), VIRTUAL_PMU_IRQ);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b5bfb75f71..98ce68eae1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -161,6 +161,7 @@ struct VirtMachineState {
     bool mte;
     bool dtb_randomness;
     bool second_ns_uart_present;
+    bool pmu;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bcc62fbf0c..fa6f1dbec9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -607,6 +607,11 @@ extern CPUTailQ cpus_queue;
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
     QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
 
+#define CPU_FOREACH_POSSIBLE(cpu, poslist) \
+    for (int iter = 0; \
+         iter < (poslist)->len && ((cpu) = (poslist)->cpus[iter].cpu, 1); \
+         iter++)
+
 extern __thread CPUState *current_cpu;
 
 /**
-- 
2.34.1


