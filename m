Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA5275EE68
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrJw-000207-DH; Mon, 24 Jul 2023 04:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJt-0001zY-Ub
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJs-0000dc-3f
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so30298835e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188811; x=1690793611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3gKpL8DiepyBHxNbIedU4D/NFgh/WMqJ9tvA2IW734=;
 b=BIuusPkjdmdnR2lEx1QWO7sDaPIqJwwq9K8J7ymCrF5gQfE8MXaA+qTlhv75lOHcbH
 R5IrPmUacKR0HJdba32KsTaYQVbe4b5rTj1d/RGPQM6P2NQychtAUVJNZhgk0mvvPPtG
 pPuhjtm0jwXrlevE/J0EFdpZ7zdF5Gn4ggzXjSqPk/MiG64G+PD9KawMQ/05W8T4Zlh0
 mFYZdAotDRVGiAj19quUYeeakoJj+5Z1KQ25FfcgYJDDqBzFWZetiv8wwT1dv3jtFIPa
 UP2Vc775TxUiZzHCWedWAO9EmY/kuE1HbZhuWHUOPfOkt+3LKMaXQw2ey0W20hSAUnj3
 ggCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188811; x=1690793611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3gKpL8DiepyBHxNbIedU4D/NFgh/WMqJ9tvA2IW734=;
 b=hVkpsRE/Xsh3YcUHW5p+IXoSyOeTNfdmP2o9Lzk/a205reLl4tXzDjIBgRd0uWbFwv
 pKKFgg8dmKDlhxR4JuTzrD0gIx1mdNwMPGkWIdWhhJmX/0f74V4HpR+S99AexWVffwOO
 254TVodb4bZ/lOPtIXyHy2Tt1nDBHsfVrbLDY9HLOsKBfcMp/wi03oLUPJlSg9/lu1xP
 Hf2/ERdJdNxSA0enZkWYA4Q5Y0A04BoTX/5w8nMOz6ADQKTGUhSIlNgAnnnYQ0OKSzo2
 +kFRxOHwCljOK/GK1hnPXsAKLO5g9P4KmhxywwysMhtykHqaIYeMMcM/Xo3GzOJN1xZk
 Pc0Q==
X-Gm-Message-State: ABy/qLbUQIQ/9CuppICMPbmxlXGJqgdaOqWHUGXufyiGn0yig1mILxag
 bSdOAowtqipLPL5RnHpwMDFbG32iZMK0L1MtriMseQ==
X-Google-Smtp-Source: APBJJlFe77uR9VLoKfYNHu7vnvfFBXI3wEdMoC5nagrzTpoKLE5OhATUI5PiPYS68Prf51kn/jMvCg==
X-Received: by 2002:a05:600c:2909:b0:3fc:85c:5ed2 with SMTP id
 i9-20020a05600c290900b003fc085c5ed2mr5823043wmd.11.1690188810698; 
 Mon, 24 Jul 2023 01:53:30 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jordan Niethe <jniethe5@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Benjamin Gray <bgray@linux.ibm.com>
Subject: [PULL 1/7] tcg/ppc: Fix race in goto_tb implementation
Date: Mon, 24 Jul 2023 09:53:22 +0100
Message-Id: <20230724085328.4936-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085328.4936-1-richard.henderson@linaro.org>
References: <20230724085328.4936-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Jordan Niethe <jniethe5@gmail.com>

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
Message-Id: <20230717093001.13167-1-jniethe5@gmail.com>
---
 tcg/ppc/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c866f2c997..511e14b180 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2496,11 +2496,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
         ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
     
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
+        /* TODO: Use direct branches when possible. */
         set_jmp_insn_offset(s, which);
         tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
 
-        /* When branch is out of range, fall through to indirect. */
         tcg_out32(s, BCCTR | BO_ALWAYS);
 
         /* For the unlinked case, need to reset TCG_REG_TB.  */
@@ -2528,10 +2527,12 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
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
2.34.1


