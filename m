Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F202D832B73
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq31-0005uT-VY; Fri, 19 Jan 2024 09:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0005pu-7F
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:34 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2m-0003tI-DS
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8UPiTZaevh6h/4URf5FGXZIx3hFxs8x0lkausVGDJfE=; b=Se2A+UURowq+fFZ9DJ/JvvVWrs
 JOjpujG/A5PBTaKsr0J8+jPXbi2xwLeucxJTQwM2CEIpui29KRE5zdTFYCX7MF/lA7des6DJhGX8l
 2MDKQ62z7Fz4QHu5w6MKi9N5v2f43I30PrnN+mJmRpVJsE7bH0uq7EXUadRn6CM3hiTM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 16/34] exec: [CPUTLB] Move cpu_*()/cpu_env() to common
 header
Date: Fri, 19 Jan 2024 15:40:06 +0100
Message-ID: <20240119144024.14289-17-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Functions are target independent.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h    | 25 -------------------------
 include/exec/cpu-common.h | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 968fbd4d16..4778976c4b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -295,33 +295,8 @@ CPUArchState *cpu_copy(CPUArchState *env);
      | CPU_INTERRUPT_TGT_EXT_3   \
      | CPU_INTERRUPT_TGT_EXT_4)
 
-/* accel/tcg/cpu-exec.c */
-int cpu_exec(CPUState *cpu);
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-/**
- * env_archcpu(env)
- * @env: The architecture environment
- *
- * Return the ArchCPU associated with the environment.
- */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d3c8b2cf55..25e50aaa37 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -347,4 +347,29 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/* accel/tcg/cpu-exec.c */
+int cpu_exec(CPUState *cpu);
+
+/**
+ * env_archcpu(env)
+ * @env: The architecture environment
+ *
+ * Return the ArchCPU associated with the environment.
+ */
+static inline ArchCPU *env_archcpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
+/**
+ * env_cpu(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline CPUState *env_cpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
 #endif /* CPU_COMMON_H */
-- 
2.43.0


