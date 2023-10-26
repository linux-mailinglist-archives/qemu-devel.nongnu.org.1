Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2B7D794A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2t-0007A0-NH; Wed, 25 Oct 2023 20:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2o-00072w-5B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rJ-Kf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c87a85332bso2311545ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279360; x=1698884160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tqKRfrHgf804PVSbuQwIQNkobvA0TCMv4wurSnK70U=;
 b=Q7KsIQ+cwLgSl+d5X2Be0oi3HG1QjXMfaTIGH2ZNhS6U8r6r4nBDjr17HinvGfoaAp
 MGFe2RytQ4R7OpfTRw5Mii9VHbNaGZ0HNOAjKp8i78ZupkIvx4CNTWBTynaFRYoI2CRi
 cTKUu3rTlQ0mjIB/D8eqxrPlWZdfbwLX+hG2ivw8IQk9dChRjAy7NCVsavmmPgcg8pDB
 oTEbGwAQx7jZ8tFYoCsMoBx8InR1kH0kt5AW/jQcMsngzBy0YsNRyDtm/wJ5zgGXbp1h
 WnXH0j4UrcWyQrNwtwEhw8t3l1lsoQsVfMXgznaXXYRKWX57Q7B2MEUnRTxynuwH5TyW
 j5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279360; x=1698884160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tqKRfrHgf804PVSbuQwIQNkobvA0TCMv4wurSnK70U=;
 b=F4qkGaVMNBiet8D15xhEcBu8R/fYd/ysdAA6mcOtURgE+aCwkix2GUVT3cWRNi+W6V
 Y0vpjdU8TKwv6lmCib/yH6kf7CFjXVoi6blMDx9YPYK6562a7OqMDrwe8QESTqhjO9u2
 mUi1uJejO7lWA9Te4B6tasIpe/SK0SFF7nherz+pEAWccp7D2ifPZ/2wmNZmXs5uSokp
 Kfv/EqIVmowGE/V6WqQbh/bmMtu8HgyqjZepcG472CxvPYR0trFejJCo/aqvhqbmFicr
 WarbJnXZr1hIgkGytZBnK7VHt8sp/BhFNf3BM554Wjxub5xcwOJuA5ikidgU2DUXAsNM
 0q5g==
X-Gm-Message-State: AOJu0Yxq1920bG67PiSX1/LHmDyuaEXN9zG9aP5xC3vSedoJ+eLgZKOw
 EN4yvb+kjzWFyZQAdRXUolx6d/43JaDL8wbW6Vk=
X-Google-Smtp-Source: AGHT+IGP2nbbJWPzCcr0ZXnTaGczEMxqTViR+TSpYPE506MFAzEuUdgz2kBp4gQ9o6+1h9sWZBGqNg==
X-Received: by 2002:a17:902:e80b:b0:1c5:6157:f073 with SMTP id
 u11-20020a170902e80b00b001c56157f073mr17257385plg.11.1698279359858; 
 Wed, 25 Oct 2023 17:15:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/94] target/sparc: Add decodetree infrastructure
Date: Wed, 25 Oct 2023 17:13:58 -0700
Message-Id: <20231026001542.1141412-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


