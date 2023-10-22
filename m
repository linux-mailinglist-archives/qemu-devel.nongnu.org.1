Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D87D2737
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtZ-0007HN-G6; Sun, 22 Oct 2023 19:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtN-00078m-13
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:58 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtA-0006ir-3m
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:56 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b40d5ea323so452435b6e.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017383; x=1698622183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tqKRfrHgf804PVSbuQwIQNkobvA0TCMv4wurSnK70U=;
 b=mGjTfaJv+5TfPWEDiVKTyyKucHi+7U2lHPG0NrCRRg8n4h2b8V+r/X+AgBML/T9WHJ
 5mqotcg/SqGK6HrJWtRbDg1N1dRFHDdmNE993o+meGM95W8pb79v/CmYw0vC4+ljkzsk
 O4ey5LT3cyTMeIJL2Y87lXs3GOZs8bAhsI6UPLkrNg+If3azgtlOCW79tRYT1Sf3Dt09
 iypMgmbsvDsNzNqzBuhhv6b2zTJH4EHhzKwO8zgGnL4tPDkvOHp8xcobKN0qanAWuSjr
 //0kTK5jsxegwfeZhqp2sVzmqclSm/dCmt1htQkZ1xPaQ408H4/gIS1MugxTV98GNB7t
 dViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017383; x=1698622183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tqKRfrHgf804PVSbuQwIQNkobvA0TCMv4wurSnK70U=;
 b=U9cYqTu02e9lVjQ0hSGxo9Dng+fYFj6njjMQrOTmKL1AyfxlG0kRkxFTEDhsP/mHXw
 ORMe+OL+AKcJYJZCc8zxEYnDV9bk2xlKyK90K5kbdDD3l/eNne4IzpOALLwNrn57IWv6
 AqARHEG+IHgmbZq9fCN4BGFbxkr0kCD6ZXJozXC9ALmc5r1KKer1cN/lfnw/ao7XEZqQ
 cai/xJ+zvwApzV4KmZOmqdmMk5nRJktYau2323uzwXP525Io701jdFqu1tU0nUVwzq1S
 IFZ+BjGw+t+XhjtDte4Y77CjzJxur1JW3uzcVlVRp40ahYnel+Byr3CRc+4SrnFb5+KX
 B52g==
X-Gm-Message-State: AOJu0YwMGQuPu2ZVG3d93mP+D5e+3cuSv1UbIrlqOiBN/RAJo16sYpPo
 SIOq8AnynGaYHYEXT4UfDTOvjMn3m4mVnzRCYfQ=
X-Google-Smtp-Source: AGHT+IEbF7sRSiu4/NJhYquW8H4s4Xbrd+2OsXfHCmZzFfVUw4CPle8PTYFAaqwbaxBBtNq6t2JakQ==
X-Received: by 2002:a05:6808:198c:b0:3ae:554b:9c97 with SMTP id
 bj12-20020a056808198c00b003ae554b9c97mr10890244oib.37.1698017382900; 
 Sun, 22 Oct 2023 16:29:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 10/94] target/sparc: Add decodetree infrastructure
Date: Sun, 22 Oct 2023 16:28:08 -0700
Message-Id: <20231022232932.80507-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


