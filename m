Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCAB72114E
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 18:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5UXT-0002kv-Pe; Sat, 03 Jun 2023 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5UXP-0002kT-AY
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:55:37 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5UXN-0001oq-K6
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:55:35 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-33b6c47898dso15491305ab.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685811332; x=1688403332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wo7XgGTGo8Fct0Rteupo4Gw8WrT2nC9cNphyBjo+w0Y=;
 b=rUj1o7EteYC4GiZswevnyVVr3hT/0xMLd3XSrMCVnRHcy6Nue+9gdYKcIMUri696WD
 +xX88s8raLTCmBfLzUgxLQOsLzRLLZccj9Zg86HWVMWGx205tlYubJkD0V7N3MfC4Ri+
 J2oXJbY7gDmLq/5N4NgGHUibnVKq1u5TpRNcvZNzU0DpSo5RQoPTJuL5kp1FulheKxqw
 ik/w6nFT3y2s2VSQY9cOpF7pMxqaIJXCDee35Ettj92TAxY67m9WYjAvq9nCN2TgkFuP
 sAB2cxoeqiSJEZYZZ0PZ2xLB13GEZuEENlz7FcRppGlDer0sZwGzfV6lfUkztUEDBUYG
 1IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685811332; x=1688403332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wo7XgGTGo8Fct0Rteupo4Gw8WrT2nC9cNphyBjo+w0Y=;
 b=AXZmM2lBbOviyAmsmsx2J/Au/ddJW3torhWeSsCJcjNKx0FUL5c/Xb/bPWXyN2ABxB
 k/KdkkcDOl673P3hdmvxN0lQ+8ZpLKTgCTsSHNBkixMRY+4OuvmfVM/7jZEANO5N6rVn
 XOJl0v6lQMFE7mDLdJEdV3U4JJq6nLTERFlopHwKfvA2AjuX9GxPSD8c1XMXUUGPDbJK
 pGpnvoGEHixpkQSvuKilNDz4ojFMBl1ThW3FQjjGImVhlJfKd4pE6LwZN295EY9Z3Yoe
 Po2XJBTkziSfI2Ha+hyUOXRVbLw829Le1Yk0oske9xr/X0q2nUoHbqn0H0OLyyEozMgz
 dC+w==
X-Gm-Message-State: AC+VfDz8os/RjfcCISooBBITC6bfzrd06qHm7ec7WgIu8HWteczdzBmr
 hjjk44Pkv3e5fNIfpgNaLuhfdwQrgSMaUaS/XNk=
X-Google-Smtp-Source: ACHHUZ48biUurYgjtXzdHukuYI1BZdSYLDqicX9Zly2vUMJmbRTFKduZLLbR0rHO7QRdLQi1cnvnyw==
X-Received: by 2002:a92:cad1:0:b0:325:b96e:6709 with SMTP id
 m17-20020a92cad1000000b00325b96e6709mr14953073ilq.11.1685811332150; 
 Sat, 03 Jun 2023 09:55:32 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a654688000000b00530277f7b0fsm2849037pgr.53.2023.06.03.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 09:55:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp,
	philmd@linaro.org
Subject: [PATCH] target/sh4: Emit insn_start for each insn in gUSA region
Date: Sat,  3 Jun 2023 09:55:30 -0700
Message-Id: <20230603165530.1189588-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

Fixes an assert in tcg_gen_code that we don't accidentally
eliminate an insn_start during optimization.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Test case is tests/tcg/multiarch/testthread.c; the assert for
equality is new with

https://lore.kernel.org/qemu-devel/20230531040330.8950-26-richard.henderson@linaro.org/


r~
---
 target/sh4/translate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index efd889d9d3..49c87d7a01 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2144,9 +2144,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* The entire region has been translated.  */
     ctx->envflags &= ~TB_FLAG_GUSA_MASK;
-    ctx->base.pc_next = pc_end;
-    ctx->base.num_insns += max_insns - 1;
-    return;
+    goto done;
 
  fail:
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
@@ -2163,8 +2161,19 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
        purposes of accounting within the TB.  We might as well report the
        entire region consumed via ctx->base.pc_next so that it's immediately
        available in the disassembly dump.  */
+
+ done:
     ctx->base.pc_next = pc_end;
     ctx->base.num_insns += max_insns - 1;
+
+    /*
+     * Emit insn_start to cover each of the insns in the region.
+     * This matches an assert in tcg.c making sure that we have
+     * tb->icount * insn_start.
+     */
+    for (i = 1; i < max_insns; ++i) {
+        tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+    }
 }
 #endif
 
-- 
2.34.1


