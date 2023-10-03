Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BC7B70ED
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAt-00085E-PM; Tue, 03 Oct 2023 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAq-00083M-60
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0001ez-U7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c871a095ceso4606525ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357865; x=1696962665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kobt9ITR02o3tC8SBBDgsqKPWPKYYPtp7QPvo0pQJWc=;
 b=b8vXXcBkI/NL18Tmlr3wgAshM+MKRul8N0CXEQZCZg8iawa+IKDZSfK885cUoumTro
 A6KREANkiwTrFiFe2Zs3FJypbwv7si1au8JWlgCOCQ8Wwb6oD/P4cR+dUTO4qnsIN+dE
 DDtkB80m84EN4iVEeeNdmg0sNbRNVZOAjJkGvBSL9r6+ESfyqyRo5FD5mRO56qh1HFaz
 EwkhIsm2ORz9tcYUCALQFYWIfAfjA1nN9sBf16jzIUIusJV1DSK1j8v/MDil5rt7eSz1
 hI5rvNR2pH3Wn99IZBmRZX2WnGiVy3cX+kXXt0j3BJJ1J3DTmfDoLqgMQUxiauPBYLGO
 mS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357865; x=1696962665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kobt9ITR02o3tC8SBBDgsqKPWPKYYPtp7QPvo0pQJWc=;
 b=Y8rH4FydVEpbEiahDwnlG4OXGaeJxWNZouEGebc6HTsNX94yOcIe4oRioqZjBAMUe3
 eo7nsjQtmkYEMbu4y3tts7N44jQkOiZ+vRExKvUrd38BXCpqDxnPJ0IyQo/oGnxHTHjg
 SV7af2jMgvLEDU1dyu08lJdSz3Ms2BXCOlZ5HZ2Fmuk0J87u7sEbqw5kuMGJEA7AtmQt
 P5lLPAwhNvz1r5OiDF1hPi8ayicC3Gujr2hkFhDT6a/0163sXwYdyQqqIz5ZPjLQJTH3
 3gOPOKrOzPsnjnhkNxrQ9CTh2vbBJg2vxYWiUp+7wiRWFS095qQYK6lt9S4cEh9iAWpR
 7W+w==
X-Gm-Message-State: AOJu0Yz15b9DfHt+Er+9FrDrpsa2jlem4kx7EhcQafMF2xCtC7qzb7zN
 /ZikW19EiWGHgvID1PY8MTMULQyIBPwszHFyBfc=
X-Google-Smtp-Source: AGHT+IGw+wh7INeFkgjD4g3+4YpsaoIMa9JPIc8NfwgWN8jOjz4I0zHw6iBBZIIhIaMT54qiC1awtg==
X-Received: by 2002:a17:902:ab82:b0:1c7:365a:566d with SMTP id
 f2-20020a170902ab8200b001c7365a566dmr314417plr.66.1696357865384; 
 Tue, 03 Oct 2023 11:31:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 06/16] accel/tcg: Collect TB execution statistics
Date: Tue,  3 Oct 2023 11:30:48 -0700
Message-Id: <20231003183058.1639121-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Collect atomic and normal execution counts for TBs which
have allocated a stats structure.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c   |  6 ++++++
 accel/tcg/translator.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1a5bc90220..1114eae5c4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -26,6 +26,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
+#include "tcg/tb-stats.h"
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "exec/log.h"
@@ -601,6 +602,11 @@ void cpu_exec_step_atomic(CPUState *cpu)
         }
 
         cpu_exec_enter(cpu);
+
+        if (tb_stats_enabled_for_tb(tb, TB_STATS_EXEC)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         /* execute the generated code */
         trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb, &tb_exit);
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index e7abcd86c1..eac281b229 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,6 +14,8 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
+#include "tcg/tcg-temp-internal.h"
+#include "tcg/tb-stats.h"
 #include "internal-target.h"
 
 static void set_can_do_io(DisasContextBase *db, bool val)
@@ -112,6 +114,31 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
     }
 }
 
+static void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled_for_tb(tb, TB_STATS_EXEC)) {
+        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
+        if (sizeof(tb->tb_stats->executions.normal) == 4) {
+            TCGv_i32 t = tcg_temp_ebb_new_i32();
+            tcg_gen_ld_i32(t, ptr, 0);
+            tcg_gen_addi_i32(t, t, 1);
+            tcg_gen_st_i32(t, ptr, 0);
+            tcg_temp_free_i32(t);
+        } else if (sizeof(tb->tb_stats->executions.normal) == 8) {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            tcg_gen_ld_i64(t, ptr, 0);
+            tcg_gen_addi_i64(t, t, 1);
+            tcg_gen_st_i64(t, ptr, 0);
+            tcg_temp_free_i64(t);
+        } else {
+            qemu_build_not_reached_always();
+        }
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
 bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
@@ -148,6 +175,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Start translating.  */
     icount_start_insn = gen_tb_start(db, cflags);
+    gen_tb_exec_count(tb);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-- 
2.34.1


