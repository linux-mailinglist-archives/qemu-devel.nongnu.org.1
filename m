Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49087AE9FF
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql50k-0002Pf-6X; Tue, 26 Sep 2023 06:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql50W-000247-BM; Tue, 26 Sep 2023 06:09:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql50F-0004RX-2R; Tue, 26 Sep 2023 06:09:29 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwRL58wkz6K62x;
 Tue, 26 Sep 2023 18:07:58 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:08:54 +0100
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
Subject: [PATCH RFC V2 12/37] hw/acpi: Use qemu_present_cpu() API in ACPI CPU
 hotplug init
Date: Tue, 26 Sep 2023 11:04:11 +0100
Message-ID: <20230926100436.28284-13-salil.mehta@huawei.com>
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
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

ACPI CPU Hotplug code assumes a virtual CPU is unplugged if the CPUState object
is absent in the list of ths possible CPUs(CPUArchIdList *possible_cpus)
maintained on per-machine basis. Use the earlier introduced qemu_present_cpu()
API to check this state.

This change should have no bearing on the functionality of any architecture and
is mere a representational change.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/acpi/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 45defdc0e2..d5ba37b209 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -225,7 +225,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
     for (i = 0; i < id_list->len; i++) {
-        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
+        struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
+        if (qemu_present_cpu(cpu)) {
+            state->devs[i].cpu = cpu;
+        }
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
-- 
2.34.1


