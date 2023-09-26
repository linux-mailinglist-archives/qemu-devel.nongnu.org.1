Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A5C7AEA18
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql53X-0003kQ-9t; Tue, 26 Sep 2023 06:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql53V-0003ed-CP; Tue, 26 Sep 2023 06:12:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql53T-0005Aj-Mx; Tue, 26 Sep 2023 06:12:37 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwWC531Fz6K6h7;
 Tue, 26 Sep 2023 18:11:19 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:12:15 +0100
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
Subject: [PATCH RFC V2 23/37] arm/virt: Release objects for *disabled*
 possible vCPUs after init
Date: Tue, 26 Sep 2023 11:04:22 +0100
Message-ID: <20230926100436.28284-24-salil.mehta@huawei.com>
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

During machvirt_init(), QOM ARMCPU objects are also pre-created along with the
corresponding KVM vCPUs in the host for all possible vCPUs. This necessary
because of the architectural constraint, KVM restricts the deferred creation of
the KVM vCPUs and VGIC initialization/sizing after VM init. Hence, VGIC is
pre-sized with possible vCPUs.

After initialization of the machine is complete disabled possible KVM vCPUs are
then parked at the per-virt-machine list "kvm_parked_vcpus" and we release the
QOM ARMCPU objects for the disabled vCPUs. These shall be re-created at the time
when vCPU is hotplugged again. QOM ARMCPU object is then re-attached with
corresponding parked KVM vCPU.

Alternatively, we could've never released the QOM CPU objects and kept on
reusing. This approach might require some modifications of qdevice_add()
interface to get old ARMCPU object instead of creating a new one for the hotplug
request.

Each of the above approaches come with their own pros and cons. This prototype
uses the 1st approach.(suggestions are welcome!)

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f1bee569d5..3b068534a8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1965,6 +1965,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
 {
     CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
     int max_cpus = MACHINE(vms)->smp.max_cpus;
+    MachineState *ms = MACHINE(vms);
     bool aarch64, steal_time;
     CPUState *cpu;
     int n;
@@ -2025,6 +2026,37 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             }
         }
     }
+
+    if (kvm_enabled() || tcg_enabled()) {
+        for (n = 0; n < possible_cpus->len; n++) {
+            cpu = qemu_get_possible_cpu(n);
+
+            /*
+             * Now, GIC has been sized with possible CPUs and we dont require
+             * disabled vCPU objects to be represented in the QOM. Release the
+             * disabled ARMCPU objects earlier used during init for pre-sizing.
+             *
+             * We fake to the guest through ACPI about the presence(_STA.PRES=1)
+             * of these non-existent vCPUs at VMM/qemu and present these as
+             * disabled vCPUs(_STA.ENA=0) so that they cant be used. These vCPUs
+             * can be later added to the guest through hotplug exchanges when
+             * ARMCPU objects are created back again using 'device_add' QMP
+             * command.
+             */
+            /*
+             * RFC: Question: Other approach could've been to keep them forever
+             * and release it only once when qemu exits as part of finalize or
+             * when new vCPU is hotplugged. In the later old could be released
+             * for the newly created object for the same vCPU?
+             */
+            if (!qemu_enabled_cpu(cpu)) {
+                CPUArchId *cpu_slot;
+                cpu_slot = virt_find_cpu_slot(ms, cpu->cpu_index);
+                cpu_slot->cpu = NULL;
+                object_unref(OBJECT(cpu));
+            }
+        }
+    }
 }
 
 static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
-- 
2.34.1


