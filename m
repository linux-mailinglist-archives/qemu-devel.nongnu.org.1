Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D99D7CBB0F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK8-00008z-Ln; Tue, 17 Oct 2023 02:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK6-0008UA-QU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK3-0003qX-VO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so34900235ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523173; x=1698127973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCQ11G4CDtK3oW1LuqfPuIgRALcswxq9MCt2fHEKN58=;
 b=Bt0lz6Xk7g5P705ut/0iztLw9zoT8JKvoI2iarXkcoebjxNFpcBvHMVp47y1hVPg25
 ipO9nq5HFhyOTcHN2k51ly3JQzkUIfwcDoMqrQRVdK95Jv+2Pmg36YK37DLyI+OL7fbx
 8bXbR0fIgm4nbLme1koM+QDSRDVHoSNhnbnHZT9ums8m7MnBp25EyDyPpbCeMcKmR6Oy
 wrkOe+CViiIO5/6yxFyVkygHreBVJvGfSR4dh4rc7oXKCyE105cU47Kfn16WWuNGqw+/
 ChMfEKLEbYglOGWaMnXa4DbtzjuctcPvBjfyzjoa2hexUA/kqlViHWwDcS3fgGLinlfl
 MSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523173; x=1698127973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCQ11G4CDtK3oW1LuqfPuIgRALcswxq9MCt2fHEKN58=;
 b=DOom3hdfAZSpj+kEF7sokIUI7ly7RdaQNKK3U4NPckQU2kiaSiZeSk/I1ZOb/Iy8MF
 qFaheVmsy2bPQOBIeiPpF1z0pjs3VCdN4t7IEH0w0lEdULLR6BEbvPdB4+75yFNlPpkg
 cslnfPIZIVLPYQyfIyRt3ip6vw8/Gfcpd+5pwesA1PEiE20LeciKrbGe1jO3tpEX8o0X
 SbIfAtpdDxG06GGcAlmKjtlHKQPlfTSb114TOwlgNkNJ41fHuEMunQlIG89+Y53UM86E
 NaxeVDG0joRcyl0T5aqQIh6oZ1Jc3gZUInEBwDtHQggfdVBtVmOTrLrG6U2Eytu2YwQl
 BF2g==
X-Gm-Message-State: AOJu0Yya7RxUFNWoCsLO9/vhh5M1rK9RdqWv7POodYwzD0LyS+trtM0i
 Kebg/B28DL0h8gv5DS3tYIavaqTO8CXdEVM0oUE=
X-Google-Smtp-Source: AGHT+IF8yQwT46jO1qKdXqG6Rv2lxdyPIPWLnGzbZJppATKuG76j8jx2oBQs5RevSdgqgFOQ1yUqNw==
X-Received: by 2002:a17:902:bd07:b0:1c9:c951:57f9 with SMTP id
 p7-20020a170902bd0700b001c9c95157f9mr1164567pls.68.1697523173446; 
 Mon, 16 Oct 2023 23:12:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/90] target/sparc: Add decodetree infrastructure
Date: Mon, 16 Oct 2023 23:11:23 -0700
Message-Id: <20231017061244.681584-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


