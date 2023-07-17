Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E121756409
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLO2U-0007SR-Gp; Mon, 17 Jul 2023 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLKYf-0007Mt-UJ; Mon, 17 Jul 2023 05:30:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLKYd-0002tm-2z; Mon, 17 Jul 2023 05:30:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b8a8154f9cso25960885ad.1; 
 Mon, 17 Jul 2023 02:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689586216; x=1692178216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IFzHqKcFIPFHyix1ZyjoIAtMTo0b/ppCQf/TcpHmm5Q=;
 b=Un9qdbQ7ZjnAr6jcLw3FSR8RzMSIq6hG478QfbZdqbzMGqfo/aATqqs99dt0UNI8gX
 9WrpnWpT6xVDU8i1YGg3rjy0cmTzQLU1+AV8t4qlQEMtbp0GAPfSR3hp9BktGSJMHgxW
 YJ7X17XUooJGO2Z8tJswpCh+9rSgy+KYO6ienNRY56cX6wuH2iKi8TMQqv0wRn7HEbMD
 GzBvkbQHaQEqvDPnMhVb5Dxdf86ZsjOXZreI601XJzLkEQ/DZGDTLLcH50kxvIadl4wK
 xATB2rTk4p5Z4JMabAqiGFhm4nqak4tCcjeV+XTcoSXn5xzwQ9GLm9i2jjZW4sRHF4DK
 Y+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689586216; x=1692178216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFzHqKcFIPFHyix1ZyjoIAtMTo0b/ppCQf/TcpHmm5Q=;
 b=C0JZA6MPk3bMjpQrSaQbtOB3ogBVAcnIra9TNDO22ZIMUZsG1r6nO4nFnUQJYhvNMw
 WNH6jbGNw71hVCLdng2hb6qkyVkSeUzcg/hcOpZSox8VhsB6wi3A5Exx0J+Tjq/pCQnO
 5TJ45HyhROA7LZPmR4bbkUgeI1omwZYUNkYRRoeMR5CFMIemqDLT7cAuDv96zMpt7oUx
 YAIAJ1F7VXrBNmSyM6RCtKz4zIw5gvSG8KUm9eigt/bjW/cT9SPSLmDepEEkIFmRQsg7
 eRkxOk/0f9vn6HBLMnM68RLFu1VxLuoXuT5tyRC3R4m+v0KA5E9IiTh3NEtc7jXV/vMw
 ed2Q==
X-Gm-Message-State: ABy/qLahC83SVjGzW5m1jxrIxzSI3vccgF4KA/y75+O6f1aMOGQ2Z/5G
 DFKcCD2Mhl45RilsuAxOdS69WMBmHBdsVg==
X-Google-Smtp-Source: APBJJlHxS1NJmAX9ilk50/4i77lDUO4xjEAfBqb6Cf4K3xGNY/bZZSR/LeejpSJuEJArIWiOcLQthg==
X-Received: by 2002:a17:903:110d:b0:1b8:3936:7b64 with SMTP id
 n13-20020a170903110d00b001b839367b64mr12199975plh.1.1689586215962; 
 Mon, 17 Jul 2023 02:30:15 -0700 (PDT)
Received: from pwon.ibmuc.com (159-196-117-139.9fc475.syd.nbn.aussiebb.net.
 [159.196.117.139]) by smtp.gmail.com with ESMTPSA id
 bd5-20020a170902830500b001b8761c739csm12226056plb.271.2023.07.17.02.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 02:30:15 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 dbarboza@ventanamicro.com, npiggin@gmail.com,
 anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru, clg@kaod.org,
 bgray@linux.ibm.com, Jordan Niethe <jniethe5@gmail.com>
Subject: [PATCH v2] tcg/ppc: Fix race in goto_tb implementation
Date: Mon, 17 Jul 2023 19:30:01 +1000
Message-Id: <20230717093001.13167-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jniethe5@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jul 2023 09:13:05 -0400
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
incorrect behavior if a thread was in the middle of multiple
instructions when they were replaced. However this introduced a race
between loading the jmp target into TCG_REG_TB and patching and
executing the direct branch.

The relevant part of the goto_tb implementation:

    ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
  patch_location:
    mtctr TCG_REG_TB
    bctr

tb_target_set_jmp_target() will replace 'patch_location' with a direct
branch if the target is in range. The direct branch now relies on
TCG_REG_TB being set up correctly by the ld. Prior to this commit
multiple instructions were patched in for the direct branch case; these
instructions would initialize TCG_REG_TB to the same value as the branch
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

Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1726
Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---
v2: - Use braces
    - Collect tags
---
 tcg/ppc/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8d6899cf40..329319ab8a 100644
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
@@ -2565,10 +2564,12 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     intptr_t diff = addr - jmp_rx;
     tcg_insn_unit insn;
 
+    if (USE_REG_TB) {
+        return;
+    }
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


