Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B77E4EAC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0XZy-0008Dk-LI; Tue, 07 Nov 2023 20:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1r0XZw-0008CX-J9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:42:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1r0XZt-0005pu-Ti
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:42:00 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxNuhi50plZeM3AA--.56170S3;
 Wed, 08 Nov 2023 09:41:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9xR50pl9qo7AA--.63823S9; 
 Wed, 08 Nov 2023 09:41:54 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 7/9] target/loongarch: Implement kvm_arch_handle_exit
Date: Wed,  8 Nov 2023 09:41:39 +0800
Message-Id: <20231108014141.2590657-8-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231108014141.2590657-1-lixianglai@loongson.cn>
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9xR50pl9qo7AA--.63823S9
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

Implement kvm_arch_handle_exit for loongarch. In this
function, the KVM_EXIT_LOONGARCH_IOCSR is handled,
we read or write the iocsr address space by the addr,
length and is_write argument in kvm_run.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/kvm.c        | 24 +++++++++++++++++++++++-
 target/loongarch/trace-events |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
index 85e7aeb083..d2dab3fef4 100644
--- a/target/loongarch/kvm.c
+++ b/target/loongarch/kvm.c
@@ -723,7 +723,29 @@ bool kvm_arch_cpu_check_are_resettable(void)
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
-    return 0;
+    int ret = 0;
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+    MemTxAttrs attrs = {};
+
+    attrs.requester_id = env_cpu(env)->cpu_index;
+
+    trace_kvm_arch_handle_exit(run->exit_reason);
+    switch (run->exit_reason) {
+    case KVM_EXIT_LOONGARCH_IOCSR:
+        address_space_rw(&env->address_space_iocsr,
+                         run->iocsr_io.phys_addr,
+                         attrs,
+                         run->iocsr_io.data,
+                         run->iocsr_io.len,
+                         run->iocsr_io.is_write);
+        break;
+    default:
+        ret = -1;
+        warn_report("KVM: unknown exit reason %d", run->exit_reason);
+        break;
+    }
+    return ret;
 }
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
index 937c3c7c0c..021839880e 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -11,3 +11,4 @@ kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
 kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
 kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
 kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
+kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
-- 
2.39.1


