Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342808B173D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 01:36:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm63-00064J-V3; Wed, 24 Apr 2024 19:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5q-00060x-Gm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5o-0003u3-HT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so1176397a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001519; x=1714606319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abuDTzJtuHQkleQ2JIJcQY+Wz/0ibhtmXe6lLhOCiLw=;
 b=yVyMBiBM0Zuq2mOa8apAYdprlW2l3d76enipPb+/VA3QDFxzSdxd38qGjWi3irYx7f
 VD/JYH2UlTueZDdHgxrwvPz+9JfOumkG6QjDzQ74Xpku878rVNtnEefOu9tH5fkVd91o
 p7xAnxKrESUDNk5rnCS9pZuN1QGBS8GXmCz/aPrbI0sbwc+BW3Pi0nJwP8Fl63BiIOn8
 9HPVu3qLl2Cz0SGj54NKq/bYwfb7jXoopdGp/CAIkYB5lYl9rdl0MIr/a2CEGAoUWrkg
 F8XgVnONJ5bRLaEYfeAQLot2rD1GYL7D24ZshSm2Pa0M8/yELFMu8FTIX6tsYXW5tY7J
 8OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001519; x=1714606319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abuDTzJtuHQkleQ2JIJcQY+Wz/0ibhtmXe6lLhOCiLw=;
 b=CpbTDK8GRUmdlvtC1R6H/apzdNdSeh1Xux2DAoxIE+qEDETALor+kNfzU8jjvyKRRj
 eWWPiP8V350wtPkm36/hAdHsb6osj5CZthKEZwREZiUN+QN1O1CtekKLxI778/5bPkIv
 gtl141mT/eEgcqsEkdq5jGQucU8zFYccMbzL+jEVDc4wtArBEurrtcqMzd7KuLK7vgDL
 r76Ud6ipM8SqnPiSf3QpRrPNDGZP5PXb9wAmBmFlWO23oAc87fHof1wF9CxLzEjmzcW2
 QMJOU1Sq6Z9yHkeW0vDA7pSOi06ELjbGJ0Fv/kh/wcdbe5y3yuTqdm4wEdzqnrlYit04
 cYoA==
X-Gm-Message-State: AOJu0YwMoNSl00p8BEwNNFhfL+7TteeAClxnJV4hKqOC2ROlK9Tmourn
 ooo278iNmc5KDBCR+4oHBs37Js5vS8yhutaOiwcYL8+L//pWwO9xIJsltGIpuUWmEuxnxqGS1pv
 v
X-Google-Smtp-Source: AGHT+IFeXjEAk5rzV4qf+wD0Tb2IPyqR0GMY5SigCIH4JccUFUQFXF15u5gNyqJx9YQRnuc2+FTTyA==
X-Received: by 2002:a17:90a:6d02:b0:2aa:90f3:a4b8 with SMTP id
 z2-20020a17090a6d0200b002aa90f3a4b8mr1486785pjj.24.1714001519370; 
 Wed, 24 Apr 2024 16:31:59 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 30/33] target/rx: Use translator_ld*
Date: Wed, 24 Apr 2024 16:31:28 -0700
Message-Id: <20240424233131.988727-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 92fb2b43ad..9b81cf20b3 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -22,7 +22,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -75,10 +74,10 @@ static TCGv_i64 cpu_acc;
 
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
     while (++i <= n) {
-        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
+        uint8_t b = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next++);
         insn |= b << (32 - i * 8);
     }
     return insn;
@@ -90,22 +89,24 @@ static uint32_t li(DisasContext *ctx, int sz)
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
-    tcg_debug_assert(sz < 4);
     switch (sz) {
     case 1:
         ctx->base.pc_next += 1;
-        return cpu_ldsb_code(env, addr);
+        return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return cpu_ldsw_code(env, addr);
+        return (int16_t)translator_lduw(env, &ctx->base, addr);
     case 3:
         ctx->base.pc_next += 3;
-        tmp = cpu_ldsb_code(env, addr + 2) << 16;
-        tmp |= cpu_lduw_code(env, addr) & 0xffff;
+        tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
+        tmp <<= 16;
+        tmp |= translator_lduw(env, &ctx->base, addr);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return cpu_ldl_code(env, addr);
+        return translator_ldl(env, &ctx->base, addr);
+    default:
+        g_assert_not_reached();
     }
     return 0;
 }
@@ -190,22 +191,22 @@ static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
 {
     uint32_t dsp;
 
-    tcg_debug_assert(ld < 3);
     switch (ld) {
     case 0:
         return cpu_regs[reg];
     case 1:
-        dsp = cpu_ldub_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 1;
         return mem;
     case 2:
-        dsp = cpu_lduw_code(ctx->env, ctx->base.pc_next) << size;
+        dsp = translator_lduw(ctx->env, &ctx->base, ctx->base.pc_next) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
+    default:
+        g_assert_not_reached();
     }
-    return NULL;
 }
 
 static inline MemOp mi_to_mop(unsigned mi)
-- 
2.34.1


