Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBF7B742C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 00:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qno0H-0000tC-PV; Tue, 03 Oct 2023 18:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0F-0000sW-Hu
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno0D-0005Vv-8l
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:36:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-694ed84c981so1146638b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696372587; x=1696977387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cgz9RF6i61ks8bpBg9LBISCk3BJSrpA+YPgHPb+5Mgg=;
 b=IxTUr4ZjafFREmu4yj8eZKyJptcy+bSRVJsRra2/Xz7ReX70dMKEJPpDlMMa/hJeb7
 yxW+lPG+DLhli27Prf3ZopPR6CTLDeFQNpd61JhKBZ4oDuOSB+Ft7cPVAE9yvgwMR4dS
 oyRx/i8GStbMOU59imeVPwqm1da3b/SqcEetg5jSxLPTq4UCu8ynBixczxUMsFe9PTGf
 Io8J/f3xRC+gMCs+D1lptApWwtNLTKR32GFqqDnlhK+OODkXnrRVcvxLxYDadRR7E1j1
 Jik10KByzZS+K4yfLc69Y5KOMdMKJYFi+zHQbwPKzC0aD95OsfQB0Oyr6fa5oeBER0Md
 oz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696372587; x=1696977387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cgz9RF6i61ks8bpBg9LBISCk3BJSrpA+YPgHPb+5Mgg=;
 b=fjmqZRGtx7yajC+2Qlp4oQj0o1RwtI/oUO5yEZujalW9IcaEs29hcJO8cyS5ht0kgY
 tdVyTSALOpJVtm71J/ZR+A8GU35KvnVY//TExQDxjR6dv13+VyWvAjyu0W34tRIOZGld
 H2Ltsnu0nNBKVc9jhZysXwcP6efblgDqjOd+RRbp2hJHCYtQWkYbrc7FWRBghHVxo3KZ
 7nb2bc9yulBwmDpJQpiDbJHaQWtAxvRb/ZvCIto0rakyRG5zKXPwtmqCC/rJQYpfrMAr
 E/L1iBgK4/iMU9xE2v1BMxf6uRM//U7o412aWD+zoOnZR/lJwOjhGEp8LlUOYGPWrJER
 /WpQ==
X-Gm-Message-State: AOJu0YyGVcrJnJABbXUG30G4BgiSD5flCjbCGRVBPugrlzdad6zM9Fi4
 0WKbbjWUAIBVZef2OJ8DD5hhmA+8bhkQoKK8aJw=
X-Google-Smtp-Source: AGHT+IEHOm+5OqdrfYYqQ5LCqhtFYgwTDT1zIVoKIjdnlwsqo43hD0smJCiYD4tGfVFN9vVkOIKKOA==
X-Received: by 2002:a05:6a20:8f26:b0:159:fe1d:2f32 with SMTP id
 b38-20020a056a208f2600b00159fe1d2f32mr917800pzk.42.1696372586780; 
 Tue, 03 Oct 2023 15:36:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 q16-20020a170902dad000b001c75d7f2597sm2126055plx.141.2023.10.03.15.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 15:36:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: keithp@keithp.com,
	laurent@vivier.eu
Subject: [PATCH v2 1/2] target/m68k: Perform the semihosting test during
 translate
Date: Tue,  3 Oct 2023 15:36:23 -0700
Message-Id: <20231003223624.1753000-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003223624.1753000-1-richard.henderson@linaro.org>
References: <20231003223624.1753000-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Replace EXCP_HALT_INSN by EXCP_SEMIHOSTING.  Perform the pre-
and post-insn tests during translate, leaving only the actual
semihosting operation for the exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  2 +-
 target/m68k/op_helper.c | 14 ++-----------
 target/m68k/translate.c | 45 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 10697120f6..4549c28452 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -66,7 +66,7 @@
 #define EXCP_MMU_ACCESS     58  /* MMU Access Level Violation Error */
 
 #define EXCP_RTE            0x100
-#define EXCP_HALT_INSN      0x101
+#define EXCP_SEMIHOSTING    0x101
 
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..38eb85b8e7 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -202,18 +202,8 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
             /* Return from an exception.  */
             cf_rte(env);
             return;
-        case EXCP_HALT_INSN:
-            if (semihosting_enabled((env->sr & SR_S) == 0)
-                    && (env->pc & 3) == 0
-                    && cpu_lduw_code(env, env->pc - 4) == 0x4e71
-                    && cpu_ldl_code(env, env->pc) == 0x4e7bf000) {
-                env->pc += 4;
-                do_m68k_semihosting(env, env->dregs[0]);
-                return;
-            }
-            cs->halted = 1;
-            cs->exception_index = EXCP_HLT;
-            cpu_loop_exit(cs);
+        case EXCP_SEMIHOSTING:
+            do_m68k_semihosting(env, env->dregs[0]);
             return;
         }
     }
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ea7af25d50..e07b0b659d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -26,12 +26,11 @@
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
 #include "exec/translator.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
 #include "fpu/softfloat.h"
+#include "semihosting/semihost.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1418,6 +1417,40 @@ static void gen_jmp_tb(DisasContext *s, int n, target_ulong dest,
     s->base.is_jmp = DISAS_NORETURN;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool semihosting_test(DisasContext *s)
+{
+    uint32_t test;
+
+    if (!semihosting_enabled(IS_USER(s))) {
+        return false;
+    }
+
+    /*
+     * "The semihosting instruction is immediately preceded by a
+     * nop aligned to a 4-byte boundary..."
+     * The preceding 2-byte (aligned) nop plus the 2-byte halt/bkpt
+     * means that we have advanced 4 bytes from the required nop.
+     */
+    if (s->pc % 4 != 0) {
+        return false;
+    }
+    test = cpu_lduw_code(s->env, s->pc - 4);
+    if (test != 0x4e71) {
+        return false;
+    }
+    /* "... and followed by an invalid sentinel instruction movec %sp,0." */
+    test = translator_ldl(s->env, &s->base, s->pc);
+    if (test != 0x4e7bf000) {
+        return false;
+    }
+
+    /* Consume the sentinel. */
+    s->pc += 4;
+    return true;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 DISAS_INSN(scc)
 {
     DisasCompare c;
@@ -4482,8 +4515,12 @@ DISAS_INSN(halt)
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-
-    gen_exception(s, s->pc, EXCP_HALT_INSN);
+    if (semihosting_test(s)) {
+        gen_exception(s, s->pc, EXCP_SEMIHOSTING);
+        return;
+    }
+    tcg_gen_movi_i32(cpu_halted, 1);
+    gen_exception(s, s->pc, EXCP_HLT);
 }
 
 DISAS_INSN(stop)
-- 
2.34.1


