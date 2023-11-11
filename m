Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD47E878E
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1cqk-0001yo-Lz; Fri, 10 Nov 2023 20:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1cqi-0001yX-Oh
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:31:48 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1cqg-0001WA-GS
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:31:48 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc5916d578so23144165ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666304; x=1700271104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGcpOmaHBdTN6OTpAuovNYElfrTOAhG1II3xdJIUm9A=;
 b=fpj7u2urXld1PRJHB1WSSLlto0SOYUSMy7yoxMA307aQITH7exgy/BgEo8u2pFnX3K
 w0zZA3gXgcdXWOnYuFSCo3x4FxSeXfYjN9Y047xuH5GMLi9z124VPMz+n3BFg3lJxEU3
 rVnkro0rhZb1uZ/sH4CyXNa5X4fmwsfntVUhoaB6eCaklqfPA36a9bWoEHl4xTHpuqmz
 isl1kryLVvaTEYhcOWVk2xz+AY0KYGB+DRTlaUIK1aUCudlaHN/gSYBmduc72MTs10o5
 0f74Y5PCWXiQr0pjOf6cAHx0SEvqIsnyuCW9V/X6B3JgeAUTl2fykdglqA0rIyclUnH9
 TyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666304; x=1700271104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGcpOmaHBdTN6OTpAuovNYElfrTOAhG1II3xdJIUm9A=;
 b=f+fPYAeOnmnZrcMk0YC7aAsJPqXD0B0C/X7yx9JR1mjhu44+Wf1qN0O7jp1kyvjbEs
 m1Yw3c0JtgjixiGSSI7v2j8IgLlbFSLwid+qlwYjS9AYqFE/6gkCkcc6TEikM20dDmWZ
 ikXDNr9ohye973NKO2b0PGaYRHNLkrmdUU3/7p4uw96xrJIZvVYIPdqaj+qmNf5UZQUq
 OxCFlAZLSlIHpj+TCG73O4fbi9NViM4uHTQzy4cjiYGscgJmmgtDxNTY9TtW0Cvg3CdH
 MiJReqoSTaKlvCxjXk+NeInkcOJ/AL4JBRcOigQZgUNO7ZZyaJUrrSiWb/HiXahtEFbF
 Qgrw==
X-Gm-Message-State: AOJu0Yy37icxZFqXYe+IDwTn25vSWbHHTpgCXUk9ABk35/OB2qcCZiu5
 JwFECUGq3/3E59T7CoZkoeSpoixcZiFwj7u/GoU=
X-Google-Smtp-Source: AGHT+IHiFoO6eWPoyWl8f6tlB4n4vIim6vTzSi4JfAXEo7OTx0iDDHqQSDo1uhFz1kfTPK8RX1vf8w==
X-Received: by 2002:a17:903:234c:b0:1cc:5674:9184 with SMTP id
 c12-20020a170903234c00b001cc56749184mr1320824plh.31.1699666304138; 
 Fri, 10 Nov 2023 17:31:44 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170902a9c900b001c60c3f9508sm276465plr.230.2023.11.10.17.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:31:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	=?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH for-8.2] accel/tcg: Remove CF_LAST_IO
Date: Fri, 10 Nov 2023 17:31:30 -0800
Message-Id: <20231111013141.229605-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013141.229605-1-richard.henderson@linaro.org>
References: <20231111013141.229605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In cpu_exec_step_atomic, we did not set CF_LAST_IO, which can
lead to a loop with cpu_io_recompile.

But since 18a536f1f8 ("Always require can_do_io") we no longer need
a flag to indicate when the last insn should have can_do_io set, so
remove the flag entirely.

Reported-by: Clément Chigot <chigot@adacore.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1961
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-icount.rst        |  6 ------
 include/exec/translation-block.h | 13 ++++++-------
 accel/tcg/cpu-exec.c             |  2 +-
 accel/tcg/tb-maint.c             |  6 ++----
 accel/tcg/translate-all.c        |  4 ++--
 accel/tcg/translator.c           | 22 +++++++++-------------
 system/watchpoint.c              |  6 ++----
 7 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index 50c8e8dabc..7df883446a 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -62,12 +62,6 @@ To deal with this case, when an I/O access is made we:
   - re-compile a single [1]_ instruction block for the current PC
   - exit the cpu loop and execute the re-compiled block
 
-The new block is created with the CF_LAST_IO compile flag which
-ensures the final instruction translation starts with a call to
-gen_io_start() so we don't enter a perpetual loop constantly
-recompiling a single instruction block. For translators using the
-common translator_loop this is done automatically.
-  
 .. [1] sometimes two instructions if dealing with delay slots  
 
 Other I/O operations
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b785751774..e2b26e16da 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -71,13 +71,12 @@ struct TranslationBlock {
 #define CF_NO_GOTO_TB    0x00000200 /* Do not chain with goto_tb */
 #define CF_NO_GOTO_PTR   0x00000400 /* Do not chain with goto_ptr */
 #define CF_SINGLE_STEP   0x00000800 /* gdbstub single-step in effect */
-#define CF_LAST_IO       0x00008000 /* Last insn may be an IO access.  */
-#define CF_MEMI_ONLY     0x00010000 /* Only instrument memory ops */
-#define CF_USE_ICOUNT    0x00020000
-#define CF_INVALID       0x00040000 /* TB is stale. Set with @jmp_lock held */
-#define CF_PARALLEL      0x00080000 /* Generate code for a parallel context */
-#define CF_NOIRQ         0x00100000 /* Generate an uninterruptible TB */
-#define CF_PCREL         0x00200000 /* Opcodes in TB are PC-relative */
+#define CF_MEMI_ONLY     0x00001000 /* Only instrument memory ops */
+#define CF_USE_ICOUNT    0x00002000
+#define CF_INVALID       0x00004000 /* TB is stale. Set with @jmp_lock held */
+#define CF_PARALLEL      0x00008000 /* Generate code for a parallel context */
+#define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
+#define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1a5bc90220..c938eb96f8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -721,7 +721,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
-                | CF_LAST_IO | CF_NOIRQ | 1;
+                | CF_NOIRQ | 1;
         }
 #endif
         return false;
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index e678d20dc2..3d2a896220 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1083,8 +1083,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb =
-            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         return true;
     }
     return false;
@@ -1154,8 +1153,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     if (current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb =
-            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
+        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b263857ecc..79a88f5fb7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -304,7 +304,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     if (phys_pc == -1) {
         /* Generate a one-shot TB with 1 insn in it */
-        cflags = (cflags & ~CF_COUNT_MASK) | CF_LAST_IO | 1;
+        cflags = (cflags & ~CF_COUNT_MASK) | 1;
     }
 
     max_insns = cflags & CF_COUNT_MASK;
@@ -632,7 +632,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * operations only (which execute after completion) so we don't
      * double instrument the instruction.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_LAST_IO | n;
+    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = log_pc(cpu, tb);
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 575b9812ad..38c34009a5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -89,7 +89,7 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
      * each translation block.  The cost is minimal, plus it would be
      * very easy to forget doing it in the translator.
      */
-    set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
+    set_can_do_io(db, db->max_insns == 1);
 
     return icount_start_insn;
 }
@@ -151,13 +151,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-    if (cflags & CF_MEMI_ONLY) {
-        /* We should only see CF_MEMI_ONLY for io_recompile. */
-        assert(cflags & CF_LAST_IO);
-        plugin_enabled = plugin_gen_tb_start(cpu, db, true);
-    } else {
-        plugin_enabled = plugin_gen_tb_start(cpu, db, false);
-    }
+    plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
     db->plugin_enabled = plugin_enabled;
 
     while (true) {
@@ -169,11 +163,13 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             plugin_gen_insn_start(cpu, db);
         }
 
-        /* Disassemble one instruction.  The translate_insn hook should
-           update db->pc_next and db->is_jmp to indicate what should be
-           done next -- either exiting this loop or locate the start of
-           the next instruction.  */
-        if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
+        /*
+         * Disassemble one instruction.  The translate_insn hook should
+         * update db->pc_next and db->is_jmp to indicate what should be
+         * done next -- either exiting this loop or locate the start of
+         * the next instruction.
+         */
+        if (db->num_insns == db->max_insns) {
             /* Accept I/O on the last instruction.  */
             set_can_do_io(db, true);
         }
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 45d1f12faf..ba5ad13352 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -179,8 +179,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                  */
                 if (!cpu->neg.can_do_io) {
                     /* Force execution of one insn next time.  */
-                    cpu->cflags_next_tb = 1 | CF_LAST_IO | CF_NOIRQ
-                                          | curr_cflags(cpu);
+                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                     cpu_loop_exit_restore(cpu, ra);
                 }
                 /*
@@ -212,8 +211,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
-                cpu->cflags_next_tb = 1 | CF_LAST_IO | CF_NOIRQ
-                                      | curr_cflags(cpu);
+                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
                 mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
-- 
2.34.1


