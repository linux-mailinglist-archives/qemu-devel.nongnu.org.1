Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E178778B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEpB-00067Z-5E; Thu, 24 Aug 2023 14:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEp0-00066b-3j
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:43 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEox-0001l9-Rs
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26f57f02442so58853a91.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692900757; x=1693505557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bcQCblrZU/Npaix3Rwgfeq9CxdoGqDRaoBazeSIf7Q=;
 b=MuQnyW32Zw9hnk2rXmkHaWLJx9ZiPoAIYCMLwVczrLpt/J8wRD6CM1QGfBP4G4gPiy
 4Cv4/cLhgIj293J6KTizekiSNPGNg28ELG5nrsTCcrrPzpdV67U80jG6Uy9SLykGhjGi
 7hbasIeYRwcvxvUOPVYHJDmz/PtdRBUq9OfJxoe2M0GzvvwQ+ZiEToQUJ5ZKpEpGiJZn
 xNnYY//4q3yy1BBF7Tp/IShKU2TUBQ7eHdrOR+Sg6fAyOaWs80eZYt+7eeY1rpwVGqWq
 WGTwwfR7JUGKkCTVbzKndAsSntmsgVLDxyGliofooLeZnaHClbQWiuPxdFj7pnK9PTcU
 tUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692900757; x=1693505557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bcQCblrZU/Npaix3Rwgfeq9CxdoGqDRaoBazeSIf7Q=;
 b=bc82fx3NSrk4PZIITnWuVbV5omgrZ0YV+qySDeXTw17v0Y7uNfdvl955G+PTl1uAM0
 L5qs4lJ7rvlvIQLcIK/tGOwbXldYHq6FnD2gs7wX0gPc2ekFuItaUrU6/jdcN9thneR5
 oyXYOBVcUPhPY9QESRKWR8lCL6IEu1FVd3zGAWEdio2qqYsSKy4no5yTmhKkUkr6e96K
 ldXiZUre1oSrB8dTqJ+B+JzBYD36+TqnjZK1uo0cQl4ZHcGnzRBQ7KOlYpW20YGuhf17
 +Vet4ouZZfRtoHuN0OshSpBraeL41enPpIIO4X5m1zYD1Ps8rxAt8wQJfP5ZsAqEFR1f
 4maQ==
X-Gm-Message-State: AOJu0YwnApHFUlDG3z8DamsLjAysDdx0pwA4bRDy27gQFzW3PopQ9Adm
 kn3Hf1YAwb6ya7uYticmqrLY/W3X9hYSiCMGUA8=
X-Google-Smtp-Source: AGHT+IERRPSuBfn4fXs1zJRqjODd1pwYfuY2TmAnmM8LiUTmcrj40JQTnmajRi+AAWTQsWV2hfhZfg==
X-Received: by 2002:a17:90a:bc49:b0:26d:213c:9b54 with SMTP id
 t9-20020a17090abc4900b0026d213c9b54mr13499859pjv.13.1692900757503; 
 Thu, 24 Aug 2023 11:12:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a17090ade9400b0026cecddfc58sm1880544pjv.42.2023.08.24.11.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:12:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 2/2] target/sh4: Disable decode_gusa when plugins enabled
Date: Thu, 24 Aug 2023 11:12:33 -0700
Message-Id: <20230824181233.1568795-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824181233.1568795-1-richard.henderson@linaro.org>
References: <20230824181233.1568795-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 49c87d7a01..f2bdd1d0fc 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1817,6 +1817,18 @@ static void decode_opc(DisasContext * ctx)
 }
 
 #ifdef CONFIG_USER_ONLY
+/*
+ * Restart with the EXCLUSIVE bit set, within a TB run via
+ * cpu_exec_step_atomic holding the exclusive lock.
+ */
+static void gen_restart_exclusive(DisasContext *ctx)
+{
+    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
+    gen_save_cpu_state(ctx, false);
+    gen_helper_exclusive(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+}
+
 /* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
    Upon an interrupt, a real kernel would simply notice magic values in
    the registers and reset the PC to the start of the sequence.
@@ -2150,12 +2162,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
                   pc, pc_end);
 
-    /* Restart with the EXCLUSIVE bit set, within a TB run via
-       cpu_exec_step_atomic holding the exclusive lock.  */
-    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
-    gen_save_cpu_state(ctx, false);
-    gen_helper_exclusive(cpu_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_restart_exclusive(ctx);
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
@@ -2243,12 +2250,22 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     if (unlikely(ctx->envflags & TB_FLAG_GUSA_MASK)
         && !(ctx->envflags & TB_FLAG_GUSA_EXCLUSIVE)) {
-        /* We're in an gUSA region, and we have not already fallen
-           back on using an exclusive region.  Attempt to parse the
-           region into a single supported atomic operation.  Failure
-           is handled within the parser by raising an exception to
-           retry using an exclusive region.  */
-        decode_gusa(ctx, env);
+        /*
+         * We're in an gUSA region, and we have not already fallen
+         * back on using an exclusive region.  Attempt to parse the
+         * region into a single supported atomic operation.  Failure
+         * is handled within the parser by raising an exception to
+         * retry using an exclusive region.
+         *
+         * Parsing the region in one block conflicts with plugins,
+         * so always use exclusive mode if plugins enabled.
+         */
+        if (ctx->base.plugin_enabled) {
+            gen_restart_exclusive(ctx);
+            ctx->base.pc_next += 2;
+        } else {
+            decode_gusa(ctx, env);
+        }
         return;
     }
 #endif
-- 
2.34.1


