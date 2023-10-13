Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671317C8F53
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiM-0006BE-1e; Fri, 13 Oct 2023 17:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiJ-0006As-4O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:55 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiH-0000PR-Ep
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:54 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e5602c12e5so1390631fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232532; x=1697837332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VMW1A6SYv+Q5MYpjx2tuCSklX9h/fdNRcIcNEOnWHE=;
 b=HXSgGVj2chJoXEUF47AVzf8DmvrgbRRbDxZY/KOsPYp0YHuGlYMXKjCruGy4RLCw9A
 MfvB4fCS4SSp85OALWfvQC4tstvyW4oQDgr8RCsktSQgY08U0UX2RLID4apnlllSY7Xo
 7WjBMUkYk7tOu/GqiQOZbB9r0QdCP6DZrrgCOT5eKKe27vEXjFxSLs2VQHmjeP3NRb0S
 NZKwV57u5HhwhsMm6S4Mn6Buv7qihZAWNFKyEjl6M1L9qxBXmQf0CU4J/reSXgSHK8CZ
 PqZrZ9yBQslw67j/O3dZ3+6OAozC9uKQ8QHb7X6oK0s1CyhcynkkA/Tr+Dj+kmxwwpX/
 8fIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232532; x=1697837332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VMW1A6SYv+Q5MYpjx2tuCSklX9h/fdNRcIcNEOnWHE=;
 b=iJsaJmmPNeplXHTx6Roe345M5bD42XXT0Yf4Foit2HJErB/LOO0X3lT62sosmHihVP
 CopZS7lKYiPh8t3FZkqBBr+kYoXyBusmul8Mh7S7jD+EsvaK+pIwgUqhG+tgbd3oChww
 6ynuAyiR3dFp+7mjsd6QojLfybk+qujttlhzGp01gTWLarVJOb2iVlbzbWDp036FXHF/
 oO4nLkYwGiya8OB6DCDVJt6r/6nrtYJsKkfq4qUssZh0Y2cKuKvWcWzXnce3sfP4605i
 BIKh4ZrlzS/U7iqyuR/ueMBaeEDpdiFioeiXXZPXgdKagLnmShjg2KydeddRLv47w6SX
 t4Mg==
X-Gm-Message-State: AOJu0Yzsf6xISiys1zqXG4AN5UnLmYyJOMtmh0Kfo/CIzpvY5GilWwcb
 RL9c3fDmBFhvKUkXNxo1eTqiwCc9pwxUYNpDsSc=
X-Google-Smtp-Source: AGHT+IFOvbuG3hYPNG4E7Gyk9WzLndscH5Bs+j/cwGnOkwY6uuOyDJG6QL8CteEmBzTP0mna4jOr9A==
X-Received: by 2002:a05:6870:f61f:b0:1d6:53e6:7c8a with SMTP id
 ek31-20020a056870f61f00b001d653e67c8amr35572670oab.14.1697232531935; 
 Fri, 13 Oct 2023 14:28:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 04/85] target/sparc: Add decodetree infrastructure
Date: Fri, 13 Oct 2023 14:27:25 -0700
Message-Id: <20231013212846.165724-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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
index 7405173dea..59e5289693 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2964,6 +2964,47 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
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
@@ -2972,7 +3013,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
         goto nfpu_insn;
 
 /* before an instruction, dc->pc must be static */
-static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
+static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1, cpu_src2;
@@ -5504,26 +5545,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
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
@@ -5614,7 +5636,10 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
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


