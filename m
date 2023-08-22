Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CC784828
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUlp-0008QK-Sp; Tue, 22 Aug 2023 13:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUlm-0008Mg-9v
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUli-0002KC-7B
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26b41112708so3226227a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723732; x=1693328532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVHhYuUKW52ubI148rbZcLTzbA6J0OmH3AziT1EPcOU=;
 b=XMnQBulDR4Ustiqol4myQIFiIOepUtO3YNk1jNTdWULlrrRjHTDaoMH7qyfedBcokR
 w2JDYrivaWMb8XVbjX+VHbd6za7n6bldANm8SngfSG+FYqmPRm14+wqT8LHIWe8D2wEC
 EHBjuprO4G36Wg8TR46ThSjxqENMPNEkQxG0JzcQAN6DFGc3bjaPLvC7fWyCqV4vQiD1
 llBbJO5nMRWleoMU3QIlmdS0pYrv2p5HQB7iOUufZgvSj6BgyW77GvLFI06YAmpAPhkK
 h1dfTQ5Mc/t7CWkwUtfQmPo8jSvdBSbpBawYmUISUFfQPo4yI9PhHSvnItdrnrSZXphO
 vMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723732; x=1693328532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVHhYuUKW52ubI148rbZcLTzbA6J0OmH3AziT1EPcOU=;
 b=GWUr7rDkIREEeyd8UMGQU01ZdnV+Xo8biQpdI9Z2Y/3DZ6RpzEh7ygwdpP4QHUPgVW
 8A5HtNyYyWWvSN2u5jf1EJvcj2Q8GUcNFuaJlsAEfmh5sCXxzlqi/BoOKPjbkZDEs4h+
 cMlolvJMb5JffSL8HH1+UFofEmbVYqfoEAr6zFRlzFNpAqt+bEKtOx/8talF5xm9DUOv
 u12FFb9PAaImHjwcTbvFKn34IBKnOs8iZGIF3aTOQ4hNQpsUBJssRUK6UbbV8rgPVbkO
 r0oB417Fv5KKo+pabXSiKEMyqOnA7+WbcXLPlpUdF7Bx48YlbRc3MV+tfkraoi9/MkVN
 WqQQ==
X-Gm-Message-State: AOJu0YzqwYTSfmUGK/irTYTr4XQo7VDEvRKZeq5nvmVbNBosIXyjrhJQ
 JTKxWtR1uguvmdRnPx1Kyr0Sjjp40YmqJINqyK0=
X-Google-Smtp-Source: AGHT+IH5vZ+iq9e2/moJ+aEuvtAOTe1Pqjenyu54E5IPgy17Vm3wobdEog31vjhtqTIpDstQHYazjw==
X-Received: by 2002:a17:90a:e7cd:b0:26b:5758:8a04 with SMTP id
 kb13-20020a17090ae7cd00b0026b57588a04mr8860306pjb.29.1692723731936; 
 Tue, 22 Aug 2023 10:02:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00264040322desm8761121pje.40.2023.08.22.10.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 10:02:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/3] linux-user/aarch64: Add ESR signal frame for SIGSEGV,
 SIGBUS
Date: Tue, 22 Aug 2023 10:02:07 -0700
Message-Id: <20230822170209.1130173-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822170209.1130173-1-richard.henderson@linaro.org>
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

These are all synchronous exceptions for which the kernel
passes on ESR to the user signal handler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 48 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b265cfd470..b2280fa9e3 100644
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
@@ -558,6 +578,23 @@ static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
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
+    /* See arch/arm64/mm/fault.c, set_thread_esr. */
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
@@ -567,7 +604,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         .total_size = offsetof(struct target_rt_sigframe,
                                uc.tuc_mcontext.__reserved),
     };
-    int fpsimd_ofs, fr_ofs, sve_ofs = 0, za_ofs = 0;
+    int fpsimd_ofs, fr_ofs, esr_ofs = 0, sve_ofs = 0, za_ofs = 0;
     int sve_size = 0, za_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
@@ -577,6 +614,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
@@ -637,6 +680,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                   layout.extra_size);
         target_setup_end_record((void *)frame + layout.extra_end_ofs);
     }
+    if (esr_ofs) {
+        target_setup_esr_record((void *)frame + esr_ofs, env);
+    }
     if (sve_ofs) {
         target_setup_sve_record((void *)frame + sve_ofs, env, sve_size);
     }
-- 
2.34.1


