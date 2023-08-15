Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D777C6E2
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 07:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVmBY-000241-7D; Tue, 15 Aug 2023 01:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qVmBV-00023n-FR; Tue, 15 Aug 2023 01:01:37 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qVmBT-0001JU-Fr; Tue, 15 Aug 2023 01:01:37 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-56cc461f34fso3267624eaf.0; 
 Mon, 14 Aug 2023 22:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692075693; x=1692680493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HBoHcbqbhFgQor55ui9/J/PunxjJ+Orzr8fv8qZ5Hmk=;
 b=mMHZxNmhtMdEbwDHd7CUaUbVa23biBcC7p+O3lKcNvh2KkQoWTlnd2WArQ0ufKBqp0
 59epnZXSI+4KzkUHCrOZN/zQYOA+9FND6c8qnYE6iHHvuRweKWulOhx8ObcYLeuAOINh
 uWrFLm/kqNG+QArlEa9IEWXqGTEijrTeeOulyOXsXrL85h92LR0NFEY752pW6KW84zMJ
 kFt9b1cVgs4weBQUFg3JnvcfSOLJ05rXu6FDAdFiFOd3gP4L5Zyjp3dNMb5v3yXpe8f0
 d40ibns1Vxw3zok3TRwOSubc8D7FVTrmjGS599+L14vDOx1tyjIYFAHtuSQ5fFAYnUNx
 5KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692075693; x=1692680493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBoHcbqbhFgQor55ui9/J/PunxjJ+Orzr8fv8qZ5Hmk=;
 b=LFgaxljAdliH4UMXOPZEs7yJD3Vhx3nocBVxki/HdiLJqrDF/mzd2AVkHEl0uuJf6o
 VHDZsYnm/8XgI7lphbmOjtgJLrEj9FNbPwnLumtgxtxWjEGUUqm2E/hhsSSrdx3c5VZ8
 Vb5BoqtbEgN2Zhn0nLZpYDjMET8gUipoAravcSmpFcx+t/kMO9IPncd443M7lI680ndN
 B2nkpbwlUmCn/n1hpnCPtE5k2qTapXr/DF3jfbVnkLM5cHrnRwYWMzIcD0W1CVAtPrd8
 sygCGN+2Y37Oq6KZ37RlZJC5tk3+mr/bXU9+pYjsAwd1O7z2zaxBW9voe6cGcQ/hpomI
 ksBQ==
X-Gm-Message-State: AOJu0Yx5J2lk0c8bOmIIA1JVQmjEDMGnhd3zoyg6bKdM9QHO0m2yL1bs
 yrmtTni+IVZRYrRwUo67auacoe8Vcwk=
X-Google-Smtp-Source: AGHT+IEF6VNG8AOG3KrEJ+NKVHQWWr7UcmWeRLy1AVdQtP2g25+RZ9iNUiLs3TeItoXuB45PSngdRg==
X-Received: by 2002:a05:6358:249b:b0:134:d128:9f5f with SMTP id
 m27-20020a056358249b00b00134d1289f5fmr10025287rwc.9.1692075693049; 
 Mon, 14 Aug 2023 22:01:33 -0700 (PDT)
Received: from pwon.ozlabs.ibm.com ([146.112.118.69])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a62ea07000000b006871859d9a1sm8734189pfh.7.2023.08.14.22.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 22:01:32 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, npiggin@gmail.com,
 bgray@linux.ibm.com, Jordan Niethe <jniethe5@gmail.com>
Subject: [RFC PATCH] tcg/ppc: Enable direct branching tcg_out_goto_tb with
 TCG_REG_TB
Date: Tue, 15 Aug 2023 15:01:17 +1000
Message-Id: <20230815050117.34731-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=jniethe5@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Direct branch patching was disabled when using TCG_REG_TB in commit
736a1588c1 ("tcg/ppc: Fix race in goto_tb implementation"). Commit
7502f89c74 ("tcg/ppc: Use prefixed instructions for tcg_out_goto_tb")
used the support for pc relative ISAv3.1 instructions to re-enable
direct branch patching on POWER10.

The issue with direct branch patching with TCG_REG_TB is the lack of
synchronization between the new TCG_REG_TB being established and the
direct branch being patched in.

If each translation block is responsible for establishing its own
TCG_REG_TB then there can be no synchronization issue.

Make each translation block begin by setting up its own TCG_REG_TB.
ISA v3.0 has addpcis so use that for getting the pc at the beginning of
a translation block (plus offset). For systems without addpcis, use
the preferred 'bcl 20,31,$+4' sequence.

When branching indirectly to a translation block the setup sequence can
be skipped if the caller sets up TCG_REG_TB as there is no possible race
in this case.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
This is just a proof of concept, not sure that this is the correct way
to do this or even if it is something we'd like to do.

Applies on top of Richard's series [1].

  [1] https://lore.kernel.org/qemu-devel/20230808030250.50602-1-richard.henderson@linaro.org/
---
 include/tcg/tcg.h        |  1 +
 tcg/ppc/tcg-target.c.inc | 59 ++++++++++++++++++++++++++--------------
 tcg/tcg.c                |  3 ++
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..337506fea0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -518,6 +518,7 @@ struct TCGContext {
        extension that allows arithmetic on void*.  */
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
+    size_t code_gen_entry_size;
     void *code_gen_ptr;
     void *data_gen_ptr;
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b686a68247..4b55751051 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -382,6 +382,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define CRNAND XO19(225)
 #define CROR   XO19(449)
 #define CRNOR  XO19( 33)
+#define ADDPCIS  XO19( 2)
 
 #define EXTSB  XO31(954)
 #define EXTSH  XO31(922)
@@ -2635,6 +2636,30 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, BCLR | BO_ALWAYS);
 }
 
+
+#define TCG_TARGET_NEED_ENTER_TB
+static void tcg_out_enter_tb(TCGContext *s)
+{
+    if (!USE_REG_TB) {
+        return;
+    }
+
+    if (have_isa_3_00) {
+        /* lnia REG_TB */
+        tcg_out32(s, ADDPCIS | RT(TCG_REG_TB));
+        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -4));
+    } else {
+        tcg_out32(s, MFSPR | RT(TCG_REG_TMP1) | LR);
+        /* bcl 20,31,$+4 (Preferred form for getting nia.) */
+        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
+        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -8));
+        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | LR);
+    }
+
+    s->code_gen_entry_size = tcg_current_code_size(s);
+}
+
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 {
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, arg);
@@ -2645,23 +2670,6 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
 
-    if (USE_REG_TB) {
-        /*
-         * With REG_TB, we must always use indirect branching,
-         * so that the branch destination and TCG_REG_TB match.
-         */
-        ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
-        tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
-        tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-
-        /* For the unlinked case, need to reset TCG_REG_TB.  */
-        set_jmp_reset_offset(s, which);
-        tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
-                         -tcg_current_code_size(s));
-        return;
-    }
-
     /* Direct branch will be patched by tb_target_set_jmp_target. */
     set_jmp_insn_offset(s, which);
     tcg_out32(s, NOP);
@@ -2670,6 +2678,13 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (have_isa_3_10) {
         ptrdiff_t offset = tcg_pcrel_diff_for_prefix(s, (void *)ptr);
         tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
+    } else if (USE_REG_TB) {
+        ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
+
+        tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
+        /* Callee can skip establishing REG_TB for the indirect case. */
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TB,
+                                s->code_gen_entry_size));
     } else {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
@@ -2678,6 +2693,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
     tcg_out32(s, BCCTR | BO_ALWAYS);
     set_jmp_reset_offset(s, which);
+
+    /* For the unlinked case, need to reset TCG_REG_TB.  */
+    if (USE_REG_TB) {
+        tcg_out_movi_int(s, TCG_TYPE_I64, TCG_REG_TB,
+                         (tcg_target_long)s->code_buf, true);
+    }
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -2687,10 +2708,6 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     intptr_t diff = addr - jmp_rx;
     tcg_insn_unit insn;
 
-    if (USE_REG_TB) {
-        return;
-    }
-
     if (in_range_b(diff)) {
         insn = B | (diff & 0x3fffffc);
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddfe9a96cb..20698131c2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -6010,6 +6010,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
 
     num_insns = -1;
+#ifdef TCG_TARGET_NEED_ENTER_TB
+    tcg_out_enter_tb(s);
+#endif
     QTAILQ_FOREACH(op, &s->ops, link) {
         TCGOpcode opc = op->opc;
 
-- 
2.39.3


