Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFA7C5077
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgl-0008CY-If; Wed, 11 Oct 2023 06:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgj-0008Ax-RS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgh-0007fV-Hw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so1477364f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021014; x=1697625814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n810Flg3eUKPCpIa9Gc8YMsIUEaYzj3LB0YfR/j6wKY=;
 b=LlwfYchKOb0fmhShTiRQMjnhLINsXIc1+vaZ60a+vk8W9Rb0lUXyUftQe7SGHw6i98
 uE3dBsR6tDYXccDm1mSw2cUDHt3ko3G4M5xS73dZ6s4Z2ZPFG467NEG9bh1qUafSBFrN
 RrbZcu5v8k6xPuTmPVEY1lu+MUE8TMXrNONkt0kUqaL7ZyhMjAKLXwTx4bMsCh7sTSB3
 4OccV0Fto6pikg3Njj2zZaEH1hfRcQ97V63fRraM1wBAMnHZuK8blwJJgMTC2/co5moX
 2f169s6jyijN/NuMHLjFCubAkp2oWDfuI1MA1jAiB7k/+LIMfgPcw+FDDQCIRsHAT8HE
 9rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021014; x=1697625814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n810Flg3eUKPCpIa9Gc8YMsIUEaYzj3LB0YfR/j6wKY=;
 b=soqx4EdpcRPCaFC1wc9smpByGgjXYWJriVFYkg/hhDEBt4JmYqqou99MmboR0UcvmP
 aJHktofL6tQRS77F6ZZH8GQqzNSss5YbDrvLuN7Gcq2xTTANRnAzbwUDvgqCx0YYwmog
 gZkY7vl+B/KttUwJ5fDzbRbW46b33fexHZOxDWOPfkTnLw6Lixc/dAysSIiJrA8SV77D
 +pnkfAJVDmQxnx/SWG2EmboA3RaMDQGcPNuNtKXQ0ctU1FKLfyf0p7X8FiIRkQChgwrO
 88G1GL64oSMV2/kUJYtaq38LONHALvl7Ow76o4Zx7cKmHqk2vbBlsc+6tyacwxTlj55Z
 H3SA==
X-Gm-Message-State: AOJu0YzBjXs6lBmsGUN9VSlSeXkFO/gpLuoC+b46QIKBHmNlSDEEPPZR
 B0sACbmLp/FubKvDMikrJVEQPw==
X-Google-Smtp-Source: AGHT+IHAbeD9UcJCzh6DkJgMUWqT0U1j3jo6jzh492roj7uEI4jQkiFKdVaPqE2rgpAtUAjKyzc6QA==
X-Received: by 2002:a05:6000:1c02:b0:32d:4545:3832 with SMTP id
 ba2-20020a0560001c0200b0032d45453832mr3881270wrb.14.1697021014165; 
 Wed, 11 Oct 2023 03:43:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v3-20020adfa1c3000000b0032d8354fb43sm1869446wrv.76.2023.10.11.03.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 721FC1FFCD;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 21/25] target/sh4: Disable decode_gusa when plugins enabled
Date: Wed, 11 Oct 2023 11:33:25 +0100
Message-Id: <20231011103329.670525-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230824181233.1568795-3-richard.henderson@linaro.org>
[AJB: fixed s/cpu_env/tcg_env/ during re-base]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-22-alex.bennee@linaro.org>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index cbd8dfc02f..220a06bdce 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1816,6 +1816,18 @@ static void decode_opc(DisasContext * ctx)
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
+    gen_helper_exclusive(tcg_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+}
+
 /* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
    Upon an interrupt, a real kernel would simply notice magic values in
    the registers and reset the PC to the start of the sequence.
@@ -2149,12 +2161,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
                   pc, pc_end);
 
-    /* Restart with the EXCLUSIVE bit set, within a TB run via
-       cpu_exec_step_atomic holding the exclusive lock.  */
-    ctx->envflags |= TB_FLAG_GUSA_EXCLUSIVE;
-    gen_save_cpu_state(ctx, false);
-    gen_helper_exclusive(tcg_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_restart_exclusive(ctx);
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
@@ -2242,12 +2249,22 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
2.39.2


