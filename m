Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEC8295B8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:06:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUC-0004Wr-SC; Wed, 10 Jan 2024 04:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSn-0003IY-Ei
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:34 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSk-0005c5-NI
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:28 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cdf76cde78so1762827a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877285; x=1705482085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5hS2KDX9FR/r3QNCAvm7J9goX/uQGCJMuysaIb1xEU=;
 b=da4hujQa4boMIn4rLwDuA7YHr4uJAd9GufB9gFVSdz+Wc5njoBF5GolHZpN5dsTj4q
 0jOQI+So8HNQMsT7Fke5cgGlfUtHKjCaps4P3xDBcfjpQ5nysmEzBdigCUgTqgCgbM50
 kpXgZJz8ZsK/8HAfJ1vXCF+ExIwowTwdP8RR22VgD7RsvslbjtVrtqull2Y0kfP4U06S
 jVHT6MG8Xhmva/QNjdt5ig6tWXNbmJCx+z/kymvhLnYfDXqPcG6frf+MhOtlhSZAMpTp
 /cDmFLTQIE7lo06VyGrrTDDFy/Ej9JPIG2x0AVrYJJP7RV4LQ8OEihGoHEZb8G1BXzd1
 7hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877285; x=1705482085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5hS2KDX9FR/r3QNCAvm7J9goX/uQGCJMuysaIb1xEU=;
 b=QjKQxrwsG+u33sKC1RN46yJLv0X7Ooz9QLqk7Ju8QNbWugPGXMDeqjhhK2Kfn9eDCe
 6B9bHaA3QrPRW0hSJzQyaPMcJdIRCynJUSbnT3sHTlZajY1rRUgGzTBsqL2U8acRaJ20
 762k8IMl4+cSfUaX39HHdfIMRyGyJXvKEYyOAlMhVDOWbTda/H02hIfVX9q5dx0WhFo3
 HBLbKUuY2jzWQDFMz0jvHxHsiZ8pCNUSCSvw4Nr9uniITkpemAhkHzZLLdkR4JYQPje0
 1ryYm2dRScwhnJBtxT9qowCLuWkWk0wmPompOqx524DpTcQITX65ifbqACQxWyY+Jq9Z
 Tshw==
X-Gm-Message-State: AOJu0YxQ8/zXPVBODEWQm3JzKn7HaVr+6u+Ztr94MxhyG5OZ/WQXcuqE
 ruoyRejgQgKcnJVHjMF6cI4aTCEvvve4wbQl
X-Google-Smtp-Source: AGHT+IFDd/0XKHax5L00uynM35znAhDWp5QpW53R9iRf2MY4v31U1bfECy1HtKr2sepsL5BEmDf/jg==
X-Received: by 2002:a05:6a20:3ca3:b0:19a:343d:87fb with SMTP id
 b35-20020a056a203ca300b0019a343d87fbmr15214pzj.92.1704877285235; 
 Wed, 10 Jan 2024 01:01:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 58/65] target/riscv/kvm: do PR_RISCV_V_SET_CONTROL during
 realize()
Date: Wed, 10 Jan 2024 18:57:26 +1000
Message-ID: <20240110085733.1607526-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Linux RISC-V vector documentation (Document/arch/riscv/vector.rst)
mandates a prctl() in order to allow an userspace thread to use the
Vector extension from the host.

This is something to be done in realize() time, after init(), when we
already decided whether we're using RVV or not. We don't have a
realize() callback for KVM yet, so add kvm_cpu_realize() and enable RVV
for the thread via PR_RISCV_V_SET_CONTROL.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218204321.75757-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 841756ab9b..d7d6fb1af0 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/prctl.h>
 
 #include <linux/kvm.h>
 
@@ -47,6 +48,9 @@
 #include "sysemu/runstate.h"
 #include "hw/riscv/numa.h"
 
+#define PR_RISCV_V_SET_CONTROL            69
+#define PR_RISCV_V_VSTATE_CTRL_ON          2
+
 void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 {
     kvm_set_irq(kvm_state, irq, !!level);
@@ -1496,11 +1500,36 @@ static void kvm_cpu_instance_init(CPUState *cs)
     }
 }
 
+/*
+ * We'll get here via the following path:
+ *
+ * riscv_cpu_realize()
+ *   -> cpu_exec_realizefn()
+ *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
+ */
+static bool kvm_cpu_realize(CPUState *cs, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    int ret;
+
+    if (riscv_has_ext(&cpu->env, RVV)) {
+        ret = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
+        if (ret) {
+            error_setg(errp, "Error in prctl PR_RISCV_V_SET_CONTROL, code: %s",
+                       strerrorname_np(errno));
+            return false;
+        }
+    }
+
+   return true;
+}
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
+    acc->cpu_target_realize = kvm_cpu_realize;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
-- 
2.43.0


