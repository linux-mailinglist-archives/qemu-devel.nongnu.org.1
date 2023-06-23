Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B334573BDC4
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 19:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCkXr-00076Q-3l; Fri, 23 Jun 2023 13:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCkXp-00076E-Mx
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 13:26:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCkXn-0002p3-Sg
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 13:26:01 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3129c55e1d1so1011563f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687541158; x=1690133158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cvrcpWiGwYWzRcHv5OBI4JG9Arm6PQa1vseMjAvcF0w=;
 b=WmasssQV4QzqPkS+TIJ6VRbMYKLlL0VUhbeE1nO3umZ7tVnxAfn2pQ3BTls9aFGEH4
 BIeESAqFgnpopPtzyJZFCmvQLyF+HB7QrZAxfk3G9nYQV31CCfPVDEwspSYMhwnYgkiK
 O4bE5Omil4KRs4lHYD+KvOOOul1XiLyhSBNVKjVDB9fQcTB3IK9lAj9Q5WPoUUHASfJ7
 nszYY++gGIYtiZNWqA8qcTxfosv2bCkTdZ4XJpBKEnBH811n133nGS98er1o0CqtrFIK
 DDt2SFcesOIfC0yVQIBnWhia4RLKc5HMhUcrLl5W34dduGJdO65vorjLTcYENYXTPm3P
 DC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687541158; x=1690133158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvrcpWiGwYWzRcHv5OBI4JG9Arm6PQa1vseMjAvcF0w=;
 b=igXgJEgOzxemSzuExjPNbjC+QgCCzgULRptEAgP5Y7OuAm1zSwzj3S2mJCNk63zsEX
 LyIM8wUBqhk/2SHJNEuuuFnbPLSTd2h58LFqQfLqVQnl7SjBAvXn/aNmqaz2OJQlNnhr
 9Hm6CMPaO/ckD94yt+KK8VdQKSHtFIzzUNbqHhHWKhy1L5FiPTuFT4biFOX36whplxGc
 qnUSyLHhSZgG/ldp53YcNW1gIVJRptysBu7WHaA86zkwD7wjKXrdVXxDp7y/hiaJiDUM
 Wby8mWI2hHtBvsBokENyiB0AQZ3qZyxexo0eiyKryGld1oAWgJMvpPb5PfLdkBDrGlNM
 XTpw==
X-Gm-Message-State: AC+VfDwueCSwwnOf0ahSBQokRLKNG5GoBcjMQgxiFZ8MOD1f0rvmcMNo
 f+GOwYjJ93KaX2BmDwOyg2nV3j38NX9+Mngs9cw=
X-Google-Smtp-Source: ACHHUZ7NcByUjJCm6Ki02kYe0FR+J79Y4JsNElaaMyU67Lm2tjJdgCdkJB4iQSWjOGtNwUc55VPtNA==
X-Received: by 2002:adf:e447:0:b0:307:cb94:85de with SMTP id
 t7-20020adfe447000000b00307cb9485demr20217918wrm.11.1687541157649; 
 Fri, 23 Jun 2023 10:25:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x14-20020adfec0e000000b0030aee3da084sm10011083wrn.49.2023.06.23.10.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 10:25:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] target/nios2 : Explicitly ask for target-endian loads and
 stores
Date: Fri, 23 Jun 2023 18:25:56 +0100
Message-Id: <20230623172556.1951974-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

When we generate code for guest loads and stores, at the moment they
end up being requests for a host-endian access. So for target-system-nios2
(little endian) a load like
   ldw        r3,0(r4)
results on an x86 host in the TCG IR
   qemu_ld_a32_i32 r3,loc2,al+leul,0
but on s390 it is
   qemu_ld_a32_i32 r3,loc2,al+beul,0

The result is that guests don't work on big-endian hosts.

Use the MO_TE* memops rather than the plain ones.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1693
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Presumably this got lost in a recent conversion somewhere,
but I can't figure out where, so maybe it's been broken much
longer...
---
 target/nios2/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index a365ad8293b..4264c7ec6b4 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -436,19 +436,19 @@ static const Nios2Instruction i_type_instructions[] = {
     INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_GE),        /* cmpgei */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_ILLEGAL(),
-    INSTRUCTION_FLG(gen_ldx, MO_UW),                  /* ldhu */
+    INSTRUCTION_FLG(gen_ldx, MO_TEUW),                /* ldhu */
     INSTRUCTION(andi),                                /* andi */
-    INSTRUCTION_FLG(gen_stx, MO_UW),                  /* sth */
+    INSTRUCTION_FLG(gen_stx, MO_TEUW),                /* sth */
     INSTRUCTION_FLG(gen_bxx, TCG_COND_GE),            /* bge */
-    INSTRUCTION_FLG(gen_ldx, MO_SW),                  /* ldh */
+    INSTRUCTION_FLG(gen_ldx, MO_TESW),                /* ldh */
     INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_LT),        /* cmplti */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_NOP(),                                /* initda */
     INSTRUCTION(ori),                                 /* ori */
-    INSTRUCTION_FLG(gen_stx, MO_UL),                  /* stw */
+    INSTRUCTION_FLG(gen_stx, MO_TEUL),                /* stw */
     INSTRUCTION_FLG(gen_bxx, TCG_COND_LT),            /* blt */
-    INSTRUCTION_FLG(gen_ldx, MO_UL),                  /* ldw */
+    INSTRUCTION_FLG(gen_ldx, MO_TEUL),                /* ldw */
     INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_NE),        /* cmpnei */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_ILLEGAL(),
@@ -468,19 +468,19 @@ static const Nios2Instruction i_type_instructions[] = {
     INSTRUCTION_FLG(gen_cmpxxui, TCG_COND_GEU),       /* cmpgeui */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_ILLEGAL(),
-    INSTRUCTION_FLG(gen_ldx, MO_UW),                  /* ldhuio */
+    INSTRUCTION_FLG(gen_ldx, MO_TEUW),                /* ldhuio */
     INSTRUCTION(andhi),                               /* andhi */
-    INSTRUCTION_FLG(gen_stx, MO_UW),                  /* sthio */
+    INSTRUCTION_FLG(gen_stx, MO_TEUW),                /* sthio */
     INSTRUCTION_FLG(gen_bxx, TCG_COND_GEU),           /* bgeu */
-    INSTRUCTION_FLG(gen_ldx, MO_SW),                  /* ldhio */
+    INSTRUCTION_FLG(gen_ldx, MO_TESW),                /* ldhio */
     INSTRUCTION_FLG(gen_cmpxxui, TCG_COND_LTU),       /* cmpltui */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_UNIMPLEMENTED(),                      /* custom */
     INSTRUCTION_NOP(),                                /* initd */
     INSTRUCTION(orhi),                                /* orhi */
-    INSTRUCTION_FLG(gen_stx, MO_SL),                  /* stwio */
+    INSTRUCTION_FLG(gen_stx, MO_TESL),                /* stwio */
     INSTRUCTION_FLG(gen_bxx, TCG_COND_LTU),           /* bltu */
-    INSTRUCTION_FLG(gen_ldx, MO_UL),                  /* ldwio */
+    INSTRUCTION_FLG(gen_ldx, MO_TEUL),                /* ldwio */
     INSTRUCTION(rdprs),                               /* rdprs */
     INSTRUCTION_ILLEGAL(),
     INSTRUCTION_FLG(handle_r_type_instr, 0),          /* R-Type */
-- 
2.34.1


