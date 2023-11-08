Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD87E4EAA
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0XZw-0008CP-TR; Tue, 07 Nov 2023 20:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1r0XZt-00089o-Lq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1r0XZq-0005pJ-Sv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:57 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXetb50plT+M3AA--.39423S3;
 Wed, 08 Nov 2023 09:41:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9xR50pl9qo7AA--.63823S4; 
 Wed, 08 Nov 2023 09:41:47 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 2/9] target/loongarch: Define some kvm_arch interfaces
Date: Wed,  8 Nov 2023 09:41:34 +0800
Message-Id: <20231108014141.2590657-3-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231108014141.2590657-1-lixianglai@loongson.cn>
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9xR50pl9qo7AA--.63823S4
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Define some functions in target/loongarch/kvm.c, such as
kvm_arch_put_registers, kvm_arch_get_registers and
kvm_arch_handle_exit, etc. which are needed by kvm/kvm-all.c.
Now the most functions has no content and they will be
implemented in the next patches.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/kvm.c | 131 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 target/loongarch/kvm.c

diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
new file mode 100644
index 0000000000..0d67322fd9
--- /dev/null
+++ b/target/loongarch/kvm.c
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch KVM
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/kvm.h>
+
+#include "qemu/timer.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
+#include "sysemu/kvm_int.h"
+#include "hw/pci/pci.h"
+#include "exec/memattrs.h"
+#include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "hw/irq.h"
+#include "qemu/log.h"
+#include "hw/loader.h"
+#include "migration/migration.h"
+#include "sysemu/runstate.h"
+#include "cpu-csr.h"
+#include "kvm_loongarch.h"
+
+static bool cap_has_mp_state;
+const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
+    KVM_CAP_LAST_INFO
+};
+
+int kvm_arch_get_registers(CPUState *cs)
+{
+    return 0;
+}
+int kvm_arch_put_registers(CPUState *cs, int level)
+{
+    return 0;
+}
+
+int kvm_arch_init_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
+unsigned long kvm_arch_vcpu_id(CPUState *cs)
+{
+    return cs->cpu_index;
+}
+
+int kvm_arch_release_virq_post(int virq)
+{
+    return 0;
+}
+
+int kvm_arch_msi_data_to_gsi(uint32_t data)
+{
+    abort();
+}
+
+int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
+                             uint64_t address, uint32_t data, PCIDevice *dev)
+{
+    return 0;
+}
+
+int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
+                                int vector, PCIDevice *dev)
+{
+    return 0;
+}
+
+void kvm_arch_init_irq_routing(KVMState *s)
+{
+}
+
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
+int kvm_arch_init(MachineState *ms, KVMState *s)
+{
+    return 0;
+}
+
+int kvm_arch_irqchip_create(KVMState *s)
+{
+    return 0;
+}
+
+void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
+{
+}
+
+MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
+{
+    return MEMTXATTRS_UNSPECIFIED;
+}
+
+int kvm_arch_process_async_events(CPUState *cs)
+{
+    return cs->halted;
+}
+
+bool kvm_arch_stop_on_emulation_error(CPUState *cs)
+{
+    return true;
+}
+
+bool kvm_arch_cpu_check_are_resettable(void)
+{
+    return true;
+}
+
+int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
+{
+    return 0;
+}
+
+void kvm_arch_accel_class_init(ObjectClass *oc)
+{
+}
-- 
2.39.1


