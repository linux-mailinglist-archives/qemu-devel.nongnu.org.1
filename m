Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FF78617D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOf-00008m-6A; Wed, 23 Aug 2023 16:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L1-7v
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005TX-OM
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso44712445ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822211; x=1693427011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSCfZX36SM4x81luXkG6DawpBtd9wgJBICXgd1wDuO8=;
 b=arWSiKRQoo+s42l/a19OIDtOIWh9F9gmR0fYIgkJKTprTFFwr6zS+QJZaST7ZsVJeD
 Q5xDwkmTkDs8Hj09mYmiODa5biDP9RljPH6lhhKGr9T0Zb50M9AAtDxILHzTYU3Af086
 gc0ChXpPpUfO85PeK7JQqnWV8KhqnJU8yy4MfB/UOkRfd+M4De/8SwkWaQsHqkEd6J27
 0iqFg2nF7ziF2VDBWKxZqvvyHB3aT5SVsD4vbS1kJCWsl0NZvzHGYQBaH2VX7xNkq9pl
 wjHtYE39ODLehgKCHtSdNCfC9slIRUrHyxMhw9ZoGIap3vT9TG5iwpvUE7cWeKdaf+dU
 GYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822211; x=1693427011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSCfZX36SM4x81luXkG6DawpBtd9wgJBICXgd1wDuO8=;
 b=lCVrp95CSSH7VlrBKHFkxLV0y5bK7MB6cNmHlqjFTx2LtlqW+kstYSV+5xaPbZhpUS
 6bcyMAYB1rRBYvSY27fde8Sd35QMu/NEux0bCI8/GfsgnuSW/qCFC3pkMEF7iEykSq+3
 Q3ceZ9UDbs3foZqTF0elc/V+CnFAqfWpgn+DJzLk4POaoUCfManCjTK5jJ/1bGcjrhrS
 CRNlKAqpKkcBRwhIiJ1/oVA0aTJQ0n6ROC80C1K61PzkxCt4l9/iqZoHiTBNRpBEfLnV
 qz4XnKg9RXBWJnnDt9xtL6BMsLP1ZE00nDSeZub5fLCv7JqAGCJsJJOp1GTmthyDsG8y
 pfaw==
X-Gm-Message-State: AOJu0Yzg3yWXifiu6tcQl/XkAbcXRtzpld/ecVT0FbMiJ2OVft/f27cv
 i5BYmYWDl99hhieGY2bpvkZ9wlb3k/vRF+1mUQk=
X-Google-Smtp-Source: AGHT+IEtavz0SGWIDMMz6sURITUzFBojf6o5EAzd4Zi3ZTTU0fQ4g/wc9brOoJrRIjd772E/Pza0qg==
X-Received: by 2002:a17:903:2305:b0:1bf:cdc:f402 with SMTP id
 d5-20020a170903230500b001bf0cdcf402mr17389974plh.48.1692822210919; 
 Wed, 23 Aug 2023 13:23:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 03/48] sysemu/kvm: Use vaddr for
 kvm_arch_[insert|remove]_hw_breakpoint
Date: Wed, 23 Aug 2023 13:22:41 -0700
Message-Id: <20230823202326.1353645-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson via <qemu-devel@nongnu.org>

Changes the signature of the target-defined functions for
inserting/removing kvm hw breakpoints. The address and length arguments
are now of vaddr type, which both matches the type used internally in
accel/kvm/kvm-all.c and makes the api target-agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-4-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/kvm.h   |  6 ++----
 target/arm/kvm64.c     |  6 ++----
 target/i386/kvm/kvm.c  |  8 +++-----
 target/ppc/kvm.c       | 13 ++++++-------
 target/s390x/kvm/kvm.c |  6 ++----
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 5670306dbf..19d87b20e8 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -426,10 +426,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
 int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type);
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type);
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
 void kvm_arch_remove_all_hw_breakpoints(void);
 
 void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 94bbd9661f..4d904a1d11 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -49,8 +49,7 @@ void kvm_arm_init_debug(KVMState *s)
     return;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -65,8 +64,7 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     }
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..295228cafb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4995,7 +4995,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
         kvm_rate_limit_on_bus_lock();
     }
 
-#ifdef CONFIG_XEN_EMU    
+#ifdef CONFIG_XEN_EMU
     /*
      * If the callback is asserted as a GSI (or PCI INTx) then check if
      * vcpu_info->evtchn_upcall_pending has been cleared, and deassert
@@ -5156,8 +5156,7 @@ static int find_hw_breakpoint(target_ulong addr, int len, int type)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -5197,8 +5196,7 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int n;
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a8a935e267..91e73620d3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1444,15 +1444,15 @@ static int find_hw_watchpoint(target_ulong addr, int *flag)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
-    if ((nb_hw_breakpoint + nb_hw_watchpoint) >= ARRAY_SIZE(hw_debug_points)) {
+    const unsigned breakpoint_index = nb_hw_breakpoint + nb_hw_watchpoint;
+    if (breakpoint_index >= ARRAY_SIZE(hw_debug_points)) {
         return -ENOBUFS;
     }
 
-    hw_debug_points[nb_hw_breakpoint + nb_hw_watchpoint].addr = addr;
-    hw_debug_points[nb_hw_breakpoint + nb_hw_watchpoint].type = type;
+    hw_debug_points[breakpoint_index].addr = addr;
+    hw_debug_points[breakpoint_index].type = type;
 
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1488,8 +1488,7 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int n;
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..1b240fc8de 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -995,8 +995,7 @@ static int insert_hw_breakpoint(target_ulong addr, int len, int type)
     return 0;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1014,8 +1013,7 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     return insert_hw_breakpoint(addr, len, type);
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int size;
     struct kvm_hw_breakpoint *bp = find_hw_breakpoint(addr, len, type);
-- 
2.34.1


