Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DB89CB2F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Apr 2024 19:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8N-00027N-It; Mon, 08 Apr 2024 13:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8K-00026s-TE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt8J-0003jm-1b
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:16 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so3811216a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598612; x=1713203412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWeWfrDPztEwkV9YuE7zu+DtIohBh0oWfxn6udjmQ4s=;
 b=XgqngNY7YmqvH/feZBb2y0Pp4VesJsceCYF1LyLUleUK9m7MvWu5/qGaUrhvc8zSb4
 VwsVtMd21dvdUQ8YnfZG/z+Ivi/uqc8DciYHFxygkHide5fdbkRFbm1vDaT04XB9sHz2
 F53Ac1ckiysBIXonSUcs1YvJ7LwoM7RGpAzoKIOnRaycsajV7PCIb2vnDs39tF7CWK1o
 IehPl2S+T+OkqPCXdIJBetDD+Z7k/sHOUnbp01JjLhos4hL+p4k2uRJOfmhAeAYed1+m
 epnDO2z+FI0GlBeAct9HFS9d7Z0UTB+UKDjCG2l7UanuGagdfPjc/Xx8ZBgMyLmYVSfw
 v6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598612; x=1713203412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWeWfrDPztEwkV9YuE7zu+DtIohBh0oWfxn6udjmQ4s=;
 b=uCsAOScy6qglBj+b54fqHAoeV90FP+tNEXX5aulCZoJbLRfCA0JCcDwmlFmrF+x4iI
 0xaG+Oe3SlQ0Sl6xgXw8tgTBLZqZnmGxOogQSvrrVYkEj9koyaGP/HPpc8zP4F17499i
 38jKwbYSH97GcXEmIQ1wQOKIRhLAKg8qIe6QKdNYo4sRRQ7YylG+bUSD8CiS+J9rDKgS
 hg/bdf0igi8cCTkWwjK6hvsBnaaysVrJb1rgW8cJmPVZsAqWv4Whqoz27mS2QWL/7XI+
 m7vGe+SLb71X88UMi1dPq48o93XyWKdwh9JmQ9Cv1yzrgdhfTda/Ynq/mh3i6CksR1+U
 Sw4g==
X-Gm-Message-State: AOJu0YyC2Vr9Pl7AmVcBgvDJW+G2GZizR68X4rSSAZqER8Nh8fjrfFZV
 WabMCsmPCbQxZTtwc1Lyr7O2Uf6Ze5u0Y2SM06wj11KFhURzVlyO1myjMS+n/vQcA02dn5hFlAb
 K
X-Google-Smtp-Source: AGHT+IGtl5EAeMFBnm3J24SXUxUFppKqtxQAhInllf9x+JDL59fGQxM1swl4FRFsZetLLHt4H3PNgw==
X-Received: by 2002:a17:90b:24a:b0:2a0:8eed:56ec with SMTP id
 fz10-20020a17090b024a00b002a08eed56ecmr8432988pjb.39.1712598612163; 
 Mon, 08 Apr 2024 10:50:12 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?J=C3=B8rgen=20Hansen?= <Jorgen.Hansen@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/35] accel/tcg: Improve can_do_io management
Date: Mon,  8 Apr 2024 07:49:21 -1000
Message-Id: <20240408174929.862917-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

We already attempted to set and clear can_do_io before the first
and last insns, but only used the initial value of max_insns and
the call to translator_io_start to find those insns.

Now that we track insn_start in DisasContextBase, and now that
we have emit_before_op, we can wait until we have finished
translation to identify the true first and last insns and emit
the sets of can_do_io at that time.

This fixes the case of a translation block which crossed a page
boundary, and for which the second page turned out to be mmio.
In this case we truncate the block, and the previous logic for
can_do_io could leave a block with a single insn with can_do_io
set to false, which would fail an assertion in cpu_io_recompile.

Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  1 -
 accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index ceaeca8c91..2c4fb818e7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -87,7 +87,6 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
-    int8_t saved_can_do_io;
     bool plugin_enabled;
     struct TCGOp *insn_start;
     void *host_addr[2];
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ae61c154c2..9de0bc34c8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,20 +18,14 @@
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    if (db->saved_can_do_io != val) {
-        db->saved_can_do_io = val;
-
-        QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
-        tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
-                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                        offsetof(ArchCPU, env));
-    }
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
+    tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
+                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
+                    offsetof(ArchCPU, env));
 }
 
 bool translator_io_start(DisasContextBase *db)
 {
-    set_can_do_io(db, true);
-
     /*
      * Ensure that this instruction will be the last in the TB.
      * The target may override this to something more forceful.
@@ -84,13 +78,6 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
                          - offsetof(ArchCPU, env));
     }
 
-    /*
-     * cpu->neg.can_do_io is set automatically here at the beginning of
-     * each translation block.  The cost is minimal, plus it would be
-     * very easy to forget doing it in the translator.
-     */
-    set_can_do_io(db, db->max_insns == 1);
-
     return icount_start_insn;
 }
 
@@ -129,6 +116,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
+    TCGOp *first_insn_start = NULL;
     bool plugin_enabled;
 
     /* Initialize DisasContext */
@@ -139,7 +127,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
-    db->saved_can_do_io = -1;
     db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
@@ -159,6 +146,9 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
         db->insn_start = tcg_last_op();
+        if (first_insn_start == NULL) {
+            first_insn_start = db->insn_start;
+        }
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
@@ -171,10 +161,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
          * done next -- either exiting this loop or locate the start of
          * the next instruction.
          */
-        if (db->num_insns == db->max_insns) {
-            /* Accept I/O on the last instruction.  */
-            set_can_do_io(db, true);
-        }
         ops->translate_insn(db, cpu);
 
         /*
@@ -207,6 +193,21 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
+    /*
+     * Manage can_do_io for the translation block: set to false before
+     * the first insn and set to true before the last insn.
+     */
+    if (db->num_insns == 1) {
+        tcg_debug_assert(first_insn_start == db->insn_start);
+    } else {
+        tcg_debug_assert(first_insn_start != db->insn_start);
+        tcg_ctx->emit_before_op = first_insn_start;
+        set_can_do_io(db, false);
+    }
+    tcg_ctx->emit_before_op = db->insn_start;
+    set_can_do_io(db, true);
+    tcg_ctx->emit_before_op = NULL;
+
     if (plugin_enabled) {
         plugin_gen_tb_end(cpu, db->num_insns);
     }
-- 
2.34.1


