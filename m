Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83982966D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:43:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNV67-0004AG-By; Wed, 10 Jan 2024 04:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV64-0004A4-6l
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV62-0005DW-D2
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e4d64a431so18119075e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704879720; x=1705484520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFLSb/RdDlEX4D0hvbJaPY0lxzR23kWiDb8MZRG9un8=;
 b=CdxC1IvxkBKmiFeRT8Mgk1JGwgtHBoXlNUjxBExFlwd7mJTbUE+ZLzuPysNynAvH9g
 9HQfnWc5zGwT1JzwvWRmB2EF8lhJg/3NGuYPyoXVcl++GDEPXauBrWdVamM0JHsR34O9
 hP46rIpOX6xZLSfZolDKv1+VGdvFa287d431o5n2NfxPys41JGFmDalv4fkmUtXl4G7g
 AdTiwzrbK9BPF+Yn8ge95zzG7cH45a5eNR5fH5O+7Of4+LtznYt7Kp2FY1eEZ1VcZNyp
 /cM9eN7JI1f02R8sjyy8k+jpQnqNDKvmBvTlmurURm57TbQNsi/B/6WMvFdjIV5hmV2j
 X4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704879720; x=1705484520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFLSb/RdDlEX4D0hvbJaPY0lxzR23kWiDb8MZRG9un8=;
 b=QEbfDIJOBqquovGHt2tYQBBznj+3R2O78I1i9NQj6MQnRHzuVS83346uy9A4G8lhRt
 j6C5ETyOHIAMwkqaQzRuZHaHhvKs0aQrcuTMmhOCXQJIZS+rJladbGFBb7r2XS1EuiEK
 ifCgoqLD90S2lHhhKQa/0voIIGKbV0Q+jwtLNn7/rBw5w4FXnpgRvKoC3lu5hTMaEwYq
 USJ09cSpwqj4pAsD9tLKQJ0pvT0L4Wv1CM3WikeZ8X8Wot90cWU5wN90BdIJ5Q+WJtes
 R4Dczdt0ceG+RjsAetysOtJv1pSZYl64EBX2sxNsO2IKB/1LK5lQgEI4JUWJkIL3qk14
 1/sQ==
X-Gm-Message-State: AOJu0YxHL8uMWBIeDLAYbUqLtqk33f9Ub8tmvOkdUV3huoTmfygb+o0J
 8b28kbiO3y/S1sTrlDWfgYQ1USZ+/XWwLsNbCknNXyczuU4=
X-Google-Smtp-Source: AGHT+IHR6gMENms00gVyIcOpnbTBQ3X+xOvvIhM3WsteIdiwNk3WM2Cv4HHgHuD+eTcu6NUJCqbmZA==
X-Received: by 2002:a05:600c:450c:b0:40e:427d:4b02 with SMTP id
 t12-20020a05600c450c00b0040e427d4b02mr398062wmo.67.1704879720736; 
 Wed, 10 Jan 2024 01:42:00 -0800 (PST)
Received: from localhost.localdomain ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 az19-20020a05600c601300b0040e43d2ec43sm1570965wmb.11.2024.01.10.01.41.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 01:42:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 8/9b] target/loongarch: Implement set vcpu intr for kvm
Date: Wed, 10 Jan 2024 10:41:52 +0100
Message-ID: <20240110094152.52138-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
References: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement loongarch kvm set vcpu interrupt interface,
when a irq is set in vcpu, we use the KVM_INTERRUPT
ioctl to set intr into kvm.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
[PMD: Split from bigger patch, part 2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/kvm/kvm_loongarch.h | 16 ++++++++++++++++
 target/loongarch/cpu.c               |  9 ++++++++-
 target/loongarch/kvm/kvm.c           | 15 +++++++++++++++
 target/loongarch/trace-events        |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 target/loongarch/kvm/kvm_loongarch.h

diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
new file mode 100644
index 0000000000..d945b6bb82
--- /dev/null
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch kvm interface
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#include "cpu.h"
+
+#ifndef QEMU_KVM_LOONGARCH_H
+#define QEMU_KVM_LOONGARCH_H
+
+int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
+void kvm_arch_reset_vcpu(CPULoongArchState *env);
+
+#endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d9f8661cfd..d3a8a2f521 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
 #include "sysemu/tcg.h"
+#include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -21,6 +22,10 @@
 #include "sysemu/reset.h"
 #endif
 #include "vec.h"
+#ifdef CONFIG_KVM
+#include "kvm/kvm_loongarch.h"
+#include <linux/kvm.h>
+#endif
 #ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg.h"
@@ -113,7 +118,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    if (tcg_enabled()) {
+    if (kvm_enabled()) {
+        kvm_loongarch_set_interrupt(cpu, irq, level);
+    } else if (tcg_enabled()) {
         env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
         if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d2dab3fef4..bd33ec2114 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -748,6 +748,21 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
+{
+    struct kvm_interrupt intr;
+    CPUState *cs = CPU(cpu);
+
+    if (level) {
+        intr.irq = irq;
+    } else {
+        intr.irq = -irq;
+    }
+
+    trace_kvm_set_intr(irq, level);
+    return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
index 021839880e..dea11edc0f 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -12,3 +12,4 @@ kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
 kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
 kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
 kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
+kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"
-- 
2.41.0


