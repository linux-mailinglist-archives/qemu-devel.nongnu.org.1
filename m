Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A39756407
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLO2S-0007Qy-7e; Mon, 17 Jul 2023 09:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLCyB-0006Na-35; Sun, 16 Jul 2023 21:24:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLCy9-00062T-Az; Sun, 16 Jul 2023 21:24:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666e916b880so2523732b3a.2; 
 Sun, 16 Jul 2023 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689557046; x=1692149046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RzCYbYF72t8xRpIzXCWZRuFw3ToPRxhalVp/REmo0hg=;
 b=kGAB/2wifsek/lM6qKavv8jNMxIwIcH6Kog4hsUQ4txWvDV59xfCjgW8cDcCo/fBW8
 EtPDSmHkEhgBxjwYwj2q7d+X9s56a4pO949tj+DPI9GRV8S9rheXrK65YdjHSonH/+U1
 SzRpQ4HgdO7prNhy+cgg2THf0qKu7jo+t83ga5a+9GlTEXL9fEia9iRkroLwm5d9AeZB
 f1OPBLNc34ob6UVdu3HhZQqgWwJ736h/QEVXIamoLahE3gQbugGJxmGaGZ2Bji7leHiO
 7DVRQNIp3k7qsjskuRPhwIeviWqQiDNrhHA/bvsOhYkUTE93+itZkZgiT8wfLHynkld8
 kazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689557046; x=1692149046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzCYbYF72t8xRpIzXCWZRuFw3ToPRxhalVp/REmo0hg=;
 b=V/SDQdIkaa4ehT0/NUPq7rlSNohNXMmOIgLG5bW2YhzS37KiOA9hjESygNNts5fzWL
 HLyyVfYPlOHqOGHQ7fYa9ba03aq5bkJuE3bRKgaufvC56iJcg2mJN/3qWlUoqfS2U/EO
 gG42R47v5d+1Ab91osNAIgvOm3HMY4l2Wmrzovp5E8vYqM712jhS1FL+yd7SRLT+DuHY
 dD/yVUODEGmwAwJrugzudtlOl6m3qyeasP1STQlwr6s2FcmcwO0V4Q7jGqBCTXKrrP3p
 WAidavnUN+YHj96aePp9ntYO5MXIGvVragSFc7RCqtPzNtzMFR9pc5G5EyQbcV7ysdkG
 d1Xw==
X-Gm-Message-State: ABy/qLbJyklJAYYnvPbLiedCS88URvDqhRHKNANskCS8IKGm1ygup9jR
 jjRGvCWQF7Zsczba9jSFmXROF16ZwRBMLw==
X-Google-Smtp-Source: APBJJlHmIy9mes3dz1HH71rFXpXnlzKIEm3ZjdmeBOQcRPrV6o38jSVGQH0eZQd8f+stc0ysF/V8dQ==
X-Received: by 2002:a05:6a00:188d:b0:66a:613f:87e1 with SMTP id
 x13-20020a056a00188d00b0066a613f87e1mr12926927pfh.8.1689557046407; 
 Sun, 16 Jul 2023 18:24:06 -0700 (PDT)
Received: from pwon.ozlabs.ibm.com ([146.112.118.69])
 by smtp.gmail.com with ESMTPSA id
 e6-20020aa78c46000000b00682562b1549sm10667731pfd.24.2023.07.16.18.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jul 2023 18:24:06 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 dbarboza@ventanamicro.com, npiggin@gmail.com,
 anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru, clg@kaod.org,
 bgray@linux.ibm.com, Jordan Niethe <jniethe5@gmail.com>
Subject: [PATCH] tcg/ppc: Fix race in goto_tb implementation
Date: Mon, 17 Jul 2023 11:23:26 +1000
Message-Id: <20230717012327.20149-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=jniethe5@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jul 2023 09:13:03 -0400
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

Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
goto_tb to ensure only a single instruction was patched to prevent
incorrect behaviour if a thread was in the middle of multiple
instructions when they were replaced. However this introduced a race
between loading the jmp target into TCG_REG_TB and patching and
executing the direct branch.

The relevent part of the goto_tb implementation:

    ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
  patch_location:
    mtctr TCG_REG_TB
    bctr

tb_target_set_jmp_target() will replace 'patch_location' with a direct
branch if the target is in range. The direct branch now relies on
TCG_REG_TB being set up correctly by the ld. Prior to this commit
multiple instructions were patched in for the direct branch case; these
instructions would initalise TCG_REG_TB to the same value as the branch
target.

Imagine the following sequence:

1) Thread A is executing the goto_tb sequence and loads the jmp
   target into TCG_REG_TB.

2) Thread B updates the jmp target address and calls
   tb_target_set_jmp_target(). This patches a new direct branch into the
   goto_tb sequence.

3) Thread A executes the newly patched direct branch. The value in
   TCG_REG_TB still contains the old jmp target.

TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
eventually crash after performing memory accesses generated from a
faulty value in TCG_REG_TB.

This presents as segfaults or illegal instruction exceptions.

Do not revert commit 20b6643324 as it did fix a different race
condition. Instead remove the direct branch optimization and always use
indirect branches.

The direct branch optimization can be re-added later with a race free
sequence.

Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/1726

Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 tcg/ppc/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8d6899cf40..a7323f479b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2533,11 +2533,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
         ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
     
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
+        /* TODO: Use direct branches when possible. */
         set_jmp_insn_offset(s, which);
         tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
 
-        /* When branch is out of range, fall through to indirect. */
         tcg_out32(s, BCCTR | BO_ALWAYS);
 
         /* For the unlinked case, need to reset TCG_REG_TB.  */
@@ -2565,10 +2564,11 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     intptr_t diff = addr - jmp_rx;
     tcg_insn_unit insn;
 
+    if (USE_REG_TB)
+        return;
+
     if (in_range_b(diff)) {
         insn = B | (diff & 0x3fffffc);
-    } else if (USE_REG_TB) {
-        insn = MTSPR | RS(TCG_REG_TB) | CTR;
     } else {
         insn = NOP;
     }
-- 
2.39.3


