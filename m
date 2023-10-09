Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC37BD61F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:03:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmA5-0002Ka-Eh; Mon, 09 Oct 2023 05:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qpm9p-0002EW-Tb
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:02:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qpm9h-00061l-FQ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:02:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIvCYwSNlpD0wAA--.26324S3;
 Mon, 09 Oct 2023 17:02:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_y+TwSNlDW4cAA--.59991S9; 
 Mon, 09 Oct 2023 17:02:15 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH RFC v4 7/9] target/loongarch: Implement kvm_arch_handle_exit
Date: Mon,  9 Oct 2023 17:01:35 +0800
Message-Id: <9b00fe7a7f28121e6f446350d063063db9fa7a2f.1696841645.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696841645.git.lixianglai@loongson.cn>
References: <cover.1696841645.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_y+TwSNlDW4cAA--.59991S9
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Implement kvm_arch_handle_exit for loongarch. In this
function, the KVM_EXIT_LOONGARCH_IOCSR is handled,
we read or write the iocsr address space by the addr,
length and is_write argument in kvm_run.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/kvm.c        | 24 +++++++++++++++++++++++-
 target/loongarch/trace-events |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
index 9754478e34..0fe52434ed 100644
--- a/target/loongarch/kvm.c
+++ b/target/loongarch/kvm.c
@@ -549,7 +549,29 @@ bool kvm_arch_cpu_check_are_resettable(void)
 
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
index f801ad7c76..6cce653b20 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -13,3 +13,4 @@ kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
 kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
 kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
 kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
+kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
-- 
2.39.1


