Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C597B2608
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:43:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwti-0007wG-Vy; Thu, 28 Sep 2023 15:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtg-0007uV-C1
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwte-0007xL-H3
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c63164a2b6so43963445ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930121; x=1696534921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LstmnDMwNDQFVw3SQAKvu0MWGEv1hgOUR8OcXIkEB5k=;
 b=udjhRXyaR6+EP4YXXJSAjqxn94Wn/tjU0C4jbQYxmD8khm1rOBzeR3PUrsuJ02Hwq9
 z47vMqZLm50ygMC06mYTOGER6MCYfYy7pnTPOn55yi3UqIzDwaVWvjep42S3Qu0mhZI7
 2PQBBfJRHla986m2NQBRx9YRIFv5vyREJlGQsYDqZWo4Tb5AxV1ITDbIYeIX1tCPh9h6
 KdceA81+HAxx4kKcMknIatTdsJfmDXbCqnxpiZqBksMZiHvQUVlvuItmrFtIMnmQWVdY
 bRIVUq4Y+1pyepANXpl0P6zA7ODuwzvr+bq75pjfnnbgOI9dfvOrVqecn7HGJNDqdB9Z
 odHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930121; x=1696534921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LstmnDMwNDQFVw3SQAKvu0MWGEv1hgOUR8OcXIkEB5k=;
 b=KtRu0IavGE+am+GhTJKmwXlV9wntXHDR5pIbuTFYP5wUXP8wgU2TOH+7gcji0s823J
 0jRVMISY8npgdhitwmrqPWqzvuwrPvSXM7Q6I2BE9ng7UyJl33nbep7y+OamEiLja2Oz
 U946VSEorZwM1KJudqFiG8wDH+ye2+oaMIq0eERz0z1K7wWwhEuMpCC1If45OJXDaj6y
 0X8vbGwW5aCpFDMH/99gadE8g8IRZ5ZvM+mN6pEcb5EIdlDtPKoCkSjTBBwo+L/4yPzb
 z4HNjW4kCV9CpN6AYSVuMqrmnLI2o7aiWLEeFFMHoDmvqZHgLICIt7nbRwfb1n/JwScJ
 zrog==
X-Gm-Message-State: AOJu0YxXaGTxQzwehvwyFBZqjQiSJxIlndvrCb+A7W2emJueisA2JOFS
 5nIGcQ6vb/4seDqV7pqQJTZ2EhHw8zv4ClywOMg=
X-Google-Smtp-Source: AGHT+IGVeJgfXsbq/zF4oFQYIfEu2XzkxqVBSnzi/HtJPJ9San7nUweDj/qAujiuFs46Ote2ENVeRg==
X-Received: by 2002:a17:902:e80e:b0:1c2:193e:1126 with SMTP id
 u14-20020a170902e80e00b001c2193e1126mr3180189plg.28.1695930120909; 
 Thu, 28 Sep 2023 12:42:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:42:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/6] accel/tcg: Track current value of can_do_io in the TB
Date: Thu, 28 Sep 2023 12:41:53 -0700
Message-Id: <20230928194156.237351-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Simplify translator_io_start by recording the current
known value of can_do_io within DisasContextBase.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  2 ++
 accel/tcg/translator.c    | 31 ++++++++++++++-----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 4e17c4f401..9d9e980819 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,6 +72,7 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
+ * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -83,6 +84,7 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
+    int8_t saved_can_do_io;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index b6ab9f3d33..850d82e26f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,11 +16,14 @@
 #include "tcg/tcg-op-common.h"
 #include "internal.h"
 
-static void gen_io_start(void)
+static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
+    if (db->saved_can_do_io != val) {
+        db->saved_can_do_io = val;
+        tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
+                       offsetof(ArchCPU, parent_obj.can_do_io) -
+                       offsetof(ArchCPU, env));
+    }
 }
 
 bool translator_io_start(DisasContextBase *db)
@@ -30,12 +33,8 @@ bool translator_io_start(DisasContextBase *db)
     if (!(cflags & CF_USE_ICOUNT)) {
         return false;
     }
-    if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
-        /* Already started in translator_loop. */
-        return true;
-    }
 
-    gen_io_start();
+    set_can_do_io(db, true);
 
     /*
      * Ensure that this instruction will be the last in the TB.
@@ -47,7 +46,7 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
-static TCGOp *gen_tb_start(uint32_t cflags)
+static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 {
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
@@ -91,12 +90,9 @@ static TCGOp *gen_tb_start(uint32_t cflags)
          * cpu->can_do_io is cleared automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
          * -icount, plus it would be very easy to forget doing it in the
-         * translator. Doing it here means we don't need a gen_io_end() to
-         * go with gen_io_start().
+         * translator.
          */
-        tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
-                       offsetof(ArchCPU, env));
+        set_can_do_io(db, false);
     }
 
     return icount_start_insn;
@@ -147,6 +143,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
+    db->saved_can_do_io = -1;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
@@ -154,7 +151,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     /* Start translating.  */
-    icount_start_insn = gen_tb_start(cflags);
+    icount_start_insn = gen_tb_start(db, cflags);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -181,7 +178,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
            the next instruction.  */
         if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
-            gen_io_start();
+            set_can_do_io(db, true);
         }
         ops->translate_insn(db, cpu);
 
-- 
2.34.1


