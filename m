Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 174767D214C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:06:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW5-0000Vp-TS; Sun, 22 Oct 2023 02:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW1-0000UP-Of
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVy-0001WW-Mx
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso1608262b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954441; x=1698559241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCQ11G4CDtK3oW1LuqfPuIgRALcswxq9MCt2fHEKN58=;
 b=FylWDYYxk4IhWTgqCAfMnZ8RCDtR9P+FuBeHto54JUsF7x5v9LoDqlgyY3RcStg3R/
 N+cQVGnKyRkC0u8rv0NI3IaI+tFugeQgbZeIhQLS8/qHf7zB4Xt9XhrXRin4pmFg9YxY
 xX5elxVlASMThufuDhgn0NQgt6w4HIrp5aNDXqurmdcnjmVYCdXDenfA2VLZ1RbjDjwO
 XrVo1+ZCRHzT32HotTUM0nfNCH6/PsLmwguP0EMsA2FXawPg38a6o4m45PZYJ5kdlyf6
 Tn1+jxAtvEg2lgMrQ6c6NNWGl9DGQSRSsB+z1Sj/QuYFTCh0Z2OO+84hBiWNZVCV5lmY
 v2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954441; x=1698559241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCQ11G4CDtK3oW1LuqfPuIgRALcswxq9MCt2fHEKN58=;
 b=jNv8kEVBHAIOM9ZfiaEOu0rEb7xNjzW1fvSRPV3+hukedRU+nh27pp3z4ypmXWWsrj
 7ZfwCvacO4BOku+Nc+vT7lrarhq3i5NW64zjL/lpAsgwGHcmxOQ+r/dFdKHVXR5iSlXO
 hrLyQ5w+Ru6QUAamUScHeQFBSDiMtiMfK9gwsj4xRMer2ySmL3Lq9iy6TPjyp14EK3jk
 AE73ajjhXxqk3DVla58nGRhCecilnpiLkyLycISSacDXjNb45LGkyCQpxsxum+dfM+ez
 G0YFYQeyb91La5/W7spV+RKKxALfZ83kMOVzFhgz0xCn184gV7syU69Ag323x/iEjRd0
 66Rg==
X-Gm-Message-State: AOJu0Yy0fD5h5DFqIjAK4TRYT6IgaJzEBxHhtEgS0EHzsJaTXK6aLkVN
 8lZ8M08mwFHX8m0ae10V4O4n/X2yuBcjgn/SMM8=
X-Google-Smtp-Source: AGHT+IHeYQqYVyo9J3BIvJjkO9w9jjIfuPdkRpIgiRAsusdSltnabUQfE5y5nNUFEt9KhJVRIuQTLQ==
X-Received: by 2002:a17:902:f542:b0:1ca:1c89:9acf with SMTP id
 h2-20020a170902f54200b001ca1c899acfmr5199100plf.53.1697954440707; 
 Sat, 21 Oct 2023 23:00:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 09/90] target/sparc: Add decodetree infrastructure
Date: Sat, 21 Oct 2023 22:59:10 -0700
Message-Id: <20231022060031.490251-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  5 +++
 target/sparc/translate.c  | 69 ++++++++++++++++++++++++++-------------
 target/sparc/meson.build  |  3 ++
 3 files changed, 55 insertions(+), 22 deletions(-)
 create mode 100644 target/sparc/insns.decode

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
new file mode 100644
index 0000000000..5811a679db
--- /dev/null
+++ b/target/sparc/insns.decode
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: LGPL-2.0+
+#
+# Sparc instruction decode definitions.
+# Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
+
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cab9f13421..080bc5f8a2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3003,6 +3003,47 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 }
 #endif
 
+/* Include the auto-generated decoder.  */
+#include "decode-insns.c.inc"
+
+#define TRANS(NAME, AVAIL, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *dc, arg_##NAME *a) \
+    { return avail_##AVAIL(dc) && FUNC(dc, __VA_ARGS__); }
+
+#define avail_ALL(C)      true
+#ifdef TARGET_SPARC64
+# define avail_32(C)      false
+# define avail_64(C)      true
+#else
+# define avail_32(C)      true
+# define avail_64(C)      false
+#endif
+
+/* Default case for non jump instructions. */
+static bool advance_pc(DisasContext *dc)
+{
+    if (dc->npc & 3) {
+        switch (dc->npc) {
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            dc->pc = dc->npc;
+            gen_op_next_insn();
+            break;
+        case JUMP_PC:
+            /* we can do a static jump */
+            gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
+            dc->base.is_jmp = DISAS_NORETURN;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        dc->pc = dc->npc;
+        dc->npc = dc->npc + 4;
+    }
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3011,7 +3052,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
         goto nfpu_insn;
 
 /* before an instruction, dc->pc must be static */
-static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
+static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1, cpu_src2;
@@ -5544,26 +5585,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
         }
         break;
     }
-    /* default case for non jump instructions */
-    if (dc->npc & 3) {
-        switch (dc->npc) {
-        case DYNAMIC_PC:
-        case DYNAMIC_PC_LOOKUP:
-            dc->pc = dc->npc;
-            gen_op_next_insn();
-            break;
-        case JUMP_PC:
-            /* we can do a static jump */
-            gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
-            dc->base.is_jmp = DISAS_NORETURN;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        dc->pc = dc->npc;
-        dc->npc = dc->npc + 4;
-    }
+    advance_pc(dc);
  jmp_insn:
     return;
  illegal_insn:
@@ -5654,7 +5676,10 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     insn = translator_ldl(env, &dc->base, dc->pc);
     dc->base.pc_next += 4;
-    disas_sparc_insn(dc, insn);
+
+    if (!decode(dc, insn)) {
+        disas_sparc_legacy(dc, insn);
+    }
 
     if (dc->base.is_jmp == DISAS_NORETURN) {
         return;
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
index 48025cce76..c316773db6 100644
--- a/target/sparc/meson.build
+++ b/target/sparc/meson.build
@@ -1,4 +1,7 @@
+gen = decodetree.process('insns.decode')
+
 sparc_ss = ss.source_set()
+sparc_ss.add(gen)
 sparc_ss.add(files(
   'cc_helper.c',
   'cpu.c',
-- 
2.34.1


