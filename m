Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF101BB7BA2
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 19:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jOb-0002GM-O9; Fri, 03 Oct 2025 13:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLY-0007YD-LY
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK9-0007pf-4I
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so2382061b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511519; x=1760116319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKl+yp0a8P56hFuIvAm8wzjB97MrEeHXJ3Wie4O1OpA=;
 b=f4p5suYdLe0VJSJgxhXJ2t39kubIjFkjYtoP+P4W4r5V9rSq78KgoKjE04uxr1xNpd
 yiOqdXNz/BSVywumrIgAeTBGBqxNxXDcGox8dsbNn9YYCynColAxhdHuT4u+gxGebhjI
 uFUh77bBuKBwQXCrc4qq7Rn2d9A92NKp+myKewm3bTBkHHVqIX2LHpILYn6JAcFYxTaT
 zas1djTHv7pqk9qRgLfKrWB453bsLXhb68Absw8LJd6gxQsJih1ZOoB6rFPKBEcziLUa
 2l3idE4jKnCoX9CKPePS6Ct3/PxBcVTVPtpmvgSlt0Pam41DybSO+mVDM1xVwtwgAWYM
 YlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511519; x=1760116319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKl+yp0a8P56hFuIvAm8wzjB97MrEeHXJ3Wie4O1OpA=;
 b=bWsr2xri1ccVIduKgJ+SpIx5ZdrAIYNWD9PNav7g1ujrrlVa6uKB8egE2/CE7r2ZSD
 kJlOe3pADc2mFeDnIMqP73hVKstC0507/AzqEKBbVhy7RldrjTGDhmzV8ozRrgXipPoY
 L6VGTMp3eFZ+HYDtOPC5CQdtMtHT9+twyFN42FFLUaCWmzL0ByugPu13DdAD11LgJnVs
 wHuVZiBjQFYxKMUHqI19Qn1uAv7j/FzeId+FKuSyuJcadqcvuk+xNzqBP81/oOA3GJU4
 8UP6Wbv/6X490SyGLeDGb0nAceT9slkjPyyjL0BS1HiL8WWlmkTCAyLgkzI41OvIENyL
 PBTw==
X-Gm-Message-State: AOJu0YxdhS4id326f24B+RbtRlDgVBlnK7p3359Ou/2INDaBtn3g4CPf
 tt3fvQWvpIwQPU1up3c7chidAww70MEHpruPwQRrjjWdJPSsOjjvhypEfQvzZ/MVP2aIVtJqOUt
 uNKMAsJ8=
X-Gm-Gg: ASbGnct6tvYGT9B2Rne4LBj6a27X4vtLbBY5tF4bmdrXoYHGlEPFSOXnXkcolnALMoP
 25H4U6PeSFxjkyR2OfVAR8K3cEvAM5NKOy+nrSLEm+YJ3B8BkNKFg51ZTkQalWv06uLjKnR/TbH
 1yN3ZSlfmXdU6D/ODP6l6UC1l3sdKRkgfHYXM7JjJ6puV4s6xnK8AM8VG0OeuAqjiaZ4dQFMbiC
 8WoTY9JEeK68o8xDC6H6Mgpqr/eOpX1sRGUgg1W8LtBKQFN5aAOHwR3LGrcOhNUYmdL3jm9sie2
 usadgiKnI7CPfnXDibluRBPGlLO9WX6yxKsTjYHsi2gUz5NEc238lDWgUBkkrEcNutvgyV5tQfy
 t2Pqx7q0agBCxkqWQ2IyhgaBTSGOtct9GurDtRyJglZVoTRP4Gz4WgjD8
X-Google-Smtp-Source: AGHT+IF9EZnIO1vkvHrzC4pe0k94joSLNmCn0VnrOy0faOEl5pOiatFVrPFvfIE9OL69wMep/TgGvQ==
X-Received: by 2002:a05:6a00:4145:b0:781:4f0b:9c58 with SMTP id
 d2e1a72fcca58-78c98dc5f60mr4490543b3a.15.1759511518621; 
 Fri, 03 Oct 2025 10:11:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 63/73] linux-user/aarch64: Implement prctls for GCS
Date: Fri,  3 Oct 2025 10:07:50 -0700
Message-ID: <20251003170800.997167-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This is PR_GET_SHADOW_STACK_STATUS, PR_SET_SHADOW_STACK_STATUS,
and PR_LOCK_SHADOW_STACK_STATUS.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/gcs-internal.h | 38 ++++++++++++
 linux-user/aarch64/target_prctl.h | 96 +++++++++++++++++++++++++++++++
 linux-user/qemu.h                 |  5 ++
 linux-user/syscall.c              | 29 ++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 linux-user/aarch64/gcs-internal.h

diff --git a/linux-user/aarch64/gcs-internal.h b/linux-user/aarch64/gcs-internal.h
new file mode 100644
index 0000000000..e586c7e80e
--- /dev/null
+++ b/linux-user/aarch64/gcs-internal.h
@@ -0,0 +1,38 @@
+/*
+ * AArch64 gcs functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef AARCH64_GCS_INTERNAL_H
+#define AARCH64_GCS_INTERNAL_H
+
+#ifndef PR_SHADOW_STACK_ENABLE
+# define PR_SHADOW_STACK_ENABLE  (1U << 0)
+# define PR_SHADOW_STACK_WRITE   (1U << 1)
+# define PR_SHADOW_STACK_PUSH    (1U << 2)
+#endif
+
+static inline uint64_t gcs_get_el0_mode(CPUArchState *env)
+{
+    uint64_t cr = env->cp15.gcscr_el[0];
+    abi_ulong flags = 0;
+
+    flags |= cr & GCSCR_PCRSEL ? PR_SHADOW_STACK_ENABLE : 0;
+    flags |= cr & GCSCR_STREN ? PR_SHADOW_STACK_WRITE : 0;
+    flags |= cr & GCSCR_PUSHMEN ? PR_SHADOW_STACK_PUSH : 0;
+
+    return flags;
+}
+
+static inline void gcs_set_el0_mode(CPUArchState *env, uint64_t flags)
+{
+    uint64_t cr = GCSCRE0_NTR;
+
+    cr |= flags & PR_SHADOW_STACK_ENABLE ? GCSCR_RVCHKEN | GCSCR_PCRSEL : 0;
+    cr |= flags & PR_SHADOW_STACK_WRITE ? GCSCR_STREN : 0;
+    cr |= flags & PR_SHADOW_STACK_PUSH ? GCSCR_PUSHMEN : 0;
+
+    env->cp15.gcscr_el[0] = cr;
+}
+
+#endif
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index ed75b9e4b5..621be5727f 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -6,8 +6,10 @@
 #ifndef AARCH64_TARGET_PRCTL_H
 #define AARCH64_TARGET_PRCTL_H
 
+#include "qemu/units.h"
 #include "target/arm/cpu-features.h"
 #include "mte_user_helper.h"
+#include "gcs-internal.h"
 
 static abi_long do_prctl_sve_get_vl(CPUArchState *env)
 {
@@ -206,4 +208,98 @@ static abi_long do_prctl_get_tagged_addr_ctrl(CPUArchState *env)
 }
 #define do_prctl_get_tagged_addr_ctrl do_prctl_get_tagged_addr_ctrl
 
+static abi_long do_prctl_get_shadow_stack_status(CPUArchState *env,
+                                                 abi_long arg2)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EINVAL;
+    }
+    return put_user_ual(gcs_get_el0_mode(env), arg2);
+}
+#define do_prctl_get_shadow_stack_status do_prctl_get_shadow_stack_status
+
+static abi_long gcs_alloc(abi_ulong hint, abi_ulong size)
+{
+    /*
+     * Without softmmu, we cannot protect GCS memory properly.
+     * Make do with normal read/write permissions.  This at least allows
+     * emulation of correct programs which don't access the gcs stack
+     * with normal instructions.
+     */
+    return target_mmap(hint, size, PROT_READ | PROT_WRITE,
+                       MAP_PRIVATE | MAP_ANONYMOUS |
+                       (hint ? MAP_FIXED_NOREPLACE : 0), -1, 0);
+}
+
+static abi_ulong gcs_new_stack(TaskState *ts)
+{
+    /* Use guest_stack_size as a proxy for RLIMIT_STACK. */
+    abi_ulong size = MIN(MAX(guest_stack_size / 2, TARGET_PAGE_SIZE), 2 * GiB);
+    abi_ulong base = gcs_alloc(0, size);
+
+    if (base == -1) {
+        return -1;
+    }
+
+    ts->gcs_base = base;
+    ts->gcs_size = size;
+    return base + size - 8;
+}
+
+static abi_long do_prctl_set_shadow_stack_status(CPUArchState *env,
+                                                 abi_long new_mode)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    TaskState *ts = get_task_state(env_cpu(env));
+    abi_long cur_mode;
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EINVAL;
+    }
+    if (new_mode & ~(PR_SHADOW_STACK_ENABLE |
+                     PR_SHADOW_STACK_WRITE |
+                     PR_SHADOW_STACK_PUSH)) {
+        return -TARGET_EINVAL;
+    }
+
+    cur_mode = gcs_get_el0_mode(env);
+    if ((new_mode ^ cur_mode) & ts->gcs_el0_locked) {
+        return -TARGET_EBUSY;
+    }
+
+    if (new_mode & ~cur_mode & PR_SHADOW_STACK_ENABLE) {
+        abi_long gcspr;
+
+        if (ts->gcs_base || env->cp15.gcspr_el[0]) {
+            return -EINVAL;
+        }
+        gcspr = gcs_new_stack(ts);
+        if (gcspr == -1) {
+            return -TARGET_ENOMEM;
+        }
+        env->cp15.gcspr_el[0] = gcspr;
+    }
+
+    gcs_set_el0_mode(env, new_mode);
+    arm_rebuild_hflags(env);
+    return 0;
+}
+#define do_prctl_set_shadow_stack_status do_prctl_set_shadow_stack_status
+
+static abi_long do_prctl_lock_shadow_stack_status(CPUArchState *env,
+                                                  abi_long arg2)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    TaskState *ts = get_task_state(env_cpu(env));
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -EINVAL;
+    }
+    ts->gcs_el0_locked |= arg2;
+    return 0;
+}
+#define do_prctl_lock_shadow_stack_status do_prctl_lock_shadow_stack_status
+
 #endif /* AARCH64_TARGET_PRCTL_H */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index cabb7bd6a8..85e68eff7b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -121,6 +121,11 @@ struct TaskState {
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
     abi_ulong tp_value;
+#endif
+#if defined(TARGET_AARCH64)
+    vaddr gcs_base;
+    abi_ulong gcs_size;
+    abi_ulong gcs_el0_locked;
 #endif
     int used; /* non zero if used */
     struct image_info *info;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1a5f2a03f9..455965991c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6353,6 +6353,11 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_LEN_MASK  0xffff
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
+#ifndef PR_GET_SHADOW_STACK_STATUS
+# define PR_GET_SHADOW_STACK_STATUS  74
+# define PR_SET_SHADOW_STACK_STATUS  75
+# define PR_LOCK_SHADOW_STACK_STATUS 76
+#endif
 
 #include "target_prctl.h"
 
@@ -6399,6 +6404,15 @@ static abi_long do_prctl_inval1(CPUArchState *env, abi_long arg2)
 #ifndef do_prctl_sme_set_vl
 #define do_prctl_sme_set_vl do_prctl_inval1
 #endif
+#ifndef do_prctl_get_shadow_stack_status
+#define do_prctl_get_shadow_stack_status do_prctl_inval1
+#endif
+#ifndef do_prctl_set_shadow_stack_status
+#define do_prctl_set_shadow_stack_status do_prctl_inval1
+#endif
+#ifndef do_prctl_lock_shadow_stack_status
+#define do_prctl_lock_shadow_stack_status do_prctl_inval1
+#endif
 
 static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
                                                abi_ulong arg2, abi_ulong arg3,
@@ -6499,6 +6513,21 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
             return -TARGET_EINVAL;
         }
         return do_prctl_get_tagged_addr_ctrl(env);
+    case PR_GET_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_get_shadow_stack_status(env, arg2);
+    case PR_SET_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_set_shadow_stack_status(env, arg2);
+    case PR_LOCK_SHADOW_STACK_STATUS:
+        if (arg3 || arg4 || arg5) {
+            return -TARGET_EINVAL;
+        }
+        return do_prctl_lock_shadow_stack_status(env, arg2);
 
     case PR_GET_UNALIGN:
         return do_prctl_get_unalign(env, arg2);
-- 
2.43.0


