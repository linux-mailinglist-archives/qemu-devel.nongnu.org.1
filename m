Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C329B266AC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 15:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXha-0001VX-Sb; Thu, 14 Aug 2025 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhO-0000uI-GB
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:54 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXh2-0005wk-1y
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:48 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b471746a879so529415a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176908; x=1755781708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=okzpQ51DVigKOc4ziC3CNGM9piXqF46OdJUtubB3PoZsCxEtDU40Q/s9AjdRrcK9nf
 7ZWfogGgpsPVBg4GMmBa6PMdyX5Se38TZFv+iiIeOIfvQ8kHj0+jeaWT2SMVGigXYvHN
 DvHF0O0D5W3PsW8HaXe5x9KEqG81Fvm6bpuTaDL5TT/xmVyyykm0u/bT53Hz7OKWo0vi
 o9j3GhcogepoEaiWsRflrjL5fhmwPZMRi5SyyccbzhGadIyZi8WWJk4pEwtpJmMpy9+G
 pDQQAjg4hmp/F2ASp+oCrOZs6fidRzUmCHKmPbxtyBgym54UoB+DpNAJbknsmS6Gd2HS
 zP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176908; x=1755781708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUo2eLEQH3tvadRbtyXeqZmXKqgrSzHJmdQtpKn9Hto=;
 b=Pqu7ms3oRDIVDVfRfxweJ6Lprliz9n1X1+3ecsNCLs4RrnrxJpvVS3ym9jn6xb0hpK
 jkI2wQ5RqQ4YeZdAkNi8oTeJPgwYF2TFCgDuA1RkQi9ONq6g+idO0GcQopSmDVHJ4C/k
 dKV5gFMJVB4KMghvjQcYk43Ju4H2T7/JtVf2WoZ/rAa2eXEeospLclKJ/FSpSsdPedMY
 mG9VpLzSntpZNLaKD1qDNk8pp4nC5KMdx+a7mhYYT3U5Z9W9VsX4rvRYeE2Zs1hk5AwX
 uI8YjEKHPIzaxiwpaok0mBAI3UR030UhcAn3PeSEZWS5fGouoGKhmgR7LtgzOFztvjaH
 sPyg==
X-Gm-Message-State: AOJu0YziwSQR2BAxjgI9iIWlUOEsMoqjeGAwL13qdecJ/Ds8LTDqrWh0
 d0EiiYzIqjSEcBIVlNjhzckZ/NCVkuxSkkI2AYWAn9ECvm1a1+lct7iog5OcI5xzD5icNbxCoi+
 qXptg9aw=
X-Gm-Gg: ASbGnctlm0vZ2yM1/Cj4dtIg1yX3HTWzJIDXau4SYUSInAmhDF3Yh9UNkI5L8akPBN2
 s23CPCzOE35BIqMj24iTYYmSi3Ay9OlD1JqRGagYyhWl0x3OLPcX1HTRCWhgdxo8FJOKwNWd0Sy
 jevN7iyisZzj2cmcqq+uo33RwRGA3J+giYV7JCaaZHo83hYMkqu9hpgJ6rl28ZQbjIgk0CfcZxn
 OCWYz2HeRue7BFoLQPM68fYk9WVWr54MJ1hrHiSgJCoJ3MrGu1XuX7Y8RkFJa9LxA+lJOLNWaus
 NebTlC6qzATI6DvvAVTusMD1BnUDhZfr/1DPCR8GJTuXZqkRLUOUW75gmflsRUZgjj4KjjRpFzW
 LOVK9QaeZM4vR6VT6eSa2uxnt/3U4MKpPf7QIOMCVfhwzYqQ=
X-Google-Smtp-Source: AGHT+IECbLuwUgIIWFCgXwT+SsT18GsKwbOiG4OlTB20ATuhLzFybHx2MfINYOfNqlzG98q+tS2wXQ==
X-Received: by 2002:a17:903:2b0f:b0:234:8ec1:4af6 with SMTP id
 d9443c01a7336-244586d5141mr46731925ad.45.1755176908010; 
 Thu, 14 Aug 2025 06:08:28 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24304c2943asm64438335ad.30.2025.08.14.06.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:08:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 80/85] linux-user/aarch64: Generate GCS signal records
Date: Thu, 14 Aug 2025 22:57:47 +1000
Message-ID: <20250814125752.164107-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Here we must push and pop a cap on the GCS stack as
well as the gcs record on the normal stack.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 138 ++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 6 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index ef97be3ac7..f7edfa249e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -22,6 +22,7 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 #include "target/arm/cpu-features.h"
+#include "gcs-internal.h"
 
 struct target_sigcontext {
     uint64_t fault_address;
@@ -152,6 +153,16 @@ struct target_zt_context {
 QEMU_BUILD_BUG_ON(TARGET_ZT_SIG_REG_BYTES != \
                   sizeof_field(CPUARMState, za_state.zt0));
 
+#define TARGET_GCS_MAGIC       0x47435300
+#define GCS_SIGNAL_CAP(X)      ((X) & TARGET_PAGE_MASK)
+
+struct target_gcs_context {
+    struct target_aarch64_ctx head;
+    uint64_t gcspr;
+    uint64_t features_enabled;
+    uint64_t reserved;
+};
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
@@ -322,6 +333,35 @@ static void target_setup_zt_record(struct target_zt_context *zt,
     }
 }
 
+static bool target_setup_gcs_record(struct target_gcs_context *ctx,
+                                    CPUARMState *env, uint64_t return_addr)
+{
+    uint64_t mode = gcs_get_el0_mode(env);
+    uint64_t gcspr = env->cp15.gcspr_el[0];
+
+    if (mode & PR_SHADOW_STACK_ENABLE) {
+        /* Push a cap for the signal frame. */
+        gcspr -= 8;
+        if (put_user_u64(GCS_SIGNAL_CAP(gcspr), gcspr)) {
+            return false;
+        }
+
+        /* Push a gcs entry for the trampoline. */
+        if (put_user_u64(return_addr, gcspr - 8)) {
+            return false;
+        }
+        env->cp15.gcspr_el[0] = gcspr - 8;
+    }
+
+    __put_user(TARGET_GCS_MAGIC, &ctx->head.magic);
+    __put_user(sizeof(*ctx), &ctx->head.size);
+    __put_user(gcspr, &ctx->gcspr);
+    __put_user(mode, &ctx->features_enabled);
+    __put_user(0, &ctx->reserved);
+
+    return true;
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -502,6 +542,64 @@ static bool target_restore_zt_record(CPUARMState *env,
     return true;
 }
 
+static bool target_restore_gcs_record(CPUARMState *env,
+                                      struct target_gcs_context *ctx,
+                                      bool *rebuild_hflags)
+{
+    TaskState *ts = get_task_state(env_cpu(env));
+    uint64_t cur_mode = gcs_get_el0_mode(env);
+    uint64_t new_mode, gcspr;
+
+    __get_user(new_mode, &ctx->features_enabled);
+    __get_user(gcspr, &ctx->gcspr);
+
+    /*
+     * The kernel pushes the value through the hw register:
+     * write_sysreg_s(gcspr, SYS_GCSPR_EL0) in restore_gcs_context,
+     * then read_sysreg_s(SYS_GCSPR_EL0) in gcs_restore_signal.
+     * Since the bottom 3 bits are RES0, this can (CONSTRAINED UNPREDICTABLE)
+     * force align the value.  Mirror the choice from gcspr_write().
+     */
+    gcspr &= ~7;
+
+    if (new_mode & ~(PR_SHADOW_STACK_ENABLE |
+                     PR_SHADOW_STACK_WRITE |
+                     PR_SHADOW_STACK_PUSH)) {
+        return false;
+    }
+    if ((new_mode ^ cur_mode) & ts->gcs_el0_locked) {
+        return false;
+    }
+    if (new_mode & ~cur_mode & PR_SHADOW_STACK_ENABLE) {
+        return false;
+    }
+
+    if (new_mode & PR_SHADOW_STACK_ENABLE) {
+        uint64_t cap;
+
+        /* Pop and clear the signal cap. */
+        if (get_user_u64(cap, gcspr)) {
+            return false;
+        }
+        if (cap != GCS_SIGNAL_CAP(gcspr)) {
+            return false;
+        }
+        if (put_user_u64(0, gcspr)) {
+            return false;
+        }
+        gcspr += 8;
+    } else {
+        new_mode = 0;
+    }
+
+    env->cp15.gcspr_el[0] = gcspr;
+    if (new_mode != cur_mode) {
+        *rebuild_hflags = true;
+        gcs_set_el0_mode(env, new_mode);
+    }
+    return true;
+}
+
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
@@ -511,8 +609,10 @@ static int target_restore_sigframe(CPUARMState *env,
     struct target_za_context *za = NULL;
     struct target_tpidr2_context *tpidr2 = NULL;
     struct target_zt_context *zt = NULL;
+    struct target_gcs_context *gcs = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
+    bool rebuild_hflags = false;
     int sve_size = 0;
     int za_size = 0;
     int zt_size = 0;
@@ -582,6 +682,15 @@ static int target_restore_sigframe(CPUARMState *env,
             zt_size = size;
             break;
 
+        case TARGET_GCS_MAGIC:
+            if (gcs
+                || size != sizeof(struct target_gcs_context)
+                || !cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
+                goto err;
+            }
+            gcs = (struct target_gcs_context *)ctx;
+            break;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 goto err;
@@ -612,6 +721,10 @@ static int target_restore_sigframe(CPUARMState *env,
         goto err;
     }
 
+    if (gcs && !target_restore_gcs_record(env, gcs, &rebuild_hflags)) {
+        goto err;
+    }
+
     /* SVE data, if present, overwrites FPSIMD data.  */
     if (sve && !target_restore_sve_record(env, sve, sve_size, &svcr)) {
         goto err;
@@ -631,6 +744,9 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     if (env->svcr != svcr) {
         env->svcr = svcr;
+        rebuild_hflags = true;
+    }
+    if (rebuild_hflags) {
         arm_rebuild_hflags(env);
     }
     unlock_user(extra, extra_datap, 0);
@@ -701,7 +817,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                uc.tuc_mcontext.__reserved),
     };
     int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0, tpidr2_ofs = 0;
-    int zt_ofs = 0, esr_ofs = 0;
+    int zt_ofs = 0, esr_ofs = 0, gcs_ofs = 0;
     int sve_size = 0, za_size = 0, tpidr2_size = 0, zt_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -720,6 +836,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                        &layout);
     }
 
+    if (env->cp15.gcspr_el[0]) {
+        gcs_ofs = alloc_sigframe_space(sizeof(struct target_gcs_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -779,6 +900,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        return_addr = ka->sa_restorer;
+    } else {
+        return_addr = default_rt_sigreturn;
+    }
+
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
     if (esr_ofs) {
@@ -786,6 +913,10 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         /* Leave ESR_EL1 clear while it's not relevant. */
         env->cp15.esr_el[1] = 0;
     }
+    if (gcs_ofs &&
+        !target_setup_gcs_record((void *)frame + gcs_ofs, env, return_addr)) {
+        goto give_sigsegv;
+    }
     target_setup_end_record((void *)frame + layout.std_end_ofs);
     if (layout.extra_ofs) {
         target_setup_extra_record((void *)frame + layout.extra_ofs,
@@ -811,11 +942,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     __put_user(env->xregs[29], &fr->fp);
     __put_user(env->xregs[30], &fr->lr);
 
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        return_addr = ka->sa_restorer;
-    } else {
-        return_addr = default_rt_sigreturn;
-    }
     env->xregs[0] = usig;
     env->xregs[29] = frame_addr + fr_ofs;
     env->xregs[30] = return_addr;
-- 
2.43.0


