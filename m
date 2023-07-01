Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B8374477F
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVx-0007YC-Iu; Sat, 01 Jul 2023 02:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVv-0007WZ-FI
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:23 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVt-0007G4-Dm
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:23 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so4466160e87.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194519; x=1690786519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeKcGtvpiTjSJLKdv4xRCsQ244TAR26gRApECngoPiQ=;
 b=CsRY+JExuzDO931hzhM5mDAGVzzLs93Pb4SwflP7BHXCwAusJpK6vhUz6v+nxoX0EF
 uATqEalmo5vDrZfhfdqViEXZkcRVx/IqYpZy914fUNLTieKKo4d6ass7dD/MVWgUMA3Z
 aTCxWs0fQswlBpEUUEo+fW9Hw2lIW1LDGRJRcmJGb6BPTIcMcP2Sgk5BVGOuXobnlHW2
 UCA+ZH1CnW5pTk5adXgqItC3kX2SuIdiAcCGMiKOUOAgOfPpR89a0cMwOVw+ttLsvHsl
 dz2U5ycHH85APPTgnSIwJv1tescaReFig/5OiVVlsqJyR7YyLk4+2fH1YF3ghBFlv+T6
 pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194519; x=1690786519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeKcGtvpiTjSJLKdv4xRCsQ244TAR26gRApECngoPiQ=;
 b=fyzEVImPYDY71Kq2lEhpYZKDmVEfu/ngDMEVeNf3kh+ya6rxer1qEi5Fu1lgrdCrS9
 pcxn2MaT6PyGf51TnJk+7VACTYFbtaxsX2NuVzfiGY743NDKwnvDiWbCun+mLvC8qE9r
 4TCRdo1aMrUHB4hq6iysZrBKb0ibaLGt0SrbzjVb824LQlqkFQ3/sCffCr5I02oquuIp
 Tiaip6uuD8qB+8vHhwo4HnWyA4tpGRhSmiSG14P2U7DlOb34FbUTeZ9csHo+g5B7NdTk
 oeIIDbaS2YOtXPGPN8LtrWM7yU/UGUpJ+uQlGisTXLDsZytCgjQRRfOS3czGwiPyblxz
 Q/Nw==
X-Gm-Message-State: ABy/qLbHG9pbobJAvm+Miu11yKU2Y7dhyi3+vF/u57weJlLNU4d81xhd
 JeA8O367a2xGUJ9nKLs+UWrbM9rzDUW3ke0N/lBYDw==
X-Google-Smtp-Source: APBJJlGQwWv8IIcGJCU9R7RYJ+SgY+cIryneHe5WOjrBxDdtxL2AlDsVOqLhk364i+zNmX04hsvUYw==
X-Received: by 2002:a19:8c14:0:b0:4f8:7754:62e1 with SMTP id
 o20-20020a198c14000000b004f8775462e1mr3554746lfd.40.1688194519514; 
 Fri, 30 Jun 2023 23:55:19 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/11] target/nios2 : Explicitly ask for target-endian loads
 and stores
Date: Sat,  1 Jul 2023 08:55:09 +0200
Message-Id: <20230701065510.514743-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230623172556.1951974-1-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index a365ad8293..4264c7ec6b 100644
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


