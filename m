Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54A78D089
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb840-0004p6-7r; Tue, 29 Aug 2023 19:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83t-0004AS-Ix
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83n-0001OU-K5
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a402c1fcdso3466475b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351426; x=1693956226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fonDp/wXRvCIKOTr9zFpwn6DY7PZ+KvY5INrQDOWD5c=;
 b=kcwbcAEZ5WahBfHQjzYIpa0UrmbF2krCmwTtOJZyFfrbRcPT/2XUESjI7jNrgnY3m5
 nu4NrJEMCwVKpCH/UcXPKbmDSgNMJkPFv4ebWiqzGys1n1mXXZO3BdshyTxfs+GRDvN1
 Jomu9DtDwm7tCKGDcad84a5OqOLu5cqQZEBVPTScdF6j2ePjbAU2Mw6By1057VfV/ubX
 oyKziDgadVrkoDhhqmeeYFv/rpH6g3wEju4jayGV3W/Bm4lRmLVocOX9JqCylq6VTG/s
 hgMTeCcBiyOzulwFK07oRMRIbvVLoZwNNfDqWCPtzZoIFSU8w+rboaQWLbPMbykOFl30
 d90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351426; x=1693956226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fonDp/wXRvCIKOTr9zFpwn6DY7PZ+KvY5INrQDOWD5c=;
 b=Y51zJzRgbigzfAGWgJTzmJcxkeE2uW4QFRqPZo8/UDDNKG1N54liw+dP7Pe3NRc8wZ
 hsnt2pjoEUdOv394yuZWBU/3JVa3oNOK3L6fKP/G7JrsNhcPzXT5jK5Y3kGMXHr8VqYQ
 mPJNwFcsJiWGUlEpnMHsWPETIuozsLMTjilYT2UPKEv6tS6xx50PXujnkMMlMF/afNGW
 SGYk8sFo35SVeNY7wPKxrN1oZgS8nXe3Sqhh9zNwO/vfV9IgvEq7DqGxYcdvT71QuDgu
 /ja6oTnqxeso3cfv7ATC/nlCm1rLVGOWtVh95Q+FhJ0sEhzJf14vQ2AJSNrrWrBV51Tm
 9iIg==
X-Gm-Message-State: AOJu0YzY3IOj15gYa8B83Qm7mZYW2rLztJpLR02ltu6PeS4N+nvzMZga
 VpTwa+Dc7zOy9gii4fyG00Tgxgd3jiN4uvK/mkk=
X-Google-Smtp-Source: AGHT+IGtOjRaCycAsK7bsLepLgcpWbmxoPY8GCx+0YYGew8NeTeKITM6Gxin7fLwm7YC1ROy0unCnA==
X-Received: by 2002:a05:6a20:6a1a:b0:133:e3e3:dc07 with SMTP id
 p26-20020a056a206a1a00b00133e3e3dc07mr893323pzk.49.1693351426151; 
 Tue, 29 Aug 2023 16:23:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com,
	qemu-arm@nongnu.org
Subject: [PATCH v5 10/12] linux-user/aarch64: Add ESR signal frame for SIGSEGV, SIGBUS
Date: Tue, 29 Aug 2023 16:23:33 -0700
Message-Id: <20230829232335.965414-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These are all synchronous exceptions for which the kernel
passes on ESR to the user signal handler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 52 ++++++++++++++++++++++++++++++++++++-
 target/arm/tcg/tlb_helper.c |  8 +++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b265cfd470..40a476c33e 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/arm/syndrome.h"
 
 struct target_sigcontext {
     uint64_t fault_address;
@@ -64,6 +65,13 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
+#define TARGET_ESR_MAGIC    0x45535201
+
+struct target_esr_context {
+    struct target_aarch64_ctx head;
+    uint64_t esr;
+};
+
 #define TARGET_EXTRA_MAGIC  0x45585401
 
 struct target_extra_context {
@@ -191,6 +199,14 @@ static void target_setup_end_record(struct target_aarch64_ctx *end)
     __put_user(0, &end->size);
 }
 
+static void target_setup_esr_record(struct target_esr_context *esr,
+                                    CPUARMState *env)
+{
+    __put_user(TARGET_ESR_MAGIC, &esr->head.magic);
+    __put_user(sizeof(struct target_esr_context), &esr->head.size);
+    __put_user(env->exception.syndrome, &esr->esr);
+}
+
 static void target_setup_sve_record(struct target_sve_context *sve,
                                     CPUARMState *env, int size)
 {
@@ -443,6 +459,10 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_ESR_MAGIC:
+            /* ignore */
+            break;
+
         case TARGET_SVE_MAGIC:
             if (sve || size < sizeof(struct target_sve_context)) {
                 goto err;
@@ -558,6 +578,27 @@ static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
     return this_loc;
 }
 
+static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
+{
+    int sig = info->si_signo;
+    int type = info->si_code >> 16;
+
+    if (type != QEMU_SI_FAULT) {
+        return false;
+    }
+
+    /*
+     * See arch/arm64/mm/fault.c, for invocations of set_thread_esr.
+     * We populate ESR in arm_cpu_record_sigsegv or arm_cpu_record_sigbus,
+     * called via cpu_loop_exit_{sigsegv,sigbus}.
+     */
+    if (sig == TARGET_SIGSEGV || sig == TARGET_SIGBUS) {
+        return true;
+    }
+
+    return false;
+}
+
 static void target_setup_frame(int usig, struct target_sigaction *ka,
                                target_siginfo_t *info, target_sigset_t *set,
                                CPUARMState *env)
@@ -567,7 +608,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
+    int fpsimd_ofs, fr_ofs, esr_ofs = 0, sve_ofs = 0, za_ofs = 0;
     int sve_size = 0, za_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -577,6 +618,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fpsimd_ofs = alloc_sigframe_space(sizeof(struct target_fpsimd_context),
                                       &layout);
 
+    /* ESR state needs saving only for certain signals. */
+    if (need_save_esr(info, env)) {
+        esr_ofs = alloc_sigframe_space(sizeof(struct target_esr_context),
+                                       &layout);
+    }
+
     /* SVE state needs saving only if it exists.  */
     if (cpu_isar_feature(aa64_sve, env_archcpu(env)) ||
         cpu_isar_feature(aa64_sme, env_archcpu(env))) {
@@ -637,6 +684,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                   layout.extra_size);
         target_setup_end_record((void *)frame + layout.extra_end_ofs);
     }
+    if (esr_ofs) {
+        target_setup_esr_record((void *)frame + esr_ofs, env);
+    }
     if (sve_ofs) {
         target_setup_sve_record((void *)frame + sve_ofs, env, sve_size);
     }
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index b22b2a4c6e..27bf30e9e2 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -354,7 +354,13 @@ void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 {
     ARMMMUFaultInfo fi = {
         .type = maperr ? ARMFault_Translation : ARMFault_Permission,
-        .level = 3,
+        /*
+         * In arch/arm64/mm/fault.c, set_thread_esr, for kernel-space
+         * addresses (i.e. TTBR1) the kernel cleans the ESR value to
+         * always report level 0.  Since we're manufacturing a level
+         * here, we might as well pick 0 always.
+         */
+        .level = 0,
     };
     ARMCPU *cpu = ARM_CPU(cs);
 
-- 
2.34.1


