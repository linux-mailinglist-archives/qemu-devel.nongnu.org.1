Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874677E4EAB
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0XZy-0008Df-KX; Tue, 07 Nov 2023 20:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1r0XZv-0008Bt-8r
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1r0XZs-0005ps-A9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxbeti50plYOM3AA--.41865S3;
 Wed, 08 Nov 2023 09:41:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9xR50pl9qo7AA--.63823S8; 
 Wed, 08 Nov 2023 09:41:52 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 6/9] target/loongarch: Implement kvm_arch_init_vcpu
Date: Wed,  8 Nov 2023 09:41:38 +0800
Message-Id: <20231108014141.2590657-7-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231108014141.2590657-1-lixianglai@loongson.cn>
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9xR50pl9qo7AA--.63823S8
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

Implement kvm_arch_init_vcpu interface for loongarch,
in this function, we register VM change state handler.
And when VM state changes to running, the counter value
should be put into kvm to keep consistent with kvm,
and when state change to stop, counter value should be
refreshed from kvm.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.h        |  2 ++
 target/loongarch/kvm.c        | 23 +++++++++++++++++++++++
 target/loongarch/trace-events |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 2580dc26e1..49edf6b016 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -382,6 +382,8 @@ struct ArchCPU {
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
+    /* used by KVM_REG_LOONGARCH_COUNTER ioctl to access guest time counters */
+    uint64_t kvm_state_counter;
 };
 
 #define TYPE_LOONGARCH_CPU "loongarch-cpu"
diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
index 29944b9ef8..85e7aeb083 100644
--- a/target/loongarch/kvm.c
+++ b/target/loongarch/kvm.c
@@ -617,8 +617,31 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     return ret;
 }
 
+static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
+                                          RunState state)
+{
+    int ret;
+    CPUState *cs = opaque;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    if (running) {
+        ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_COUNTER,
+                              &cpu->kvm_state_counter);
+        if (ret < 0) {
+            trace_kvm_failed_put_counter(strerror(errno));
+        }
+    } else {
+        ret = kvm_get_one_reg(cs, KVM_REG_LOONGARCH_COUNTER,
+                              &cpu->kvm_state_counter);
+        if (ret < 0) {
+            trace_kvm_failed_get_counter(strerror(errno));
+        }
+    }
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
+    qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
     return 0;
 }
 
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
index 6827ab566a..937c3c7c0c 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -7,5 +7,7 @@ kvm_failed_get_fpu(const char *msg) "Failed to get fpu from KVM: %s"
 kvm_failed_put_fpu(const char *msg) "Failed to put fpu into KVM: %s"
 kvm_failed_get_mpstate(const char *msg) "Failed to get mp_state from KVM: %s"
 kvm_failed_put_mpstate(const char *msg) "Failed to put mp_state into KVM: %s"
+kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
+kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
 kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
 kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
-- 
2.39.1


